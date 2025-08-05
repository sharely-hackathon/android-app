import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sharely/utils/network_image_util.dart';
import '../../../utils/assets_utils.dart';
import '../../../utils/color_utils.dart';
import 'search_controller.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(
              () => controller.hasSearchResults.value
                  ? _buildSearchResults()
                  : _buildCategoryGrid(),
            ),
          ),
        ],
      ),
    );
  }

  // 构建搜索栏
  Widget _buildSearchBar() => SafeArea(
    child: Container(
      margin: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                color: toColor('#FAFAF9'),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onChanged: controller.onSearchChanged,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Lip color'.tr,
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    color: toColor('999999'),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: toColor('999999'),
                    size: 20.w,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 0,
                  ),
                  isDense: true,
                ),
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
          ),
          16.horizontalSpace,
          InkWell(
            onTap: () => Get.back(),
            child: Text(
              'Cancel'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: toColor('333333'),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // 构建搜索结果页面
  Widget _buildSearchResults() => Column(
    children: [
      _buildFilterTabs(),
      Expanded(child: _buildProductGrid()),
    ],
  );

  // 构建筛选标签
  Widget _buildFilterTabs() => Container(
    height: 40.h,
    margin: EdgeInsets.only(top: 16.h),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: controller.filterOptions.length,
      itemBuilder: (context, index) {
        return Obx(() {
          final filter = controller.filterOptions[index];
          final isSelected = controller.selectedFilters.contains(filter);
          return Container(
            margin: EdgeInsets.only(right: 12.w),
            child: InkWell(
              onTap: () => controller.onFilterTap(filter),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? toColor('FF6B6B') : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected ? toColor('FF6B6B') : toColor('E5E5E5'),
                    width: 1.w,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      filter,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: isSelected ? Colors.white : toColor('666666'),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (isSelected) ...[
                      4.horizontalSpace,
                      Icon(Icons.close, size: 14.sp, color: Colors.white),
                    ] else ...[
                      4.horizontalSpace,
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 16.sp,
                        color: toColor('666666'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        });
      },
    ),
  );

  // 构建商品网格
  Widget _buildProductGrid() => Container(
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    child: Obx(
      () => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 0.78,
        ),
        itemCount: controller.searchProducts.length,
        itemBuilder: (context, index) {
          final product = controller.searchProducts[index];
          return _buildProductItem(product);
        },
      ),
    ),
  );

  // 构建商品项（复用home_page的布局）
  Widget _buildProductItem(Product product) => InkWell(
    onTap: () => controller.onProductTap(product),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_buildProductImage(product), _buildProductInfo(product)],
    ),
  );

  Widget _buildProductImage(Product product) => Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          color: toColor('#F6F3F3'),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: NetworkImageUtil.loadRoundedImage(
          product.image,
          height: 140.h,
          width: 1.sw,
          radius: 16.r,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        top: 8.h,
        left: 8.w,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: toColor("FF6B6B"),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AssetsUtils.alpha_ic, height: 12.h),
              4.horizontalSpace,
              Text(
                'Earn ${product.earnPercentage}',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _buildProductInfo(Product product) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            product.name,
            style: TextStyle(
              fontSize: 14.sp,
              color: toColor("#292524"),
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16.sp,
                color: toColor("FF6B6B"),
                fontWeight: FontWeight.bold,
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: Text(
                product.originalPrice.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: toColor("999999"),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: toColor("#292524"), size: 14.sp),
                2.horizontalSpace,
                Text(
                  product.rating.toString(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: toColor("#292524"),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // 构建分类网格
  Widget _buildCategoryGrid() => Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    child: Obx(
      () => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15.w,
          mainAxisSpacing: 15.h,
          childAspectRatio: 1.3,
        ),
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return _buildCategoryItem(category, controller);
        },
      ),
    ),
  );

  // 构建单个分类项
  Widget _buildCategoryItem(
    CategoryItem category,
    SearchController controller,
  ) => InkWell(
    onTap: () => controller.onCategoryTap(category),
    child: Container(
      decoration: BoxDecoration(
        color: toColor(category.color),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 背景图片
          Positioned.fill(
            child: NetworkImageUtil.loadRoundedImage(
              category.imagePath,
              radius: 10.r,
            ),
          ),
          // 渐变遮罩
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),
          ),
          // 文字
          Center(
            child: Text(
              category.title,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
          // Z图标（针对Home appliances分类）
          if (category.title == 'Home appliances')
            Positioned(
              right: 16.w,
              top: 16.h,
              child: Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: toColor('FF6B35'),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'Z',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
