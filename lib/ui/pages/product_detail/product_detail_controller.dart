import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sharely/base/base_controller.dart';
import 'package:sharely/ui/dialog/product_detail/product_detail_filter_dialog.dart';

import '../../../apis/cart_api.dart';
import '../../../apis/product_api.dart';
import '../../../dio/http_interceptor.dart';
import '../../../models/cart_model.dart';
import '../../../models/product_model.dart';
import '../../../utils/sp_utils.dart';
import '../../../utils/toast_utils.dart';
import '../../dialog/share/share_dialog.dart';
import '../home/home_controller.dart';

class ProductDetailController extends BaseController {
  // 购物车ID的SPUtils key
  static const String _cartIdKey = 'cart_id';

  // 当前选中的图片索引
  final currentImageIndex = 0.obs;

  // 商品数据
  final Rxn<Product> product = Rxn<Product>();

  // PageView控制器
  late PageController pageController;

  // 本地状态变量
  final selectedVariantIndex = 0.obs; // 选中的变体索引
  final quantity = 1.obs;

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
    final result = await ProductApi.getProductById(productId: Get.arguments);

    if (result != null) {
      product.value = result;
    }
  }

  // 获取商品图片列表
  List<String> get productImages {
    if (product.value?.images.isNotEmpty == true) {
      return product.value!.images.map((img) => img.url).toList();
    }
    // 如果没有图片，返回测试图片
    return [];
  }

  // 获取当前选中的变体
  Variant? get selectedVariant {
    if (product.value?.variants.isNotEmpty == true &&
        selectedVariantIndex.value < product.value!.variants.length) {
      return product.value!.variants[selectedVariantIndex.value];
    }
    return null;
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
        currentSizeValue: currentSize,
        currentColorValue: currentColor,
        sizeOptions: sizeOptions,
        colorOptions: colorOptions,
        colorOptionsMetadata: colorOptionsMetadata,
        onSelected: (String size, String color) {
          // 根据选择的尺寸和颜色找到对应的变体
          for (int i = 0; i < product.value!.variants.length; i++) {
            final variant = product.value!.variants[i];
            bool sizeMatch = size.isEmpty || sizeOptions.isEmpty;
            bool colorMatch = color.isEmpty || colorOptions.isEmpty;

            for (var option in variant.options) {
              final optionTitle = option.option?.title ?? '';
              if (optionTitle.toLowerCase() == 'size' && option.value == size) {
                sizeMatch = true;
              } else if (optionTitle.toLowerCase() == 'color' &&
                  option.value == color) {
                colorMatch = true;
              }
            }

            if (sizeMatch && colorMatch) {
              selectedVariantIndex.value = i;
              break;
            }
          }
        },
      ),
      isScrollControlled: true,
    );
  }

  // 显示分享弹窗
  void showShareDialog() {
    final token = SPUtils.get("token") as String?;
    final cartId = SPUtils.get("cart_id") as String?;

    // 准备cookies
    final cookies = <String, String?>{
      '_medusa_jwt': token,
      '_medusa_cart_id': cartId,
    };

    showCustom(
      ShareDialog(
        handle: product.value!.handle,
        url:
            "https://sharely.dev/${HomeController.find.selectedCountry.value?.iso2}/share/product/${product.value?.handle}",
        cookies: cookies,
      ),
      clickMaskDismiss: true,
    );
  }

  // 添加到购物车
  void addToCart() async {
    try {
      // 检查是否有选中的变体
      if (selectedVariant == null) {
        showToast('Please select product specifications');
        return;
      }

      // 获取当前选中的国家regionId
      String? regionId = HomeController.find.selectedCountry.value?.regionId;
      if (regionId == null || regionId.isEmpty) {
        showToast('Please select a country first');
        return;
      }

      // 检查是否已有购物车ID
      String? cartId = _getCartId();

      if (cartId == null || cartId.isEmpty) {
        // 如果没有购物车ID，先创建购物车
        cartId = await _createCart(regionId);
        if (cartId == null) {
          showToast('Add to cart failed');
          return;
        }
      } else {
        // 如果有购物车ID，先验证购物车是否还存在
        bool cartExists = await _validateCart(cartId);
        if (!cartExists) {
          // 购物车不存在，重新创建
          cartId = await _createCart(regionId);
          if (cartId == null) {
            showToast('Failed to create shopping cart');
            return;
          }
        }
      }

      // 添加商品到购物车
      bool success = await _addProductToCart(cartId);
      if (!success) {
        showToast('Add to cart failed');
      }
    } catch (e) {
      showToast('error：$e');
    }
  }

  // 获取保存的购物车ID
  String? _getCartId() {
    return SPUtils.get(_cartIdKey) as String?;
  }

  // 保存购物车ID
  void _saveCartId(String cartId) {
    SPUtils.set(_cartIdKey, cartId);
  }

  // 清除购物车ID（用于支付完成后调用）
  // 使用方法：在支付成功回调中调用 ProductDetailController.clearCartId();
  static void clearCartId() {
    SPUtils.remove(_cartIdKey);
  }

  // 获取当前购物车ID（静态方法，供其他页面使用）
  static String? getCurrentCartId() {
    return SPUtils.get(_cartIdKey) as String?;
  }

  // 创建购物车
  Future<String?> _createCart(String regionId) async {
    try {
      CartModel? result = await CartApi.createCart(regionId: regionId);
      if (result?.cart?.id != null) {
        String cartId = result!.cart!.id;
        _saveCartId(cartId);
        return cartId;
      }
      return null;
    } catch (e) {
      flog('创建购物车失败：$e');
      return null;
    }
  }

  // 验证购物车是否存在
  Future<bool> _validateCart(String cartId) async {
    try {
      final model = await CartApi.queryCartById(
        cartId: cartId,
        isShowLoading: false,
        isShowErrMsg: false,
      );
      return model != null;
    } catch (e) {
      flog('验证购物车失败：$e');
      return false;
    }
  }

  // 添加商品到购物车
  Future<bool> _addProductToCart(String cartId) async {
    try {
      Map<String, dynamic> data = {
        'variant_id': selectedVariant!.id,
        'quantity': quantity.value,
      };

      return await CartApi.addProductToCart(cartId: cartId, map: data);
    } catch (e) {
      flog('添加商品到购物车失败：$e');
      return false;
    }
  }

  // 获取颜色选项
  List<String> get colorOptions {
    if (product.value?.options.isNotEmpty == true) {
      for (var option in product.value!.options) {
        if (option.title.toLowerCase() == 'color') {
          return option.values.map((value) => value.value).toList();
        }
      }
    }
    return [];
  }

  // 获取颜色选项的元数据映射
  Map<String, String> get colorOptionsMetadata {
    final Map<String, String> colorMap = {};
    if (product.value?.options.isNotEmpty == true) {
      for (var option in product.value!.options) {
        if (option.title.toLowerCase() == 'color') {
          for (var value in option.values) {
            if (value.metadata?.hexVal != null &&
                value.metadata!.hexVal.isNotEmpty) {
              colorMap[value.value] = value.metadata!.hexVal;
            }
          }
        }
      }
    }
    return colorMap;
  }

  // 获取尺寸选项
  List<String> get sizeOptions {
    if (product.value?.options.isNotEmpty == true) {
      for (var option in product.value!.options) {
        if (option.title.toLowerCase() == 'size') {
          return option.values.map((value) => value.value).toList();
        }
      }
    }
    return [];
  }

  // 获取当前选中的尺寸
  String get currentSize {
    if (sizeOptions.isNotEmpty) {
      if (selectedVariant != null) {
        for (var option in selectedVariant!.options) {
          final optionTitle = option.option?.title ?? '';
          if (optionTitle.toLowerCase() == 'size') {
            return option.value;
          }
        }
      }
      return sizeOptions.first;
    }
    return '';
  }

  // 获取当前选中的颜色
  String get currentColor {
    if (colorOptions.isNotEmpty) {
      if (selectedVariant != null) {
        for (var option in selectedVariant!.options) {
          final optionTitle = option.option?.title ?? '';
          if (optionTitle.toLowerCase() == 'color') {
            return option.value;
          }
        }
      }
      return colorOptions.first;
    }
    return '';
  }

  // 检查是否有颜色选项
  bool get hasColorOption => colorOptions.isNotEmpty;

  // 检查是否有尺寸选项
  bool get hasSizeOption => sizeOptions.isNotEmpty;
}
