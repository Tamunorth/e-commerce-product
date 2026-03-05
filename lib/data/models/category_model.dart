import '../../domain/entities/category.dart';

class CategoryModel {
  const CategoryModel({
    required this.slug,
    required this.name,
    required this.url,
  });

  final String slug;
  final String name;
  final String url;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'] as String,
      name: json['name'] as String,
      url: json['url'] as String? ?? '',
    );
  }

  Category toEntity() => Category(slug: slug, name: name, url: url);
}
