import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/presentation/design_system/components/ds_error_state.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('DsErrorState', () {
    testWidgets('displays error message', (tester) async {
      await tester.pumpApp(
        const DsErrorState(message: 'Something went wrong'),
      );

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('retry button calls callback when tapped', (tester) async {
      var retryTapped = false;

      await tester.pumpApp(
        DsErrorState(
          message: 'Error occurred',
          onRetry: () => retryTapped = true,
        ),
      );

      expect(find.text('Retry'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      await tester.pump();

      expect(retryTapped, true);
    });

    testWidgets('renders without retry button when onRetry is null',
        (tester) async {
      await tester.pumpApp(
        const DsErrorState(message: 'Error without retry'),
      );

      expect(find.text('Error without retry'), findsOneWidget);
      expect(find.text('Retry'), findsNothing);
    });
  });
}
