import 'package:product_catalog/domain/entities/product.dart';
import 'package:product_catalog/domain/entities/products_page.dart';
import 'package:product_catalog/domain/entities/category.dart';

class TestProductFactory {
  static Product createProduct({
    int id = 1,
    String title = 'Test Product',
    String description = 'A test product description',
    double price = 29.99,
    double discountPercentage = 10.0,
    double rating = 4.5,
    int stock = 50,
    String brand = 'TestBrand',
    String category = 'smartphones',
    String thumbnail = 'https://example.com/thumb.jpg',
    List<String> images = const ['https://example.com/img1.jpg'],
  }) {
    return Product(
      id: id,
      title: title,
      description: description,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      brand: brand,
      category: category,
      thumbnail: thumbnail,
      images: images,
    );
  }

  static List<Product> createProducts(int count) {
    return List.generate(
      count,
      (i) => createProduct(
        id: i + 1,
        title: 'Product ${i + 1}',
        price: 10.0 + i,
      ),
    );
  }

  static ProductsPage createPage({
    int count = 5,
    int total = 100,
    int skip = 0,
    int limit = 20,
  }) {
    return ProductsPage(
      items: createProducts(count),
      total: total,
      skip: skip,
      limit: limit,
    );
  }

  static Category createCategory({
    String slug = 'smartphones',
    String name = 'Smartphones',
    String url = 'https://example.com/categories/smartphones',
  }) {
    return Category(slug: slug, name: name, url: url);
  }

  static List<Category> createCategories(int count) {
    return List.generate(
      count,
      (i) => createCategory(
        slug: 'category-$i',
        name: 'Category $i',
      ),
    );
  }
}
