import '../entities/products_page.dart';
import '../repositories/product_repository.dart';

class GetProductsByCategory {
  const GetProductsByCategory(this._repository);
  final ProductRepository _repository;

  Future<ProductsPage> call({required String categorySlug, required int limit, required int skip}) =>
      _repository.getProductsByCategory(categorySlug: categorySlug, limit: limit, skip: skip);
}
