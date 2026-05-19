import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_30/data/models/product_model.dart';
import 'package:flutter_application_30/data/repositories/product_repository.dart';
import 'package:flutter_application_30/data/resources/caches/shared_preferences.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final productsFutureProvider = FutureProvider<List<ProductModel>>((ref) async {
  final repo = ref.read(productRepositoryProvider);
  return repo.getProducts();
});

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}

final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

final filteredProductsProvider = Provider<AsyncValue<List<ProductModel>>>((
  ref,
) {
  final query = ref.watch(searchQueryProvider);
  final asyncProducts = ref.watch(productsFutureProvider);
  return asyncProducts.when(
    data: (list) {
      if (query.isEmpty) return AsyncValue.data(list);
      final filtered = list
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
      return AsyncValue.data(filtered);
    },
    loading: () => const AsyncValue.loading(),
    error: (e, st) => AsyncValue.error(e, st),
  );
});

class FavoriteProductsNotifier extends AsyncNotifier<List<ProductModel>> {
  @override
  Future<List<ProductModel>> build() {
    return SharedPreferenceData.getFavoriteProducts();
  }

  Future<bool> toggleFavorite(ProductModel product) async {
    final loadedProducts = state.maybeWhen<List<ProductModel>?>(
      data: (products) => products,
      orElse: () => null,
    );
    final currentProducts =
        loadedProducts ?? await SharedPreferenceData.getFavoriteProducts();
    final isAlreadyFavorite = currentProducts.any((p) => p.id == product.id);
    final updatedProducts = isAlreadyFavorite
        ? currentProducts.where((p) => p.id != product.id).toList()
        : [...currentProducts, product];

    state = AsyncValue.data(updatedProducts);
    await SharedPreferenceData.saveFavoriteProducts(updatedProducts);
    return !isAlreadyFavorite;
  }

  bool isFavorite(int productId) {
    return state.maybeWhen(
      data: (products) => products.any((product) => product.id == productId),
      orElse: () => false,
    );
  }
}

final favoriteProductsProvider =
    AsyncNotifierProvider<FavoriteProductsNotifier, List<ProductModel>>(
      FavoriteProductsNotifier.new,
    );
