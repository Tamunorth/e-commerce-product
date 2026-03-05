import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class DsChip extends StatelessWidget {
  const DsChip({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
    this.icon,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final bgColor = selected ? colors.chipSelected : colors.chipUnselected;
    final fgColor =
        selected ? colors.chipSelectedText : colors.chipUnselectedText;

    // Icon-only: 44x44 rounded square
    if (icon != null) {
      return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: AppSpacing.chipIconSize,
          height: AppSpacing.chipIconSize,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          ),
          alignment: Alignment.center,
          child: IconTheme(
            data: IconThemeData(color: fgColor, size: AppSpacing.xl),
            child: icon!,
          ),
        ),
      );
    }

    // Text-only: pill shape
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(color: fgColor),
        ),
      ),
    );
  }
}
