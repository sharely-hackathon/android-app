import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sharely/utils/assets_utils.dart';
import '../../../models/product_model.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/network_image_util.dart';
import '../search/search_page.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 1.sh,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [toColor('#F0ECE1'), toColor('#FCF9F4'), toColor('#FFFFFF')],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(child: _buildProductGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() => Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
    child: Row(
      children: [
        SvgPicture.asset(AssetsUtils.logo_text_ic, width: 58.w),
        8.horizontalSpace,
        Expanded(
          child: Text(
            'Product Hub'.tr,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: toColor("#292524"),
            ),
          ),
        ),
        InkWell(
          onTap: () => controller.showCountryDialog(),
          child: Obx(() => Row(
            children: [
              if (controller.selectedCountry.value != null) ...[
                _buildCountryFlag(controller.selectedCountry.value!.iso2),
                6.horizontalSpace,
              ],
              Text(
                controller.selectedCountry.value?.displayName.isEmpty == true
                    ? (controller.selectedCountry.value?.name ?? "Select Country")
                    : (controller.selectedCountry.value?.displayName ?? "Select Country"),
                style: TextStyle(color: toColor('#3D3D3D'), fontSize: 13.sp),
              ),
              const Icon(Icons.arrow_drop_down_sharp, color: Colors.black),
            ],
          )),
        ),
      ],
    ),
  );

  Widget _buildSearchBar() => Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: () => Get.to(() => SearchPage()),
          child: Container(
            height: 40.h,
            margin: EdgeInsets.only(left: 16.w, right: 16.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: toColor("ffffff"),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: toColor("999999"), size: 20.sp),
                12.horizontalSpace,
                Center(
                  child: Text(
                    "Lip color".tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: toColor("#A6A09B"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // InkWell(
      //   onTap: () => controller.showFilterDialog(),
      //   child: Container(
      //     width: 40.h,
      //     height: 40.h,
      //     margin: EdgeInsets.only(right: 16.w),
      //     decoration: BoxDecoration(
      //       color: toColor("ffffff"),
      //       borderRadius: BorderRadius.circular(25.r),
      //     ),
      //     child: Icon(Icons.tune, color: toColor("333333"), size: 20.sp),
      //   ),
      // ),
    ],
  );

  Widget _buildProductGrid() => Container(
    padding: EdgeInsets.all(16.w),
    child: Obx(
      () => controller.products.value != null
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
                childAspectRatio: 0.72,
              ),
              itemCount: controller.products.value!.products.length,
              itemBuilder: (context, index) {
                final product = controller.products.value?.products[index];
                return _buildProductItem(product!);
              },
            )
          : Container(),
    ),
  );

  Widget _buildProductItem(Product product) => InkWell(
    onTap: () => controller.onProductTap(product),
    borderRadius: BorderRadius.circular(16.r),
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
          product.thumbnail,
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
                '${'Earn'.tr} ${product.shareEarnPercent}%',
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
        SizedBox(
          height: 14.sp * 1.3 * 2,
          child: Text(
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
        ),
        4.verticalSpace,
        Row(
          children: [
            Text(
              '\$${product.variants.first.calculatedPrice?.rawCalculatedAmount?.value}',
              style: TextStyle(
                fontSize: 16.sp,
                color: toColor("FF6B6B"),
                fontWeight: FontWeight.bold,
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: Text(
                "${product.variants.first.calculatedPrice?.rawOriginalAmount?.value}",
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
                  product.rating.toStringAsFixed(2),
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

  Widget _buildCountryFlag(String iso2) => Container(
        width: 20.w,
        height: 14.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.r),
          border: Border.all(
            color: toColor('E0E0E0'),
            width: 0.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2.r),
          child: SvgPicture.asset(
            'assets/images/countries/${iso2.toLowerCase()}.svg',
            width: 20.w,
            height: 14.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: toColor('F5F5F5'),
              child: Icon(
                Icons.flag,
                size: 10.sp,
                color: toColor('CCCCCC'),
              ),
            ),
          ),
        ),
      );
}
