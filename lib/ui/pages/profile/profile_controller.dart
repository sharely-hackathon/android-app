import 'package:get/get.dart';
import 'package:sharely/ui/pages/account/account_page.dart';
import '../../../base/base_controller.dart';
import '../distribution/distribution_page.dart';

class ProfileController extends BaseController {
  final userName = 'Olga Harrison'.obs;
  final userEmail = 'Olga.d.harrison@gmail.com'.obs;
  final isVerified = true.obs;
  final hasNotification = true.obs;

  @override
  Future<void> fetchData() async {
  }

  void onAccountSettingsTap() {
    Get.to(() => AccountPage());
  }

  void onPaymentTap() {
    // TODO: 导航到支付页面
  }

  void onDistributionTap() {
    Get.to(() => DistributionPage());
  }

  void onFollowSharelyTap() {
    // TODO: 打开外部链接或导航到关注页面
  }

  void onSignOutTap() {
    // TODO: 实现登出逻辑
    Get.defaultDialog(
      title: 'sign_out'.tr,
      middleText: 'confirm_sign_out'.tr,
      textConfirm: 'confirm'.tr,
      textCancel: 'Cancel'.tr,
      onConfirm: () {
        Get.back();
        // 执行登出逻辑
      },
    );
  }
} 