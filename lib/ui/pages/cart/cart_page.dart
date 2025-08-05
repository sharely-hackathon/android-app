import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sharely/utils/assets_utils.dart';
import 'package:sharely/widgets/empty_view.dart';
import '../../../base/base_scaffold.dart';
import '../../../models/cart_model.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/network_image_util.dart';
import 'cart_controller.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  final controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Cart'.tr,
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.cartModel.value == null
            ? cartEmptyView()
            : controller.cartModel.value!.cart!.items.isEmpty
            ? cartEmptyView()
            : Column(
                children: [
                  _buildSelectAllSection(controller),
                  Expanded(
                    child: ListView.separated(
                      itemCount:
                          controller.cartModel.value?.cart?.items.length ?? 0,
                      itemBuilder: (context, index) => _buildProductItem(
                        controller,
                        controller.cartModel.value!.cart!.items[index],
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(
                            height: 1.h,
                            color: Colors.grey.withValues(alpha: 0.1),
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                          ),
                    ),
                  ),
                  _buildBottomSection(controller),
                ],
              ),
      ),
    );
  }

  Widget cartEmptyView() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(AssetsUtils.cart_empty_ic, width: 120.w,),
      Text(
        'Your cart is empty'.tr,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: toColor('#292524'),
        ),
      ),
      10.verticalSpace,
      Text(
        'Hey there! It seems your cart is still empty. Want to add some items?'.tr,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: toColor('#79716B'),
        ),
        textAlign: TextAlign.center,
      ).marginSymmetric(horizontal: 20.w),
      30.verticalSpace,
      GestureDetector(
        onTap: () => Get.until((route) => route.isFirst),
        child: Container(
          width: 140.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25.r),
          ),
          alignment: Alignment.center,
          child: Text(
            'Start shopping'.tr,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ],
  );

  // 全选区域
  Widget _buildSelectAllSection(CartController controller) => Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    child: Row(
      children: [
        Obx(
          () => GestureDetector(
            onTap: () => controller.toggleSelectAll(),
            child: Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.isAllSelected
                    ? toColor("FF6B35")
                    : Colors.transparent,
                border: Border.all(
                  color: controller.isAllSelected
                      ? toColor("FF6B35")
                      : toColor("E0E0E0"),
                  width: 2.w,
                ),
              ),
              child: controller.isAllSelected
                  ? Icon(Icons.check, size: 14.w, color: Colors.white)
                  : null,
            ),
          ),
        ),
        12.horizontalSpace,
        Text(
          'Select All'.tr,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        Obx(
          () => Text(
            '${controller.selectedItemCount} items selected',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );

  Widget _buildProductItem(
    CartController controller,
    ItemModel item,
  ) => Container(
    padding: EdgeInsets.all(16.w),
    child: Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        decoration: BoxDecoration(
          color: toColor("FF6B35"),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete, color: Colors.white, size: 24.w),
            4.verticalSpace,
            Text(
              'Remove',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        controller.removeItem(item.id);
        return false; // 返回false防止widget被删除，我们手动控制删除逻辑
      },
      child: Row(
        children: [
          Obx(
            () => GestureDetector(
              onTap: () => controller.toggleItemSelection(item.id),
              child: Container(
                width: 18.w,
                height: 18.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.selectedItems.contains(item.id)
                      ? toColor("FF6B35")
                      : Colors.transparent,
                  border: Border.all(
                    color: controller.selectedItems.contains(item.id)
                        ? toColor("FF6B35")
                        : toColor("E0E0E0"),
                    width: 2.w,
                  ),
                ),
                child: controller.selectedItems.contains(item.id)
                    ? Icon(Icons.check, size: 12.w, color: Colors.white)
                    : null,
              ),
            ),
          ),
          16.horizontalSpace,
          NetworkImageUtil.loadRoundedImage(
            item.thumbnail.isNotEmpty ? item.thumbnail : item.productTitle,
            width: 64.w,
            height: 64.w,
            radius: 8.r,
            fit: BoxFit.cover,
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.productTitle,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${item.unitPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: toColor("FF6B35"),
                          ),
                        ),
                        if (item.compareAtUnitPrice > 0)
                          Text(
                            '\$${item.compareAtUnitPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[400],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                4.verticalSpace,
                Text(
                  item.variantTitle,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
                8.verticalSpace,
                _buildQuantitySelector(controller, item),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildQuantitySelector(CartController controller, ItemModel item) =>
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: toColor("E0E0E0")),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => controller.decreaseQuantity(item.id),
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.quantity > 1
                      ? Colors.transparent
                      : toColor("F5F5F5"),
                ),
                child: Icon(
                  Icons.remove,
                  size: 16.w,
                  color: item.quantity > 1 ? Colors.black : Colors.grey[400],
                ),
              ),
            ),
            Container(
              width: 30.w,
              alignment: Alignment.center,
              child: Text(
                '${item.quantity}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.increaseQuantity(item.id),
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: Icon(Icons.add, size: 16.w, color: Colors.black),
              ),
            ),
          ],
        ),
      );

  Widget _buildBottomSection(CartController controller) => Container(
    padding: EdgeInsets.all(20.w),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 10.r,
          offset: Offset(0, -2.h),
        ),
      ],
    ),
    child: Column(
      children: [
        // 总计
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: toColor('#79716B'),
              ),
            ),
            Obx(
              () => Text(
                '\$${controller.totalPriceWithShipping.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: toColor('#292524'),
                ),
              ),
            ),
          ],
        ),
        20.verticalSpace,
        GestureDetector(
          onTap: controller.payWithHelio,
          child: Container(
            width: 1.sw,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pay with Helio'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                8.horizontalSpace,
                SvgPicture.asset(AssetsUtils.cart_pay_ic, width: 20.w),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
