import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../base/base_scaffold.dart';
import '../../../../utils/color_utils.dart';
import 'shipping_address_controller.dart';

class ShippingAddressPage extends StatelessWidget {
  ShippingAddressPage({super.key});

  final controller = Get.put(ShippingAddressController());

  @override
  Widget build(BuildContext context) => BaseScaffold(
    title: 'Shipping address'.tr,
    actions: [
      IconButton(
        onPressed: controller.addNewAddress,
        icon: Icon(Icons.add, color: toColor('1A1A1A'), size: 24.r),
      ),
    ],
    body: Obx(() => _buildContent()),
  );

  Widget _buildContent() => Container(
    color: Colors.white,
    padding: EdgeInsets.all(16.w),
    child: controller.addressList.isEmpty
        ? _buildEmptyState()
        : _buildAddressList(),
  );

  Widget _buildEmptyState() => Center(
    child: Text(
      'No shipping addresses'.tr,
      style: TextStyle(fontSize: 16.sp, color: toColor('9E9E9E')),
    ),
  );

  Widget _buildAddressList() => ListView.separated(
    itemCount: controller.addressList.length,
    separatorBuilder: (context, index) => 16.verticalSpace,
    itemBuilder: (context, index) {
      final address = controller.addressList[index];
      return _buildAddressCard(address);
    },
  );

  Widget _buildAddressCard(ShippingAddressModel address) => Container(
    padding: EdgeInsets.all(20.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: toColor('E0E0E0'), width: 1.w),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          address.name,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: toColor('1A1A1A'),
          ),
        ),
        12.verticalSpace,
        Text(
          address.address,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: toColor('79716B'),
          ),
        ),
        4.verticalSpace,
        Text(
          address.city,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: toColor('79716B'),
          ),
        ),
        12.verticalSpace,
        Text(
          address.phone,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: toColor('79716B'),
          ),
        ),
        12.verticalSpace,
        InkWell(
          onTap: () => controller.editAddress(address),
          child: Text(
            'Edit'.tr,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: toColor('FF6B6B'),
            ),
          ),
        ),
      ],
    ),
  );
}
