import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_assets.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/primary_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/account/widgets/account_item_widget.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Container(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(),
          ),
          const HeightSpace(20),
          AccountItemWidget(
            iconPath: AppAssets.box,
            title: "My Orders",
            onTap: () {},
          ),
          const Divider(
            thickness: 8,
            color: Color(0xffE6E6E6),
          ),
          AccountItemWidget(
            iconPath: AppAssets.details,
            title: "My Details",
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(),
          ),
          AccountItemWidget(
            iconPath: AppAssets.address,
            title: "Address Book",
            onTap: () {
              context.pushNamed(AppRoutes.addressScreen);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(),
          ),
          AccountItemWidget(
            iconPath: AppAssets.question,
            title: "FAQ",
            onTap: () {},
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(),
          ),
          AccountItemWidget(
            iconPath: AppAssets.help,
            title: "Help Center",
            onTap: () {},
          ),
          const HeightSpace(16),
          const Divider(
            thickness: 8,
            color: Color(0xffE6E6E6),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: InkWell(
              onTap: () {
                logoutShowDialog(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                    size: 25.sp,
                  ),
                  const WidthSpace(8),
                  Text(
                    "Logout",
                    style: AppStyles.black15BoldStyle
                        .copyWith(color: Colors.redAccent),
                  ),
                ],
              ),
            ),
          ),
          const HeightSpace(20),
        ],
      ),
    );
  }

  logoutShowDialog(BuildContext parentcontext) {
    return showDialog(
      context: parentcontext,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 400.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Colors.red,
                    size: 65.sp,
                  ),
                  const HeightSpace(8),
                  Text(
                    'Logout',
                    style: AppStyles.black18BoldStyle,
                  ),
                  const HeightSpace(8),
                  Text(
                    'Are you sure you want to Logout?',
                    style: AppStyles.grey12MediumStyle,
                  ),
                  const HeightSpace(14),
                  PrimrayButtonWidget(
                    onPress: () {
                      parentcontext.read<AuthCubit>().logout();
                      parentcontext.pushReplacement(AppRoutes.loginScreen);
                    },
                    buttonColor: Colors.red,
                    textColor: Colors.white,
                    buttonText: 'Logout',
                  ),
                  const HeightSpace(8),
                  PrimrayButtonWidget(
                    onPress: () {
                      context.pop();
                    },
                    buttonColor: Colors.grey[500],
                    textColor: Colors.black,
                    buttonText: 'Cancel',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
