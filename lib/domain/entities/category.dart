import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    required this.slug,
    required this.name,
    required this.url,
  });

  final String slug;
  final String name;
  final String url;

  @override
  List<Object?> get props => [slug];
}
