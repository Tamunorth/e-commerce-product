import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/core/theme/app_colors.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) async {
    await pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const [AppColors.light],
        ),
        home: Scaffold(body: widget),
      ),
    );
  }
}
