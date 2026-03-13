import 'package:ecommerce_app/core/routing/app_routes.dart';
import 'package:ecommerce_app/core/styling/app_colors.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/custom_text_field.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:ecommerce_app/features/home_screen/cubit/category_cubit.dart';
import 'package:ecommerce_app/features/home_screen/cubit/product_cubit.dart';
import 'package:ecommerce_app/features/home_screen/widgets/category_item_widget.dart';
import 'package:ecommerce_app/features/home_screen/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  @override
  void initState() {
    context.read<CategoryCubit>().fetchCategories();
    context.read<ProductCubit>().fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // getIt<StorageHelper>().removeToken();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeightSpace(28),
          SizedBox(
            width: 335.w,
            child: Text(
              "Discover",
              style: AppStyles.primaryHeadLinesStyle,
            ),
          ),
          const HeightSpace(16),
          Row(
            children: [
              CustomTextField(
                  width: 274.w,
                  hintText: "Search For Clothes",
                  onChanged: (value) {
                    if (selectedCategory == 'All') {
                      context
                          .read<ProductCubit>()
                          .fetchProducts(searchTerm: value);
                    } else {
                      context.read<ProductCubit>().fetchProducts(
                          searchTerm: value, category: selectedCategory);
                    }
                  }),
              const WidthSpace(3),
              Container(
                width: 65.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const HeightSpace(16),
          BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              if (state is CategorySuccess) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: state.categories
                          .map((e) => CategoryItemWidget(
                                categoryName: e.name,
                                isSelected: selectedCategory == e.name,
                                onTap: () {
                                  setState(() {
                                    selectedCategory = e.name;
                                    if (selectedCategory == 'All') {
                                      context
                                          .read<ProductCubit>()
                                          .fetchProducts();
                                    } else {
                                      context
                                          .read<ProductCubit>()
                                          .fetchProducts(category: e.name);
                                    }
                                  });
                                },
                              ))
                          .toList()),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const HeightSpace(16),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: GridView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 150.w,
                          height: 150.w,
                          color: Colors.red,
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.h,
                        crossAxisSpacing: 16.w,
                        childAspectRatio: 0.7,
                      ),
                    ),
                  ),
                );
              } else if (state is ProductError) {
                return Center(child: Text(state.message));
              } else if (state is ProductSuccess) {
                return Expanded(
                  child: RefreshIndicator(
                    color: AppColors.primaryColor,
                    backgroundColor: Colors.white,
                    onRefresh: () async {
                      selectedCategory = 'All';
                      setState(() {});
                      context.read<ProductCubit>().fetchProducts();
                    },
                    child: AnimationLimiter(
                      child: GridView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 675),
                            columnCount: 2,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: ProductItemWidget(
                                  title: product.name,
                                  price: product.price.toString(),
                                  imageUrl: product.coverPictureUrl!,
                                  onTap: () {
                                    GoRouter.of(context).pushNamed(
                                        AppRoutes.productScreen,
                                        extra: product);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.h,
                          crossAxisSpacing: 16.w,
                          childAspectRatio: 0.7,
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const Center(child: Text('data'));
            },
          )
        ],
      ),
    );
  }
}
