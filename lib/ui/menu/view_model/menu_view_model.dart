import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/repositories/product_respository.dart';
import 'package:flutter_application_2/domain/models/product.dart';

class MenuViewModel extends ChangeNotifier {
  final ProductRepository productRepository;

  int? restaurantId;
  List<Product> products = [];
  String? errorMessage;

  bool isLoading = true;

  MenuViewModel({required this.productRepository});

  Future<void> getProducts() async {
    if (restaurantId == null) {
      errorMessage = 'Restaurante não definido';
      isLoading = false;
      notifyListeners();
      return;
    }

    try {
      products = await productRepository.getAllByRestaurantId(restaurantId!);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Erro ao carregar produtos';
      products = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
