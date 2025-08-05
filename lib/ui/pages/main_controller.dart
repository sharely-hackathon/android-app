import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apis/login_api.dart';
import '../../base/base_controller.dart';

class MainController extends BaseController {
  final currentIndex = 0.obs;
  final pageController = PageController(initialPage: 0);

  void changePage(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  @override
  Future<void> fetchData() async {
    await LoginApi.authApi(map: {});
  }
}