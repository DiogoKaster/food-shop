import 'package:flutter/material.dart';
import 'package:flutter_application_2/domain/models/order.dart';
import 'package:flutter_application_2/domain/models/order_item.dart';
import 'package:flutter_application_2/data/repositories/order_repository.dart';
import 'package:flutter_application_2/data/repositories/order_item_repository.dart';

class CartService extends ChangeNotifier {
  final OrderRepository orderRepository;
  final OrderItemRepository orderItemRepository;

  Order? _currentOrder;
  final List<OrderItem> _items = [];

  CartService({
    required this.orderRepository,
    required this.orderItemRepository,
  });

  Order? get currentOrder => _currentOrder;
  List<OrderItem> get items => List.unmodifiable(_items);

  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + (item.quantity * 10));
  }

  void startOrder({
    required int userId,
    required int restaurantId,
    int? userAddressId,
    required DeliveryType deliveryType,
  }) {
    _currentOrder = Order(
      userId: userId,
      restaurantId: restaurantId,
      userAddressId: userAddressId,
      deliveryType: deliveryType,
      status: OrderStatus.preparing,
      totalPrice: 0,
    );
    _items.clear();
    notifyListeners();
  }

  void addItem(int productId, int quantity) {
    final existing = _items.indexWhere((i) => i.productId == productId);
    if (existing >= 0) {
      _items[existing] = _items[existing].copyWith(
        quantity: _items[existing].quantity + quantity,
      );
    } else {
      _items.add(
        OrderItem(orderId: 0, productId: productId, quantity: quantity),
      );
    }
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.removeWhere((item) => item.productId == productId);
    notifyListeners();
  }

  void clearCart() {
    _currentOrder = null;
    _items.clear();
    notifyListeners();
  }

  Future<void> finalizeOrder() async {
    if (_currentOrder == null || _items.isEmpty) {
      throw Exception('Pedido vazio ou não iniciado.');
    }

    final createdOrder = await orderRepository.create(
      _currentOrder!.copyWith(totalPrice: totalPrice),
    );

    for (var item in _items) {
      await orderItemRepository.create(
        item.copyWith(orderId: createdOrder.id!),
      );
    }

    clearCart();
  }
}
