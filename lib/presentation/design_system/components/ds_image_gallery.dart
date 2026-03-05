import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import 'ds_network_image.dart';

class DsImageGallery extends StatefulWidget {
  const DsImageGallery({
    super.key,
    required this.images,
    this.height,
  });

  final List<String> images;
  final double? height;

  @override
  State<DsImageGallery> createState() => _DsImageGalleryState();
}

class _DsImageGalleryState extends State<DsImageGallery> {
  int _currentPage = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final galleryHeight = widget.height ?? AppSpacing.galleryDefaultHeight;

    return SizedBox(
      height: galleryHeight,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                child: DsNetworkImage(
                  url: widget.images[index],
                  width: double.infinity,
                  height: galleryHeight,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          if (widget.images.length > 1)
            Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.md),
              child: _DotIndicators(
                count: widget.images.length,
                current: _currentPage,
              ),
            ),
        ],
      ),
    );
  }
}

class _DotIndicators extends StatelessWidget {
  const _DotIndicators({
    required this.count,
    required this.current,
  });

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: EdgeInsets.symmetric(horizontal: AppSpacing.xs / 2),
          width: isActive ? AppSpacing.dotActiveWidth : AppSpacing.dotInactiveWidth,
          height: AppSpacing.dotHeight,
          decoration: BoxDecoration(
            color: isActive
                ? colors.primary
                : colors.onBackgroundMuted.withAlpha(100),
            borderRadius: BorderRadius.circular(AppSpacing.dotRadius),
          ),
        );
      }),
    );
  }
}
