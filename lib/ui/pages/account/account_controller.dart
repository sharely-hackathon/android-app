import 'package:get/get.dart';
import 'package:sharely/ui/pages/account/shipping_address/shipping_address_page.dart';
import 'email/email_page.dart';

import '../../../base/base_controller.dart';

class AccountController extends BaseController {
  // 用户基本信息
  final userEmail = 'olga.d.harrison@gmail.com'.obs;
  final userMobile = '+1 2385827583'.obs;
  final userAvatar = ''.obs;
  
  // 社交媒体信息
  final xAccount = '@olga_harrison'.obs;
  final discordAccount = '@olga_harrison'.obs;
  final telegramAccount = '@olga_harrison'.obs;

  @override
  Future<void> fetchData() async {
    // 这里可以从API获取用户账户信息
    // 目前使用固定数据
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
  }

  // 编辑Discord账号
  void editDiscordAccount() {
    // 实现编辑Discord账号功能
  }

  // 编辑Telegram账号
  void editTelegramAccount() {
    // 实现编辑Telegram账号功能
  }
} 