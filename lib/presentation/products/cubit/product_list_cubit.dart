import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../../domain/usecases/get_products.dart';
import '../../../domain/usecases/get_products_by_category.dart';
import '../../../domain/usecases/search_products.dart';
import 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit({
    required GetProducts getProducts,
    required SearchProducts searchProducts,
    required GetProductsByCategory getProductsByCategory,
  })  : _getProducts = getProducts,
        _searchProducts = searchProducts,
        _getProductsByCategory = getProductsByCategory,
        super(const ProductListState());

  final GetProducts _getProducts;
  final SearchProducts _searchProducts;
  final GetProductsByCategory _getProductsByCategory;
  Timer? _debounceTimer;

  Future<void> loadProducts() async {
    emit(state.copyWith(status: ProductListStatus.loading));
    await _fetchProducts();
  }

  Future<void> loadMore() async {
    if (state.status == ProductListStatus.loadingMore || !state.hasMore) return;
    emit(state.copyWith(status: ProductListStatus.loadingMore));
    await _fetchProducts(isLoadMore: true);
  }

  void search(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: AppConstants.searchDebounceMs), () {
      emit(state.copyWith(
        searchQuery: query,
        currentSkip: 0,
        products: [],
        status: ProductListStatus.loading,
      ));
      _fetchProducts();
    });
  }

  void selectCategory(String? slug) {
    emit(state.copyWith(
      selectedCategory: () => slug,
      currentSkip: 0,
      products: [],
      status: ProductListStatus.loading,
    ));
    _fetchProducts();
  }

  void selectProduct(int id) {
    emit(state.copyWith(selectedProductId: () => id));
  }

  Future<void> refresh() async {
    emit(state.copyWith(
      currentSkip: 0,
      products: [],
      status: ProductListStatus.loading,
    ));
    await _fetchProducts();
  }

  Future<void> _fetchProducts({bool isLoadMore = false}) async {
    try {
      final skip = isLoadMore ? state.currentSkip + AppConstants.pageSize : 0;
      final hasSearch = state.searchQuery.isNotEmpty;
      final hasCategory = state.selectedCategory != null;

      final page = hasCategory && hasSearch
          // API doesn't support search within category, so search and filter client-side
          ? await _searchProducts(
              query: state.searchQuery,
              limit: AppConstants.pageSize,
              skip: skip,
            )
          : hasCategory
              ? await _getProductsByCategory(
                  categorySlug: state.selectedCategory!,
                  limit: AppConstants.pageSize,
                  skip: skip,
                )
              : hasSearch
                  ? await _searchProducts(
                      query: state.searchQuery,
                      limit: AppConstants.pageSize,
                      skip: skip,
                    )
                  : await _getProducts(
                      limit: AppConstants.pageSize,
                      skip: skip,
                    );

      // Filter by category client-side when both search and category are active
      final items = hasCategory && hasSearch
          ? page.items.where((p) => p.category == state.selectedCategory).toList()
          : page.items;

      final allProducts = isLoadMore ? [...state.products, ...items] : items;

      emit(state.copyWith(
        products: allProducts,
        status: ProductListStatus.loaded,
        hasMore: page.hasMore,
        currentSkip: skip,
        isOffline: false,
        errorMessage: () => null,
      ));
    } catch (e) {
      if (state.products.isNotEmpty) {
        // Keep existing products, just show error
        emit(state.copyWith(
          status: ProductListStatus.error,
          errorMessage: () => e.toString(),
        ));
      } else {
        emit(state.copyWith(
          status: ProductListStatus.error,
          errorMessage: () => e.toString(),
          isOffline: true,
        ));
      }
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
