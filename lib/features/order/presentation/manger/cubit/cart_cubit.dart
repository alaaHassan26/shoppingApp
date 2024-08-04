import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoping/features/home/data/models/get_prodcts_model/get_prodcts_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    _loadCartItems();
  }

  final List<ProductModel> _cartItems = [];

  void addToCart(ProductModel product) async {
    final existingProduct = _cartItems.firstWhere(
      (item) => item.id == product.id,
      orElse: () => ProductModel(
          id: null,
          price: 0,
          oldPrice: 0,
          discount: 0,
          image: '',
          name: '',
          description: '',
          inFavorites: false,
          images: []),
    );

    if (existingProduct.id != null) {
      existingProduct.quantity += product.quantity;
    } else {
      _cartItems.add(product);
    }

    emit(CartUpdated(_cartItems));
    await _saveCartItems();
  }

  void increaseQuantity(ProductModel product) async {
    final existingProduct = _cartItems.firstWhere(
      (item) => item.id == product.id,
      orElse: () => ProductModel(
          id: null,
          price: 0,
          oldPrice: 0,
          discount: 0,
          image: '',
          name: '',
          description: '',
          inFavorites: false,
          images: []),
    );

    if (existingProduct.id != null) {
      existingProduct.quantity += 1;
    }

    emit(CartUpdated(_cartItems));
    await _saveCartItems();
  }

  void decreaseQuantity(ProductModel product) async {
    final existingProduct = _cartItems.firstWhere(
      (item) => item.id == product.id,
      orElse: () => ProductModel(
          id: null,
          price: 0,
          oldPrice: 0,
          discount: 0,
          image: '',
          name: '',
          description: '',
          inFavorites: false,
          images: []),
    );

    if (existingProduct.id != null && existingProduct.quantity > 1) {
      existingProduct.quantity -= 1;
    } else {
      _cartItems.remove(existingProduct);
    }

    emit(CartUpdated(_cartItems));
    await _saveCartItems();
  }

  void removeFromCart(ProductModel product) async {
    _cartItems.removeWhere((item) => item.id == product.id);

    emit(CartUpdated(_cartItems));
    await _saveCartItems();
  }

  List<ProductModel> get cartItems => _cartItems;

  void _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsString = prefs.getString('cartItems');

    if (cartItemsString != null) {
      final List<dynamic> jsonList = json.decode(cartItemsString);
      _cartItems.clear();
      _cartItems.addAll(jsonList.map((json) => ProductModel.fromJson(json)));
      emit(CartUpdated(_cartItems));
    }
  }

  Future<void> _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList =
        _cartItems.map((item) => item.toJson()).toList();
    await prefs.setString('cartItems', json.encode(jsonList));
  }
}
