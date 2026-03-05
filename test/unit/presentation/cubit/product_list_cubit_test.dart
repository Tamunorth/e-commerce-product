import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_catalog/domain/usecases/get_products.dart';
import 'package:product_catalog/domain/usecases/get_products_by_category.dart';
import 'package:product_catalog/domain/usecases/search_products.dart';
import 'package:product_catalog/presentation/products/cubit/product_list_cubit.dart';
import 'package:product_catalog/presentation/products/cubit/product_list_state.dart';

import '../../../helpers/test_product_factory.dart';

class MockGetProducts extends Mock implements GetProducts {}

class MockSearchProducts extends Mock implements SearchProducts {}

class MockGetProductsByCategory extends Mock implements GetProductsByCategory {}

void main() {
  late MockGetProducts mockGetProducts;
  late MockSearchProducts mockSearchProducts;
  late MockGetProductsByCategory mockGetProductsByCategory;

  setUp(() {
    mockGetProducts = MockGetProducts();
    mockSearchProducts = MockSearchProducts();
    mockGetProductsByCategory = MockGetProductsByCategory();
  });

  ProductListCubit buildCubit() => ProductListCubit(
        getProducts: mockGetProducts,
        searchProducts: mockSearchProducts,
        getProductsByCategory: mockGetProductsByCategory,
      );

  group('ProductListCubit', () {
    test('initial state is correct', () {
      final cubit = buildCubit();
      expect(cubit.state.status, ProductListStatus.initial);
      expect(cubit.state.products, isEmpty);
      expect(cubit.state.hasMore, true);
      expect(cubit.state.currentSkip, 0);
      expect(cubit.state.searchQuery, '');
      expect(cubit.state.selectedCategory, isNull);
      cubit.close();
    });

    blocTest<ProductListCubit, ProductListState>(
      'loadProducts emits loading then loaded on success',
      setUp: () {
        when(() => mockGetProducts(limit: any(named: 'limit'), skip: any(named: 'skip')))
            .thenAnswer((_) async => TestProductFactory.createPage(count: 5, total: 100));
      },
      build: buildCubit,
      act: (cubit) => cubit.loadProducts(),
      expect: () => [
        isA<ProductListState>().having(
          (s) => s.status,
          'status',
          ProductListStatus.loading,
        ),
        isA<ProductListState>()
            .having((s) => s.status, 'status', ProductListStatus.loaded)
            .having((s) => s.products.length, 'products count', 5)
            .having((s) => s.hasMore, 'hasMore', true),
      ],
    );

    blocTest<ProductListCubit, ProductListState>(
      'loadProducts emits loading then error on failure',
      setUp: () {
        when(() => mockGetProducts(limit: any(named: 'limit'), skip: any(named: 'skip')))
            .thenThrow(Exception('Network error'));
      },
      build: buildCubit,
      act: (cubit) => cubit.loadProducts(),
      expect: () => [
        isA<ProductListState>().having(
          (s) => s.status,
          'status',
          ProductListStatus.loading,
        ),
        isA<ProductListState>()
            .having((s) => s.status, 'status', ProductListStatus.error)
            .having((s) => s.errorMessage, 'errorMessage', isNotNull),
      ],
    );

    blocTest<ProductListCubit, ProductListState>(
      'loadMore appends products and updates skip',
      setUp: () {
        when(() => mockGetProducts(limit: any(named: 'limit'), skip: any(named: 'skip')))
            .thenAnswer((_) async => TestProductFactory.createPage(count: 5, total: 100));
      },
      build: buildCubit,
      seed: () => ProductListState(
        products: TestProductFactory.createProducts(5),
        status: ProductListStatus.loaded,
        hasMore: true,
        currentSkip: 0,
      ),
      act: (cubit) => cubit.loadMore(),
      expect: () => [
        isA<ProductListState>().having(
          (s) => s.status,
          'status',
          ProductListStatus.loadingMore,
        ),
        isA<ProductListState>()
            .having((s) => s.status, 'status', ProductListStatus.loaded)
            .having((s) => s.products.length, 'products count', 10)
            .having((s) => s.currentSkip, 'currentSkip', 20),
      ],
    );

    blocTest<ProductListCubit, ProductListState>(
      'loadMore does nothing when already loading more',
      build: buildCubit,
      seed: () => const ProductListState(
        status: ProductListStatus.loadingMore,
        hasMore: true,
      ),
      act: (cubit) => cubit.loadMore(),
      expect: () => [],
    );

    blocTest<ProductListCubit, ProductListState>(
      'loadMore does nothing when hasMore is false',
      build: buildCubit,
      seed: () => const ProductListState(
        status: ProductListStatus.loaded,
        hasMore: false,
      ),
      act: (cubit) => cubit.loadMore(),
      expect: () => [],
    );

    blocTest<ProductListCubit, ProductListState>(
      'selectCategory resets and fetches by category',
      setUp: () {
        when(() => mockGetProductsByCategory(
              categorySlug: any(named: 'categorySlug'),
              limit: any(named: 'limit'),
              skip: any(named: 'skip'),
            )).thenAnswer(
          (_) async => TestProductFactory.createPage(count: 3, total: 3),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.selectCategory('laptops'),
      expect: () => [
        isA<ProductListState>()
            .having((s) => s.status, 'status', ProductListStatus.loading)
            .having((s) => s.selectedCategory, 'selectedCategory', 'laptops')
            .having((s) => s.products, 'products', isEmpty)
            .having((s) => s.currentSkip, 'currentSkip', 0),
        isA<ProductListState>()
            .having((s) => s.status, 'status', ProductListStatus.loaded)
            .having((s) => s.products.length, 'products count', 3),
      ],
    );
  });
}
