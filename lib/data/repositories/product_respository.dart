import 'package:flutter_application_2/domain/models/product.dart';

abstract class ProductRepository {
  Future<Product?> getById(int id);
  Future<List<Product>> getAllByRestaurantId(int restaurantId);
  Future<Product> create(Product product);
  Future<Product> update(Product product);
  Future<bool> delete(int id);
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
    if (product.id == null) {
      throw Exception('ID do produto não pode ser nulo');
    }

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
