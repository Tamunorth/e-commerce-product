import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/category.dart';
import '../../design_system/components/ds_chip.dart';
import '../../design_system/components/ds_chip_row.dart';
import '../cubit/product_list_cubit.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
  });

  final List<Category> categories;
  final String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return DsChipRow(
      children: [
        DsChip(
          label: 'All',
          selected: selectedCategory == null,
          onTap: () => context.read<ProductListCubit>().selectCategory(null),
        ),
        ...categories.map(
          (category) => DsChip(
            label: category.name,
            selected: selectedCategory == category.slug,
            onTap: () =>
                context.read<ProductListCubit>().selectCategory(category.slug),
          ),
        ),
      ],
    );
  }
}
