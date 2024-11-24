

import 'package:flutter/material.dart';
import '../models/product.dart';

class Cart with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    final existingItemIndex =
        _cartItems.indexWhere((item) => item.name == product.name);
    if (existingItemIndex != -1) {
      _cartItems[existingItemIndex].quantity += product.quantity;
    } else {
      _cartItems.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.removeWhere((item) => item.name == product.name);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
