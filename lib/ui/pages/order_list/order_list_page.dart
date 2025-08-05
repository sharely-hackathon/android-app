import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharely/base/base_scaffold.dart';
import 'package:sharely/utils/color_utils.dart';
import 'package:sharely/utils/network_image_util.dart';
import 'package:sharely/widgets/custom_loading_widget.dart';

import '../../../models/order_list_model.dart';
import 'order_list_controller.dart';

class OrderListPage extends StatelessWidget {
  OrderListPage({super.key});

  final controller = Get.put(OrderListController());

  @override
  Widget build(BuildContext context) => BaseScaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Orders'.tr,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    ),
    body: Obx(
      () => controller.isDataLoad.value
          ? const CustomLoadingWidget(
              color: Colors.blue,
              size: 40,
              msg: 'Loading...',
            )
          : SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: controller.orderListModel.value?.orders.isEmpty == true
                  ? _buildEmptyState()
                  : _buildOrderList(),
            ),
    ),
  );

  Widget _buildEmptyState() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.receipt_long_outlined, size: 64.w, color: toColor('CCCCCC')),
        SizedBox(height: 16.h),
        Text(
          'No orders yet',
          style: TextStyle(
            fontSize: 18.sp,
            color: toColor('666666'),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Start shopping to see your orders here',
          style: TextStyle(fontSize: 14.sp, color: toColor('999999')),
        ),
      ],
    ),
  );

  Widget _buildOrderList() => Obx(
    () => controller.orderListModel.value == null
        ? Container()
        : ListView.builder(
            padding: EdgeInsets.all(10.w),
            itemCount: controller.orderListModel.value!.orders.length,
            itemBuilder: (context, index) =>
                _buildOrderCard(controller.orderListModel.value!.orders[index]),
          ),
  );

  Widget _buildOrderCard(Order order) => Container(
    margin: EdgeInsets.only(bottom: 16.h),
    color: Colors.white,
    child: Column(
      children: [
        _buildOrderHeader(order),
        _buildOrderItems(order),
        _buildOrderTotal(order),
        _buildOrderActions(order),
      ],
    ),
  );

  Widget _buildOrderHeader(Order order) => Container(
    padding: EdgeInsets.all(16.w),
    child: Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: toColor('98DEFE').withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Center(
            child: NetworkImageUtil.loadCircleImage(
              "${order.seller?.photo}",
              size: 40.w,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            "${order.seller?.name}",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: toColor('333333'),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: toColor(
              controller.getStatusColor(order.status),
            ).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            controller.getStatusText(order.status),
            style: TextStyle(
              fontSize: 12.sp,
              color: toColor(controller.getStatusColor(order.status)),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildOrderItems(Order order) => Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    child: Column(
      children: [
        Row(
          children: [
            ...order.items
                .take(3)
                .map(
                  (item) => Container(
                    margin: EdgeInsets.only(right: 8.w),
                    child: NetworkImageUtil.loadRoundedImage(
                      item.thumbnail,
                      width: 50.w,
                      height: 50.w,
                      radius: 8.r,
                    ),
                  ),
                ),
            if (order.items.length > 3)
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: toColor('F5F5F5'),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    '+${order.items.length - 3}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: toColor('666666'),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );

  Widget _buildOrderTotal(Order order) => Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Total',
          style: TextStyle(
            fontSize: 14.sp,
            color: toColor('#A6A09B'),
            fontWeight: FontWeight.bold,
          ),
        ),
        4.horizontalSpace,
        Text(
          '\$${(order.total).toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 14.sp,
            color: toColor('#292524'),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );

  Widget _buildOrderActions(Order order) => Container(
    padding: EdgeInsets.all(16.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (order.status.toLowerCase() == 'finished') ...[
          _buildActionButton(
            text: 'Review',
            onTap: () => controller.reviewOrder(order.id),
            backgroundColor: Colors.white,
            textColor: toColor('333333'),
            borderColor: toColor('E0E0E0'),
          ),
          SizedBox(width: 12.w),
          _buildActionButton(
            text: 'Share',
            onTap: () => controller.shareOrder(order.id),
            backgroundColor: Colors.white,
            textColor: toColor('333333'),
            borderColor: toColor('E0E0E0'),
          ),
        ] else ...[
          _buildActionButton(
            text: 'Track delivery',
            onTap: () => controller.trackDelivery(order.id),
            backgroundColor: toColor('333333'),
            textColor: Colors.white,
            borderColor: toColor('333333'),
          ),
        ],
      ],
    ),
  );

  Widget _buildActionButton({
    required String text,
    required VoidCallback onTap,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
