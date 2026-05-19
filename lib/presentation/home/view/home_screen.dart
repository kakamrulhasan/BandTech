import 'package:flutter/material.dart';
import 'package:flutter_application_30/core/constants/color_manager.dart';
import 'package:flutter_application_30/core/constants/style_manager.dart';
import 'package:flutter_application_30/data/static_data.dart';
import 'package:flutter_application_30/presentation/home/widgets/product_card.dart';
import 'package:flutter_application_30/presentation/home/details/view/product_detail_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _filteredProducts = staticProducts;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      _isSearching = _searchController.text.isNotEmpty;
      if (_isSearching) {
        _filteredProducts = staticProducts
            .where(
              (product) =>
                  product.title.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ) ||
                  product.category.toLowerCase().contains(
                    _searchController.text.toLowerCase(),
                  ),
            )
            .toList();
      } else {
        _filteredProducts = staticProducts;
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _isSearching = false;
      _filteredProducts = staticProducts;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            // =============== Header Section ================
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
            // =============== Search Bar Section =================
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
                    suffixIcon: _isSearching
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
            // =================== Products List ======================
            Expanded(
              child: _filteredProducts.isEmpty
                  ? _buildNoProductsWidget()
                  : GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
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
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoProductsWidget() {
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
            _isSearching ? 'No products found' : 'No products available',
            style: getRegularStyle18_600(color: ColorManager.secondary),
          ),
          SizedBox(height: 8.h),
          Text(
            _isSearching
                ? 'Try searching with different keywords'
                : 'Please try again later',
            style: getLightStyle14_400(color: ColorManager.typography300),
          ),
        ],
      ),
    );
  }
}
