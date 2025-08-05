import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../base/base_scaffold.dart';
import '../../../../utils/color_utils.dart';
import 'email_controller.dart';
import 'widgets/verification_code_input.dart';

class EmailPage extends StatelessWidget {
  EmailPage({super.key});

  final controller = Get.put(EmailController());

  @override
  Widget build(BuildContext context) => BaseScaffold(
        title: 'Email'.tr,
        onBack: controller.goBack,
        body: Obx(() => controller.currentStep.value == 1
            ? _buildEmailInputStep()
            : _buildVerificationStep()),
      );

  // 邮箱输入步骤
  Widget _buildEmailInputStep() => Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please enter your new email address and we will send a verification code to verify the email.'.tr,
              style: TextStyle(
                fontSize: 14.sp,
                color: toColor('#292524'),
                height: 1.5,
              ),
            ),
            40.verticalSpace,
            _buildEmailTextField(),
            40.verticalSpace,
            _buildSendButton(),
          ],
        ),
      );

  // 验证码输入步骤
  Widget _buildVerificationStep() => Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'We have sent a verification code to your email address '.tr,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: toColor('666666'),
                      height: 1.5,
                    ),
                  ),
                  TextSpan(
                    text: controller.currentEmail.value,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: toColor('1A1A1A'),
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            40.verticalSpace,
            VerificationCodeInput(
              onCompleted: controller.onVerificationCodeComplete,
              onChanged: (value) {
                controller.verificationCode.value = value;
              },
            ),
            20.verticalSpace,
            _buildResendCodeButton(),
          ],
        ),
      );

  // 邮箱输入框
  Widget _buildEmailTextField() => Container(
        height: 48.h,
        decoration: BoxDecoration(
          border: Border.all(color: toColor('E5E5E5'), width: 1.w),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: TextField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontSize: 16.sp,
            color: toColor('1A1A1A'),
          ),
          decoration: InputDecoration(
            hintText: 'Email address'.tr,
            hintStyle: TextStyle(
              fontSize: 16.sp,
              color: toColor('CCCCCC'),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
          ),
        ),
      );

  // 发送验证码按钮
  Widget _buildSendButton() => Obx(() => SizedBox(
        width: 1.sw,
        height: 44.h,
        child: ElevatedButton(
          onPressed: controller.isSendingCode.value
              ? null
              : controller.sendVerificationCode,
          style: ElevatedButton.styleFrom(
            backgroundColor: toColor('1A1A1A'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            elevation: 0,
          ),
          child: controller.isSendingCode.value
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  'Send verification code'.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
        ),
      ));

  // 重新发送验证码按钮
  Widget _buildResendCodeButton() => Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: controller.resendCode,
          child: Text(
            'Resend code'.tr,
            style: TextStyle(
              fontSize: 14.sp,
              color: toColor('1A1A1A'),
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
} 