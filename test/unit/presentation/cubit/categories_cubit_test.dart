import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_catalog/domain/usecases/get_categories.dart';
import 'package:product_catalog/presentation/products/cubit/categories_cubit.dart';

import '../../../helpers/test_product_factory.dart';

class MockGetCategories extends Mock implements GetCategories {}

void main() {
  late MockGetCategories mockGetCategories;

  setUp(() {
    mockGetCategories = MockGetCategories();
  });

  CategoriesCubit buildCubit() => CategoriesCubit(mockGetCategories);

  group('CategoriesCubit', () {
    test('initial state has empty categories and not loading', () {
      final cubit = buildCubit();
      expect(cubit.state.categories, isEmpty);
      expect(cubit.state.isLoading, false);
      expect(cubit.state.error, isNull);
      cubit.close();
    });

    blocTest<CategoriesCubit, CategoriesState>(
      'loadCategories emits loading then loaded with categories',
      setUp: () {
        when(() => mockGetCategories()).thenAnswer(
          (_) async => TestProductFactory.createCategories(3),
        );
      },
      build: buildCubit,
      act: (cubit) => cubit.loadCategories(),
      expect: () => [
        isA<CategoriesState>()
            .having((s) => s.isLoading, 'isLoading', true),
        isA<CategoriesState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.categories.length, 'categories count', 3)
            .having((s) => s.error, 'error', isNull),
      ],
    );

    blocTest<CategoriesCubit, CategoriesState>(
      'loadCategories emits error on failure',
      setUp: () {
        when(() => mockGetCategories())
            .thenThrow(Exception('Failed to load'));
      },
      build: buildCubit,
      act: (cubit) => cubit.loadCategories(),
      expect: () => [
        isA<CategoriesState>()
            .having((s) => s.isLoading, 'isLoading', true),
        isA<CategoriesState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.error, 'error', isNotNull),
      ],
    );
  });
}
