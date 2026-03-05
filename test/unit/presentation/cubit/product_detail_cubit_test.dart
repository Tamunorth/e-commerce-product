import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_catalog/domain/usecases/get_product_by_id.dart';
import 'package:product_catalog/presentation/products/cubit/product_detail_cubit.dart';
import 'package:product_catalog/presentation/products/cubit/product_detail_state.dart';

import '../../../helpers/test_product_factory.dart';

class MockGetProductById extends Mock implements GetProductById {}

void main() {
  late MockGetProductById mockGetProductById;

  setUp(() {
    mockGetProductById = MockGetProductById();
  });

  ProductDetailCubit buildCubit() => ProductDetailCubit(mockGetProductById);

  group('ProductDetailCubit', () {
    test('initial state is ProductDetailInitial', () {
      final cubit = buildCubit();
      expect(cubit.state, isA<ProductDetailInitial>());
      cubit.close();
    });

    blocTest<ProductDetailCubit, ProductDetailState>(
      'loadProduct emits Loading then Loaded on success',
      setUp: () {
        when(() => mockGetProductById(any()))
            .thenAnswer((_) async => TestProductFactory.createProduct(id: 1));
      },
      build: buildCubit,
      act: (cubit) => cubit.loadProduct(1),
      expect: () => [
        isA<ProductDetailLoading>(),
        isA<ProductDetailLoaded>().having(
          (s) => s.product.id,
          'product id',
          1,
        ),
      ],
    );

    blocTest<ProductDetailCubit, ProductDetailState>(
      'loadProduct emits Loading then Error on failure',
      setUp: () {
        when(() => mockGetProductById(any()))
            .thenThrow(Exception('Not found'));
      },
      build: buildCubit,
      act: (cubit) => cubit.loadProduct(999),
      expect: () => [
        isA<ProductDetailLoading>(),
        isA<ProductDetailError>().having(
          (s) => s.message,
          'message',
          contains('Not found'),
        ),
      ],
    );
  });
}
