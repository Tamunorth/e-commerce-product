import 'package:flutter/material.dart';

class AppSpacing {
  const AppSpacing._();

  // 4px grid
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 48;

  // Component-specific sizes
  static const double chipIconSize = 44;
  static const double galleryDefaultHeight = 300;
  static const double dotActiveWidth = 30;
  static const double dotInactiveWidth = 15;
  static const double dotHeight = 4;
  static const double dotRadius = 2;
  static const double skeletonImageHeight = 180;
  static const double skeletonTitleWidth = 140;
  static const double skeletonSubtitleWidth = 100;
  static const double skeletonPriceWidth = 60;
  static const double skeletonBadgeWidth = 40;

  // Border radius
  static const double radiusSm = 6;
  static const double radiusMd = 8;
  static const double radiusLg = 12;
  static const double radiusXl = 16;
  static const double radiusRound = 40;

  // Padding helpers
  static const EdgeInsets paddingAllSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingAllMd = EdgeInsets.all(md);
  static const EdgeInsets paddingAllLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingAllXl = EdgeInsets.all(xl);

  static const EdgeInsets paddingHorizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets paddingHorizontalXl = EdgeInsets.symmetric(horizontal: xl);

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: xl);
}
