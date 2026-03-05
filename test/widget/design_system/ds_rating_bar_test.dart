import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/presentation/design_system/components/ds_rating_bar.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('DsRatingBar', () {
    testWidgets('renders 5 filled stars for rating 5.0', (tester) async {
      await tester.pumpApp(
        const DsRatingBar(rating: 5.0),
      );

      final starIcons = tester.widgetList<Icon>(find.byType(Icon)).toList();
      expect(starIcons, hasLength(5));

      for (final icon in starIcons) {
        expect(icon.icon, Icons.star);
      }
    });

    testWidgets('renders correct mix for rating 3.5', (tester) async {
      await tester.pumpApp(
        const DsRatingBar(rating: 3.5),
      );

      final starIcons = tester.widgetList<Icon>(find.byType(Icon)).toList();
      expect(starIcons, hasLength(5));

      // First 3 should be full stars
      expect(starIcons[0].icon, Icons.star);
      expect(starIcons[1].icon, Icons.star);
      expect(starIcons[2].icon, Icons.star);
      // 4th should be half star
      expect(starIcons[3].icon, Icons.star_half);
      // 5th should be empty
      expect(starIcons[4].icon, Icons.star_border);
    });

    testWidgets('renders 5 empty stars for rating 0.0', (tester) async {
      await tester.pumpApp(
        const DsRatingBar(rating: 0.0),
      );

      final starIcons = tester.widgetList<Icon>(find.byType(Icon)).toList();
      expect(starIcons, hasLength(5));

      for (final icon in starIcons) {
        expect(icon.icon, Icons.star_border);
      }
    });
  });
}
