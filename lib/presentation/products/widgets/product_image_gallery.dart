import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class ProductImageGallery extends StatefulWidget {
  const ProductImageGallery({
    super.key,
    required this.images,
    required this.productId,
    this.height,
  });

  final List<String> images;
  final int productId;
  final double? height;

  @override
  State<ProductImageGallery> createState() => _ProductImageGalleryState();
}

class _ProductImageGalleryState extends State<ProductImageGallery> {
  int _currentPage = 0;
  late final PageController _pageController;
  bool _isHovering = false;

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

  void _goTo(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final galleryHeight = widget.height ?? AppSpacing.galleryDefaultHeight;
    final hasMultiple = widget.images.length > 1;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: SizedBox(
        height: galleryHeight,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                final child = Container(
                  color: colors.surfaceContainer,
                  child: CachedNetworkImage(
                    imageUrl: widget.images[index],
                    width: double.infinity,
                    height: galleryHeight,
                    fit: BoxFit.contain,
                    placeholder: (context, url) => Container(
                      color: colors.surfaceContainer,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: colors.surfaceContainer,
                      child: Icon(
                        Icons.broken_image_outlined,
                        color: colors.onBackgroundMuted,
                        size: AppSpacing.xxxl,
                      ),
                    ),
                  ),
                );

                // Hero only on first image (the thumbnail that matches the list card)
                if (index == 0) {
                  return Hero(
                    tag: 'product-image-${widget.productId}',
                    child: child,
                  );
                }
                return child;
              },
            ),

            // Navigation arrows (visible on hover)
            if (hasMultiple && _isHovering) ...[
              if (_currentPage > 0)
                Positioned(
                  left: AppSpacing.sm,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _ArrowButton(
                      icon: Icons.chevron_left,
                      onTap: () => _goTo(_currentPage - 1),
                      colors: colors,
                    ),
                  ),
                ),
              if (_currentPage < widget.images.length - 1)
                Positioned(
                  right: AppSpacing.sm,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _ArrowButton(
                      icon: Icons.chevron_right,
                      onTap: () => _goTo(_currentPage + 1),
                      colors: colors,
                    ),
                  ),
                ),
            ],

            if (hasMultiple)
              Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.md),
                child: _DotIndicators(
                  count: widget.images.length,
                  current: _currentPage,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.icon,
    required this.onTap,
    required this.colors,
  });

  final IconData icon;
  final VoidCallback onTap;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.surface.withAlpha(200),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.sm),
          child: Icon(
            icon,
            size: AppSpacing.xxl,
            color: colors.onBackground,
          ),
        ),
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
