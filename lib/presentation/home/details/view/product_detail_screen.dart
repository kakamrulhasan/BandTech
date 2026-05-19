import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_30/core/constants/color_manager.dart';
import 'package:flutter_application_30/core/constants/style_manager.dart';
import 'package:flutter_application_30/data/models/product_model.dart';
import 'package:flutter_application_30/presentation/home/viewmodel/home_screen_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailScreen extends ConsumerWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProducts = ref
        .watch(favoriteProductsProvider)
        .maybeWhen(
          data: (products) => products,
          orElse: () => <ProductModel>[],
        );
    final isFavorite = favoriteProducts.any(
      (favorite) => favorite.id == product.id,
    );
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: colorScheme.onSurface,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Product Details',
          style: getRegularStyle18_600(color: colorScheme.onSurface),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () async {
                final isNowFavorite = await ref
                    .read(favoriteProductsProvider.notifier)
                    .toggleFavorite(product);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isNowFavorite
                            ? 'Added to favorites'
                            : 'Removed from favorites',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: Icon(
                isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                color: isFavorite
                    ? ColorManager.redColor
                    : colorScheme.onSurface,
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
              color: colorScheme.surfaceContainerHighest,
              child: Center(
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 60.sp,
                        color: colorScheme.onSurfaceVariant,
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
                      product.category.toUpperCase(),
                      style: getLightStyle12_400(
                        color: ColorManager.categoryTagText,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // ============= Product Title ===============
                  Text(
                    product.title,
                    style: getRegularStyle20_600(color: colorScheme.onSurface),
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
                            product.rating.rate.toStringAsFixed(1),
                            style: getRegularStyle16_600(
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        '(${product.rating.count} reviews)',
                        style: getLightStyle14_400(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // ============ Price Section ===============
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: getLightStyle14_400(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
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
                    style: getRegularStyle18_600(color: colorScheme.onSurface),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    product.description,
                    style: getLightStyle14_400(
                      color: colorScheme.onSurfaceVariant,
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
                              '${product.title} added to cart',
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
