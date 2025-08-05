import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../base/base_scaffold.dart';
import '../../../../models/region_model.dart';
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
      spacing: 16.r,
      children: [
        // _buildAddressNameField(),
        // 16.verticalSpace,
        _buildNameRow(),
        // 16.verticalSpace,
        // _buildCompanyField(),
        _buildCountryField(),
        _buildStateField(),
        _buildCityAndPostalRow(),
        _buildAddressLine1Field(),
        _buildAddressLine2Field(),
        // 16.verticalSpace,
        // _buildPhoneField(),
        _buildBottomButtons(),
      ],
    ),
  );

  Widget _buildAddressNameField() => _buildTextField(
    controller: controller.addressNameController,
    hintText: 'Address name'.tr,
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

  Widget _buildCompanyField() => _buildTextField(
    controller: controller.companyController,
    hintText: 'Company (optional)'.tr,
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

  Widget _buildPhoneField() => _buildTextField(
    controller: controller.phoneController,
    hintText: 'Phone number'.tr,
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
          16.horizontalSpace,
          // 显示国家旗帜（如果有选中的国家）
          Obx(() {
            if (this.controller.selectedCountry.value != null) {
              return Row(
                children: [
                  _buildCountryFlag(this.controller.selectedCountry.value!.iso2),
                  12.horizontalSpace,
                ],
              );
            }
            return const SizedBox.shrink();
          }),
          Expanded(
            child: Obx(() => Text(
              this.controller.countryDisplayText.value.isEmpty ? hintText : this.controller.countryDisplayText.value,
              style: TextStyle(
                fontSize: 16.sp,
                color: this.controller.countryDisplayText.value.isEmpty ? toColor('B8B8B8') : toColor('1A1A1A'),
              ),
            )),
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
    final countries = controller.getCountryList();
    if (countries.isEmpty) return;

    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        width: 1.sw,
        height: 0.6.sh,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          children: [
            _buildCountryDialogHeader(),
            20.verticalSpace,
            Expanded(child: _buildCountryDialogList(countries)),
          ],
        ),
      ),
    );
  }

  Widget _buildCountryDialogHeader() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'SELECT COUNTRY'.tr,
            style: TextStyle(
              color: toColor('#3D3D3D'),
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () => Navigator.pop(Get.context!),
            child: Text(
              'CANCEL'.tr,
              style: TextStyle(
                color: toColor('#767676'),
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      );

  Widget _buildCountryDialogList(List<Country> countries) => ListView.separated(
        itemCount: countries.length,
        separatorBuilder: (context, index) => Divider(
          color: toColor("EEEEEE"),
          height: 1.h,
        ).marginSymmetric(vertical: 10.h),
        itemBuilder: (context, index) {
          final country = countries[index];
          return _buildCountryDialogItem(country);
        },
      );

  Widget _buildCountryDialogItem(Country country) => InkWell(
        onTap: () {
          controller.selectCountry(country);
          Navigator.pop(Get.context!);
        },
        child: Row(
          children: [
            _buildCountryFlag(country.iso2),
            12.horizontalSpace,
            Expanded(
              child: Text(
                country.displayName.isEmpty ? country.name : country.displayName,
                style: TextStyle(
                  color: toColor('#1A1A1A'),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildCountryFlag(String iso2) => Container(
        width: 24.w,
        height: 16.h,
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
            width: 24.w,
            height: 16.h,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: toColor('F5F5F5'),
              child: Icon(
                Icons.flag,
                size: 12.sp,
                color: toColor('CCCCCC'),
              ),
            ),
          ),
        ),
      );
} 