import '../entities/products_page.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  const GetProducts(this._repository);
  final ProductRepository _repository;

  Future<ProductsPage> call({required int limit, required int skip}) =>
      _repository.getProducts(limit: limit, skip: skip);
}
