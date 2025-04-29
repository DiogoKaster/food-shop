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
    final newOrder = Order(
      id: _nextId++,
      userId: order.userId,
      userAddressId: order.userAddressId,
      deliveryType: order.deliveryType,
      status: order.status,
      totalPrice: order.totalPrice,
      paidAt: order.paidAt,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

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
