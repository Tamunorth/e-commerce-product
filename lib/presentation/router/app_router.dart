import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import '../products/cubit/categories_cubit.dart';
import '../products/cubit/product_detail_cubit.dart';
import '../products/cubit/product_list_cubit.dart';
import '../products/screens/product_detail_screen.dart';
import '../products/screens/products_adaptive_screen.dart';
import '../design_system/showcase/showcase_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/products',
    routes: [
      GoRoute(
        path: '/products',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<ProductListCubit>()..loadProducts()),
            BlocProvider(create: (_) => sl<CategoriesCubit>()..loadCategories()),
            BlocProvider(create: (_) => sl<ProductDetailCubit>()),
          ],
          child: const ProductsAdaptiveScreen(),
        ),
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return BlocProvider(
                create: (_) => sl<ProductDetailCubit>()..loadProduct(id),
                child: const ProductDetailScreen(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: '/showcase',
        builder: (context, state) => const ShowcaseScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
}
