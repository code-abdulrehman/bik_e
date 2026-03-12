import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _products = demoProducts;

  List<Product> get products => [..._products];

  void toggleFavorite(String id) {
    final productIndex = _products.indexWhere((p) => p.id == id);
    if (productIndex >= 0) {
      _products[productIndex].isFavorite = !_products[productIndex].isFavorite;
      notifyListeners();
    }
  }

  bool isFavorite(String id) {
    return _products.firstWhere((p) => p.id == id).isFavorite;
  }
}
