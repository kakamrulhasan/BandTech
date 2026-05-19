import 'package:flutter/material.dart';
import 'package:flutter_application_30/core/constants/color_manager.dart';
import 'package:flutter_application_30/core/constants/style_manager.dart';
import 'package:flutter_application_30/data/models/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: AppBar(
        backgroundColor: ColorManager.whiteColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: ColorManager.secondary,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Product Details',
          style: getRegularStyle18_600(color: ColorManager.secondary),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              child: Icon(
                _isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                color: _isFavorite
                    ? ColorManager.redColor
                    : ColorManager.secondary,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================ Product Image ==================
            Container(
              height: 300.h,
              width: double.infinity,
              color: ColorManager.grey100,
              child: Center(
                child: Image.network(
                  widget.product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 60.sp,
                        color: ColorManager.grey400,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 24.h),
            // =========== Product Details ================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.categoryTagBg,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      widget.product.category.toUpperCase(),
                      style: getLightStyle12_400(
                        color: ColorManager.categoryTagText,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // ============= Product Title ===============
                  Text(
                    widget.product.title,
                    style: getRegularStyle20_600(color: ColorManager.secondary),
                  ),
                  SizedBox(height: 16.h),
                  // Rating and Reviews Row
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: ColorManager.ratingColor,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            widget.product.rating.rate.toStringAsFixed(1),
                            style: getRegularStyle16_600(
                              color: ColorManager.secondary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        '(${widget.product.rating.count} reviews)',
                        style: getLightStyle14_400(
                          color: ColorManager.typography300,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // ============ Price Section ===============
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: ColorManager.categoryTagBg,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: getLightStyle14_400(
                            color: ColorManager.secondary,
                          ),
                        ),
                        Text(
                          '\$${widget.product.price.toStringAsFixed(2)}',
                          style: getRegularStyle20_600(
                            color: ColorManager.priceColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // ============= Description Section ==============
                  Text(
                    'Description',
                    style: getRegularStyle18_600(color: ColorManager.secondary),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    widget.product.description,
                    style: getLightStyle14_400(
                      color: ColorManager.typography300,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 32.h),
                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.product.title} added to cart',
                              style: getLightStyle14_400(
                                color: ColorManager.whiteColor,
                              ),
                            ),
                            backgroundColor: ColorManager.priceColor,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.priceColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: getRegularStyle18_600(
                          color: ColorManager.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
