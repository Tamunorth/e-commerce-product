import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../design_system/components/ds_empty_state.dart';
import '../cubit/product_detail_cubit.dart';
import '../cubit/product_list_cubit.dart';
import '../cubit/product_list_state.dart';
import 'product_detail_screen.dart';
import 'product_list_screen.dart';

class ProductsAdaptiveScreen extends StatelessWidget {
  const ProductsAdaptiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= AppConstants.tabletBreakpoint) {
              return _MasterDetailLayout(
                totalWidth: constraints.maxWidth,
              );
            }
            return const ProductListScreen();
          },
        ),
      ),
    );
  }
}

class _MasterDetailLayout extends StatefulWidget {
  const _MasterDetailLayout({required this.totalWidth});

  final double totalWidth;

  @override
  State<_MasterDetailLayout> createState() => _MasterDetailLayoutState();
}

class _MasterDetailLayoutState extends State<_MasterDetailLayout> {
  StreamSubscription<int?>? _subscription;
  int? _lastLoadedProductId;
  late final ValueNotifier<double> _splitRatio;

  @override
  void initState() {
    super.initState();
    _splitRatio = ValueNotifier(0.4);
    final listCubit = context.read<ProductListCubit>();
    _subscription = listCubit.stream
        .map((state) => state.selectedProductId)
        .distinct()
        .listen(_onSelectedProductChanged);
  }

  void _onSelectedProductChanged(int? selectedId) {
    if (!mounted) return;
    if (selectedId != null && selectedId != _lastLoadedProductId) {
      _lastLoadedProductId = selectedId;
      context.read<ProductDetailCubit>().loadProduct(selectedId);
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _splitRatio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return ValueListenableBuilder<double>(
      valueListenable: _splitRatio,
      builder: (context, ratio, _) {
        final totalWidth = widget.totalWidth;
        final minList = max(250.0, totalWidth * 0.25);
        final maxList = totalWidth * 0.5;
        final listWidth = (totalWidth * ratio).clamp(minList, maxList);

        return Row(
          children: [
            SizedBox(
              width: listWidth,
              child: const ProductListScreen(isEmbedded: true),
            ),
            _DraggableDivider(
              colors: colors,
              onDrag: (dx) {
                final newRatio = _splitRatio.value + dx / totalWidth;
                _splitRatio.value = newRatio.clamp(
                  minList / totalWidth,
                  maxList / totalWidth,
                );
              },
            ),
            Expanded(
              child: BlocBuilder<ProductListCubit, ProductListState>(
                buildWhen: (previous, current) =>
                    previous.selectedProductId != current.selectedProductId,
                builder: (context, state) {
                  if (state.selectedProductId == null) {
                    return const DsEmptyState(
                      message: 'Select a product',
                      icon: Iconsax.mouse_circle,
                    );
                  }
                  return const _ConstrainedDetail();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ConstrainedDetail extends StatelessWidget {
  const _ConstrainedDetail();

  @override
  Widget build(BuildContext context) {
    return const ProductDetailScreen(showBackButton: false);
  }
}

class _DraggableDivider extends StatelessWidget {
  const _DraggableDivider({
    required this.colors,
    required this.onDrag,
  });

  final AppColors colors;
  final ValueChanged<double> onDrag;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) => onDrag(details.delta.dx),
        child: SizedBox(
          width: 8,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Divider line
              Positioned.fill(
                child: Center(
                  child: Container(width: 1, color: colors.divider),
                ),
              ),
              // Drag handle
              Container(
                width: 4,
                height: 32,
                decoration: BoxDecoration(
                  color: colors.onBackgroundMuted,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
