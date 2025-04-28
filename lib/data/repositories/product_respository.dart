import 'package:flutter_application_2/domain/models/product.dart';

abstract class ProductRespository {
  Future<Product> getById(int id);
  Future<List<Product>> getAllByRestaurantId(int id);
  Future<Product> create(Product product);
  Future<Product> update(Product product);
  Future<bool> delete(int id);
}
