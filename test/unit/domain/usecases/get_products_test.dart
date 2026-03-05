import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_catalog/domain/repositories/product_repository.dart';
import 'package:product_catalog/domain/usecases/get_products.dart';

import '../../../helpers/test_product_factory.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late MockProductRepository mockRepository;
  late GetProducts usecase;

  setUp(() {
    mockRepository = MockProductRepository();
    usecase = GetProducts(mockRepository);
  });

  test('delegates to repository with correct params', () async {
    final tPage = TestProductFactory.createPage();
    when(() => mockRepository.getProducts(limit: 20, skip: 0))
        .thenAnswer((_) async => tPage);

    final result = await usecase(limit: 20, skip: 0);

    expect(result, equals(tPage));
    verify(() => mockRepository.getProducts(limit: 20, skip: 0)).called(1);
  });
}
