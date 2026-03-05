import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/data/models/product_model.dart';

void main() {
  group('ProductModel', () {
    const completeJson = {
      'id': 1,
      'title': 'iPhone 15',
      'description': 'Latest iPhone',
      'price': 999.99,
      'discountPercentage': 5.5,
      'rating': 4.7,
      'stock': 42,
      'brand': 'Apple',
      'category': 'smartphones',
      'thumbnail': 'https://example.com/thumb.jpg',
      'images': [
        'https://example.com/img1.jpg',
        'https://example.com/img2.jpg',
      ],
    };

    group('fromJson', () {
      test('parses complete valid JSON correctly', () {
        final model = ProductModel.fromJson(completeJson);

        expect(model.id, 1);
        expect(model.title, 'iPhone 15');
        expect(model.description, 'Latest iPhone');
        expect(model.price, 999.99);
        expect(model.discountPercentage, 5.5);
        expect(model.rating, 4.7);
        expect(model.stock, 42);
        expect(model.brand, 'Apple');
        expect(model.category, 'smartphones');
        expect(model.thumbnail, 'https://example.com/thumb.jpg');
        expect(model.images, hasLength(2));
      });

      test('handles missing optional fields with defaults', () {
        final json = {
          'id': 2,
          'price': 100,
        };

        final model = ProductModel.fromJson(json);

        expect(model.id, 2);
        expect(model.title, '');
        expect(model.description, '');
        expect(model.price, 100.0);
        expect(model.discountPercentage, 0.0);
        expect(model.rating, 0.0);
        expect(model.stock, 0);
        expect(model.brand, '');
        expect(model.category, '');
        expect(model.thumbnail, '');
        expect(model.images, isEmpty);
      });

      test('handles null brand and empty images list', () {
        final json = {
          'id': 3,
          'price': 50,
          'brand': null,
          'images': null,
        };

        final model = ProductModel.fromJson(json);

        expect(model.brand, '');
        expect(model.images, isEmpty);
      });
    });

    group('toEntity', () {
      test('produces correct Product entity', () {
        final model = ProductModel.fromJson(completeJson);
        final entity = model.toEntity();

        expect(entity.id, model.id);
        expect(entity.title, model.title);
        expect(entity.description, model.description);
        expect(entity.price, model.price);
        expect(entity.discountPercentage, model.discountPercentage);
        expect(entity.rating, model.rating);
        expect(entity.stock, model.stock);
        expect(entity.brand, model.brand);
        expect(entity.category, model.category);
        expect(entity.thumbnail, model.thumbnail);
        expect(entity.images, model.images);
      });
    });

    group('toJson', () {
      test('round-trips correctly', () {
        final model = ProductModel.fromJson(completeJson);
        final json = model.toJson();
        final roundTripped = ProductModel.fromJson(json);

        expect(roundTripped.id, model.id);
        expect(roundTripped.title, model.title);
        expect(roundTripped.description, model.description);
        expect(roundTripped.price, model.price);
        expect(roundTripped.discountPercentage, model.discountPercentage);
        expect(roundTripped.rating, model.rating);
        expect(roundTripped.stock, model.stock);
        expect(roundTripped.brand, model.brand);
        expect(roundTripped.category, model.category);
        expect(roundTripped.thumbnail, model.thumbnail);
        expect(roundTripped.images, model.images);
      });
    });
  });
}
