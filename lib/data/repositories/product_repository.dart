import 'package:flutter_application_30/data/models/product_model.dart';
import 'package:flutter_application_30/data/resources/remote/services/product_api_service.dart';

class ProductRepository {
  final ProductApiService _service = ProductApiService();

  Future<List<ProductModel>> getProducts() async {
    final res = await _service.fetchProducts();
    if (res is Map && res.containsKey('success') && res['success'] == false) {
      throw Exception(res['message'] ?? 'Failed to fetch products');
    }
    if (res is List) {
      return res
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Unexpected response format');
  }

  Future<ProductModel> getProductById(int id) async {
    final res = await _service.fetchProductById(id);
    if (res is Map && res.containsKey('success') && res['success'] == false) {
      throw Exception(res['message'] ?? 'Failed to fetch product');
    }
    if (res is Map<String, dynamic>) {
      return ProductModel.fromJson(res);
    }
    throw Exception('Unexpected response format');
  }
}
