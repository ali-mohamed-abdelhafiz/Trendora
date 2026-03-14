import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tendora/core/routing/app_routes.dart';
import 'package:tendora/core/utils/service_locator.dart';
import 'package:tendora/features/address/address_screen.dart';
import 'package:tendora/features/auth/cubit/auth_cubit.dart';
import 'package:tendora/features/auth/login_screen.dart';
import 'package:tendora/features/auth/register_screen.dart';
import 'package:tendora/features/cart/cubit/cart_cubit.dart';
import 'package:tendora/features/home_screen/models/product_model.dart';
import 'package:tendora/features/main_screen/main_screen.dart';
import 'package:tendora/features/product_screen/cubit/add_product_cubit.dart';
import 'package:tendora/features/product_screen/product_screen.dart';
import 'package:tendora/features/splash_screen/splash_screen.dart';

class RouterGenerationConfig {
  static GoRouter goRouter =
      GoRouter(initialLocation: AppRoutes.splashScreen, routes: [
    GoRoute(
      name: AppRoutes.splashScreen,
      path: AppRoutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: AppRoutes.loginScreen,
      path: AppRoutes.loginScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.registerScreen,
      path: AppRoutes.registerScreen,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: AppRoutes.mainScreen,
      path: AppRoutes.mainScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt<CartCubit>(),
        child: const MainScreen(),
      ),
    ),
    GoRoute(
        name: AppRoutes.productScreen,
        path: AppRoutes.productScreen,
        builder: (context, state) {
          ProductData product = state.extra as ProductData;
          return BlocProvider(
            create: (context) => getIt<AddProductCubit>(),
            child: ProductScreen(product: product),
          );
        }),
    GoRoute(
      name: AppRoutes.addressScreen,
      path: AppRoutes.addressScreen,
      builder: (context, state) => const AddressScreen(),
    ),
  ]);
}
