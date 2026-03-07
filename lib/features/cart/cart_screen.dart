import 'package:ecommerce_app/core/widgets/loading_widget.dart';
import 'package:ecommerce_app/core/widgets/primary_button_widget.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/widget/cart_item_widget.dart';
import 'package:ecommerce_app/features/home_screen/widgets/title_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Container(),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is DeleteCartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        buildWhen: (previous, current) =>
            current is CartSuccess ||
            current is CartLoading ||
            current is CartError,
        builder: (context, state) {
          if (state is CartLoading) {
            return LoadingWidget(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
            );
          }
          if (state is CartError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is CartSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeightSpace(20),
                    ...state.carts.map((e) => CartItemWidget(
                          cartData: e,
                        )),
                    const HeightSpace(20),
                    const TitlePriceWidget(
                        title: "Sub Total", price: "1190 \$"),
                    const TitlePriceWidget(
                        title: "VAT (16 %)", price: "1190 \$"),
                    const TitlePriceWidget(
                        title: "Shipping Fees", price: "1190 \$"),
                    const HeightSpace(20),
                    const Divider(),
                    const HeightSpace(20),
                    const TotalPriceWidget(title: "Total", price: "1190 \$"),
                    const HeightSpace(20),
                    PrimrayButtonWidget(
                      buttonText: "Go To Checkout",
                      trailingIcon: Icon(
                        Icons.payment,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      onPress: () {},
                    ),
                    const HeightSpace(20),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}
