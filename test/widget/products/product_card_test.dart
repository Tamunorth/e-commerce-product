import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/presentation/products/widgets/product_card.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/test_product_factory.dart';

void main() {
  group('ProductCard', () {
    testWidgets('displays product title', (tester) async {
      final product = TestProductFactory.createProduct(title: 'Cool Phone');

      await tester.pumpApp(
        SizedBox(
          width: 200,
          height: 300,
          child: ProductCard(
            product: product,
            onTap: () {},
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Cool Phone'), findsOneWidget);
    });

    testWidgets('displays formatted price', (tester) async {
      final product = TestProductFactory.createProduct(price: 49.99);

      await tester.pumpApp(
        SizedBox(
          width: 200,
          height: 300,
          child: ProductCard(
            product: product,
            onTap: () {},
          ),
        ),
      );
      await tester.pump();

      expect(find.text('\$49.99'), findsOneWidget);
    });

    testWidgets('onTap callback fires when tapped', (tester) async {
      var tapped = false;
      final product = TestProductFactory.createProduct();

      await tester.pumpApp(
        SizedBox(
          width: 200,
          height: 300,
          child: ProductCard(
            product: product,
            onTap: () => tapped = true,
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.byType(ProductCard));
      await tester.pump();

      expect(tapped, true);
    });

    testWidgets('Hero widget exists with correct tag', (tester) async {
      final product = TestProductFactory.createProduct(id: 42);

      await tester.pumpApp(
        SizedBox(
          width: 200,
          height: 300,
          child: ProductCard(
            product: product,
            onTap: () {},
          ),
        ),
      );
      await tester.pump();

      final heroFinder = find.byWidgetPredicate(
        (widget) => widget is Hero && widget.tag == 'product-image-42',
      );
      expect(heroFinder, findsOneWidget);
    });
  });
}
