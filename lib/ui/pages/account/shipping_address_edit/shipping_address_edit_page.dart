import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../base/base_scaffold.dart';
import '../../../../utils/color_utils.dart';
import 'shipping_address_edit_controller.dart';

class ShippingAddressEditPage extends StatelessWidget {
  ShippingAddressEditPage({super.key});

  final controller = Get.put(ShippingAddressEditController());

  @override
  Widget build(BuildContext context) => BaseScaffold(
    title: 'Shipping address'.tr,
    backgroundColor: Colors.white,
    body: _buildContent(),
  );

  Widget _buildContent() => SingleChildScrollView(
    padding: EdgeInsets.all(20.w),
    child: Column(
      children: [
        _buildNameRow(),
        16.verticalSpace,
        _buildCountryField(),
        16.verticalSpace,
        _buildStateField(),
        16.verticalSpace,
        _buildCityAndPostalRow(),
        16.verticalSpace,
        _buildAddressLine1Field(),
        16.verticalSpace,
        _buildAddressLine2Field(),
        40.verticalSpace,
        _buildBottomButtons(),
      ],
    ),
  );

  Widget _buildNameRow() => Row(
    children: [
      Expanded(
        child: _buildTextField(
          controller: controller.firstNameController,
          hintText: 'First name'.tr,
        ),
      ),
      16.horizontalSpace,
      Expanded(
        child: _buildTextField(
          controller: controller.lastNameController,
          hintText: 'Last name'.tr,
        ),
      ),
    ],
  );

  Widget _buildCountryField() => _buildDropdownField(
    controller: controller.countryController,
    hintText: 'Country'.tr,
    onTap: _showCountryPicker,
  );

  Widget _buildStateField() => _buildTextField(
    controller: controller.stateController,
    hintText: 'State'.tr,
  );

  Widget _buildCityAndPostalRow() => Row(
    children: [
      Expanded(
        child: _buildTextField(
          controller: controller.cityController,
          hintText: 'City'.tr,
        ),
      ),
      16.horizontalSpace,
      Expanded(
        child: _buildTextField(
          controller: controller.postalCodeController,
          hintText: 'Postal code'.tr,
        ),
      ),
    ],
  );

  Widget _buildAddressLine1Field() => _buildTextField(
    controller: controller.addressLine1Controller,
    hintText: 'Address line 1'.tr,
  );

  Widget _buildAddressLine2Field() => _buildTextField(
    controller: controller.addressLine2Controller,
    hintText: 'Address line 2'.tr,
  );

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) => Container(
    height: 56.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: toColor('E5E5E5'), width: 1.w),
      color: Colors.white,
    ),
    child: Center(
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontSize: 16.sp,
          color: toColor('1A1A1A'),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16.sp,
            color: toColor('B8B8B8'),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          isDense: true,
        ),
      ),
    ),
  );

  Widget _buildDropdownField({
    required TextEditingController controller,
    required String hintText,
    required VoidCallback onTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: toColor('E5E5E5'), width: 1.w),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                controller.text.isEmpty ? hintText : controller.text,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: controller.text.isEmpty ? toColor('B8B8B8') : toColor('1A1A1A'),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: toColor('B8B8B8'),
              size: 24.r,
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildBottomButtons() => Container(
    padding: EdgeInsets.all(20.w),
    color: Colors.white,
    child: Column(
      children: [
        _buildSaveButton(),
        16.verticalSpace,
        _buildCancelButton(),
      ],
    ),
  );

  Widget _buildSaveButton() => GestureDetector(
    onTap: controller.saveAddress,
    child: Container(
      width: 1.sw,
      height: 44.h,
      decoration: BoxDecoration(
        color: toColor('1A1A1A'),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Center(
        child: Text(
          'Save'.tr,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );

  Widget _buildCancelButton() => GestureDetector(
    onTap: controller.cancel,
    child: Text(
      'Cancel'.tr,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: toColor('9E9E9E'),
      ),
    ),
  );

  void _showCountryPicker() {
    // 示例国家列表
    final countries = [
      'United States',
      'Canada',
      'Mexico',
      'Spain',
      'France',
      'Germany',
      'Italy',
      'United Kingdom',
    ];

    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => Container(
        height: 300.h,
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Text(
              'Country'.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: toColor('1A1A1A'),
              ),
            ),
            20.verticalSpace,
            Expanded(
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return ListTile(
                    title: Text(
                      country,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: toColor('1A1A1A'),
                      ),
                    ),
                    onTap: () {
                      controller.selectCountry(country);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 