import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import 'ds_button.dart';

class DsEmptyState extends StatelessWidget {
  const DsEmptyState({
    super.key,
    required this.message,
    this.icon,
    this.description,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final IconData? icon;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Center(
      child: Padding(
        padding: AppSpacing.paddingAllXl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Iconsax.box_1,
              size: AppSpacing.huge + AppSpacing.lg,
              color: colors.onBackgroundMuted,
            ),
            SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style: AppTypography.headlineSmall.copyWith(
                color: colors.onBackgroundSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (description != null) ...[
              SizedBox(height: AppSpacing.sm),
              Text(
                description!,
                style: AppTypography.bodyMedium.copyWith(
                  color: colors.onBackgroundMuted,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: AppSpacing.xxl),
              DsButton(
                label: actionLabel!,
                onPressed: onAction,
                variant: DsButtonVariant.secondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
