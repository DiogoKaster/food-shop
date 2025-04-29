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

  InMemoryRestaurantRepository() {
    _mockRestaurants();
  }

  void _mockRestaurants() {
    _restaurants.addAll([
      Restaurant(
        id: 1,
        cnpj: '12.345.678/0001-90',
        name: 'Marmitas Mamma-mia',
        street: 'Rua das Flores',
        number: '123',
        neighborhood: 'Centro',
        city: 'São Paulo',
        state: 'SP',
        zipCode: '01001-000',
        complement: 'Loja 1',
        brand: 'assets/bitcoin.png',
        createdAt: DateTime.now().subtract(Duration(days: 10)),
        updatedAt: DateTime.now(),
      ),
      Restaurant(
        id: 2,
        cnpj: '98.765.432/0001-55',
        name: 'My Mita - Refeições Express',
        street: 'Av. Paulista',
        number: '1000',
        neighborhood: 'Bela Vista',
        city: 'São Paulo',
        state: 'SP',
        zipCode: '01310-000',
        complement: 'Sala 203',
        brand: 'assets/cardano.png',
        createdAt: DateTime.now().subtract(Duration(days: 8)),
        updatedAt: DateTime.now(),
      ),
      Restaurant(
        id: 3,
        cnpj: '11.222.333/0001-44',
        name: 'Sr Marmita',
        street: 'Rua do Comércio',
        number: '456',
        neighborhood: 'Centro',
        city: 'Rio de Janeiro',
        state: 'RJ',
        zipCode: '20010-000',
        complement: '',
        brand: 'assets/ethereum.png',
        createdAt: DateTime.now().subtract(Duration(days: 15)),
        updatedAt: DateTime.now(),
      ),
      Restaurant(
        id: 4,
        cnpj: '22.333.444/0001-11',
        name: 'Crazyfood - Marmita & Marmitex',
        street: 'Av. Brasil',
        number: '789',
        neighborhood: 'Jardins',
        city: 'Belo Horizonte',
        state: 'MG',
        zipCode: '30140-000',
        complement: 'Próximo ao posto',
        brand: 'assets/litecoin.png',
        createdAt: DateTime.now().subtract(Duration(days: 5)),
        updatedAt: DateTime.now(),
      ),
      Restaurant(
        id: 5,
        cnpj: '33.444.555/0001-22',
        name: 'Restaurante Elite - Centro',
        street: 'Rua Central',
        number: '321',
        neighborhood: 'Centro',
        city: 'Curitiba',
        state: 'PR',
        zipCode: '80010-000',
        complement: '',
        brand: 'assets/usdcoin.png',
        createdAt: DateTime.now().subtract(Duration(days: 20)),
        updatedAt: DateTime.now(),
      ),
      Restaurant(
        id: 6,
        cnpj: '44.555.666/0001-33',
        name: 'Casa da Vó',
        street: 'Rua das Acácias',
        number: '50',
        neighborhood: 'Vila Nova',
        city: 'Porto Alegre',
        state: 'RS',
        zipCode: '90010-000',
        complement: 'Fundos',
        brand: 'assets/xrp.png',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        updatedAt: DateTime.now(),
      ),
    ]);
  }

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
