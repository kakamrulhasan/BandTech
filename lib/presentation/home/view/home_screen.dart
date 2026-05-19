import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_30/core/constants/color_manager.dart';
import 'package:flutter_application_30/core/constants/style_manager.dart';
import 'package:flutter_application_30/presentation/home/widgets/product_card.dart';
import 'package:flutter_application_30/presentation/home/details/view/product_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../viewmodel/home_screen_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      ref.read(searchQueryProvider.notifier).setQuery(_searchController.text);
      setState(() {});
    });
  }

  void _clearSearch() {
    _searchController.clear();
    ref.read(searchQueryProvider.notifier).clear();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredAsync = ref.watch(filteredProductsProvider);

    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'BrandTECH',
                    style: getBoldStyle24(color: ColorManager.secondary),
                  ),
                  Icon(
                    Icons.favorite_outline_rounded,
                    color: ColorManager.secondary,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.grey100,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: ColorManager.cardBorder, width: 1),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products or category...',
                    hintStyle: getLightStyle14_400(
                      color: ColorManager.typography200,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: ColorManager.typography300,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: _clearSearch,
                            child: Icon(
                              Icons.clear,
                              color: ColorManager.typography300,
                            ),
                          )
                        : null,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  style: getLightStyle14_400(color: ColorManager.secondary),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: filteredAsync.when(
                data: (products) {
                  if (products.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 64.sp,
                            color: ColorManager.typography300,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'No products found',
                            style: getRegularStyle18_600(
                              color: ColorManager.secondary,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Try searching with different keywords',
                            style: getLightStyle14_400(
                              color: ColorManager.typography300,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                error: (e, st) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wifi_off,
                            size: 56.sp,
                            color: ColorManager.typography300,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Failed to load products',
                            style: getRegularStyle18_600(
                              color: ColorManager.secondary,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            e.toString(),
                            style: getLightStyle14_400(
                              color: ColorManager.typography300,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
