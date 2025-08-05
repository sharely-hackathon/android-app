import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharely/base/base_controller.dart';
import 'package:sharely/ui/dialog/product_detail/product_detail_filter_dialog.dart';

class ProductDetailController extends BaseController {
  // 当前选中的图片索引
  final currentImageIndex = 0.obs;
  
  // 商品图片列表
  final productImages = <String>[].obs;
  
  // PageView控制器
  late PageController pageController;
  
  // 商品信息
  final productTitle = 'Daily Routine: Natural Finish Full Face Kit (4 PC)'.obs;
  final productRating = 4.52.obs;
  final productReviews = 1588.obs;
  final productPrice = 27.50.obs;
  final originalPrice = 30.25.obs;
  final shareEarning = '8%'.obs;
  final selectedSize = 'XS'.obs;
  final selectedColor = 'Orange'.obs;
  final quantity = 1.obs;
  
  // 颜色映射
  final colorMap = {
    'Orange': 'FF8C42',
    'Blue': '4A90E2',
    'Green': '7ED321',
    'Red': 'D0021B',
    'Purple': '9013FE',
    'Black': '000000',
  };
  
  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  @override
  Future<void> fetchData() async {
    // 模拟网络请求获取商品详情
    await Future.delayed(const Duration(milliseconds: 500));
    
    // 添加测试图片
    productImages.addAll([
      'https://picsum.photos/400/400?random=1',
      'https://picsum.photos/400/400?random=2',
      'https://picsum.photos/400/400?random=3',
      'https://picsum.photos/400/400?random=4',
      'https://picsum.photos/400/400?random=5',
    ]);
  }
  
  // 切换图片
  void changeImage(int index) {
    if (index >= 0 && index < productImages.length) {
      currentImageIndex.value = index;
      // 使用PageController切换到指定页面，使用jumpToPage避免动画过程中的状态变化
      if (pageController.hasClients) {
        pageController.jumpToPage(index);
      }
    }
  }
  
  // 增加数量
  void increaseQuantity() {
    quantity.value++;
  }
  
  // 减少数量
  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
  
  // 显示变体选择对话框（尺寸和颜色）
  void showVariantsDialog() {
    Get.bottomSheet(
      ProductDetailFilterDialog(
        currentSizeValue: selectedSize.value,
        currentColorValue: selectedColor.value,
        onSelected: (String size, String color) {
          selectedSize.value = size;
          selectedColor.value = color;
        },
      ),
      isScrollControlled: true,
    );
  }
} 