import '../entities/products_page.dart';
import '../repositories/product_repository.dart';

class SearchProducts {
  const SearchProducts(this._repository);
  final ProductRepository _repository;

  Future<ProductsPage> call({required String query, required int limit, required int skip}) =>
      _repository.searchProducts(query: query, limit: limit, skip: skip);
}
