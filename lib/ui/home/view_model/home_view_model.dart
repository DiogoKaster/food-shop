import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repositories/restaurant_repository.dart';
import 'package:flutter_application_2/domain/models/restaurant.dart';

class HomeViewModel extends ChangeNotifier {
  final RestaurantRepository _restaurantRepository;

  HomeViewModel({required RestaurantRepository restaurantRepository})
    : _restaurantRepository = restaurantRepository {
    _load();
  }

  List<Restaurant> _restaurants = [];
  bool _isLoading = false;

  List<Restaurant> get restaurants => _restaurants;
  bool get isLoading => _isLoading;

  Future<void> _load() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _restaurantRepository.getAll();
      _restaurants = result;
    } catch (e) {
      debugPrint('Erro ao carregar restaurantes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
