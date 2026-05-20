import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_30/core/constants/color_manager.dart';
import 'package:flutter_application_30/core/constants/style_manager.dart';
import 'package:flutter_application_30/presentation/home/details/view/product_detail_screen.dart';
import 'package:flutter_application_30/presentation/home/viewmodel/home_screen_riverpod.dart';
import 'package:flutter_application_30/presentation/home/widgets/product_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends ConsumerWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteProductsProvider);

    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackground(context),
      appBar: AppBar(
        backgroundColor: ColorManager.scaffoldBackground(context),
        elevation: 0,
        iconTheme: IconThemeData(color: ColorManager.textPrimary(context)),
        title: Text(
          'Favorites',
          style: getRegularStyle18_600(
            color: ColorManager.textPrimary(context),
          ),
        ),
        centerTitle: true,
      ),
      body: favoritesAsync.when(
        data: (products) {
          if (products.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_outline_rounded,
                      size: 64.sp,
                      color: ColorManager.textSecondary(context),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'No favorites yet',
                      style: getRegularStyle18_600(
                        color: ColorManager.textPrimary(context),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Tap the heart on a product to save it here',
                      style: getLightStyle14_400(
                        color: ColorManager.textSecondary(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return GridView.builder(
            padding: EdgeInsets.all(16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 0.7,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
                isFavorite: true,
                onFavoriteTap: () async {
                  await ref
                      .read(favoriteProductsProvider.notifier)
                      .toggleFavorite(product);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Removed from favorites'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(product: product),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Failed to load favorites: $e',
              style: getLightStyle14_400(
                color: ColorManager.textSecondary(context),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
