import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sharely/base/base_scaffold.dart';
import 'package:sharely/ui/dialog/share/share_dialog.dart';
import 'package:sharely/ui/pages/cart/cart_page.dart';
import 'package:sharely/ui/pages/product_detail/product_detail_controller.dart';
import 'package:sharely/utils/assets_utils.dart';
import 'package:sharely/utils/color_utils.dart';
import 'package:sharely/utils/network_image_util.dart';

import 'package:badges/badges.dart' as badges;
import 'package:sharely/utils/toast_utils.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key});

  final controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) => BaseScaffold(
    backgroundColor: Colors.white,
    appBar: _buildCustomAppBar(),
    body: Obx(
      () => controller.isDataLoad.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageSection(),
                  _buildThumbnailList(),
                  _buildProductInfo(),
                  _buildSizeSelector(),
                  _buildDivider(),
                  _buildColorSelector(),
                  _buildDivider(),
                  _buildQuantitySelector(),
                ],
              ),
            ),
    ),
    bottomNavigationBar: InkWell(
      child: Container(
        width: 1.sw,
        height: 44.h,
        margin: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Center(
          child: Text(
            'Add to cart'.tr,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );

  // 自定义AppBar
  PreferredSizeWidget _buildCustomAppBar() => AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    leading: InkWell(
      onTap: () => Get.back(),
      child: Icon(Icons.arrow_back_ios_new_outlined, color: toColor("3d3d3d")),
    ),
    title: Row(
      children: [
        NetworkImageUtil.loadCircleImage(
          'https://picsum.photos/400/400?random=5',
          size: 32.w,
        ),
        6.horizontalSpace,
        Text(
          'Laura Geller',
          style: TextStyle(
            fontSize: 18.sp,
            color: toColor("#292524"),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () => Get.to(() => CartPage()),
        icon: badges.Badge(
          showBadge: true,
          badgeContent: Text(
            "1",
            style: TextStyle(color: Colors.white, fontSize: 10.sp),
          ),
          position: badges.BadgePosition.topEnd(end: -5.w, top: -12.h),
          child: SvgPicture.asset(AssetsUtils.cart_ic, height: 18.h),
        ),
      ),
    ],
    centerTitle: false,
  );

  // 图片区域
  Widget _buildImageSection() => Container(
    height: 370.h,
    margin: EdgeInsets.symmetric(horizontal: 10.w),
    decoration: BoxDecoration(
      color: toColor('#F6F3F3'),
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: PageView.builder(
      controller: controller.pageController,
      onPageChanged: (index) => controller.currentImageIndex.value = index,
      itemCount: controller.productImages.length,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(10.w),
        child: Obx(
          () => NetworkImageUtil.loadRoundedImage(
            controller.productImages[index],
            radius: 8.r,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );

  // 小图列表
  Widget _buildThumbnailList() => Container(
    height: 40.h,
    margin: EdgeInsets.only(top: 16.h),
    child: Obx(
      () => ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: controller.productImages.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => controller.changeImage(index),
          child: Container(
            width: 40.w,
            height: 40.w,
            margin: EdgeInsets.only(right: 8.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: controller.currentImageIndex.value == index
                    ? Colors.black
                    : Colors.transparent,
                width: 2.w,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: NetworkImageUtil.loadImage(
                controller.productImages[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // 商品信息
  Widget _buildProductInfo() => Container(
    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 产品名称
        Obx(
          () => Text(
            controller.productTitle.value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: toColor('#292524'),
            ),
          ),
        ),
        12.verticalSpace,
        // 评分和评价
        Row(
          children: [
            Icon(Icons.star, color: toColor('#292524'), size: 14.sp),
            4.horizontalSpace,
            Obx(
              () => Text(
                '${controller.productRating.value}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: toColor('#292524'),
                ),
              ),
            ),
            8.horizontalSpace,
            Obx(
              () => Text(
                '(${controller.productReviews.value} ${'reviews'.tr})',
                style: TextStyle(fontSize: 14.sp, color: toColor('999999')),
              ),
            ),
          ],
        ),
        20.verticalSpace,
        // 价格和分享收益
        Row(
          children: [
            Obx(
              () => Text(
                '\$${controller.productPrice.value}',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: toColor('FF6B6B'),
                ),
              ),
            ),
            6.horizontalSpace,
            Expanded(
              child: Obx(
                () => Text(
                  '${controller.originalPrice.value}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: toColor('999999'),
                    decoration: TextDecoration.lineThrough,
                  ),
                ).paddingOnly(top: 6.h),
              ),
            ),
            InkWell(
              onTap: () => _showShareDialog(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: toColor('FFE5E5'),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.share, color: toColor('FF6B6B'), size: 16.sp),
                    4.horizontalSpace,
                    Obx(
                      () => Text(
                        '${'Share and earn'.tr} ${controller.shareEarning.value}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: toColor('FF6B6B'),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // 分隔线
  Widget _buildDivider() => Container(
    height: 0.5.h,
    margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
    color: toColor('F5F5F4'),
  );

  // 尺寸选择器
  Widget _buildSizeSelector() => Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => controller.showVariantsDialog(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Size'.tr,
                style: TextStyle(fontSize: 14.sp, color: toColor('999999')),
              ),
              Row(
                children: [
                  Obx(
                    () => Text(
                      controller.selectedSize.value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: toColor('#292524'),
                      ),
                    ),
                  ),
                  4.horizontalSpace,
                  SvgPicture.asset(AssetsUtils.up_down_arrow_ic, height: 16.h),
                ],
              ),
            ],
          ),
        ),
        20.verticalSpace,
      ],
    ),
  );

  // 颜色选择器
  Widget _buildColorSelector() => Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => controller.showVariantsDialog(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Color'.tr,
                style: TextStyle(fontSize: 14.sp, color: toColor('999999')),
              ),
              Row(
                children: [
                  Obx(
                    () => Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: toColor(
                          controller.colorMap[controller.selectedColor.value] ??
                              'FF8C42',
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Obx(
                    () => Text(
                      controller.selectedColor.value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: toColor('#292524'),
                      ),
                    ),
                  ),
                  4.horizontalSpace,
                  SvgPicture.asset(AssetsUtils.up_down_arrow_ic, height: 16.h),
                ],
              ),
            ],
          ),
        ),
        20.verticalSpace,
      ],
    ),
  );

  // 数量选择器
  Widget _buildQuantitySelector() => Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Quantity'.tr,
          style: TextStyle(fontSize: 14.sp, color: toColor('999999')),
        ),
        Container(
          height: 32.h,
          decoration: BoxDecoration(
            border: Border.all(color: toColor('E5E5E5')),
            borderRadius: BorderRadius.circular(8.r),
            color: toColor('F5F5F5'),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: controller.decreaseQuantity,
                child: SizedBox(
                  width: 40.w,
                  height: 32.h,
                  child: Icon(
                    Icons.remove,
                    color: toColor('999999'),
                    size: 16.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 32.h,
                child: Center(
                  child: Obx(
                    () => Text(
                      '${controller.quantity.value}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: toColor('#292524'),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: controller.increaseQuantity,
                child: SizedBox(
                  width: 40.w,
                  height: 30.h,
                  child: Icon(Icons.add, color: toColor('999999'), size: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // 显示分享弹窗
  void _showShareDialog() {
    showCustom(
      ShareDialog(
        productTitle: controller.productTitle.value,
        productPrice: '\$${controller.productPrice.value}',
        originalPrice: controller.originalPrice.value.toString(),
        rating: '${controller.productRating.value}',
        reviews: '${controller.productReviews.value}',
        productImage: controller.productImages.isNotEmpty
            ? controller.productImages[controller.currentImageIndex.value]
            : 'https://picsum.photos/400/400?random=1',
        shareUrl: 'https://sharely.love/product/B...',
      ),
    );
  }
}
