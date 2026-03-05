import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.background,
    required this.surface,
    required this.surfaceContainer,
    required this.onPrimary,
    required this.onBackground,
    required this.onBackgroundSecondary,
    required this.onBackgroundMuted,
    required this.onBackgroundDisabled,
    required this.accent,
    required this.starRating,
    required this.chipSelected,
    required this.chipSelectedText,
    required this.chipUnselected,
    required this.chipUnselectedText,
    required this.buttonShadow,
    required this.cardShadow,
    required this.divider,
    required this.statusSuccess,
    required this.statusWarning,
    required this.destructive,
    required this.connectivityBanner,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.imageOverlay,
  });

  final Color primary;
  final Color background;
  final Color surface;
  final Color surfaceContainer;
  final Color onPrimary;
  final Color onBackground;
  final Color onBackgroundSecondary;
  final Color onBackgroundMuted;
  final Color onBackgroundDisabled;
  final Color accent;
  final Color starRating;
  final Color chipSelected;
  final Color chipSelectedText;
  final Color chipUnselected;
  final Color chipUnselectedText;
  final Color buttonShadow;
  final Color cardShadow;
  final Color divider;
  final Color statusSuccess;
  final Color statusWarning;
  final Color destructive;
  final Color connectivityBanner;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color imageOverlay;

  static const light = AppColors(
    primary: Color(0xFF242424),
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    surfaceContainer: Color(0xFFF5F5F5),
    onPrimary: Color(0xFFFFFFFF),
    onBackground: Color(0xFF303030),
    onBackgroundSecondary: Color(0xFF606060),
    onBackgroundMuted: Color(0xFF909090),
    onBackgroundDisabled: Color(0xFF999999),
    accent: Color(0xFFE85D4A),
    starRating: Color(0xFFF2C94C),
    chipSelected: Color(0xFF303030),
    chipSelectedText: Color(0xFFFFFFFF),
    chipUnselected: Color(0xFFF5F5F5),
    chipUnselectedText: Color(0xFF999999),
    buttonShadow: Color(0x40303030),
    cardShadow: Color(0x338A959E),
    divider: Color(0xFFE0E0E0),
    statusSuccess: Color(0xFF27AE60),
    statusWarning: Color(0xFFF2994A),
    destructive: Color(0xFFEB5757),
    connectivityBanner: Color(0xFFF2994A),
    shimmerBase: Color(0xFFE0E0E0),
    shimmerHighlight: Color(0xFFF5F5F5),
    imageOverlay: Color(0x66606060),
  );

  static const dark = AppColors(
    primary: Color(0xFFE6EDF3),
    background: Color(0xFF0D1117),
    surface: Color(0xFF161B22),
    surfaceContainer: Color(0xFF21262D),
    onPrimary: Color(0xFF0D1117),
    onBackground: Color(0xFFE6EDF3),
    onBackgroundSecondary: Color(0xFF8B949E),
    onBackgroundMuted: Color(0xFF6E7681),
    onBackgroundDisabled: Color(0xFF484F58),
    accent: Color(0xFFF0A500),
    starRating: Color(0xFFF2C94C),
    chipSelected: Color(0xFFE6EDF3),
    chipSelectedText: Color(0xFF0D1117),
    chipUnselected: Color(0xFF21262D),
    chipUnselectedText: Color(0xFF8B949E),
    buttonShadow: Color(0x40000000),
    cardShadow: Color(0x33000000),
    divider: Color(0xFF30363D),
    statusSuccess: Color(0xFF3FB950),
    statusWarning: Color(0xFFD29922),
    destructive: Color(0xFFF85149),
    connectivityBanner: Color(0xFFD29922),
    shimmerBase: Color(0xFF21262D),
    shimmerHighlight: Color(0xFF30363D),
    imageOverlay: Color(0x66000000),
  );

  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>()!;
  }

  @override
  AppColors copyWith({
    Color? primary,
    Color? background,
    Color? surface,
    Color? surfaceContainer,
    Color? onPrimary,
    Color? onBackground,
    Color? onBackgroundSecondary,
    Color? onBackgroundMuted,
    Color? onBackgroundDisabled,
    Color? accent,
    Color? starRating,
    Color? chipSelected,
    Color? chipSelectedText,
    Color? chipUnselected,
    Color? chipUnselectedText,
    Color? buttonShadow,
    Color? cardShadow,
    Color? divider,
    Color? statusSuccess,
    Color? statusWarning,
    Color? destructive,
    Color? connectivityBanner,
    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? imageOverlay,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      onPrimary: onPrimary ?? this.onPrimary,
      onBackground: onBackground ?? this.onBackground,
      onBackgroundSecondary: onBackgroundSecondary ?? this.onBackgroundSecondary,
      onBackgroundMuted: onBackgroundMuted ?? this.onBackgroundMuted,
      onBackgroundDisabled: onBackgroundDisabled ?? this.onBackgroundDisabled,
      accent: accent ?? this.accent,
      starRating: starRating ?? this.starRating,
      chipSelected: chipSelected ?? this.chipSelected,
      chipSelectedText: chipSelectedText ?? this.chipSelectedText,
      chipUnselected: chipUnselected ?? this.chipUnselected,
      chipUnselectedText: chipUnselectedText ?? this.chipUnselectedText,
      buttonShadow: buttonShadow ?? this.buttonShadow,
      cardShadow: cardShadow ?? this.cardShadow,
      divider: divider ?? this.divider,
      statusSuccess: statusSuccess ?? this.statusSuccess,
      statusWarning: statusWarning ?? this.statusWarning,
      destructive: destructive ?? this.destructive,
      connectivityBanner: connectivityBanner ?? this.connectivityBanner,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
      imageOverlay: imageOverlay ?? this.imageOverlay,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceContainer: Color.lerp(surfaceContainer, other.surfaceContainer, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      onBackground: Color.lerp(onBackground, other.onBackground, t)!,
      onBackgroundSecondary: Color.lerp(onBackgroundSecondary, other.onBackgroundSecondary, t)!,
      onBackgroundMuted: Color.lerp(onBackgroundMuted, other.onBackgroundMuted, t)!,
      onBackgroundDisabled: Color.lerp(onBackgroundDisabled, other.onBackgroundDisabled, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      starRating: Color.lerp(starRating, other.starRating, t)!,
      chipSelected: Color.lerp(chipSelected, other.chipSelected, t)!,
      chipSelectedText: Color.lerp(chipSelectedText, other.chipSelectedText, t)!,
      chipUnselected: Color.lerp(chipUnselected, other.chipUnselected, t)!,
      chipUnselectedText: Color.lerp(chipUnselectedText, other.chipUnselectedText, t)!,
      buttonShadow: Color.lerp(buttonShadow, other.buttonShadow, t)!,
      cardShadow: Color.lerp(cardShadow, other.cardShadow, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      statusSuccess: Color.lerp(statusSuccess, other.statusSuccess, t)!,
      statusWarning: Color.lerp(statusWarning, other.statusWarning, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      connectivityBanner: Color.lerp(connectivityBanner, other.connectivityBanner, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
      imageOverlay: Color.lerp(imageOverlay, other.imageOverlay, t)!,
    );
  }
}
