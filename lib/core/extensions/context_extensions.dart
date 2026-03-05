import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

extension BuildContextX on BuildContext {
  AppColors get colors => AppColors.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
}
