import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class DsPriceBadge extends StatelessWidget {
  const DsPriceBadge({
    super.key,
    required this.price,
    this.discountPercentage,
    this.showOriginal = true,
  });

  final double price;
  final double? discountPercentage;
  final bool showOriginal;

  double get _originalPrice {
    if (discountPercentage == null || discountPercentage == 0) return price;
    return price / (1 - discountPercentage! / 100);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final hasDiscount =
        discountPercentage != null && discountPercentage! > 0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: AppTypography.priceMedium.copyWith(
            color: colors.onBackground,
          ),
        ),
        if (hasDiscount && showOriginal) ...[
          SizedBox(width: AppSpacing.sm),
          Text(
            '\$${_originalPrice.toStringAsFixed(2)}',
            style: AppTypography.bodySmall.copyWith(
              color: colors.onBackgroundMuted,
              decoration: TextDecoration.lineThrough,
              decorationColor: colors.onBackgroundMuted,
            ),
          ),
          SizedBox(width: AppSpacing.xs),
          Text(
            '-${discountPercentage!.toStringAsFixed(0)}%',
            style: AppTypography.labelSmall.copyWith(
              color: colors.destructive,
            ),
          ),
        ],
      ],
    );
  }
}
