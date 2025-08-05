import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharely/utils/color_utils.dart';
import 'package:sharely/utils/toast_utils.dart';

class ProductDetailFilterDialog extends StatelessWidget {
  final String currentSizeValue;
  final String currentColorValue;
  final Function(String, String) onSelected; // 修改为同时返回size和color

  ProductDetailFilterDialog({
    super.key,
    required this.currentSizeValue,
    required this.currentColorValue,
    required this.onSelected,
  });

  // 尺寸选项
  final sizeOptions = ['XS', 'SM', 'LG', 'XL'];
  
  // 颜色选项
  final colorOptions = [
    {'name': 'Orange', 'color': 'FF8C42'},
    {'name': 'Blue', 'color': '4A90E2'},
    {'name': 'Green', 'color': '7ED321'},
    {'name': 'Red', 'color': 'D0021B'},
    {'name': 'Purple', 'color': '9013FE'},
    {'name': 'Black', 'color': '000000'},
  ];

  final selectedSizeValue = ''.obs;
  final selectedColorValue = ''.obs;

  @override
  Widget build(BuildContext context) {
    selectedSizeValue.value = currentSizeValue;
    selectedColorValue.value = currentColorValue;
    
    return Container(
      width: 1.sw,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFilterHeader(),
          30.verticalSpace,
          _buildSizeSection(),
          30.verticalSpace,
          _buildColorSection(),
          30.verticalSpace,
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildFilterHeader() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Variants'.tr,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      InkWell(
        onTap: () => Get.back(),
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            border: Border.all(color: toColor('#F5F5F4'), width: 1.w),
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Icon(Icons.close, size: 18.sp, color: Colors.black),
        ),
      ),
    ],
  );

  Widget _buildSizeSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('Size'),
      20.verticalSpace,
      _buildSizeOptions(),
    ],
  );

  Widget _buildColorSection() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildSectionTitle('Color'),
      20.verticalSpace,
      _buildColorOptions(),
    ],
  );

  Widget _buildSectionTitle(String title) => Text(
    title,
    style: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: toColor('#292524'),
    ),
  );

  Widget _buildSizeOptions() => GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      mainAxisSpacing: 6.h,
      crossAxisSpacing: 6.w,
      childAspectRatio: 78 / 36,
    ),
    itemCount: sizeOptions.length,
    itemBuilder: (context, index) => _buildSizeItem(sizeOptions[index]),
  );

  Widget _buildSizeItem(String size) => Obx(
    () => InkWell(
      onTap: () => selectedSizeValue.value = size,
      child: Container(
        height: 36.h,
        decoration: BoxDecoration(
          color: selectedSizeValue.value == size 
              ? Colors.black 
              : Colors.transparent,
          border: Border.all(
            color: selectedSizeValue.value == size 
                ? Colors.black 
                : toColor('#E5E5E5'),
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Text(
            size,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: selectedSizeValue.value == size 
                  ? Colors.white 
                  : toColor('#292524'),
              height: 1.0,
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildColorOptions() => GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: 12.h,
      crossAxisSpacing: 12.w,
      childAspectRatio: 2.0,
    ),
    itemCount: colorOptions.length,
    itemBuilder: (context, index) => _buildColorItem(colorOptions[index]),
  );

  Widget _buildColorItem(Map<String, String> colorData) => Obx(
    () => InkWell(
      onTap: () => selectedColorValue.value = colorData['name']!,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: selectedColorValue.value == colorData['name'] 
              ? Colors.black 
              : Colors.transparent,
          border: Border.all(
            color: selectedColorValue.value == colorData['name'] 
                ? Colors.black 
                : toColor('#E5E5E5'),
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16.w,
                height: 16.w,
                decoration: BoxDecoration(
                  color: toColor(colorData['color']!),
                  shape: BoxShape.circle,
                ),
              ),
              6.horizontalSpace,
              Text(
                colorData['name']!,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: selectedColorValue.value == colorData['name'] 
                      ? Colors.white 
                      : toColor('#292524'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _buildConfirmButton() => InkWell(
    onTap: () {
      onSelected(selectedSizeValue.value, selectedColorValue.value);
      Get.back();
    },
    child: Container(
      width: 1.sw,
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Center(
        child: Text(
          'Add to cart'.tr,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
} 