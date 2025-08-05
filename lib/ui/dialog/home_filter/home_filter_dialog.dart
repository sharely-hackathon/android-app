import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharely/utils/color_utils.dart';

import '../../../utils/toast_utils.dart';

class HomeFilterDialog extends StatelessWidget {
  HomeFilterDialog({super.key});

  // 筛选相关属性
  final selectedShipFrom = 'USA'.obs;
  final selectedCategory = 'Beauty and personal care'.obs;
  final selectedSortBy = 'Price: low to high'.obs;

  @override
  Widget build(BuildContext context) => Container(
    width: 1.sw,
    margin: EdgeInsets.symmetric(horizontal: 16.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
    ),
    padding: EdgeInsets.all(20.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildFilterHeader(),
        20.verticalSpace,
        _buildFilterOption('Ship from', selectedShipFrom, [
          'USA',
          'China',
          'Europe',
        ]),
        20.verticalSpace,
        _buildFilterOption('Category', selectedCategory, [
          'Beauty and personal care',
          'Electronics',
          'Fashion',
        ]),
        20.verticalSpace,
        _buildFilterOption('Sort by', selectedSortBy, [
          'Price: low to high',
          'Price: high to low',
          'Rating',
        ]),
        30.verticalSpace,
        _buildConfirmButton(),
      ],
    ),
  );

  Widget _buildFilterHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Filter',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        InkWell(
          onTap: () => dismissLoading(),
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
  }

  Widget _buildFilterOption(
    String title,
    RxString selectedValue,
    List<String> options,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
        ),
        Obx(
          () => Text(
            selectedValue.value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        Icon(Icons.keyboard_arrow_down, size: 24.sp, color: Colors.grey),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return InkWell(
      onTap: () => dismissLoading(),
      child: Container(
        width: 1.sw,
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Center(
          child: Text(
            'Confirm',
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
}
