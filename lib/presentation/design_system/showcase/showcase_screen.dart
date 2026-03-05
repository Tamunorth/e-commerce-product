import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/di/injection.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/theme_cubit.dart';
import '../components/ds_badge.dart';
import '../components/ds_button.dart';
import '../components/ds_card.dart';
import '../components/ds_chip.dart';
import '../components/ds_chip_row.dart';
import '../components/ds_connectivity_banner.dart';
import '../components/ds_divider.dart';
import '../components/ds_empty_state.dart';
import '../components/ds_error_state.dart';
import '../components/ds_image_gallery.dart';
import '../components/ds_network_image.dart';
import '../components/ds_price_badge.dart';
import '../components/ds_rating_bar.dart';
import '../components/ds_search_bar.dart';
import '../components/ds_skeleton.dart';
import '../components/ds_skeleton_card.dart';

class ShowcaseScreen extends StatefulWidget {
  const ShowcaseScreen({super.key});

  @override
  State<ShowcaseScreen> createState() => _ShowcaseScreenState();
}

class _ShowcaseScreenState extends State<ShowcaseScreen> {
  bool _showOfflineBanner = false;
  int _selectedChipIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left,
            color: colors.onBackground,
          ),
          onPressed: () => context.go('/products'),
        ),
        title: Text(
          'Design System',
          style: AppTypography.headlineMedium.copyWith(
            color: colors.onBackground,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              context.isDark ? Icons.light_mode : Icons.dark_mode,
              color: colors.onBackground,
            ),
            onPressed: () => sl<ThemeCubit>().toggle(),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        children: [
          _sectionHeader(context, 'Typography'),
          _typographySection(context),
          _sectionHeader(context, 'Colors'),
          _colorsSection(context),
          _sectionHeader(context, 'DsButton'),
          _buttonSection(context),
          _sectionHeader(context, 'DsCard'),
          _cardSection(context),
          _sectionHeader(context, 'DsChip'),
          _chipSection(context),
          _sectionHeader(context, 'DsChipRow'),
          _chipRowSection(),
          _sectionHeader(context, 'DsSearchBar'),
          _searchBarSection(),
          _sectionHeader(context, 'DsRatingBar'),
          _ratingBarSection(context),
          _sectionHeader(context, 'DsPriceBadge'),
          _priceBadgeSection(),
          _sectionHeader(context, 'DsBadge'),
          _badgeSection(context),
          _sectionHeader(context, 'DsNetworkImage'),
          _networkImageSection(),
          _sectionHeader(context, 'DsImageGallery'),
          _imageGallerySection(),
          _sectionHeader(context, 'DsSkeleton'),
          _skeletonSection(),
          _sectionHeader(context, 'DsSkeletonCard'),
          _skeletonCardSection(),
          _sectionHeader(context, 'DsDivider'),
          _dividerSection(context),
          _sectionHeader(context, 'DsConnectivityBanner'),
          _connectivityBannerSection(),
          _sectionHeader(context, 'DsErrorState'),
          _errorStateSection(),
          _sectionHeader(context, 'DsEmptyState'),
          _emptyStateSection(),
          SizedBox(height: AppSpacing.huge),
        ],
      ),
        ),
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String title) {
    final colors = AppColors.of(context);
    return Padding(
      padding: EdgeInsets.only(
        top: AppSpacing.xxl,
        bottom: AppSpacing.md,
      ),
      child: Text(
        title,
        style: AppTypography.headlineLarge.copyWith(
          color: colors.onBackground,
        ),
      ),
    );
  }

  Widget _typographySection(BuildContext context) {
    final colors = AppColors.of(context);
    final samples = <(String, TextStyle)>[
      ('Display Large', AppTypography.displayLarge),
      ('Display Medium', AppTypography.displayMedium),
      ('Display Small', AppTypography.displaySmall),
      ('Headline Large', AppTypography.headlineLarge),
      ('Headline Medium', AppTypography.headlineMedium),
      ('Headline Small', AppTypography.headlineSmall),
      ('Body Large', AppTypography.bodyLarge),
      ('Body Medium', AppTypography.bodyMedium),
      ('Body Small', AppTypography.bodySmall),
      ('Label Large', AppTypography.labelLarge),
      ('Label Medium', AppTypography.labelMedium),
      ('Label Small', AppTypography.labelSmall),
      ('Price Large', AppTypography.priceLarge),
      ('Price Medium', AppTypography.priceMedium),
      ('Button', AppTypography.button),
      ('Button Small', AppTypography.buttonSmall),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (name, style) in samples)
          Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(
              name,
              style: style.copyWith(color: colors.onBackground),
            ),
          ),
      ],
    );
  }

  Widget _colorsSection(BuildContext context) {
    final colors = AppColors.of(context);
    final swatches = <(String, Color)>[
      ('primary', colors.primary),
      ('background', colors.background),
      ('surface', colors.surface),
      ('surfaceContainer', colors.surfaceContainer),
      ('onBackground', colors.onBackground),
      ('onBackgroundSecondary', colors.onBackgroundSecondary),
      ('onBackgroundMuted', colors.onBackgroundMuted),
      ('accent', colors.accent),
      ('starRating', colors.starRating),
      ('statusSuccess', colors.statusSuccess),
      ('statusWarning', colors.statusWarning),
      ('destructive', colors.destructive),
      ('connectivityBanner', colors.connectivityBanner),
      ('divider', colors.divider),
    ];

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final (name, color) in swatches)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  border: Border.all(color: colors.divider),
                ),
              ),
              SizedBox(height: AppSpacing.xs),
              SizedBox(
                width: 64,
                child: Text(
                  name,
                  style: AppTypography.labelSmall.copyWith(
                    color: colors.onBackgroundMuted,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buttonSection(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        DsButton(label: 'Primary', onPressed: () {}),
        DsButton(
          label: 'Secondary',
          onPressed: () {},
          variant: DsButtonVariant.secondary,
        ),
        DsButton(
          label: 'Text',
          onPressed: () {},
          variant: DsButtonVariant.text,
        ),
        const DsButton(label: 'Disabled'),
        const DsButton(label: 'Loading', isLoading: true),
        DsButton(
          label: 'Loading Secondary',
          isLoading: true,
          variant: DsButtonVariant.secondary,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _cardSection(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      children: [
        DsCard(
          onTap: () {},
          child: Text(
            'Tappable card with default elevation',
            style: AppTypography.bodyMedium.copyWith(
              color: colors.onBackground,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        DsCard(
          elevation: 6,
          child: Text(
            'Card with higher elevation',
            style: AppTypography.bodyMedium.copyWith(
              color: colors.onBackground,
            ),
          ),
        ),
        SizedBox(height: AppSpacing.md),
        DsCard(
          elevation: 0,
          padding: AppSpacing.paddingAllSm,
          child: Text(
            'Flat card, small padding',
            style: AppTypography.bodyMedium.copyWith(
              color: colors.onBackground,
            ),
          ),
        ),
      ],
    );
  }

  Widget _chipSection(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        DsChip(
          label: 'Selected',
          selected: true,
          onTap: () {},
        ),
        DsChip(
          label: 'Unselected',
          selected: false,
          onTap: () {},
        ),
        DsChip(
          label: '',
          selected: true,
          icon: const Icon(Icons.grid_view),
          onTap: () {},
        ),
        DsChip(
          label: '',
          selected: false,
          icon: const Icon(Icons.list),
          onTap: () {},
        ),
        DsChip(
          label: 'Electronics',
          selected: false,
          onTap: () {},
        ),
        DsChip(
          label: 'Furniture',
          selected: true,
          onTap: () {},
        ),
      ],
    );
  }

  Widget _chipRowSection() {
    final categories = [
      'All',
      'Electronics',
      'Furniture',
      'Clothing',
      'Books',
      'Sports',
    ];

    return DsChipRow(
      children: [
        for (int i = 0; i < categories.length; i++)
          DsChip(
            label: categories[i],
            selected: i == _selectedChipIndex,
            onTap: () => setState(() => _selectedChipIndex = i),
          ),
      ],
    );
  }

  Widget _searchBarSection() {
    return Column(
      children: [
        DsSearchBar(
          onChanged: (_) {},
          hint: 'Search products...',
        ),
        SizedBox(height: AppSpacing.md),
        DsSearchBar(
          onChanged: (_) {},
          hint: 'With initial value',
          initialValue: 'iPhone',
        ),
      ],
    );
  }

  Widget _ratingBarSection(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ratingRow(context, '5.0', 5.0),
        SizedBox(height: AppSpacing.sm),
        _ratingRow(context, '3.5', 3.5),
        SizedBox(height: AppSpacing.sm),
        _ratingRow(context, '1.0', 1.0),
        SizedBox(height: AppSpacing.sm),
        _ratingRow(context, '0.0', 0.0),
        SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            DsRatingBar(rating: 4.0, size: AppSpacing.lg),
            SizedBox(width: AppSpacing.sm),
            Text(
              'Small size',
              style: AppTypography.bodySmall.copyWith(
                color: colors.onBackgroundMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _ratingRow(BuildContext context, String label, double rating) {
    final colors = AppColors.of(context);
    return Row(
      children: [
        DsRatingBar(rating: rating),
        SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: colors.onBackgroundSecondary,
          ),
        ),
      ],
    );
  }

  Widget _priceBadgeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DsPriceBadge(price: 29.99),
        SizedBox(height: AppSpacing.sm),
        const DsPriceBadge(price: 49.99, discountPercentage: 20),
        SizedBox(height: AppSpacing.sm),
        const DsPriceBadge(
          price: 9.99,
          discountPercentage: 50,
          showOriginal: false,
        ),
        SizedBox(height: AppSpacing.sm),
        const DsPriceBadge(price: 1299.00, discountPercentage: 10),
      ],
    );
  }

  Widget _badgeSection(BuildContext context) {
    final colors = AppColors.of(context);
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        const DsBadge(text: 'In Stock'),
        DsBadge(
          text: 'Low Stock',
          backgroundColor: colors.statusWarning.withAlpha(30),
          textColor: colors.statusWarning,
        ),
        DsBadge(
          text: 'Out of Stock',
          backgroundColor: colors.destructive.withAlpha(30),
          textColor: colors.destructive,
        ),
        DsBadge(
          text: 'New',
          backgroundColor: colors.accent.withAlpha(30),
          textColor: colors.accent,
        ),
      ],
    );
  }

  Widget _networkImageSection() {
    return SizedBox(
      height: 150,
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              child: const DsNetworkImage(
                url: 'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png',
                height: 150,
              ),
            ),
          ),
          SizedBox(width: AppSpacing.md),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              child: const DsNetworkImage(
                url: 'https://invalid-url-for-error-test.example/image.png',
                height: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageGallerySection() {
    return const DsImageGallery(
      height: 220,
      images: [
        'https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png',
        'https://cdn.dummyjson.com/products/images/beauty/Eyeshadow%20Palette%20with%20Mirror/1.png',
        'https://cdn.dummyjson.com/products/images/beauty/Powder%20Canister/1.png',
      ],
    );
  }

  Widget _skeletonSection() {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        const DsSkeleton(width: 200, height: 20),
        const DsSkeleton(width: 120, height: 14),
        const DsSkeleton(width: 60, height: 60, borderRadius: 30),
        const DsSkeleton(width: double.infinity, height: 100),
      ],
    );
  }

  Widget _skeletonCardSection() {
    return SizedBox(
      width: 180,
      height: 280,
      child: const DsSkeletonCard(),
    );
  }

  Widget _dividerSection(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Default divider',
          style: AppTypography.bodySmall.copyWith(
            color: colors.onBackgroundMuted,
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        const DsDivider(),
        SizedBox(height: AppSpacing.lg),
        Text(
          'Indented divider',
          style: AppTypography.bodySmall.copyWith(
            color: colors.onBackgroundMuted,
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        DsDivider(indent: AppSpacing.xl),
      ],
    );
  }

  Widget _connectivityBannerSection() {
    final colors = AppColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DsButton(
          label: _showOfflineBanner ? 'Hide Banner' : 'Show Banner',
          onPressed: () =>
              setState(() => _showOfflineBanner = !_showOfflineBanner),
          variant: DsButtonVariant.secondary,
        ),
        SizedBox(height: AppSpacing.md),
        ClipRect(
          child: SizedBox(
            height: 36,
            child: DsConnectivityBanner(isOffline: _showOfflineBanner),
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        Text(
          'Tap the button to toggle the offline banner.',
          style: AppTypography.bodySmall.copyWith(
            color: colors.onBackgroundMuted,
          ),
        ),
      ],
    );
  }

  Widget _errorStateSection() {
    return DsErrorState(
      message: 'Something went wrong. Please try again.',
      onRetry: () {},
    );
  }

  Widget _emptyStateSection() {
    return Column(
      children: [
        const DsEmptyState(message: 'No products found'),
        SizedBox(height: AppSpacing.lg),
        DsEmptyState(
          message: 'Your cart is empty',
          icon: Icons.shopping_cart_outlined,
          description: 'Add some products to get started.',
          actionLabel: 'Browse products',
          onAction: () {},
        ),
      ],
    );
  }
}
