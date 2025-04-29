import 'package:flutter_application_2/domain/models/restaurant.dart';

abstract class RestaurantRepository {
  Future<Restaurant?> getById(int id);
  Future<List<Restaurant>> getAll();
  Future<Restaurant> create(Restaurant restaurant);
  Future<Restaurant> updated(Restaurant restaurant);
  Future<bool> delete(int id);
}

class InMemoryRestaurantRepository implements RestaurantRepository {
  final List<Restaurant> _restaurants = [];
  var _nextId = 1;

  @override
  Future<Restaurant?> getById(int id) async {
    var restaurant = _restaurants.firstWhere((r) => r.id == id);

    return restaurant;
  }

  @override
  Future<List<Restaurant>> getAll() async {
    return _restaurants.toList();
  }

  @override
  Future<Restaurant> create(Restaurant restaurant) async {
    if (_restaurants.any((r) => r.cnpj == restaurant.cnpj)) {
      throw Exception('Restaurante com esse CNPJ já foi cadastrado');
    }

    final newRestaurant = restaurant.copyWith(
      id: _nextId++,
      createdAt: DateTime.now(),
    );

    _restaurants.add(newRestaurant);

    return newRestaurant;
  }

  @override
  Future<Restaurant> updated(Restaurant restaurant) async {
    if (restaurant.id == null) {
      throw Exception('ID de restaurante não pode ser nulo');
    }

    final index = _restaurants.indexWhere((r) => r.id == restaurant.id);

    if (index == -1) {
      throw Exception('Restaurante não encontrado');
    }

    final updatedRestaurant = restaurant.copyWith(updatedAt: DateTime.now());

    _restaurants[index] = updatedRestaurant;

    return updatedRestaurant;
  }

  @override
  Future<bool> delete(int id) async {
    final index = _restaurants.indexWhere((r) => r.id == id);

    if (index == -1) {
      throw Exception('Restaurante não encontrado');
    }

    _restaurants.removeAt(index);

    return true;
  }
}
