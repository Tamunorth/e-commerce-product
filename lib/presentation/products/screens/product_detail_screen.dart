import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../design_system/components/ds_error_state.dart';
import '../../design_system/components/ds_skeleton.dart';
import '../cubit/product_detail_cubit.dart';
import '../cubit/product_detail_state.dart';
import '../widgets/product_image_gallery.dart';
import '../widgets/product_info_section.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    this.showBackButton = true,
  });

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
            builder: (context, state) {
              return switch (state) {
                ProductDetailInitial() =>
                  _DetailLoadingSkeleton(colors: colors),
                ProductDetailLoading() =>
                  _DetailLoadingSkeleton(colors: colors),
                ProductDetailLoaded(:final product) => CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Stack(
                          children: [
                            ProductImageGallery(
                              images: product.images.isNotEmpty
                                  ? product.images
                                  : [product.thumbnail],
                              productId: product.id,
                              height:
                                  MediaQuery.sizeOf(context).height * 0.56,
                            ),
                            if (showBackButton)
                              Positioned(
                                top: MediaQuery.paddingOf(context).top +
                                    AppSpacing.sm,
                                left: AppSpacing.lg,
                                child:
                                    _FloatingBackButton(colors: colors),
                              ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: ProductInfoSection(product: product),
                      ),
                    ],
                  ),
                ProductDetailError(:final message) => DsErrorState(
                    message: message,
                    onRetry: () =>
                        context.read<ProductDetailCubit>().retry(),
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}

class _FloatingBackButton extends StatelessWidget {
  const _FloatingBackButton({required this.colors});

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        shape: BoxShape.circle,
        boxShadow: const [
          BoxShadow(
            color: Color(0x338A959E),
            blurRadius: 40,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: AppSpacing.xl,
            color: colors.onBackground,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }
}

class _DetailLoadingSkeleton extends StatelessWidget {
  const _DetailLoadingSkeleton({required this.colors});

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          DsSkeleton(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.56,
            borderRadius: 0,
          ),
          Padding(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppSpacing.xl),
                // Title skeleton
                DsSkeleton(
                  width: 220,
                  height: 28,
                  borderRadius: AppSpacing.radiusSm,
                ),
                SizedBox(height: AppSpacing.md),
                // Rating skeleton
                DsSkeleton(
                  width: 140,
                  height: 20,
                  borderRadius: AppSpacing.radiusSm,
                ),
                SizedBox(height: AppSpacing.lg),
                // Price skeleton
                DsSkeleton(
                  width: 120,
                  height: 36,
                  borderRadius: AppSpacing.radiusSm,
                ),
                SizedBox(height: AppSpacing.lg),
                // Badge skeleton
                DsSkeleton(
                  width: 80,
                  height: 24,
                  borderRadius: AppSpacing.radiusSm,
                ),
                SizedBox(height: AppSpacing.xxl),
                // Description skeletons
                DsSkeleton(
                  width: double.infinity,
                  height: 14,
                  borderRadius: AppSpacing.radiusSm,
                ),
                SizedBox(height: AppSpacing.sm),
                DsSkeleton(
                  width: double.infinity,
                  height: 14,
                  borderRadius: AppSpacing.radiusSm,
                ),
                SizedBox(height: AppSpacing.sm),
                DsSkeleton(
                  width: 200,
                  height: 14,
                  borderRadius: AppSpacing.radiusSm,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
