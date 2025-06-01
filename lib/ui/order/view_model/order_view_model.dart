import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repositories/order_repository.dart';
import 'package:flutter_application_2/domain/models/order.dart';

class OrderViewModel extends ChangeNotifier {
  final OrderRepository _orderRepository;
  final int userId;

  OrderViewModel({
    required OrderRepository orderRepository,
    required this.userId,
  }) : _orderRepository = orderRepository {
    _loadOrders();
  }

  List<Order> _orders = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Order> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> _loadOrders() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _orderRepository.getAllByUserId(userId);
      _orders = result;
    } catch (e) {
      _errorMessage = 'Erro ao carregar pedidos: $e';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
