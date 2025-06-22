import 'package:flutter_application_2/data/database/db.dart';
import 'package:flutter_application_2/domain/models/product.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductRepository {
  Future<Product?> getById(int id);
  Future<List<Product>> getAllByRestaurantId(int restaurantId);
  Future<Product> create(Product product);
  Future<Product> update(Product product);
  Future<bool> delete(int id);
}

class DatabaseProductRepository implements ProductRepository {
  Future<Database> get _db async => await DB.instance.database;

  @override
  Future<Product?> getById(int id) async {
    final db = await _db;
    final result = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return _mapToProduct(result.first);
    }

    return null;
  }

  @override
  Future<List<Product>> getAllByRestaurantId(int restaurantId) async {
    final db = await _db;
    final result = await db.query(
      'products',
      where: 'restaurant_id = ?',
      whereArgs: [restaurantId],
    );

    return result.map(_mapToProduct).toList();
  }

  @override
  Future<Product> create(Product product) async {
    final db = await _db;
    final id = await db.insert('products', {
      'restaurant_id': product.restaurantId,
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'image': product.image,
    });

    return product.copyWith(id: id);
  }

  @override
  Future<Product> update(Product product) async {
    final db = await _db;

    await db.update(
      'products',
      {
        'restaurant_id': product.restaurantId,
        'name': product.name,
        'description': product.description,
        'price': product.price,
        'image': product.image,
      },
      where: 'id = ?',
      whereArgs: [product.id],
    );

    return product;
  }

  @override
  Future<bool> delete(int id) async {
    final db = await _db;
    final rowsDeleted = await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );

    return rowsDeleted > 0;
  }

  Product _mapToProduct(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      restaurantId: map['restaurant_id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price:
          map['price'] is int
              ? (map['price'] as int).toDouble()
              : map['price'] as double,
      image: map['image'] as String?,
    );
  }
}

class InMemoryProductRepository implements ProductRepository {
  final List<Product> _products = [];
  var _nextId = 1;

  InMemoryProductRepository() {
    _mockProducts();
  }

  void _mockProducts() {
    _products.addAll([
      Product(
        id: 1,
        restaurantId: 1,
        name: 'Marmita Tradicional',
        description: 'Arroz, feijão, carne e salada',
        image: 'assets/bitcoin.png',
        price: 15.90,
      ),
      Product(
        id: 2,
        restaurantId: 1,
        name: 'Marmita Fitness',
        description: 'Arroz integral, frango grelhado e legumes',
        image: 'assets/bitcoin.png',
        price: 18.90,
      ),
      Product(
        id: 3,
        restaurantId: 2,
        name: 'Espaguete à Bolonhesa',
        description: 'Macarrão com molho de tomate e carne moída',
        image: 'assets/cardano.png',
        price: 16.50,
      ),
      Product(
        id: 4,
        restaurantId: 3,
        name: 'Feijoada Completa',
        description: 'Feijão preto, carnes variadas, arroz, couve e laranja',
        image: 'assets/ethereum.png',
        price: 22.90,
      ),
    ]);
  }

  @override
  Future<Product?> getById(int id) async {
    return _products.firstWhere((p) => p.id == id);
  }

  @override
  Future<List<Product>> getAllByRestaurantId(int restaurantId) async {
    return _products.where((p) => p.restaurantId == restaurantId).toList();
  }

  @override
  Future<Product> create(Product product) async {
    final newProduct = product.copyWith(
      id: _nextId++,
      createdAt: DateTime.now(),
    );

    _products.add(newProduct);

    return newProduct;
  }

  @override
  Future<Product> update(Product product) async {
    final index = _products.indexWhere((p) => p.id == product.id);

    if (index == -1) {
      throw Exception('Produto não encontrado');
    }

    final updatedProduct = product.copyWith(updatedAt: DateTime.now());
    _products[index] = updatedProduct;

    return updatedProduct;
  }

  @override
  Future<bool> delete(int id) async {
    final index = _products.indexWhere((p) => p.id == id);

    if (index == -1) {
      throw Exception('Produto não encontrado');
    }

    _products.removeAt(index);

    return true;
  }
}
