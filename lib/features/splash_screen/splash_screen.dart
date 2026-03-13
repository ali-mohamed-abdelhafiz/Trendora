import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_assets.dart';
import 'package:ecommerce_app/core/utils/service_locator.dart';
import 'package:ecommerce_app/core/utils/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 1, milliseconds: 500))
      ..repeat(reverse: true);
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutBack);
    waitNavigationTo();
    super.initState();
  }

  waitNavigationTo() async {
    await Future.delayed(const Duration(seconds: 3));
    getIt<StorageHelper>().getAccessToken().then(
      (value) {
        if (value.isNotEmpty) {
          // ignore: use_build_context_synchronously
          GoRouter.of(context).pushReplacement(AppRoutes.mainScreen);
        } else {
          // ignore: use_build_context_synchronously
          GoRouter.of(context).pushReplacement(AppRoutes.loginScreen);
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ScaleTransition(
      scale: _animation,
      child: Image.asset(
        AppAssets.logo,
        width: 300.w,
      ),
    )));
  }
}
