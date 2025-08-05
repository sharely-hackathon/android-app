import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../base/base_scaffold.dart';
import '../../../utils/assets_utils.dart';
import '../../../utils/color_utils.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          10.verticalSpace,
          SafeArea(
            child: SvgPicture.asset(AssetsUtils.logo_text_ic, width: 86.w),
          ),
          20.verticalSpace,
          Text(
            "Create a Sharely account".tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Get Sharley points and more".tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          40.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                _buildEmailInput(controller),
                16.verticalSpace,
                _buildPasswordInput(controller),
                40.verticalSpace,
                _buildLoginButton(controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInput(LoginController controller) => Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: toColor("F5F5F5"),
      borderRadius: BorderRadius.circular(25.r),
    ),
    child: TextField(
      controller: controller.emailController,
      decoration: InputDecoration(
        hintText: "Email address".tr,
        hintStyle: TextStyle(color: toColor("A8A8A8"), fontSize: 16.sp),
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
      keyboardType: TextInputType.emailAddress,
    ),
  );

  Widget _buildPasswordInput(LoginController controller) => Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: toColor("F5F5F5"),
      borderRadius: BorderRadius.circular(25.r),
    ),
    child: TextField(
      controller: controller.passwordController,
      decoration: InputDecoration(
        hintText: "Password".tr,
        hintStyle: TextStyle(color: toColor("A8A8A8"), fontSize: 16.sp),
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
      obscureText: true,
    ),
  );

  Widget _buildLoginButton(LoginController controller) => Container(
    width: 1.sw,
    height: 44.h,
    child: Obx(
      () => ElevatedButton(
        onPressed: controller.isLoading.value ? null : controller.login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28.r),
          ),
          elevation: 0,
        ),
        child: controller.isLoading.value
            ? SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                "Login".tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    ),
  );
}
