import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharely/ui/pages/order_list/order_list_controller.dart';
import 'package:sharely/ui/pages/profile/profile_controller.dart';

import '../../base/base_controller.dart';
import '../../controller/app_controller.dart';
import 'login/login_page.dart';

class MainController extends BaseController {
  final currentIndex = 0.obs;
  final pageController = PageController(initialPage: 0);

  void changePage(int index) {
    // 如果点击的是Profile页面（索引3），需要检查登录状态
    if (index == 3) {
      if (!AppController.find.isLoggedIn()) {
        // 未登录，跳转到登录页面
        Get.to(() => LoginPage());
        return;
      } else {
        ProfileController.find.requestProfile();
      }
    } else if (index == 2) {
      OrderListController.find.requestOrderList();
    }

    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  @override
  Future<void> fetchData() async {}
}
