import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/product.dart';
import '../../design_system/components/ds_connectivity_banner.dart';
import '../../design_system/components/ds_empty_state.dart';
import '../../design_system/components/ds_error_state.dart';
import '../../design_system/components/ds_skeleton_card.dart';
import '../../shared/widgets/staggered_list_item.dart';
import '../cubit/categories_cubit.dart';
import '../cubit/product_list_cubit.dart';
import '../cubit/product_list_state.dart';
import '../widgets/category_chips.dart';
import '../widgets/product_card.dart';
import '../widgets/product_search_bar.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({
    super.key,
    this.isEmbedded = false,
  });

  final bool isEmbedded;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= AppConstants.scrollThreshold) {
      final state = context.read<ProductListCubit>().state;
      if (state.status != ProductListStatus.loadingMore && state.hasMore) {
        context.read<ProductListCubit>().loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return BlocListener<ProductListCubit, ProductListState>(
      listenWhen: (prev, curr) =>
          curr.status == ProductListStatus.error &&
          curr.products.isNotEmpty,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.errorMessage ?? 'Something went wrong',
              style: AppTypography.bodyMedium.copyWith(color: colors.onPrimary),
            ),
            backgroundColor: colors.destructive,
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Column(
        children: [
          // Search bar + showcase button
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                const Expanded(child: ProductSearchBar()),
                SizedBox(width: AppSpacing.sm),
                IconButton(
                  icon: Icon(
                    Iconsax.setting_4,
                    size: 22,
                    color: colors.onBackgroundSecondary,
                  ),
                  onPressed: () => context.go('/showcase'),
                  tooltip: 'Design Showcase',
                ),
              ],
            ),
          ),

          // Category chips
          Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.sm),
            child: BlocSelector<CategoriesCubit, CategoriesState,
                ({List<Category> categories, String? selected})>(
              selector: (state) => (
                categories: state.categories,
                selected:
                    context.read<ProductListCubit>().state.selectedCategory,
              ),
              builder: (context, data) {
                return BlocSelector<ProductListCubit, ProductListState,
                    String?>(
                  selector: (state) => state.selectedCategory,
                  builder: (context, selectedCategory) {
                    return CategoryChips(
                      categories: data.categories,
                      selectedCategory: selectedCategory,
                    );
                  },
                );
              },
            ),
          ),

          // Offline banner
          BlocSelector<ProductListCubit, ProductListState, bool>(
            selector: (state) => state.isOffline,
            builder: (context, isOffline) => isOffline
                ? const DsConnectivityBanner(isOffline: true)
                : const SizedBox.shrink(),
          ),

          // Product grid
          Expanded(
            child: BlocSelector<ProductListCubit, ProductListState,
                ({
                  List<Product> products,
                  ProductListStatus status,
                  bool hasMore,
                  int? selectedProductId,
                })>(
              selector: (state) => (
                products: state.products,
                status: state.status,
                hasMore: state.hasMore,
                selectedProductId: state.selectedProductId,
              ),
              builder: (context, data) {
                return _ProductGrid(
                  products: data.products,
                  status: data.status,
                  hasMore: data.hasMore,
                  scrollController: _scrollController,
                  isEmbedded: widget.isEmbedded,
                  selectedProductId:
                      widget.isEmbedded ? data.selectedProductId : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Width threshold at which the grid switches from 2 to 3 columns.
const double _wideGridBreakpoint = 500;

int _crossAxisCount(double width) => width >= _wideGridBreakpoint ? 3 : 2;

SliverGridDelegateWithFixedCrossAxisCount _gridDelegate(double width) {
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: _crossAxisCount(width),
    childAspectRatio: 0.58,
    mainAxisSpacing: AppSpacing.lg,
    crossAxisSpacing: AppSpacing.lg,
  );
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({
    required this.products,
    required this.status,
    required this.hasMore,
    required this.scrollController,
    this.isEmbedded = false,
    this.selectedProductId,
  });

  final List<Product> products;
  final ProductListStatus status;
  final bool hasMore;
  final ScrollController scrollController;
  final bool isEmbedded;
  final int? selectedProductId;

  @override
  Widget build(BuildContext context) {
    // Loading state: skeleton grid
    if (status == ProductListStatus.loading) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final cols = _crossAxisCount(constraints.maxWidth);
          return GridView.builder(
            padding: AppSpacing.paddingHorizontalXl,
            gridDelegate: _gridDelegate(constraints.maxWidth),
            itemCount: cols * 2,
            itemBuilder: (context, index) => const DsSkeletonCard(),
          );
        },
      );
    }

    // Error with no products: show error state
    if (status == ProductListStatus.error && products.isEmpty) {
      return DsErrorState(
        message: 'Failed to load products. Please try again.',
        onRetry: () => context.read<ProductListCubit>().loadProducts(),
      );
    }

    // Empty results
    if (status == ProductListStatus.loaded && products.isEmpty) {
      return DsEmptyState(
        message: 'No products match your search',
        description: 'Try a different keyword or clear your search.',
        icon: Icons.search_off,
        actionLabel: 'Clear search',
        onAction: () => context.read<ProductListCubit>().search(''),
      );
    }

    // Products grid with infinite scroll
    return RefreshIndicator(
      onRefresh: () => context.read<ProductListCubit>().refresh(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= _wideGridBreakpoint;

          return CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: AppSpacing.paddingHorizontalXl,
                sliver: SliverGrid(
                  gridDelegate: _gridDelegate(constraints.maxWidth),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = products[index];
                      return StaggeredListItem(
                        index: index,
                        child: ProductCard(
                          product: product,
                          isWide: isWide,
                          isSelected: product.id == selectedProductId,
                          onTap: () {
                            if (isEmbedded) {
                              context
                                  .read<ProductListCubit>()
                                  .selectProduct(product.id);
                            } else {
                              context.go('/products/${product.id}');
                            }
                          },
                        ),
                      );
                    },
                    childCount: products.length,
                  ),
                ),
              ),

              // Loading more indicator
              if (status == ProductListStatus.loadingMore)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.of(context).primary,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
