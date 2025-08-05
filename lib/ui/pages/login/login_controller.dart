import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../apis/profile_api.dart';
import '../../../base/base_controller.dart';
import '../../../controller/app_controller.dart';
import '../../../utils/sp_utils.dart';
import '../../../utils/toast_utils.dart';
import '../main_page.dart';

class LoginController extends BaseController {
  final emailController = TextEditingController(text: "rolledmyeyes@gmail.com");
  final passwordController = TextEditingController(text: "ZfcKNew6pq@JfEE-dnfY");
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  @override
  Future<void> fetchData() async {
    // 可以在这里获取一些初始数据
  }

  // 验证邮箱格式
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // 执行登录
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // 验证输入
    if (email.isEmpty) {
      showToast('Please enter your email address'.tr);
      return;
    }

    if (!_isValidEmail(email)) {
      showToast('Please enter a valid email address'.tr);
      return;
    }

    if (password.isEmpty) {
      showToast('Please enter your password'.tr);
      return;
    }

    try {
      isLoading.value = true;

      // 调用登录API
      final success = await ProfileApi.login(
        map: {
          'email': email,
          'password': password,
        },
      );

      if (success != null) {
        // 更新登录状态
        SPUtils.set("email", email);
        SPUtils.set("password", password);
        SPUtils.set("token", success);

        // 登录成功后跳转到主页面
        Get.back();
      } else {
        showToast('Login Failure');
      }
    } catch (e) {
      showToast('Login Failure：$e');
    } finally {
      isLoading.value = false;
    }
  }
} 