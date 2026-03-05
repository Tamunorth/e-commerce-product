import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_catalog/data/datasources/product_local_datasource.dart';
import 'package:product_catalog/data/datasources/product_remote_datasource.dart';
import 'package:product_catalog/data/models/product_model.dart';
import 'package:product_catalog/data/models/products_response_model.dart';
import 'package:product_catalog/data/repositories/product_repository_impl.dart';

class MockRemoteDatasource extends Mock implements ProductRemoteDatasource {}

class MockLocalDatasource extends Mock implements ProductLocalDatasource {}

void main() {
  late MockRemoteDatasource mockRemote;
  late MockLocalDatasource mockLocal;
  late ProductRepositoryImpl repository;

  setUp(() {
    mockRemote = MockRemoteDatasource();
    mockLocal = MockLocalDatasource();
    repository = ProductRepositoryImpl(
      remoteDatasource: mockRemote,
      localDatasource: mockLocal,
    );
  });

  final tProductModel = ProductModel.fromJson(const {
    'id': 1,
    'title': 'Test',
    'description': 'Desc',
    'price': 10,
    'discountPercentage': 5,
    'rating': 4.0,
    'stock': 10,
    'brand': 'Brand',
    'category': 'cat',
    'thumbnail': 'https://example.com/thumb.jpg',
    'images': ['https://example.com/img.jpg'],
  });

  final tResponse = ProductsResponseModel(
    products: [tProductModel],
    total: 100,
    skip: 0,
    limit: 20,
  );

  group('getProducts', () {
    test('returns data from remote on success', () async {
      when(() => mockRemote.getProducts(limit: 20, skip: 0))
          .thenAnswer((_) async => tResponse);
      when(() => mockLocal.cacheData(any(), any()))
          .thenAnswer((_) async {});

      final result = await repository.getProducts(limit: 20, skip: 0);

      expect(result.items, hasLength(1));
      expect(result.items.first.id, 1);
      expect(result.total, 100);
      verify(() => mockRemote.getProducts(limit: 20, skip: 0)).called(1);
    });

    test('caches data on successful remote fetch', () async {
      when(() => mockRemote.getProducts(limit: 20, skip: 0))
          .thenAnswer((_) async => tResponse);
      when(() => mockLocal.cacheData(any(), any()))
          .thenAnswer((_) async {});

      await repository.getProducts(limit: 20, skip: 0);

      verify(() => mockLocal.cacheData('products_20_0', any())).called(1);
    });

    test('returns cached data when remote fails', () async {
      when(() => mockRemote.getProducts(limit: 20, skip: 0))
          .thenThrow(Exception('No network'));
      when(() => mockLocal.getCachedData('products_20_0'))
          .thenAnswer((_) async => {
                'products': [tProductModel.toJson()],
                'total': 100,
                'skip': 0,
                'limit': 20,
              });

      final result = await repository.getProducts(limit: 20, skip: 0);

      expect(result.items, hasLength(1));
      expect(result.total, 100);
    });

    test('throws when remote fails and cache is empty', () async {
      when(() => mockRemote.getProducts(limit: 20, skip: 0))
          .thenThrow(Exception('No network'));
      when(() => mockLocal.getCachedData('products_20_0'))
          .thenAnswer((_) async => null);

      expect(
        () => repository.getProducts(limit: 20, skip: 0),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('getProductById', () {
    test('returns product from remote when cache is empty', () async {
      when(() => mockLocal.getCachedData('product_1'))
          .thenAnswer((_) async => null);
      when(() => mockRemote.getProductById(1))
          .thenAnswer((_) async => tProductModel);
      when(() => mockLocal.cacheData(any(), any()))
          .thenAnswer((_) async {});

      final result = await repository.getProductById(1);

      expect(result.id, 1);
      expect(result.title, 'Test');
      verify(() => mockRemote.getProductById(1)).called(1);
    });

    test('returns cached product immediately and refreshes in background',
        () async {
      when(() => mockLocal.getCachedData('product_1'))
          .thenAnswer((_) async => tProductModel.toJson());
      when(() => mockRemote.getProductById(1))
          .thenAnswer((_) async => tProductModel);
      when(() => mockLocal.cacheData(any(), any()))
          .thenAnswer((_) async {});

      final result = await repository.getProductById(1);

      expect(result.id, 1);
      // Remote was not awaited, but will fire in background
    });

    test('returns from remote when cache is empty and caches result',
        () async {
      when(() => mockLocal.getCachedData('product_1'))
          .thenAnswer((_) async => null);
      when(() => mockRemote.getProductById(1))
          .thenAnswer((_) async => tProductModel);
      when(() => mockLocal.cacheData(any(), any()))
          .thenAnswer((_) async {});

      await repository.getProductById(1);

      verify(() => mockLocal.cacheData('product_1', any())).called(1);
    });

    test('throws when cache is empty and remote fails', () async {
      when(() => mockLocal.getCachedData('product_1'))
          .thenAnswer((_) async => null);
      when(() => mockRemote.getProductById(1))
          .thenThrow(Exception('No network'));

      expect(
        () => repository.getProductById(1),
        throwsA(isA<Exception>()),
      );
    });
  });
}
