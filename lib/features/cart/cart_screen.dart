import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tendora/core/utils/snak_bar_widget.dart';
import 'package:tendora/core/widgets/loading_widget.dart';
import 'package:tendora/core/widgets/primary_button_widget.dart';
import 'package:tendora/core/widgets/spacing_widgets.dart';
import 'package:tendora/features/cart/cubit/cart_cubit.dart';
import 'package:tendora/features/cart/widget/cart_item_widget.dart';
import 'package:tendora/features/home_screen/widgets/title_price_widget.dart';

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
            showMsg(state.message, context, isError: true);
          }

          if (state is UpdateCartError) {
            showMsg(state.message, context, isError: true);
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
            return Center(child: Text(state.message));
          }
          if (state is CartSuccess) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeightSpace(20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.carts.length,
                      itemBuilder: (context, index) {
                        return CartItemWidget(cartData: state.carts[index]);
                      },
                    ),
                    const HeightSpace(20),
                    TitlePriceWidget(
                      title: "Sub Total",
                      price: "${state.subTotal.toStringAsFixed(2)} \$",
                    ),
                    TitlePriceWidget(
                      title: "VAT (16 %)",
                      price: "${state.vat.toStringAsFixed(2)} \$",
                    ),
                    TitlePriceWidget(
                      title: "Shipping Fees",
                      price: "${state.shippingFees.toStringAsFixed(2)} \$",
                    ),
                    const HeightSpace(20),
                    const Divider(),
                    const HeightSpace(20),
                    TotalPriceWidget(
                      title: "Total",
                      price: "${state.total.toStringAsFixed(2)} \$",
                    ),
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
