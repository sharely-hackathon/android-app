import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../apis/product_api.dart';
import '../../../base/base_controller.dart';
import '../../../controller/app_controller.dart';
import '../../../models/product_model.dart';
import '../../../models/region_model.dart';
import '../../../utils/toast_utils.dart';
import '../../dialog/home_filter/home_filter_dialog.dart';
import '../../dialog/country/switch_country_dialog.dart';
import '../product_detail/product_detail_page.dart';

class HomeController extends BaseController {
  static HomeController get find => Get.isRegistered<HomeController>()
      ? Get.find<HomeController>()
      : Get.put(HomeController());

  final products = Rxn<ProductModel>();
  final selectedCountry = Rxn<Country>();

  void onProductTap(Product product) {
    Get.to(() => ProductDetailPage(), arguments: product.id);
  }

  // 显示筛选弹窗
  void showFilterDialog() {
    showCustom(
      HomeFilterDialog(),
      alignment: Alignment.bottomCenter,
      clickMaskDismiss: true,
    );
  }

  // 显示国家选择弹窗
  void showCountryDialog() {
    List<Country> allCountries = getUniqueCountries();
    if (allCountries.isEmpty) return;
    
    showCustom(
      SwitchCountryDialog(
        countries: allCountries,
        selectedCountry: selectedCountry.value,
        onCountrySelected: (Country country) {
          selectedCountry.value = country;
        },
      ),
      alignment: Alignment.bottomCenter,
      clickMaskDismiss: true,
    );
  }

  // 获取所有区域中的去重国家列表
  List<Country> getUniqueCountries() {
    return AppController.find.getCountryList();
  }

  // 设置默认选中的国家（第一个国家）
  void setDefaultSelectedCountry() {
    List<Country> countries = getUniqueCountries();
    if (countries.isNotEmpty && selectedCountry.value == null) {
      selectedCountry.value = countries.first;
    }
  }

  @override
  Future<void> fetchData() async {
    products.value = await ProductApi.getProductList();
    await AppController.find.getRegionData();
    setDefaultSelectedCountry();
  }
} 