import 'package:get/get.dart';
import '../../../base/base_controller.dart';
import '../../../main.dart';
import '../../../utils/toast_utils.dart';

// 商品模型
class CartProduct {
  final String id;
  final String name;
  final String image;
  final double price;
  final double originalPrice;
  final String color;
  final String size;
  final int quantity;

  CartProduct({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.originalPrice,
    required this.color,
    required this.size,
    required this.quantity,
  });

  CartProduct copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
    double? originalPrice,
    String? color,
    String? size,
    int? quantity,
  }) {
    return CartProduct(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      color: color ?? this.color,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}

// 商家模型
class Merchant {
  final String id;
  final String name;
  final String avatar;
  final List<CartProduct> products;

  Merchant({
    required this.id,
    required this.name,
    required this.avatar,
    required this.products,
  });

  Merchant copyWith({
    String? id,
    String? name,
    String? avatar,
    List<CartProduct>? products,
  }) {
    return Merchant(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      products: products ?? this.products,
    );
  }
}

class CartController extends BaseController {
  final merchants = <Merchant>[].obs;
  final selectedProducts = <String>{}.obs; // 已选中的商品ID
  final shippingFee = 5.00.obs;

  @override
  void onInit() {
    super.onInit();
    _initCartData();
  }

  void _initCartData() {
    merchants.value = [
      Merchant(
        id: '1',
        name: 'Laura Geller',
        avatar: testImg,
        products: [
          CartProduct(
            id: '1',
            name: 'Daily Routine: Natural Finish Full Face Kit (4 PC)',
            image: testImg,
            price: 27.50,
            originalPrice: 30.25,
            color: 'Orange',
            size: 'xl',
            quantity: 3,
          ),
          CartProduct(
            id: '2',
            name: 'Daily Routine: Natural Finish Full Face Kit (4 PC)',
            image: testImg,
            price: 27.50,
            originalPrice: 30.25,
            color: 'Orange',
            size: 'xl',
            quantity: 3,
          ),
        ],
      ),
      Merchant(
        id: '2',
        name: 'Laura Geller',
        avatar: testImg,
        products: [
          CartProduct(
            id: '3',
            name: 'Daily Routine: Natural Finish Full Face Kit (4 PC)',
            image: testImg,
            price: 27.50,
            originalPrice: 30.25,
            color: 'Orange',
            size: 'xl',
            quantity: 3,
          ),
          CartProduct(
            id: '4',
            name: 'Daily Routine: Natural Finish Full Face Kit (4 PC)',
            image: testImg,
            price: 27.50,
            originalPrice: 30.25,
            color: 'Orange',
            size: 'xl',
            quantity: 3,
          ),
        ],
      ),
    ];
    
    // 默认全选商品
    for (var merchant in merchants) {
      for (var product in merchant.products) {
        selectedProducts.add(product.id);
      }
    }
  }

  // 切换商品选中状态
  void toggleProductSelection(String productId) {
    if (selectedProducts.contains(productId)) {
      selectedProducts.remove(productId);
    } else {
      selectedProducts.add(productId);
    }
  }

  // 切换商家全选
  void toggleMerchantSelection(String merchantId) {
    final merchant = merchants.firstWhere((m) => m.id == merchantId);
    final allSelected = merchant.products.every((p) => selectedProducts.contains(p.id));
    
    if (allSelected) {
      // 全部取消选中
      for (var product in merchant.products) {
        selectedProducts.remove(product.id);
      }
    } else {
      // 全部选中
      for (var product in merchant.products) {
        selectedProducts.add(product.id);
      }
    }
  }

  // 判断商家是否全选
  bool isMerchantSelected(String merchantId) {
    final merchant = merchants.firstWhere((m) => m.id == merchantId);
    return merchant.products.every((p) => selectedProducts.contains(p.id));
  }

  // 增加商品数量
  void increaseQuantity(String productId) {
    for (int i = 0; i < merchants.length; i++) {
      for (int j = 0; j < merchants[i].products.length; j++) {
        if (merchants[i].products[j].id == productId) {
          final updatedProduct = merchants[i].products[j].copyWith(
            quantity: merchants[i].products[j].quantity + 1,
          );
          final updatedProducts = List<CartProduct>.from(merchants[i].products);
          updatedProducts[j] = updatedProduct;
          merchants[i] = merchants[i].copyWith(products: updatedProducts);
          merchants.refresh();
          return;
        }
      }
    }
  }

  // 减少商品数量
  void decreaseQuantity(String productId) {
    for (int i = 0; i < merchants.length; i++) {
      for (int j = 0; j < merchants[i].products.length; j++) {
        if (merchants[i].products[j].id == productId) {
          if (merchants[i].products[j].quantity > 1) {
            final updatedProduct = merchants[i].products[j].copyWith(
              quantity: merchants[i].products[j].quantity - 1,
            );
            final updatedProducts = List<CartProduct>.from(merchants[i].products);
            updatedProducts[j] = updatedProduct;
            merchants[i] = merchants[i].copyWith(products: updatedProducts);
            merchants.refresh();
          }
          return;
        }
      }
    }
  }

  // 删除商品
  void removeProduct(String productId) {
    for (int i = 0; i < merchants.length; i++) {
      final updatedProducts = merchants[i].products.where((p) => p.id != productId).toList();
      if (updatedProducts.length != merchants[i].products.length) {
        // 从选中列表中移除
        selectedProducts.remove(productId);
        
        if (updatedProducts.isEmpty) {
          // 如果商家没有商品了，删除整个商家
          merchants.removeAt(i);
        } else {
          // 更新商家的商品列表
          merchants[i] = merchants[i].copyWith(products: updatedProducts);
        }
        merchants.refresh();
        return;
      }
    }
  }

  // 计算选中商品的总价
  double get totalPrice {
    double total = 0;
    for (var merchant in merchants) {
      for (var product in merchant.products) {
        if (selectedProducts.contains(product.id)) {
          total += product.price * product.quantity;
        }
      }
    }
    return total;
  }

  // 计算选中商品的总价（包含运费）
  double get totalPriceWithShipping => totalPrice + shippingFee.value;

  // 支付
  void payWithHelio() {
    if (selectedProducts.isEmpty) {
      showToast('请选择要购买的商品');
      return;
    }
    showToast('支付功能待实现');
  }

  @override
  Future<void> fetchData() async {
    // 这里可以实现从API获取购物车数据
  }
} 