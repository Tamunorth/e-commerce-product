import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import 'ds_skeleton.dart';

class DsNetworkImage extends StatelessWidget {
  const DsNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ??
          DsSkeleton(
            width: width ?? double.infinity,
            height: height ?? 200,
            borderRadius: AppSpacing.radiusLg,
          ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Container(
            width: width,
            height: height,
            color: colors.surfaceContainer,
            child: Icon(
              Icons.broken_image_outlined,
              color: colors.onBackgroundMuted,
              size: AppSpacing.xxxl,
            ),
          ),
    );
  }
}
