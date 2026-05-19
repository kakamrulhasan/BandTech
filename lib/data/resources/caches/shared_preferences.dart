import 'dart:convert';

import 'package:flutter_application_30/data/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceData {
  static const String _favoriteProductsKey = 'favorite_products';

  static Future<void> setToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', "$token");
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  static Future<void> setIsFirstTime(bool? isFirstTime) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstTime', isFirstTime ?? false);
  }

  static Future<bool?> getIsFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTime');
  }

  static Future<void> removeIsFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('isFirstTime');
  }

  static Future<List<ProductModel>> getFavoriteProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = prefs.getStringList(_favoriteProductsKey) ?? [];
    return productsJson
        .map((product) => ProductModel.fromJson(jsonDecode(product)))
        .toList();
  }

  static Future<void> saveFavoriteProducts(List<ProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = products
        .map((product) => jsonEncode(product.toJson()))
        .toList();
    await prefs.setStringList(_favoriteProductsKey, productsJson);
  }
}
