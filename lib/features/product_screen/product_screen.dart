import 'package:cached_network_image/cached_network_image.dart';
import 'package:tendora/core/styling/app_styles.dart';
import 'package:tendora/core/utils/snak_bar_widget.dart';
import 'package:tendora/core/widgets/primary_button_widget.dart';
import 'package:tendora/core/widgets/spacing_widgets.dart';
import 'package:tendora/features/home_screen/models/product_model.dart';
import 'package:tendora/features/product_screen/cubit/add_product_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.product});
  final ProductData product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(20),
                  Hero(
                    tag: product.name,
                    child: CachedNetworkImage(
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        imageUrl: product.coverPictureUrl ?? ''),
                  ),
                  const HeightSpace(12),
                  Text(
                    product.name,
                    style: AppStyles.black16w500Style.copyWith(fontSize: 24.sp),
                  ),
                  const HeightSpace(8),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 18.sp,
                      ),
                      const WidthSpace(2),
                      Text(
                        "${product.rating.toString()}/5",
                        style: AppStyles.black15BoldStyle
                            .copyWith(decoration: TextDecoration.underline),
                      ),
                      const WidthSpace(2),
                      Text(
                        "(${product.reviewsCount.toString()} Reviews)",
                        style: AppStyles.grey12MediumStyle.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                    ],
                  ),
                  const HeightSpace(8),
                  Text(
                    product.description,
                    style: AppStyles.grey12MediumStyle.copyWith(
                        fontSize: 16.sp, fontWeight: FontWeight.normal),
                  ),
                  const HeightSpace(150),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const Divider(),
                  const HeightSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price",
                            style: AppStyles.grey12MediumStyle
                                .copyWith(fontSize: 16.sp),
                          ),
                          const HeightSpace(4),
                          Text(
                            '${product.price} \$',
                            style: AppStyles.black16w500Style.copyWith(
                                fontSize: 24.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const WidthSpace(16),
                      BlocConsumer<AddProductCubit, AddProductState>(
                        listener: (context, state) {
                          if (state is AddProductSuccess) {
                            showMsg(state.model.message, context);
                          } else if (state is AddProductError) {
                            showMsg(state.error.firstErrorMessage, context,
                                isError: true);
                          }
                        },
                        builder: (context, state) {
                          final isLoading = state is AddProductLoading;
                          return PrimrayButtonWidget(
                            width: MediaQuery.of(context).size.width * 0.5,
                            buttonText: isLoading ? "Adding..." : "Add To Cart",
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                            isLoading: isLoading,
                            onPress: () {
                              if (!isLoading) {
                                context.read<AddProductCubit>().addProduct(
                                      productId: product.id,
                                      quantity: 1,
                                    );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  const HeightSpace(8),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
