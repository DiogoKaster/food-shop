import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repositories/product_respository.dart';
import 'package:flutter_application_2/domain/models/order.dart';
import 'package:flutter_application_2/domain/models/order_item.dart';
import 'package:flutter_application_2/domain/models/product.dart';
import 'package:flutter_application_2/data/repositories/order_repository.dart';
import 'package:flutter_application_2/data/repositories/order_item_repository.dart';

class CartProduct {
  final Product product;
  final int quantity;

  CartProduct({required this.product, required this.quantity});
}

class CartService extends ChangeNotifier {
  final OrderRepository orderRepository;
  final OrderItemRepository orderItemRepository;
  final ProductRepository productRepository;

  Order? _currentOrder;
  final List<OrderItem> _items = [];

  CartService({
    required this.orderRepository,
    required this.orderItemRepository,
    required this.productRepository,
  });

  Order? get currentOrder => _currentOrder;
  List<OrderItem> get items => List.unmodifiable(_items);

  Future<double> get totalPrice async {
    double total = 0;
    for (final item in _items) {
      final product = await productRepository.getById(item.productId);
      if (product != null) {
        total += item.quantity * product.price;
      }
    }
    return total;
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
    debugPrint(_currentOrder.toString());
    if (_currentOrder == null || _items.isEmpty) {
      throw Exception('Pedido vazio ou não iniciado.');
    }

    final total = await totalPrice;

    final createdOrder = await orderRepository.create(
      _currentOrder!.copyWith(totalPrice: total),
    );

    for (var item in _items) {
      await orderItemRepository.create(
        item.copyWith(orderId: createdOrder.id!),
      );
    }

    clearCart();
  }

  Future<List<CartProduct>> getCartProducts() async {
    List<CartProduct> cartProducts = [];

    for (final item in _items) {
      final product = await productRepository.getById(item.productId);
      if (product != null) {
        cartProducts.add(
          CartProduct(product: product, quantity: item.quantity),
        );
      }
    }

    return cartProducts;
  }
}
