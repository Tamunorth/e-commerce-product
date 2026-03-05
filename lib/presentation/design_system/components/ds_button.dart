import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

enum DsButtonVariant { primary, secondary, text }

class DsButton extends StatelessWidget {
  const DsButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = DsButtonVariant.primary,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final DsButtonVariant variant;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return switch (variant) {
      DsButtonVariant.primary => _PrimaryButton(
          label: label,
          onPressed: onPressed,
          isLoading: isLoading,
          colors: colors,
        ),
      DsButtonVariant.secondary => _SecondaryButton(
          label: label,
          onPressed: onPressed,
          isLoading: isLoading,
          colors: colors,
        ),
      DsButtonVariant.text => _TextButton(
          label: label,
          onPressed: onPressed,
          isLoading: isLoading,
          colors: colors,
        ),
    };
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    this.onPressed,
    required this.isLoading,
    required this.colors,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: colors.buttonShadow,
            blurRadius: AppSpacing.sm,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.xxl,
            vertical: AppSpacing.md,
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                width: AppSpacing.xl,
                height: AppSpacing.xl,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colors.onPrimary,
                ),
              )
            : Text(label, style: AppTypography.buttonSmall),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.label,
    this.onPressed,
    required this.isLoading,
    required this.colors,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.surfaceContainer,
        foregroundColor: colors.onBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.xxl,
          vertical: AppSpacing.md,
        ),
        elevation: 0,
      ),
      child: isLoading
          ? SizedBox(
              width: AppSpacing.xl,
              height: AppSpacing.xl,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.onBackground,
              ),
            )
          : Text(
              label,
              style: AppTypography.buttonSmall.copyWith(
                color: colors.onBackground,
              ),
            ),
    );
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    required this.label,
    this.onPressed,
    required this.isLoading,
    required this.colors,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: colors.onBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.xxl,
          vertical: AppSpacing.md,
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: AppSpacing.xl,
              height: AppSpacing.xl,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.onBackground,
              ),
            )
          : Text(
              label,
              style: AppTypography.buttonSmall.copyWith(
                color: colors.onBackground,
              ),
            ),
    );
  }
}
