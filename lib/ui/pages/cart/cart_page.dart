import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sharely/utils/assets_utils.dart';
import '../../../base/base_scaffold.dart';
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
        () => Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: controller.merchants.length,
                itemBuilder: (context, index) => _buildMerchantSection(
                  controller,
                  controller.merchants[index],
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                      height: 4.h,
                      color: Colors.grey.withValues(alpha: 0.05),
                    ),
              ),
            ),
            _buildBottomSection(controller),
          ],
        ),
      ),
    );
  }

  Widget _buildMerchantSection(CartController controller, Merchant merchant) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            _buildMerchantHeader(controller, merchant),
            ...merchant.products.map(
              (product) => _buildProductItem(controller, product),
            ),
          ],
        ),
      );

  Widget _buildMerchantHeader(CartController controller, Merchant merchant) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Obx(
              () => GestureDetector(
                onTap: () => controller.toggleMerchantSelection(merchant.id),
                child: Container(
                  width: 16.w,
                  height: 16.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: controller.isMerchantSelected(merchant.id)
                        ? toColor("FF6B35")
                        : Colors.transparent,
                    border: Border.all(
                      color: controller.isMerchantSelected(merchant.id)
                          ? toColor("FF6B35")
                          : toColor("E0E0E0"),
                      width: 2.w,
                    ),
                  ),
                  child: controller.isMerchantSelected(merchant.id)
                      ? Icon(Icons.check, size: 14.w, color: Colors.white)
                      : null,
                ),
              ),
            ),
            12.horizontalSpace,
            NetworkImageUtil.loadCircleImage(
              merchant.avatar,
              fit: BoxFit.cover,
              size: 28.r,
            ),
            12.horizontalSpace,
            Text(
              merchant.name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );

  Widget _buildProductItem(CartController controller, CartProduct product) =>
      Container(
        margin: EdgeInsets.only(bottom: 12.h),
        child: Dismissible(
          key: Key(product.id),
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
            controller.removeProduct(product.id);
            return false; // 返回false防止widget被删除，我们手动控制删除逻辑
          },
          child: Row(
            children: [
              Obx(
                () => GestureDetector(
                  onTap: () => controller.toggleProductSelection(product.id),
                  child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.selectedProducts.contains(product.id)
                          ? toColor("FF6B35")
                          : Colors.transparent,
                      border: Border.all(
                        color: controller.selectedProducts.contains(product.id)
                            ? toColor("FF6B35")
                            : toColor("E0E0E0"),
                        width: 2.w,
                      ),
                    ),
                    child: controller.selectedProducts.contains(product.id)
                        ? Icon(Icons.check, size: 14.w, color: Colors.white)
                        : null,
                  ),
                ),
              ),
              16.horizontalSpace,
              NetworkImageUtil.loadRoundedImage(
                product.image,
                width: 56.w,
                height: 56.w,
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
                            product.name,
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
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: toColor("FF6B35"),
                              ),
                            ),
                            Text(
                              '\$${product.originalPrice.toStringAsFixed(2)}',
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
                      '${product.color} • ${product.size}',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                    ),
                    4.verticalSpace,
                    _buildQuantitySelector(controller, product),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildQuantitySelector(
    CartController controller,
    CartProduct product,
  ) => Obx(() {
    // 从控制器中获取最新的商品数据
    CartProduct? currentProduct;
    for (var merchant in controller.merchants) {
      for (var p in merchant.products) {
        if (p.id == product.id) {
          currentProduct = p;
          break;
        }
      }
      if (currentProduct != null) break;
    }

    final quantity = currentProduct?.quantity ?? product.quantity;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: toColor("E0E0E0")),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => controller.decreaseQuantity(product.id),
            child: Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: quantity > 1 ? Colors.transparent : toColor("F5F5F5"),
              ),
              child: Icon(
                Icons.remove,
                size: 16.w,
                color: quantity > 1 ? Colors.black : Colors.grey[400],
              ),
            ),
          ),
          Container(
            width: 30.w,
            alignment: Alignment.center,
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => controller.increaseQuantity(product.id),
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
  });

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total'.tr,
              style: TextStyle(
                fontSize: 14.sp,
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
                SvgPicture.asset(AssetsUtils.cart_pay_ic, width: 20.w,),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
