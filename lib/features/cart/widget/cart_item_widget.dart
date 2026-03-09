import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/cart/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({super.key, required this.cartData});
  final CartData cartData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  placeholder: (context, url) => SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  ),
                  imageUrl: cartData.productCoverUrl,
                  width: 100.w,
                  height: 100.h,
                  fit: BoxFit.cover,
                )),
            const WidthSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          cartData.productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.black15BoldStyle,
                        ),
                      ),
                      const WidthSpace(8),
                      IconButton(
                        onPressed: () => context
                            .read<CartCubit>()
                            .deleteCartItem(cartData.itemId),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(
                          minWidth: 32.w,
                          minHeight: 32.h,
                        ),
                      ),
                    ],
                  ),
                  const HeightSpace(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${cartData.totalPrice} \$",
                        style: AppStyles.black15BoldStyle,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => context
                                .read<CartCubit>()
                                .incrementCartItem(cartData.itemId),
                            child: Container(
                              width: 24.w,
                              height: 24.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 16.sp,
                              ),
                            ),
                          ),
                          const WidthSpace(8),
                          Text(
                            cartData.quantity.toString(),
                            style: AppStyles.black15BoldStyle,
                          ),
                          const WidthSpace(8),
                          InkWell(
                            // onTap: () {
                            //   if (cartData.quantity > 1) {
                            //     context.read<CartCubit>().updateCartQuantity(
                            //         cartData.itemId, cartData.quantity - 1);
                            //   }
                            // },
                            child: Container(
                              width: 24.w,
                              height: 24.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.5),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
