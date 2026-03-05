import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/product.dart';
import '../../design_system/components/ds_badge.dart';
import '../../design_system/components/ds_price_badge.dart';
import '../../design_system/components/ds_rating_bar.dart';

class ProductInfoSection extends StatelessWidget {
  const ProductInfoSection({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Padding(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppSpacing.xl),
          // Product name
          Text(
            product.title,
            style: AppTypography.displayMedium.copyWith(
              color: colors.onBackground,
            ),
          ),
          SizedBox(height: AppSpacing.md),
          // Rating row
          Row(
            children: [
              DsRatingBar(rating: product.rating),
              SizedBox(width: AppSpacing.sm),
              Text(
                product.rating.toStringAsFixed(1),
                style: AppTypography.bodySmall.copyWith(
                  color: colors.onBackgroundSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.lg),
          // Price
          Text(
            '\$${product.discountedPrice.toStringAsFixed(2)}',
            style: AppTypography.priceLarge.copyWith(
              color: colors.onBackground,
            ),
          ),
          SizedBox(height: AppSpacing.xs),
          DsPriceBadge(
            price: product.discountedPrice,
            discountPercentage: product.discountPercentage,
          ),
          SizedBox(height: AppSpacing.lg),
          // Stock badge
          _StockBadge(stock: product.stock, colors: colors),
          SizedBox(height: AppSpacing.lg),
          // Brand and category
          if (product.brand.isNotEmpty) ...[
            Text(
              'Brand: ${product.brand}',
              style: AppTypography.labelLarge.copyWith(
                color: colors.onBackgroundSecondary,
              ),
            ),
            SizedBox(height: AppSpacing.xs),
          ],
          Text(
            'Category: ${product.category}',
            style: AppTypography.labelMedium.copyWith(
              color: colors.onBackgroundMuted,
            ),
          ),
          SizedBox(height: AppSpacing.xxl),
          // Description
          Text(
            'Description',
            style: AppTypography.headlineSmall.copyWith(
              color: colors.onBackground,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            product.description,
            style: AppTypography.bodyMedium.copyWith(
              color: colors.onBackgroundSecondary,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: AppSpacing.xxxl),
        ],
      ),
    );
  }
}

class _StockBadge extends StatelessWidget {
  const _StockBadge({
    required this.stock,
    required this.colors,
  });

  final int stock;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    if (stock <= 0) {
      return DsBadge(
        text: 'Out of Stock',
        backgroundColor: colors.destructive.withAlpha(30),
        textColor: colors.destructive,
      );
    }
    if (stock <= 10) {
      return DsBadge(
        text: 'Low Stock ($stock left)',
        backgroundColor: colors.statusWarning.withAlpha(30),
        textColor: colors.statusWarning,
      );
    }
    return DsBadge(
      text: 'In Stock',
      backgroundColor: colors.statusSuccess.withAlpha(30),
      textColor: colors.statusSuccess,
    );
  }
}
