import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
    this.isWide = false,
    this.isSelected = false,
  });

  final Product product;
  final VoidCallback onTap;
  final bool isWide;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final hasDiscount = product.discountPercentage > 0;

    // Scaled text styles for wider layouts
    final titleStyle = isWide
        ? AppTypography.bodyMedium
        : AppTypography.bodySmall;
    final ratingStyle = isWide
        ? AppTypography.labelMedium
        : AppTypography.labelSmall;
    final priceStyle = isWide
        ? AppTypography.headlineSmall
        : AppTypography.priceMedium;
    final subPriceStyle = isWide
        ? AppTypography.bodyMedium
        : AppTypography.bodySmall;
    final starSize = isWide ? 14.0 : 12.0;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: isSelected ? colors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        padding: isSelected
            ? EdgeInsets.all(AppSpacing.xs)
            : EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image with hero animation + discount badge
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: 'product-image-${product.id}',
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                        child: CachedNetworkImage(
                          imageUrl: product.thumbnail,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          placeholder: (context, url) => Container(
                            color: colors.surfaceContainer,
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: colors.surfaceContainer,
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: colors.onBackgroundMuted,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (hasDiscount)
                    Positioned(
                      top: AppSpacing.sm,
                      right: AppSpacing.sm,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: colors.destructive,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm),
                        ),
                        child: Text(
                          '-${product.discountPercentage.round()}%',
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.sm),

            // Product name
            Text(
              product.title,
              style: titleStyle.copyWith(
                color: colors.onBackgroundSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppSpacing.xs),

            // Rating + stock row
            Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  size: starSize,
                  color: colors.starRating,
                ),
                SizedBox(width: 2),
                Text(
                  product.rating.toStringAsFixed(1),
                  style: ratingStyle.copyWith(
                    color: colors.onBackgroundMuted,
                  ),
                ),
                const Spacer(),
                if (product.stock <= 0)
                  _StockIndicator(
                    color: colors.destructive,
                    label: 'Out of Stock',
                    isWide: isWide,
                  )
                else if (product.stock <= 10)
                  _StockIndicator(
                    color: colors.statusWarning,
                    label: '${product.stock} left',
                    isWide: isWide,
                  ),
              ],
            ),
            SizedBox(height: AppSpacing.xs),

            // Price with discount
            if (hasDiscount)
              Row(
                children: [
                  Text(
                    '\$${product.discountedPrice.toStringAsFixed(2)}',
                    style: priceStyle.copyWith(
                      color: colors.onBackground,
                    ),
                  ),
                  SizedBox(width: AppSpacing.xs),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: subPriceStyle.copyWith(
                      color: colors.onBackgroundMuted,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              )
            else
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: priceStyle.copyWith(
                  color: colors.onBackground,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StockIndicator extends StatelessWidget {
  const _StockIndicator({
    required this.color,
    required this.label,
    this.isWide = false,
  });

  final Color color;
  final String label;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style: (isWide ? AppTypography.labelMedium : AppTypography.labelSmall)
              .copyWith(color: color),
        ),
      ],
    );
  }
}
