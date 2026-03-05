import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/products_page.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/category_model.dart';
import '../models/products_response_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  final ProductRemoteDatasource remoteDatasource;
  final ProductLocalDatasource localDatasource;

  @override
  Future<ProductsPage> getProducts({required int limit, required int skip}) async {
    final cacheKey = 'products_${limit}_$skip';
    try {
      final response = await remoteDatasource.getProducts(limit: limit, skip: skip);
      await localDatasource.cacheData(cacheKey, {
        'products': response.products.map((p) => p.toJson()).toList(),
        'total': response.total,
        'skip': response.skip,
        'limit': response.limit,
      });
      return _toPage(response);
    } catch (e) {
      return _fromCacheOrThrow(cacheKey, e);
    }
  }

  @override
  Future<ProductsPage> searchProducts({required String query, required int limit, required int skip}) async {
    final cacheKey = 'search_${query}_${limit}_$skip';
    try {
      final response = await remoteDatasource.searchProducts(query: query, limit: limit, skip: skip);
      await localDatasource.cacheData(cacheKey, {
        'products': response.products.map((p) => p.toJson()).toList(),
        'total': response.total,
        'skip': response.skip,
        'limit': response.limit,
      });
      return _toPage(response);
    } catch (e) {
      return _fromCacheOrThrow(cacheKey, e);
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    const cacheKey = 'categories';
    try {
      final models = await remoteDatasource.getCategories();
      await localDatasource.cacheData(
        cacheKey,
        models.map((m) => {'slug': m.slug, 'name': m.name, 'url': m.url}).toList(),
      );
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      final cached = await localDatasource.getCachedData(cacheKey);
      if (cached == null) throw e;
      return (cached as List)
          .map((e) => CategoryModel.fromJson(Map<String, dynamic>.from(e)))
          .map((m) => m.toEntity())
          .toList();
    }
  }

  @override
  Future<ProductsPage> getProductsByCategory({required String categorySlug, required int limit, required int skip}) async {
    final cacheKey = 'category_${categorySlug}_${limit}_$skip';
    try {
      final response = await remoteDatasource.getProductsByCategory(
        categorySlug: categorySlug,
        limit: limit,
        skip: skip,
      );
      await localDatasource.cacheData(cacheKey, {
        'products': response.products.map((p) => p.toJson()).toList(),
        'total': response.total,
        'skip': response.skip,
        'limit': response.limit,
      });
      return _toPage(response);
    } catch (e) {
      return _fromCacheOrThrow(cacheKey, e);
    }
  }

  @override
  Future<Product> getProductById(int id) async {
    final cacheKey = 'product_$id';

    // Return cached data immediately if available
    final cached = await localDatasource.getCachedData(cacheKey);
    if (cached != null) {
      // Fire-and-forget background refresh so cache stays fresh
      _refreshProductInBackground(id, cacheKey);
      return _productFromMap(Map<String, dynamic>.from(cached));
    }

    // No cache: fetch from network
    try {
      final model = await remoteDatasource.getProductById(id);
      await localDatasource.cacheData(cacheKey, model.toJson());
      return model.toEntity();
    } catch (_) {
      rethrow;
    }
  }

  Future<void> _refreshProductInBackground(int id, String cacheKey) async {
    try {
      final model = await remoteDatasource.getProductById(id);
      await localDatasource.cacheData(cacheKey, model.toJson());
    } catch (_) {
      // Silently ignore - we already returned cached data
    }
  }

  ProductsPage _toPage(ProductsResponseModel response) => ProductsPage(
    items: response.products.map((m) => m.toEntity()).toList(),
    total: response.total,
    skip: response.skip,
    limit: response.limit,
  );

  Future<ProductsPage> _fromCacheOrThrow(String key, Object originalError) async {
    final cached = await localDatasource.getCachedData(key);
    if (cached == null) throw originalError;
    final map = Map<String, dynamic>.from(cached);
    final products = (map['products'] as List)
        .map((e) => _productFromMap(Map<String, dynamic>.from(e)))
        .toList();
    return ProductsPage(
      items: products,
      total: map['total'] as int,
      skip: map['skip'] as int,
      limit: map['limit'] as int,
    );
  }

  Product _productFromMap(Map<String, dynamic> json) => Product(
    id: json['id'] as int,
    title: json['title'] as String? ?? '',
    description: json['description'] as String? ?? '',
    price: (json['price'] as num).toDouble(),
    discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0,
    rating: (json['rating'] as num?)?.toDouble() ?? 0,
    stock: json['stock'] as int? ?? 0,
    brand: json['brand'] as String? ?? '',
    category: json['category'] as String? ?? '',
    thumbnail: json['thumbnail'] as String? ?? '',
    images: (json['images'] as List?)?.cast<String>() ?? [],
  );
}
