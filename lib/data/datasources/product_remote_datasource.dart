import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/products_response_model.dart';

class ProductRemoteDatasource {
  const ProductRemoteDatasource(this._client);
  final ApiClient _client;

  Future<ProductsResponseModel> getProducts({required int limit, required int skip}) async {
    final data = await _client.get(
      ApiConstants.products,
      queryParameters: {'limit': limit, 'skip': skip},
    );
    return ProductsResponseModel.fromJson(data);
  }

  Future<ProductsResponseModel> searchProducts({
    required String query,
    required int limit,
    required int skip,
  }) async {
    final data = await _client.get(
      ApiConstants.productsSearch,
      queryParameters: {'q': query, 'limit': limit, 'skip': skip},
    );
    return ProductsResponseModel.fromJson(data);
  }

  Future<List<CategoryModel>> getCategories() async {
    final data = await _client.getList(ApiConstants.productsCategories);
    return data
        .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<ProductsResponseModel> getProductsByCategory({
    required String categorySlug,
    required int limit,
    required int skip,
  }) async {
    final data = await _client.get(
      '${ApiConstants.productsByCategory}/$categorySlug',
      queryParameters: {'limit': limit, 'skip': skip},
    );
    return ProductsResponseModel.fromJson(data);
  }

  Future<ProductModel> getProductById(int id) async {
    final data = await _client.get('${ApiConstants.products}/$id');
    return ProductModel.fromJson(data);
  }
}
