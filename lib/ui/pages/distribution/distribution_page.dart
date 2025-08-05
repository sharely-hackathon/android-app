import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../base/base_scaffold.dart';
import '../../../utils/assets_utils.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/network_image_util.dart';
import '../../../main.dart';
import 'distribution_controller.dart';

class DistributionPage extends StatelessWidget {
  DistributionPage({super.key});

  final controller = Get.put(DistributionController());

  @override
  Widget build(BuildContext context) => BaseScaffold(
    title: 'Distribution',
    backgroundColor: toColor('FFFFFF'),
    centerTitle: false,
    body: Obx(
      () => controller.isDataLoad.value
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEarningsSection(),
                  20.verticalSpace,
                  _buildWithdrawButton(),
                  30.verticalSpace,
                  _buildStatsSection(),
                  10.verticalSpace,
                  _buildRecentOrdersSection(),
                  10.verticalSpace,
                  _buildProductsSection(),
                ],
              ),
            ),
    ),
  );

  // 收益部分
  Widget _buildEarningsSection() => Container(
    width: 1.sw,
    padding: EdgeInsets.all(20.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Earnings',
          style: TextStyle(
            fontSize: 14.sp,
            color: toColor('666666'),
            fontWeight: FontWeight.w500,
          ),
        ),
        12.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Obx(
              () => Text(
                controller.earnings.value,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: toColor('1A1A1A'),
                  height: 1.0,
                ),
              ),
            ),
            Text(
              '.00',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: toColor('1A1A1A'),
              ),
            ),
            4.horizontalSpace,
            Text(
              'USDT',
              style: TextStyle(
                fontSize: 18.sp,
                color: toColor('1A1A1A'),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        6.verticalSpace,
        Obx(
          () => Text(
            'Today ${controller.todayChange.value}',
            style: TextStyle(
              fontSize: 14.sp,
              color: toColor('FF6B47'),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );

  // 提现按钮
  Widget _buildWithdrawButton() => Container(
    width: 1.sw,
    height: 44.h,
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    child: ElevatedButton(
      onPressed: controller.onWithdrawTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: toColor('1A1A1A'),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
      ),
      child: Text(
        'Withdraw'.tr,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
    ),
  );

  // 统计数据部分
  Widget _buildStatsSection() => Row(
    children: [
      16.horizontalSpace,
      Expanded(
        child: _buildStatCard(
          'Customers'.tr,
          controller.customers.value,
          onTap: controller.onCustomersTap,
        ),
      ),
      12.horizontalSpace,
      Expanded(
        child: _buildStatCard(
          'Sales'.tr,
          controller.sales.value,
          onTap: controller.onSalesTap,
        ),
      ),
      16.horizontalSpace,
    ],
  );

  // 统计卡片
  Widget _buildStatCard(String title, String value, {VoidCallback? onTap}) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          height: 90.h,
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: BoxDecoration(
            color: toColor('#FAFAF9'),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10.r,
                offset: Offset(0, 2.h),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: toColor('666666'),
                  fontWeight: FontWeight.w500,
                ),
              ),
              8.verticalSpace,
              SizedBox(
                height: 40.h,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: toColor('1A1A1A'),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  // 等级卡片
  Widget _buildAffiliateTierCard() => GestureDetector(
    onTap: controller.onAffiliateTierTap,
    child: Container(
      height: 90.h,
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      decoration: BoxDecoration(
        color: toColor('#FAFAF9'),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Affiliate tier'.tr,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: toColor('666666'),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, size: 16.w, color: toColor('CCCCCC')),
            ],
          ),
          8.verticalSpace,
          Image.asset(AssetsUtils.affiliate_ic, height: 40.h),
        ],
      ),
    ),
  );

  // 最近订单部分
  Widget _buildRecentOrdersSection() => Container(
    width: 1.sw,
    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Recent orders'.tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: toColor('1A1A1A'),
                ),
              ),
            ),
            GestureDetector(
              onTap: controller.onViewMoreOrdersTap,
              child: Icon(
                Icons.chevron_right,
                size: 20.w,
                color: toColor('CCCCCC'),
              ),
            ),
          ],
        ),
        20.verticalSpace,
        Obx(
          () => Column(
            children: controller.recentOrders
                .map((order) => _buildOrderItem(order))
                .toList(),
          ),
        ),
      ],
    ),
  );

  // 订单项
  Widget _buildOrderItem(OrderInfo order) => Container(
    margin: EdgeInsets.only(bottom: 16.h),
    child: Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: toColor('FF6B47'),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Icon(Icons.share, color: Colors.white, size: 20.w),
        ),
        12.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.id,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: toColor('1A1A1A'),
                ),
              ),
              2.verticalSpace,
              Text(
                order.amount,
                style: TextStyle(fontSize: 12.sp, color: toColor('666666')),
              ),
            ],
          ),
        ),
        Text(
          order.commission,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: toColor('FF6B47'),
          ),
        ),
      ],
    ),
  );

  // 产品部分
  Widget _buildProductsSection() => Container(
    width: 1.sw,
    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Products'.tr,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: toColor('1A1A1A'),
          ),
        ),
        20.verticalSpace,
        Obx(
          () => Column(
            children: controller.products
                .map((product) => _buildProductItem(product))
                .toList(),
          ),
        ),
      ],
    ),
  );

  // 产品项
  Widget _buildProductItem(ProductInfo product) => Container(
    margin: EdgeInsets.only(bottom: 16.h),
    child: Row(
      children: [
        NetworkImageUtil.loadRoundedImage(
          testImg,
          width: 60.w,
          height: 60.h,
          radius: 8.r,
        ),
        12.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: toColor('1A1A1A'),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              4.verticalSpace,
              Text(
                '${product.views} · ${product.orders}',
                style: TextStyle(fontSize: 12.sp, color: toColor('666666')),
              ),
            ],
          ),
        ),
        Icon(Icons.more_horiz, size: 20.w, color: toColor('#343330')),
      ],
    ),
  );
}
