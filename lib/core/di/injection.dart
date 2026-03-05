import 'package:get_it/get_it.dart';

import '../../data/datasources/product_local_datasource.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_categories.dart';
import '../../domain/usecases/get_product_by_id.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/get_products_by_category.dart';
import '../../domain/usecases/search_products.dart';
import '../../presentation/products/cubit/categories_cubit.dart';
import '../../presentation/products/cubit/product_detail_cubit.dart';
import '../../presentation/products/cubit/product_list_cubit.dart';
import '../network/api_client.dart';
import '../theme/theme_cubit.dart';

final sl = GetIt.instance;

void initDependencies() {
  // Core
  sl.registerLazySingleton(() => ApiClient());
  sl.registerLazySingleton(() => ThemeCubit());

  // Data sources
  sl.registerLazySingleton(() => ProductRemoteDatasource(sl()));
  sl.registerLazySingleton(() => ProductLocalDatasource());

  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDatasource: sl(),
      localDatasource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => SearchProducts(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetProductsByCategory(sl()));
  sl.registerLazySingleton(() => GetProductById(sl()));

  // Cubits - factory (new instance per screen)
  sl.registerFactory(() => ProductListCubit(
    getProducts: sl(),
    searchProducts: sl(),
    getProductsByCategory: sl(),
  ));
  sl.registerFactory(() => CategoriesCubit(sl()));
  sl.registerFactory(() => ProductDetailCubit(sl()));
}
