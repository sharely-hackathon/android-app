import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sharely/utils/assets_utils.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/network_image_util.dart';
import '../../../utils/toast_utils.dart';
import '../../dialog/language/switch_language_dialog.dart';
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
          onTap: () => showCustom(
            SwitchLanguageDialog(),
            alignment: Alignment.bottomCenter,
          ),
          child: Row(
            children: [
              Text(
                "English".tr,
                style: TextStyle(
                  color: toColor('#3D3D3D'),
                  fontSize: 13.sp,
                ),
              ),
              const Icon(
                Icons.arrow_drop_down_sharp,
                color: Colors.black,
              ),
            ],
          ),
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
            margin: EdgeInsets.only(left: 16.w, right: 6.w),
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
      InkWell(
        onTap: () => controller.showFilterDialog(),
        child: Container(
          width: 40.h,
          height: 40.h,
          margin: EdgeInsets.only(right: 16.w),
          decoration: BoxDecoration(
            color: toColor("ffffff"),
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Icon(Icons.tune, color: toColor("333333"), size: 20.sp),
        ),
      ),
    ],
  );

  Widget _buildProductGrid() => Container(
    padding: EdgeInsets.all(16.w),
    child: Obx(
      () => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: 0.78,
        ),
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          final product = controller.products[index];
          return _buildProductItem(product);
        },
      ),
    ),
  );

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
                '${'Earn'.tr} ${product.earnPercentage}',
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
}
