import '../entities/category.dart';
import '../entities/product.dart';
import '../entities/products_page.dart';

abstract class ProductRepository {
  Future<ProductsPage> getProducts({required int limit, required int skip});
  Future<ProductsPage> searchProducts({required String query, required int limit, required int skip});
  Future<List<Category>> getCategories();
  Future<ProductsPage> getProductsByCategory({required String categorySlug, required int limit, required int skip});
  Future<Product> getProductById(int id);
}
