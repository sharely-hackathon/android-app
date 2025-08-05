import 'package:get/get.dart';
import 'package:sharely/ui/pages/account/shipping_address/shipping_address_page.dart';
import '../profile/profile_controller.dart';
import '../webview/webview_page.dart';
import 'email/email_page.dart';

import '../../../base/base_controller.dart';

class AccountController extends BaseController {
  // 用户基本信息
  final userEmail = ''.obs;
  final userMobile = ''.obs;
  final userAvatar = ''.obs;
  
  // 社交媒体信息
  final xAccount = ''.obs;
  final discordAccount = ''.obs;
  final telegramAccount = ''.obs;

  @override
  Future<void> fetchData() async {
    userEmail.value = ProfileController.find.profileModel.value!.email;
    userMobile.value = ProfileController.find.profileModel.value!.phone;
    userAvatar.value = ProfileController.find.profileModel.value!.metadata?.avatar ?? '';
  }

  // 编辑邮箱
  void editEmail() {
    Get.to(() => EmailPage())?.then((newEmail) {
      if (newEmail != null && newEmail is String) {
        userEmail.value = newEmail;
      }
    });
  }

  // 编辑手机号
  void editMobile() {
    // 实现编辑手机号功能
  }

  // 编辑头像
  void editAvatar() {
    // 实现编辑头像功能
  }

  // 编辑收货地址
  void editShippingAddress() {
    Get.to(() => ShippingAddressPage());
  }

  // 编辑X账号
  void editXAccount() {
    // 实现编辑X账号功能
    Get.to(() => WebViewPage(
      title: ''.tr,
      url: "https://x.com/sharely_love",
    ));
  }

  // 编辑Discord账号
  void editDiscordAccount() {
    // 实现编辑Discord账号功能
  }

  // 编辑Telegram账号
  void editTelegramAccount() {
    // 实现编辑Telegram账号功能
    Get.to(() => WebViewPage(
      title: ''.tr,
      url: "https://t.me/+cAQoP8m6xM81ODMx",
    ));
  }
} 