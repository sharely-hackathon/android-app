import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharely/apis/profile_api.dart';
import 'package:sharely/ui/pages/account/account_page.dart';
import 'package:sharely/ui/pages/login/login_page.dart';
import '../../../base/base_controller.dart';
import '../../../controller/app_controller.dart';
import '../../../models/profile_model.dart';
import '../../../utils/sp_utils.dart';
import '../../../utils/toast_utils.dart';
import '../../dialog/language/switch_language_dialog.dart';
import '../distribution/distribution_page.dart';
import '../home/home_controller.dart';
import '../points/points_page.dart';
import '../webview/webview_page.dart';

class ProfileController extends BaseController {
  static ProfileController get find => Get.isRegistered<ProfileController>()
      ? Get.find<ProfileController>()
      : Get.put(ProfileController());

  final hasNotification = false.obs;

  final profileModel = Rxn<ProfileModel>();

  @override
  Future<void> fetchData() async {}

  void requestProfile() async {
    if (AppController.find.isLoggedIn()) {
      profileModel.value = await ProfileApi.getProfile();
    }
  }

  Map<String, String?> getCookieMap() {
    // 从SPUtils获取token和cartId
    final token = SPUtils.get("token") as String?;
    final cartId = SPUtils.get("cart_id") as String?;

    // 准备cookies
    final cookies = <String, String?>{
      '_medusa_jwt': token,
      '_medusa_cart_id': cartId,
    };

    return cookies;
  }

  void onAccountSettingsTap() {
    Get.to(() => AccountPage());
  }

  void onPointsTap() {
    Get.to(() => PointsPage());
  }

  void onPaymentTap() {
    Get.to(() => WebViewPage(
      title: 'Payment'.tr,
      url: "https://sharely.dev/${HomeController.find.selectedCountry.value?.iso2}/pages/intro-helio",
      cookies: getCookieMap(),
    ));
  }

  void onDistributionTap() {
    Get.to(() => WebViewPage(
      title: 'Distribution'.tr,
      url: "https://sharely.dev/${HomeController.find.selectedCountry.value?.iso2}/user/distribution",
      cookies: getCookieMap(),
    ));
  }

  void onFollowSharelyTap() {
    Get.to(() => WebViewPage(
      title: 'Follow'.tr,
      url: "https://x.com/sharely_love",
    ));
  }

  void switchLanguage() {
    showCustom(
      SwitchLanguageDialog(),
      alignment: Alignment.bottomCenter,
    );
  }

  void onSignOutTap() {
    Get.defaultDialog(
      title: 'sign_out'.tr,
      middleText: 'confirm_sign_out'.tr,
      textConfirm: 'confirm'.tr,
      textCancel: 'Cancel'.tr,
      onConfirm: () async {
        Get.back();
        // 清除登录状态
        SPUtils.remove("token");

        // 跳转到登录页面
        Get.to(() => LoginPage());
      },
    );
  }
} 