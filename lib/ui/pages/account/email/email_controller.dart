import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../base/base_controller.dart';
import '../../../../utils/toast_utils.dart';

class EmailController extends BaseController {
  // 当前步骤: 1-输入邮箱, 2-输入验证码
  final currentStep = 1.obs;
  
  // 邮箱输入框控制器
  final emailController = TextEditingController();
  
  // 验证码输入值
  final verificationCode = ''.obs;
  
  // 验证码输入组件的GlobalKey
  final verificationCodeKey = GlobalKey();
  
  // 当前邮箱地址
  final currentEmail = ''.obs;
  
  // 验证码发送状态
  final isCodeSent = false.obs;
  final isSendingCode = false.obs;
  


  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  @override
  Future<void> fetchData() async {
    // 获取当前用户邮箱
  }

  // 发送验证码
  Future<void> sendVerificationCode() async {
    if (emailController.text.trim().isEmpty) {
      showToast('Please enter email address'.tr);
      return;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      showToast('Please enter valid email address'.tr);
      return;
    }

    try {
      isSendingCode.value = true;
      
      // 模拟API调用发送验证码
      await Future.delayed(const Duration(seconds: 1));
      
      currentEmail.value = emailController.text.trim();
      isCodeSent.value = true;
      currentStep.value = 2;

      showToast('Verification code sent'.tr);
    } catch (e) {
      showToast('Failed to send verification code'.tr);
    } finally {
      isSendingCode.value = false;
    }
  }

  // 验证码输入完成
  void onVerificationCodeComplete(String code) {
    verificationCode.value = code;
    verifyEmailCode();
  }

  // 验证邮箱验证码
  Future<void> verifyEmailCode() async {
    if (verificationCode.value.length != 6) {
      showToast('Please enter 6-digit verification code'.tr);
      return;
    }

    try {
      isDataLoad.value = true;
      
      // 模拟API调用验证验证码
      await Future.delayed(const Duration(seconds: 1));
      
      // 模拟验证成功
      showToast('Email updated successfully'.tr);
      Get.back(result: currentEmail.value);
      
    } catch (e) {
      showToast('Invalid verification code'.tr);
      verificationCode.value = '';
      // 清空验证码输入框
      clearVerificationCode();
    } finally {
      isDataLoad.value = false;
    }
  }

  // 重新发送验证码
  Future<void> resendCode() async {
    await sendVerificationCode();
  }

  // 清空验证码输入框
  void clearVerificationCode() {
    // 这个方法可以在验证失败时调用
    // 具体实现需要在使用时通过callback或者其他方式通知组件清空
  }

  // 返回上一步
  void goBack() {
    if (currentStep.value == 2) {
      currentStep.value = 1;
      verificationCode.value = '';
    } else {
      Get.back();
    }
  }
} 