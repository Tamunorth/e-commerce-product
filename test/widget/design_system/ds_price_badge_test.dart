import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/presentation/design_system/components/ds_price_badge.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('DsPriceBadge', () {
    testWidgets('displays formatted price', (tester) async {
      await tester.pumpApp(
        const DsPriceBadge(price: 29.99),
      );

      expect(find.text('\$29.99'), findsOneWidget);
    });

    testWidgets('displays discount with strikethrough original price',
        (tester) async {
      await tester.pumpApp(
        const DsPriceBadge(
          price: 90.00,
          discountPercentage: 10.0,
          showOriginal: true,
        ),
      );

      // Current price
      expect(find.text('\$90.00'), findsOneWidget);

      // Original price (90 / (1 - 0.10) = 100)
      expect(find.text('\$100.00'), findsOneWidget);

      // Discount percentage
      expect(find.text('-10%'), findsOneWidget);

      // Verify strikethrough decoration on original price
      final originalPriceText = tester.widgetList<Text>(find.byType(Text)).where(
        (t) => t.data == '\$100.00',
      );
      expect(originalPriceText, isNotEmpty);
      expect(
        originalPriceText.first.style?.decoration,
        TextDecoration.lineThrough,
      );
    });

    testWidgets('hides original price when showOriginal is false',
        (tester) async {
      await tester.pumpApp(
        const DsPriceBadge(
          price: 90.00,
          discountPercentage: 10.0,
          showOriginal: false,
        ),
      );

      // Current price shows
      expect(find.text('\$90.00'), findsOneWidget);

      // Original price and discount hidden
      expect(find.text('\$100.00'), findsNothing);
      expect(find.text('-10%'), findsNothing);
    });
  });
}
