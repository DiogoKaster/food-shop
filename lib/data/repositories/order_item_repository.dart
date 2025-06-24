import 'package:flutter_application_2/data/database/db.dart';
import 'package:flutter_application_2/domain/models/order_item.dart';
import 'package:sqflite/sqflite.dart';

abstract class OrderItemRepository {
  Future<OrderItem?> getById(int orderId);
  Future<List<OrderItem>> getAllByOrderId(int orderId);
  Future<OrderItem> create(OrderItem item);
  Future<OrderItem> update(OrderItem item);
  Future<bool> delete(int id);
}

class DatabaseOrderItemRepository implements OrderItemRepository {
  Future<Database> get _db async => await DB.instance.database;

  @override
  Future<OrderItem?> getById(int id) async {
    final db = await _db;
    final result = await db.query(
      'order_items',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return _mapToOrderItem(result.first);
    }

    return null;
  }

  @override
  Future<List<OrderItem>> getAllByOrderId(int orderId) async {
    final db = await _db;
    final result = await db.query(
      'order_items',
      where: 'order_id = ?',
      whereArgs: [orderId],
    );

    return result.map(_mapToOrderItem).toList();
  }

  @override
  Future<OrderItem> create(OrderItem item) async {
    final db = await _db;

    final id = await db.insert('order_items', {
      'order_id': item.orderId,
      'product_id': item.productId,
      'quantity': item.quantity,
      'created_at':
          item.createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      'updated_at':
          item.updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    });

    return item.copyWith(id: id);
  }

  @override
  Future<OrderItem> update(OrderItem item) async {
    final db = await _db;

    await db.update(
      'order_items',
      {
        'order_id': item.orderId,
        'product_id': item.productId,
        'quantity': item.quantity,
        'updated_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [item.id],
    );

    return item;
  }

  @override
  Future<bool> delete(int id) async {
    final db = await _db;
    final result = await db.delete(
      'order_items',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result > 0;
  }

  OrderItem _mapToOrderItem(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id'] as int?,
      orderId: map['order_id'] as int,
      productId: map['product_id'] as int,
      quantity: map['quantity'] as int,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }
}

class InMemoryOrderItemRepository implements OrderItemRepository {
  final List<OrderItem> _items = [];
  var _nextId = 1;

  InMemoryOrderItemRepository() {
    _mockOrderItem();
  }

  void _mockOrderItem() {
    _items.addAll([
      OrderItem(orderId: 1, productId: 1, quantity: 2),
      OrderItem(orderId: 1, productId: 2, quantity: 1),
      OrderItem(orderId: 2, productId: 3, quantity: 3),
      OrderItem(orderId: 3, productId: 4, quantity: 3),
    ]);
  }

  @override
  Future<OrderItem?> getById(int id) async {
    return _items.firstWhere((o) => o.id == id);
  }

  @override
  Future<List<OrderItem>> getAllByOrderId(int orderId) async {
    return _items.where((i) => i.orderId == orderId).toList();
  }

  @override
  Future<OrderItem> create(OrderItem item) async {
    final newItem = item.copyWith(id: _nextId++, createdAt: DateTime.now());

    _items.add(newItem);
    return newItem;
  }

  @override
  Future<OrderItem> update(OrderItem item) async {
    if (item.id == null) {
      throw Exception('ID do item de pedido não pode ser nulo');
    }

    final index = _items.indexWhere((i) => i.id == item.id);
    if (index == -1) {
      throw Exception('Item de pedido não encontrado');
    }

    final updatedItem = item.copyWith(updatedAt: DateTime.now());
    _items[index] = updatedItem;

    return updatedItem;
  }

  @override
  Future<bool> delete(int id) async {
    final index = _items.indexWhere((i) => i.id == id);
    if (index == -1) {
      throw Exception('Item de pedido não encontrado');
    }

    _items.removeAt(index);
    return true;
  }
}
