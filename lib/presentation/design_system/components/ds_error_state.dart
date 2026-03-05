import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import 'ds_button.dart';

class DsErrorState extends StatelessWidget {
  const DsErrorState({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

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
              Iconsax.warning_2,
              size: AppSpacing.huge + AppSpacing.lg,
              color: colors.destructive,
            ),
            SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style: AppTypography.bodyMedium.copyWith(
                color: colors.onBackgroundSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: AppSpacing.xxl),
              DsButton(
                label: 'Retry',
                onPressed: onRetry,
                variant: DsButtonVariant.secondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
