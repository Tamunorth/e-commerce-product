import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class DsRatingBar extends StatelessWidget {
  const DsRatingBar({
    super.key,
    required this.rating,
    this.size,
    this.activeColor,
    this.inactiveColor,
  });

  final double rating;
  final double? size;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final starSize = size ?? AppSpacing.xl;
    final active = activeColor ?? colors.starRating;
    final inactive = inactiveColor ?? colors.onBackgroundDisabled;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        IconData icon;
        Color color;

        if (rating >= starValue) {
          icon = Icons.star;
          color = active;
        } else if (rating >= starValue - 0.5) {
          icon = Icons.star_half;
          color = active;
        } else {
          icon = Icons.star_border;
          color = inactive;
        }

        return Icon(icon, size: starSize, color: color);
      }),
    );
  }
}
