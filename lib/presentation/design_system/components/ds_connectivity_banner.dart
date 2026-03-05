import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class DsConnectivityBanner extends StatelessWidget {
  const DsConnectivityBanner({
    super.key,
    this.isOffline = true,
  });

  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return AnimatedSlide(
      duration: const Duration(milliseconds: 300),
      offset: isOffline ? Offset.zero : const Offset(0, -1),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isOffline ? 1.0 : 0.0,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          color: colors.connectivityBanner,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off,
                size: AppSpacing.lg,
                color: colors.onPrimary,
              ),
              SizedBox(width: AppSpacing.sm),
              Text(
                "You're offline",
                style: AppTypography.labelMedium.copyWith(
                  color: colors.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
