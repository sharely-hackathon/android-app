import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomWarnWidget extends StatelessWidget {
  String msg;

  CustomWarnWidget(this.msg, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500.w,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15.r),
        ),
        padding: EdgeInsets.only(top: 5.h, bottom: 1.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '提示'.tr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 44.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              width: 480.w,
              margin: EdgeInsets.only(top: 5.h),
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
              alignment: Alignment.center,
              child: Text(
                msg,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
