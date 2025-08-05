import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:sharely/utils/sp_utils.dart';

import '../../lang/translations.dart';

class AppController extends GetxController {

  static AppController get find => Get.find();

  @override
  void onInit() {
    super.onInit();

    Get.updateLocale(SPUtils.getLocal() ?? ENGLISH);
    initEasyLoadding();
  }

  initEasyLoadding() {
    // 全局配置SmartDialog的参数
    SmartDialog.config.toast = SmartConfigToast(alignment: Alignment.center);
    SmartDialog.config.loading = SmartConfigLoading(clickMaskDismiss: true);
  }
}
