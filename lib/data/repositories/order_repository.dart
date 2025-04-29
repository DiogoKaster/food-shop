import 'package:flutter_application_2/domain/models/order.dart';

abstract class OrderRepository {
  Future<Order?> getById(int id);
  Future<List<Order>> getAllByUserId(int userId);
  Future<Order> create(Order order);
  Future<Order> update(Order order);
  Future<bool> delete(int id);
}

class InMemoryOrderRepository implements OrderRepository {
  final List<Order> _orders = [];
  var _nextId = 1;

  InMemoryOrderRepository() {
    _mockOrders();
  }

  void _mockOrders() {
    _orders.addAll([
      Order(
        id: _nextId++,
        userId: 1,
        restaurantId: 1,
        userAddressId: 1,
        deliveryType: DeliveryType.standard,
        status: OrderStatus.preparing,
        totalPrice: 50.0,
        paidAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
      Order(
        id: _nextId++,
        userId: 1,
        userAddressId: 1,
        restaurantId: 2,
        deliveryType: DeliveryType.express,
        status: OrderStatus.inDelivery,
        totalPrice: 75.0,
        paidAt: DateTime.now().subtract(Duration(days: 1)),
      ),
      Order(
        id: _nextId++,
        userId: 1,
        restaurantId: 3,
        userAddressId: 1,
        deliveryType: DeliveryType.standard,
        status: OrderStatus.delivered,
        totalPrice: 40.0,
        paidAt: DateTime.now().subtract(Duration(days: 3)),
      ),
      Order(
        id: _nextId++,
        userId: 1,
        restaurantId: 4,
        userAddressId: 1,
        deliveryType: DeliveryType.standard,
        status: OrderStatus.cancelled,
        totalPrice: 20.0,
        paidAt: DateTime.now().subtract(Duration(days: 7)),
      ),
    ]);
  }

  @override
  Future<Order?> getById(int id) async {
    return _orders.firstWhere((o) => o.id == id);
  }

  @override
  Future<List<Order>> getAllByUserId(int userId) async {
    return _orders.where((o) => o.userId == userId).toList();
  }

  @override
  Future<Order> create(Order order) async {
    final newOrder = order.copyWith(id: _nextId++, createdAt: DateTime.now());

    _orders.add(newOrder);
    return newOrder;
  }

  @override
  Future<Order> update(Order order) async {
    if (order.id == null) {
      throw Exception('ID do pedido não pode ser nulo');
    }

    final index = _orders.indexWhere((o) => o.id == order.id);
    if (index == -1) {
      throw Exception('Pedido não encontrado');
    }

    final updatedOrder = order.copyWith(updatedAt: DateTime.now());
    _orders[index] = updatedOrder;

    return updatedOrder;
  }

  @override
  Future<bool> delete(int id) async {
    final index = _orders.indexWhere((o) => o.id == id);
    if (index == -1) {
      throw Exception('Pedido não encontrado');
    }

    _orders.removeAt(index);
    return true;
  }
}
