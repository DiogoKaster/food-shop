import 'package:flutter_application_2/domain/models/restaurant.dart';

abstract class RestaurantRepository {
  Future<Restaurant?> getById(int id);
  Future<List<Restaurant>> getAll();
  Future<Restaurant> create(Restaurant restaurant);
  Future<Restaurant> updated(Restaurant restaurant);
  Future<bool> delete(int id);
}

class InMemoryRestaurantRepository implements RestaurantRepository {
  // final List<Restaurant> _restaurants = [];

  @override
  Future<Restaurant?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<Restaurant>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<Restaurant> create(Restaurant restaurant) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Restaurant> updated(Restaurant restaurant) {
    // TODO: implement updated
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
