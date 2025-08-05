import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:sharely/utils/sp_utils.dart';

import '../../lang/translations.dart';
import '../apis/product_api.dart';
import '../apis/profile_api.dart';
import '../models/region_model.dart';

class AppController extends GetxController {

  static AppController get find => Get.find();
  
  // 全局区域数据缓存
  final regionModel = Rxn<RegionModel>();

  @override
  void onInit() {
    super.onInit();

    Get.updateLocale(SPUtils.getLocal() ?? ENGLISH);
    initEasyLoadding();

    Timer.periodic(const Duration(minutes: 10), (timer) => _login());
    _login();
  }

  void _login() async {
    if (isLoggedIn()) {
      final success = await ProfileApi.login(
        map: {
          'email': SPUtils.get("email"),
          'password': SPUtils.get("password"),
        },
        isShowLoading: false,
        isShowErrMsg: false,
      );

      if (success != null) {
        // 更新登录状态
        SPUtils.set("token", success);
      }
    }
  }

  initEasyLoadding() {
    // 全局配置SmartDialog的参数
    SmartDialog.config.toast = SmartConfigToast(alignment: Alignment.center);
    SmartDialog.config.loading = SmartConfigLoading(clickMaskDismiss: true);
  }

  // 检查用户是否已登录
  bool isLoggedIn() {
    String? token = SPUtils.get("token") as String?;
    return token != null && token.isNotEmpty;
  }

  // 获取区域数据（带缓存）
  Future<RegionModel?> getRegionData() async {
    if (regionModel.value != null) {
      return regionModel.value;
    }
    
    try {
      regionModel.value = await ProductApi.getRegionData();
      return regionModel.value;
    } catch (e) {
      return null;
    }
  }

  // 获取所有区域中的去重国家列表
  List<Country> getCountryList() {
    if (regionModel.value == null) return [];
    
    Map<String, Country> countryMap = {};
    
    for (Region region in regionModel.value!.regions) {
      for (Country country in region.countries) {
        if (country.iso2.isNotEmpty) {
          countryMap[country.iso2] = country;
        }
      }
    }
    
    return countryMap.values.toList();
  }
}
