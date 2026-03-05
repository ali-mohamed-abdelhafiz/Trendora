import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/core/styling/app_styles.dart';
import 'package:ecommerce_app/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItemWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String price;
  final Function()? onTap;
  const ProductItemWidget(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.price,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: .2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(-1, 1),
              // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            HeightSpace(12.h),
            ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) => SizedBox(
                    width: 150.w,
                    height: 150.h,
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  ),
                  imageUrl: imageUrl,
                  width: 150.w,
                  height: 150.h,
                  fit: BoxFit.cover,
                )),
            const HeightSpace(8),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 6.w),
              child:
                  Text(title, maxLines: 1, style: AppStyles.black15BoldStyle),
            ),
            const HeightSpace(8),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 6.w),
                child: Text('$price \$',
                    textAlign: TextAlign.start,
                    style: AppStyles.grey12MediumStyle
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
