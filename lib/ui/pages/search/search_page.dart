import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sharely/models/category_model.dart';
import 'package:sharely/utils/network_image_util.dart';
import '../../../main.dart';
import '../../../models/product_model.dart';
import '../../../utils/assets_utils.dart';
import '../../../utils/color_utils.dart';
import 'search_controller.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final controller = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus(); // 关闭键盘
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: Obx(
                () {
                  // 如果正在加载，显示空容器
                  if (controller.isDataLoad.value) {
                    return Container();
                  }

                  // 如果还没开始搜索，显示分类网格
                  if (!controller.hasStartedSearch.value) {
                    return _buildCategoryGrid();
                  }

                  // 如果输入框为空，显示分类网格
                  if (controller.searchController.text.trim().isEmpty) {
                    return _buildCategoryGrid();
                  }

                  // 如果有搜索错误，显示错误信息
                  if (controller.searchError.value != null) {
                    return _buildErrorWidget();
                  }

                  // 如果正在搜索，显示加载状态
                  if (controller.isSearching.value) {
                    return _buildLoadingWidget();
                  }

                  // 如果有搜索结果，显示搜索结果
                  if (controller.searchProducts.isNotEmpty) {
                    return _buildSearchResults();
                  }

                  // 如果搜索结果为空，显示无数据提示
                  return _buildNoDataWidget();
                },
              ),
            ),
          ],
        ),
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
                controller: controller.searchController,
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
          childAspectRatio: 0.72,
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

  // 构建加载状态Widget
  Widget _buildLoadingWidget() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(toColor('FF6B6B')),
        ),
        16.verticalSpace,
        Text(
          'Searching...'.tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: toColor('666666'),
          ),
        ),
      ],
    ),
  );

  // 构建无数据Widget
  Widget _buildNoDataWidget() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.search_off,
          size: 80.sp,
          color: toColor('CCCCCC'),
        ),
        16.verticalSpace,
        Text(
          'No Data',
          style: TextStyle(
            fontSize: 18.sp,
            color: toColor('666666'),
            fontWeight: FontWeight.w500,
          ),
        ),
        8.verticalSpace,
        Text(
          'No products found for your search',
          style: TextStyle(
            fontSize: 14.sp,
            color: toColor('999999'),
          ),
        ),
      ],
    ),
  );

  // 构建错误Widget
  Widget _buildErrorWidget() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          size: 60.sp,
          color: toColor('FF6B6B'),
        ),
        16.verticalSpace,
        Text(
          controller.searchError.value ?? 'Search Error',
          style: TextStyle(
            fontSize: 16.sp,
            color: toColor('666666'),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ).marginSymmetric(horizontal: 16.w),
      ],
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
          _getProductImage(product),
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
                'Earn 5%', // 默认显示5%，可以后续从产品数据中获取
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
        4.verticalSpace,
        Text(
          product.title,
          style: TextStyle(
            fontSize: 14.sp,
            color: toColor("#292524"),
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        4.verticalSpace,
        Row(
          children: [
            Text(
              '\$${_getProductPrice(product)}',
              style: TextStyle(
                fontSize: 16.sp,
                color: toColor("FF6B6B"),
                fontWeight: FontWeight.bold,
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: Text(
                '\$${_getOriginalPrice(product)}',
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
                  '4.5', // 默认评分，可以后续从产品数据中获取
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

  // 获取产品图片
  String _getProductImage(Product product) {
    // 优先使用images数组中的第一张图片
    if (product.images.isNotEmpty) {
      return product.images.first.url;
    }
    // 如果没有images，使用thumbnail
    if (product.thumbnail.isNotEmpty) {
      return product.thumbnail;
    }
    // 最后使用默认图片
    return testImg;
  }

  // 获取产品价格
  String _getProductPrice(Product product) {
    // 优先使用variants中的计算价格
    if (product.variants.isNotEmpty && 
        product.variants.first.calculatedPrice != null) {
      return (product.variants.first.calculatedPrice!.calculatedAmount / 100)
          .toStringAsFixed(2);
    }
    return '0.00';
  }

  // 获取原价
  String _getOriginalPrice(Product product) {
    // 优先使用variants中的原始价格
    if (product.variants.isNotEmpty && 
        product.variants.first.calculatedPrice != null) {
      return (product.variants.first.calculatedPrice!.originalAmount / 100)
          .toStringAsFixed(2);
    }
    return '0.00';
  }

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
        itemCount: controller.categories.value?.productCategories.length,
        itemBuilder: (context, index) {
          final category =
              controller.categories.value?.productCategories[index];
          return _buildCategoryItem(category, controller);
        },
      ),
    ),
  );

  // 构建单个分类项
  Widget _buildCategoryItem(
    ProductCategory? category,
    SearchController controller,
  ) => InkWell(
    onTap: () => controller.onCategoryTap(category),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
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
              "${category?.metadata?.thumbnailImage}",
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
              "${category?.name}",
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
        ],
      ),
    ),
  );
}
