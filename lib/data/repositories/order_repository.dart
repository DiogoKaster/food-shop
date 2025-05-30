import 'package:flutter_application_2/data/database/db.dart';
import 'package:flutter_application_2/domain/models/order.dart';
import 'package:sqflite/sqflite.dart';

abstract class OrderRepository {
  Future<Order?> getById(int id);
  Future<List<Order>> getAllByUserId(int userId);
  Future<Order> create(Order order);
  Future<Order> update(Order order);
  Future<bool> delete(int id);
}

class DatabaseOrderRepository implements OrderRepository {
  Future<Database> get _db async => await DB.instance.database;

  @override
  Future<Order?> getById(int id) async {
    final db = await _db;
    final result = await db.query(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return _mapToOrder(result.first);
    }

    return null;
  }

  @override
  Future<List<Order>> getAllByUserId(int userId) async {
    final db = await _db;
    final result = await db.query(
      'orders',
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    return result.map((row) => _mapToOrder(row)).toList();
  }

  @override
  Future<Order> create(Order order) async {
    final db = await _db;
    final id = await db.insert('orders', {
      'user_id': order.userId,
      'restaurant_id': order.restaurantId,
      'user_address_id': order.userAddressId,
      'delivery_type': order.deliveryType.index,
      'status': order.status.index,
      'total_price': order.totalPrice,
      'paid_at': order.paidAt?.toIso8601String(),
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });

    return order.copyWith(id: id);
  }

  @override
  Future<Order> update(Order order) async {
    final db = await _db;
    await db.update(
      'orders',
      {
        'restaurant_id': order.restaurantId,
        'user_address_id': order.userAddressId,
        'delivery_type': order.deliveryType.index,
        'status': order.status.index,
        'total_price': order.totalPrice,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [order.id],
    );
    return order;
  }

  @override
  Future<bool> delete(int id) async {
    final db = await _db;
    final deleted = await db.delete('orders', where: 'id = ?', whereArgs: [id]);
    return deleted > 0;
  }

  Order _mapToOrder(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as int,
      userId: map['user_id'] as int,
      restaurantId: map['restaurant_id'] as int,
      userAddressId: map['user_address_id'] as int,
      deliveryType: DeliveryType.values[map['delivery_type']],
      status: OrderStatus.values[map['status']],
      totalPrice: map['total_price'] as double,
      paidAt: map['paid_at'] != null ? DateTime.parse(map['paid_at']) : null,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
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
