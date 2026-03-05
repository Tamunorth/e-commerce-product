import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class DsCard extends StatelessWidget {
  const DsCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.elevation,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final baseElevation = elevation ?? 2;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      elevation: baseElevation,
      shadowColor: colors.cardShadow,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        hoverColor: colors.surfaceContainer.withAlpha(80),
        splashColor: colors.surfaceContainer.withAlpha(40),
        child: Padding(
          padding: padding ?? AppSpacing.paddingAllLg,
          child: child,
        ),
      ),
    );
  }
}
