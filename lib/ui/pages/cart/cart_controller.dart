import 'package:get/get.dart';
import 'package:sharely/dio/dio_config.dart';
import 'package:sharely/ui/pages/home/home_controller.dart';
import '../../../apis/cart_api.dart';
import '../../../base/base_controller.dart';
import '../../../dio/http_interceptor.dart';
import '../../../models/cart_model.dart';
import '../../../utils/sp_utils.dart';
import '../../../utils/toast_utils.dart';
import '../webview/webview_page.dart';

class CartController extends BaseController {
  final cartModel = Rxn<CartModel>();
  final selectedItems = <String>{}.obs; // 已选中的商品项ID
  final shippingFee = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCartData();
  }

  // 加载购物车数据
  Future<void> loadCartData() async {
    final cartId = SPUtils.get("cart_id") as String?;
    if (cartId != null && cartId.isNotEmpty) {
      final result = await CartApi.queryCartById(cartId: cartId);
      if (result != null) {
        cartModel.value = result;
        shippingFee.value = result.cart?.shippingTotal.toDouble() ?? 0.0;
        
        // 默认全选所有商品
        for (var item in result.cart?.items ?? []) {
          selectedItems.add(item.id);
        }
      }
    }
  }

  // 切换商品选中状态
  void toggleItemSelection(String itemId) {
    if (selectedItems.contains(itemId)) {
      selectedItems.remove(itemId);
    } else {
      selectedItems.add(itemId);
    }
  }

  // 全选/取消全选
  void toggleSelectAll() {
    final items = cartModel.value?.cart?.items ?? [];
    if (items.isEmpty) return;

    final allSelected = items.every((item) => selectedItems.contains(item.id));

    if (allSelected) {
      // 全部取消选中
      selectedItems.clear();
    } else {
      // 全部选中
      selectedItems.clear();
      for (var item in items) {
        selectedItems.add(item.id);
      }
    }
  }

  // 判断是否全选
  bool get isAllSelected {
    final items = cartModel.value?.cart?.items ?? [];
    if (items.isEmpty) return false;
    return items.every((item) => selectedItems.contains(item.id));
  }

  // 更新商品数量的辅助方法
  void _updateItemQuantity(String itemId, int newQuantity) {
    final cartData = cartModel.value;
    if (cartData?.cart?.items != null && newQuantity >= 1) {
      final items = cartData!.cart!.items;
      final itemIndex = items.indexWhere((item) => item.id == itemId);
      
      if (itemIndex != -1) {
        // 直接修改quantity属性
        items[itemIndex].quantity = newQuantity;
        
        // 触发响应式更新
        cartModel.refresh();
      }
    }
  }

  // 增加商品数量
  void increaseQuantity(String itemId) {
    final cartData = cartModel.value;
    if (cartData?.cart?.items != null) {
      final items = cartData!.cart!.items;
      try {
        final itemIndex = items.indexWhere((item) => item.id == itemId);
        if (itemIndex != -1) {
          final item = items[itemIndex];
          _updateItemQuantity(itemId, item.quantity.toInt() + 1);
        }
      } catch (e) {
        flog('增加商品数量失败: $e');
      }
    }
  }

  // 减少商品数量
  void decreaseQuantity(String itemId) {
    final cartData = cartModel.value;
    if (cartData?.cart?.items != null) {
      final items = cartData!.cart!.items;
      try {
        final itemIndex = items.indexWhere((item) => item.id == itemId);
        if (itemIndex != -1) {
          final item = items[itemIndex];
          final currentQuantity = item.quantity.toInt();
          
          // 数量最低为1，不能再减少
          if (currentQuantity > 1) {
            _updateItemQuantity(itemId, currentQuantity - 1);
          }
        }
      } catch (e) {
        flog('减少商品数量失败: $e');
      }
    }
  }

  // 删除商品
  void removeItem(String itemId) {
    // 这里需要调用API来删除购物车商品
    // 暂时显示提示，后续可以实现具体的API调用
    selectedItems.remove(itemId);
    showToast('删除商品功能待实现');
  }

  // 计算选中商品的总价
  double get totalPrice {
    double total = 0.0;
    final items = cartModel.value?.cart?.items ?? [];
    
    for (var item in items) {
      if (selectedItems.contains(item.id)) {
        // unitPrice直接使用，不需要除以100
        total += item.unitPrice * item.quantity;
      }
    }
    return total;
  }

  // 计算选中商品的总价（包含运费）
  double get totalPriceWithShipping => totalPrice + shippingFee.value;

  // 获取购物车商品总数量
  int get totalItemCount {
    final items = cartModel.value?.cart?.items ?? [];
    int total = 0;
    for (var item in items) {
      total += item.quantity.toInt();
    }
    return total;
  }

  // 获取选中商品数量
  int get selectedItemCount => selectedItems.length;

  // 支付
  void payWithHelio() {
    if (selectedItems.isEmpty) {
      showToast('Please select the product you want to purchase'.tr);
      return;
    }
    
    // 从SPUtils获取token和cartId
    final token = SPUtils.get("token") as String?;
    final cartId = SPUtils.get("cart_id") as String?;
    
    // 准备cookies
    final cookies = <String, String?>{
      '_medusa_jwt': token,
      '_medusa_cart_id': cartId,
    };
    
    // 跳转到支付页面
    Get.to(() => WebViewPage(
      title: 'Payment',
      url: "https://sharely.dev/${HomeController.find.selectedCountry.value?.iso2}/checkout?step=address&_from=app",
      cookies: cookies,
    ));
  }

  @override
  Future<void> fetchData() async {
    await loadCartData();
  }
}
