import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';

import 'app_colors.dart';
import 'app_typography.dart';

enum AppThemeMode { light, dark, system }

class ThemeCubit extends Cubit<AppThemeMode> {
  ThemeCubit() : super(AppThemeMode.system) {
    _loadTheme();
  }

  static const _boxName = 'settings';
  static const _themeKey = 'theme_mode';

  Future<void> _loadTheme() async {
    final box = await Hive.openBox(_boxName);
    final stored = box.get(_themeKey, defaultValue: 'system') as String;
    emit(_fromString(stored));
  }

  Future<void> setTheme(AppThemeMode mode) async {
    emit(mode);
    final box = await Hive.openBox(_boxName);
    await box.put(_themeKey, mode.name);
  }

  Future<void> toggle() async {
    final next = switch (state) {
      AppThemeMode.light => AppThemeMode.dark,
      AppThemeMode.dark => AppThemeMode.system,
      AppThemeMode.system => AppThemeMode.light,
    };
    await setTheme(next);
  }

  ThemeData buildTheme(Brightness brightness) {
    final isDark = switch (state) {
      AppThemeMode.light => false,
      AppThemeMode.dark => true,
      AppThemeMode.system => brightness == Brightness.dark,
    };
    return isDark ? _darkTheme : _lightTheme;
  }

  ThemeMode get themeMode => switch (state) {
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
    AppThemeMode.system => ThemeMode.system,
  };

  static AppThemeMode _fromString(String value) => switch (value) {
    'light' => AppThemeMode.light,
    'dark' => AppThemeMode.dark,
    _ => AppThemeMode.system,
  };

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.light.background,
    colorScheme: ColorScheme.light(
      primary: AppColors.light.primary,
      surface: AppColors.light.surface,
      onPrimary: AppColors.light.onPrimary,
      onSurface: AppColors.light.onBackground,
    ),
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge,
      displayMedium: AppTypography.displayMedium,
      displaySmall: AppTypography.displaySmall,
      headlineLarge: AppTypography.headlineLarge,
      headlineMedium: AppTypography.headlineMedium,
      headlineSmall: AppTypography.headlineSmall,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      labelLarge: AppTypography.labelLarge,
      labelMedium: AppTypography.labelMedium,
      labelSmall: AppTypography.labelSmall,
    ),
    extensions: const [AppColors.light],
  );

  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.dark.background,
    colorScheme: ColorScheme.dark(
      primary: AppColors.dark.primary,
      surface: AppColors.dark.surface,
      onPrimary: AppColors.dark.onPrimary,
      onSurface: AppColors.dark.onBackground,
    ),
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge,
      displayMedium: AppTypography.displayMedium,
      displaySmall: AppTypography.displaySmall,
      headlineLarge: AppTypography.headlineLarge,
      headlineMedium: AppTypography.headlineMedium,
      headlineSmall: AppTypography.headlineSmall,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodySmall: AppTypography.bodySmall,
      labelLarge: AppTypography.labelLarge,
      labelMedium: AppTypography.labelMedium,
      labelSmall: AppTypography.labelSmall,
    ),
    extensions: const [AppColors.dark],
  );
}
