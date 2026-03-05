import 'package:equatable/equatable.dart';

import '../../../domain/entities/product.dart';

enum ProductListStatus { initial, loading, loaded, loadingMore, error }

class ProductListState extends Equatable {
  const ProductListState({
    this.products = const [],
    this.status = ProductListStatus.initial,
    this.hasMore = true,
    this.currentSkip = 0,
    this.searchQuery = '',
    this.selectedCategory,
    this.selectedProductId,
    this.isOffline = false,
    this.errorMessage,
  });

  final List<Product> products;
  final ProductListStatus status;
  final bool hasMore;
  final int currentSkip;
  final String searchQuery;
  final String? selectedCategory;
  final int? selectedProductId;
  final bool isOffline;
  final String? errorMessage;

  ProductListState copyWith({
    List<Product>? products,
    ProductListStatus? status,
    bool? hasMore,
    int? currentSkip,
    String? searchQuery,
    String? Function()? selectedCategory,
    int? Function()? selectedProductId,
    bool? isOffline,
    String? Function()? errorMessage,
  }) {
    return ProductListState(
      products: products ?? this.products,
      status: status ?? this.status,
      hasMore: hasMore ?? this.hasMore,
      currentSkip: currentSkip ?? this.currentSkip,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory != null ? selectedCategory() : this.selectedCategory,
      selectedProductId: selectedProductId != null ? selectedProductId() : this.selectedProductId,
      isOffline: isOffline ?? this.isOffline,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [products, status, hasMore, currentSkip, searchQuery, selectedCategory, selectedProductId, isOffline, errorMessage];
}
