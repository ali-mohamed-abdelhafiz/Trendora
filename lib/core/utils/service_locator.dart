import 'package:ecommerce_app/core/networking/dio_helper.dart';
import 'package:ecommerce_app/core/utils/storage_helper.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/repo/auth_repo.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/repo/cart_repo.dart';
import 'package:ecommerce_app/features/home_screen/cubit/category_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/product_cubit.dart';
import 'package:ecommerce_app/features/home_screen/repo/home_repo.dart';
import 'package:ecommerce_app/features/product_screen/cubit/add_product_cubit.dart';
import 'package:ecommerce_app/features/product_screen/repo/add_product_repo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
void setupServiseLocator() {
  //Dio Helper
  getIt.registerSingleton<DioHelper>(DioHelper());

  //Storage Helper
  getIt.registerLazySingleton(
    () => StorageHelper(),
  );

  //Repos
  getIt.registerLazySingleton(
    () => AuthRepo(getIt()),
  );
  getIt.registerLazySingleton(
    () => HomeRepo(getIt()),
  );
  getIt.registerLazySingleton(
    () => AddProductRepo(getIt()),
  );
  getIt.registerLazySingleton(
    () => CartRepo(getIt()),
  );

  //Cubit
  getIt.registerFactory(
    () => AuthCubit(getIt()),
  );
  getIt.registerFactory(
    () => CategoryCubit(getIt()),
  );
  getIt.registerFactory(
    () => ProductCubit(getIt()),
  );
  getIt.registerFactory(
    () => AddProductCubit(getIt()),
  );
  getIt.registerFactory(
    () => CartCubit(getIt()),
  );
}
