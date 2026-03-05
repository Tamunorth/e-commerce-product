import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import 'ds_skeleton.dart';

/// Skeleton loader that mirrors the ProductCard layout:
/// Expanded image, title, rating/stock row, price row.
class DsSkeletonCard extends StatelessWidget {
  const DsSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image placeholder (matches Expanded in ProductCard)
        Expanded(
          child: DsSkeleton(
            width: double.infinity,
            height: double.infinity,
            borderRadius: AppSpacing.radiusLg,
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        // Title
        DsSkeleton(
          width: AppSpacing.skeletonTitleWidth,
          height: AppSpacing.md,
          borderRadius: AppSpacing.radiusSm,
        ),
        SizedBox(height: AppSpacing.xs),
        // Rating/stock row
        Row(
          children: [
            DsSkeleton(
              width: 40,
              height: 10,
              borderRadius: AppSpacing.radiusSm,
            ),
            const Spacer(),
            DsSkeleton(
              width: 36,
              height: 10,
              borderRadius: AppSpacing.radiusSm,
            ),
          ],
        ),
        SizedBox(height: AppSpacing.xs),
        // Price row
        Row(
          children: [
            DsSkeleton(
              width: AppSpacing.skeletonPriceWidth,
              height: AppSpacing.lg,
              borderRadius: AppSpacing.radiusSm,
            ),
            SizedBox(width: AppSpacing.xs),
            DsSkeleton(
              width: AppSpacing.skeletonBadgeWidth,
              height: AppSpacing.md,
              borderRadius: AppSpacing.radiusSm,
            ),
          ],
        ),
      ],
    );
  }
}
