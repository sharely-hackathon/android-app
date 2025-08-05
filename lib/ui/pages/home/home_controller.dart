import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../base/base_controller.dart';
import '../../../main.dart';
import '../../../utils/toast_utils.dart';
import '../../dialog/home_filter/home_filter_dialog.dart';
import '../product_detail/product_detail_page.dart';

class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final double originalPrice;
  final double rating;
  final String earnPercentage;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.earnPercentage,
  });
}

class HomeController extends BaseController {
  final products = <Product>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initProducts();
  }

  void _initProducts() {
    products.value = [
      Product(
        id: '1',
        name: 'Daily Routine: Natural Finish Full Face Kit (4 PC)',
        image: testImg,
        price: 27.50,
        originalPrice: 30.25,
        rating: 4.52,
        earnPercentage: '8%',
      ),
      Product(
        id: '2',
        name: 'Jelly Balm Hydrating Lip Color...',
        image: testImg,
        price: 27.50,
        originalPrice: 30.25,
        rating: 4.52,
        earnPercentage: '8%',
      ),
      Product(
        id: '3',
        name: 'Spackle Skin Perfecting Primer',
        image: testImg,
        price: 27.50,
        originalPrice: 30.25,
        rating: 4.52,
        earnPercentage: '8%',
      ),
      Product(
        id: '4',
        name: 'Daily Routine: Natural Finish Full Face Kit (4 PC)',
        image: testImg,
        price: 27.50,
        originalPrice: 30.25,
        rating: 4.52,
        earnPercentage: '8%',
      ),
    ];
  }

  void onProductTap(Product product) {
    Get.to(() => ProductDetailPage());
  }

  // 显示筛选弹窗
  void showFilterDialog() {
    showCustom(
      HomeFilterDialog(),
      alignment: Alignment.bottomCenter,
      clickMaskDismiss: true,
    );
  }

  @override
  Future<void> fetchData() async {
  }
} 