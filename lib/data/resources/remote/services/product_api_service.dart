import 'package:flutter_application_30/core/services/network_services/api_clients.dart';
import 'package:flutter_application_30/core/services/network_services/api_end_points.dart';

class ProductApiService {
  final ApiClient _client = ApiClient();

  Future<dynamic> fetchProducts() async {
    return await _client.getRequest(
      endpoints: ApiEndpoints.productsEndpoint.replaceFirst('/', ''),
    );
  }

  Future<dynamic> fetchProductById(int id) async {
    return await _client.getRequest(
      endpoints: '${ApiEndpoints.productsEndpoint}/$id'
          .replaceFirst('//', '/')
          .replaceFirst('/', ''),
    );
  }
}
