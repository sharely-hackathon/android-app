import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/assets_utils.dart';
import '../../utils/color_utils.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, this.msg});

  final String? msg;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetsUtils.empty, width: 105.w, height: 94.w),
          Text(
            msg ?? "No data",
            style: TextStyle(color: toColor('1a1a1a'), fontSize: 14.sp),
          ).marginOnly(top: 5.h),
        ],
      ),
    );
  }
}
