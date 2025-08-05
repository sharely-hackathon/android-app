import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../models/region_model.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/toast_utils.dart';

class SwitchCountryDialog extends StatelessWidget {
  final List<Country> countries;
  final Country? selectedCountry;
  final Function(Country) onCountrySelected;

  final currentSelectedCountry = Rxn<Country>();

  SwitchCountryDialog({
    super.key,
    required this.countries,
    this.selectedCountry,
    required this.onCountrySelected,
  }) {
    currentSelectedCountry.value = selectedCountry;
  }

  @override
  Widget build(BuildContext context) => Container(
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
            _buildHeader(),
            20.verticalSpace,
            Expanded(child: _buildCountryList()),
            20.verticalSpace,
            _buildConfirmButton(),
          ],
        ),
      );

  Widget _buildHeader() => Row(
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
            onTap: () => dismissLoading(),
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

  Widget _buildCountryList() => ListView.separated(
        itemCount: countries.length,
        separatorBuilder: (context, index) => Divider(
          color: toColor("EEEEEE"),
          height: 1.h,
        ).marginSymmetric(vertical: 10.h),
        itemBuilder: (context, index) {
          final country = countries[index];
          return _buildCountryItem(country);
        },
      );

  Widget _buildCountryItem(Country country) => InkWell(
        onTap: () => currentSelectedCountry.value = country,
        child: Obx(() => Row(
              children: [
                _buildCountryFlag(country.iso2),
                12.horizontalSpace,
                Expanded(
                  child: Text(
                    country.displayName.isEmpty ? country.name : country.displayName,
                    style: TextStyle(
                      color: currentSelectedCountry.value?.iso2 == country.iso2
                          ? toColor('#1A1A1A')
                          : toColor('#767676'),
                      fontSize: 14.sp,
                      fontWeight: currentSelectedCountry.value?.iso2 == country.iso2
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                currentSelectedCountry.value?.iso2 == country.iso2
                    ? Icon(
                        Icons.check_circle,
                        size: 20.sp,
                        color: toColor('#1A1A1A'),
                      )
                    : Icon(
                        Icons.check_circle,
                        size: 20.sp,
                        color: Colors.transparent,
                      ),
              ],
            )),
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

  Widget _buildConfirmButton() => InkWell(
        onTap: () => _confirmSelection(),
        child: Container(
          width: 1.sw,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Center(
            child: Text(
              'Confirm'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );

  void _confirmSelection() {
    if (currentSelectedCountry.value != null) {
      onCountrySelected(currentSelectedCountry.value!);
    }
    dismissLoading();
  }
}