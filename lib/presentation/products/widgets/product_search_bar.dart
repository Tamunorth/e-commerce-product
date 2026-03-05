import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_system/components/ds_search_bar.dart';
import '../cubit/product_list_cubit.dart';

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DsSearchBar(
      hint: 'Search products...',
      onChanged: (query) => context.read<ProductListCubit>().search(query),
    );
  }
}
