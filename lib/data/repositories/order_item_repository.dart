import 'package:flutter_application_2/domain/models/order_item.dart';

abstract class OrderItemRepository {
  Future<OrderItem?> getById(int orderId);
  Future<List<OrderItem>> getAllByOrderId(int orderId);
  Future<OrderItem> create(OrderItem item);
  Future<OrderItem> update(OrderItem item);
  Future<bool> delete(int id);
}

class InMemoryOrderItemRepository implements OrderItemRepository {
  final List<OrderItem> _items = [];
  var _nextId = 1;

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
    final newItem = OrderItem(
      id: _nextId++,
      orderId: item.orderId,
      productId: item.productId,
      quantity: item.quantity,
      unitPrice: item.unitPrice,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

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
