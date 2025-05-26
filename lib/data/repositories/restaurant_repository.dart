import 'package:flutter_application_2/data/database/db.dart';
import 'package:flutter_application_2/domain/models/restaurant.dart';
import 'package:sqflite/sqflite.dart';

abstract class RestaurantRepository {
  Future<Restaurant?> getById(int id);
  Future<List<Restaurant>> getAll();
  Future<Restaurant> create(Restaurant restaurant);
  Future<bool> delete(int id);
}

class DatabaseRestaurantRepository implements RestaurantRepository {
  Future<Database> get _db async => await DB.instance.database;

  @override
  Future<Restaurant?> getById(int id) async {
    final db = await _db;
    final result = await db.query(
      'restaurants',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return _fromMap(result.first);
    }
    return null;
  }

  @override
  Future<List<Restaurant>> getAll() async {
    final db = await _db;
    final result = await db.query('restaurants');
    return result.map(_fromMap).toList();
  }

  @override
  Future<Restaurant> create(Restaurant restaurant) async {
    final db = await _db;
    final id = await db.insert(
      'restaurants',
      _toMap(restaurant, includeId: false),
    );

    return restaurant.copyWith(id: id);
  }

  @override
  Future<bool> delete(int id) async {
    final db = await _db;
    final rows = await db.delete(
      'restaurants',
      where: 'id = ?',
      whereArgs: [id],
    );

    return rows > 0;
  }

  Restaurant _fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      cnpj: map['cnpj'],
      name: map['name'],
      street: map['street'],
      number: map['number'],
      neighborhood: map['neighborhood'],
      city: map['city'],
      state: map['state'],
      zipCode: map['zip_code'],
      complement: map['complement'] ?? '',
      brand: map['brand'],
      createdAt:
          map['created_at'] != null
              ? DateTime.tryParse(map['created_at'])
              : null,
      updatedAt:
          map['updated_at'] != null
              ? DateTime.tryParse(map['updated_at'])
              : null,
    );
  }

  Map<String, dynamic> _toMap(Restaurant restaurant, {bool includeId = true}) {
    final map = <String, dynamic>{
      'cnpj': restaurant.cnpj,
      'name': restaurant.name,
      'street': restaurant.street,
      'number': restaurant.number,
      'neighborhood': restaurant.neighborhood,
      'city': restaurant.city,
      'state': restaurant.state,
      'zip_code': restaurant.zipCode,
      'complement': restaurant.complement,
      'brand': restaurant.brand,
      'created_at': restaurant.createdAt?.toIso8601String(),
      'updated_at': restaurant.updatedAt?.toIso8601String(),
    };

    if (includeId && restaurant.id != null) {
      map['id'] = restaurant.id;
    }

    return map;
  }
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
  Future<bool> delete(int id) async {
    final index = _restaurants.indexWhere((r) => r.id == id);

    if (index == -1) {
      throw Exception('Restaurante não encontrado');
    }

    _restaurants.removeAt(index);

    return true;
  }
}
