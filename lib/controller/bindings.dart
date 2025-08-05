import 'package:get/get.dart';

import 'app_controller.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(AppController(),permanent: true);
  }
}