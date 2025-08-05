import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sharely/base/base_scaffold.dart';
import 'package:sharely/ui/dialog/share/share_dialog.dart';
import 'package:sharely/ui/pages/cart/cart_controller.dart';
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
                  if (controller.hasSizeOption) ...[
                    _buildSizeSelector(),
                    _buildDivider(),
                  ],
                  if (controller.hasColorOption) ...[
                    _buildColorSelector(),
                    _buildDivider(),
                  ],
                  _buildQuantitySelector(),
                ],
              ),
            ),
    ),
    bottomNavigationBar: InkWell(
      onTap: controller.addToCart,
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
    title: Obx(
      () => controller.isDataLoad.value
          ? Container()
          : Row(
              children: [
                NetworkImageUtil.loadCircleImage(
                  '${controller.product.value?.seller?.photo}',
                  size: 32.w,
                ),
                6.horizontalSpace,
                Text(
                  '${controller.product.value?.seller?.name}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: toColor("#292524"),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
    ),
    actions: [
      IconButton(
        onPressed: () => Get.to(() => CartPage()),
        icon: Get.isRegistered<CartController>()
            ? Obx(() {
                final cartController = Get.find<CartController>();
                // 使用新的数据结构获取购物车商品数量
                final itemCount = cartController.totalItemCount;
                return badges.Badge(
                  showBadge: itemCount > 0,
                  badgeContent: Text(
                    itemCount.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 10.sp),
                  ),
                  position: badges.BadgePosition.topEnd(end: -5.w, top: -12.h),
                  child: SvgPicture.asset(AssetsUtils.cart_ic, height: 18.h),
                );
              })
            : badges.Badge(
                showBadge: false,
                child: SvgPicture.asset(AssetsUtils.cart_ic, height: 18.h),
              ),
      ),
    ],
    centerTitle: false,
  );

  // 图片区域
  Widget _buildImageSection() => Container(
    height: 370.h,
    margin: EdgeInsets.symmetric(horizontal: 10.r),
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
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: controller.productImages.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => controller.changeImage(index),
        child: Obx(
          () => Container(
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
            controller.product.value?.title ?? '',
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
            Text(
              controller.product.value?.rating.toStringAsFixed(2) ?? '0.00',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: toColor('#292524'),
              ),
            ),
            8.horizontalSpace,
            Text(
              '(${controller.product.value?.reviewCount ?? 0} ${'reviews'.tr})',
              style: TextStyle(
                fontSize: 14.sp,
                color: toColor('999999'),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        20.verticalSpace,
        // 价格和分享收益
        Row(
          children: [
            Text(
              '\$${controller.product.value?.variants.first.calculatedPrice?.rawCalculatedAmount?.value}',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: toColor('FF6B6B'),
              ),
            ),
            6.horizontalSpace,
            Expanded(
              child: Text(
                '${controller.product.value?.variants.first.calculatedPrice?.rawOriginalAmount?.value}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: toColor('999999'),
                  decoration: TextDecoration.lineThrough,
                ),
              ).paddingOnly(top: 6.h),
            ),
            InkWell(
              onTap: () => controller.showShareDialog(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: toColor('FFE5E5'),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AssetsUtils.alpha_ic,
                      width: 14.w,
                      colorFilter: ColorFilter.mode(
                        toColor('FF6B6B'),
                        BlendMode.srcIn,
                      ),
                    ),
                    4.horizontalSpace,
                    Text(
                      '${'Share and earn'.tr} ${controller.product.value?.shareEarnPercent ?? 0}%',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: toColor('FF6B6B'),
                        fontWeight: FontWeight.w500,
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
                      controller.currentSize,
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
                  Obx(() {
                    final color = controller.currentColor;
                    final colorHex = controller.colorOptionsMetadata[color];

                    return Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: colorHex != null
                            ? toColor(colorHex)
                            : toColor('FF8C42'),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 1.w),
                      ),
                    );
                  }),
                  8.horizontalSpace,
                  Obx(
                    () => Text(
                      controller.currentColor,
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
}
