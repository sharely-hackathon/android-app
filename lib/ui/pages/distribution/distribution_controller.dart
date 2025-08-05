import 'package:get/get.dart';
import '../../../base/base_controller.dart';

class DistributionController extends BaseController {
  // 收益相关
  final earnings = '299'.obs;
  final todayChange = '+2.00'.obs;
  
  // 统计数据
  final customers = '12'.obs;
  final sales = '\$9000'.obs;
  
  // 最近订单列表
  final recentOrders = <OrderInfo>[].obs;
  
  // 产品列表
  final products = <ProductInfo>[].obs;
  
  @override
  Future<void> fetchData() async {
    // 模拟加载数据
    await Future.delayed(const Duration(milliseconds: 500));
    
    // 初始化最近订单数据
    recentOrders.value = [
      OrderInfo(
        id: 'Order 2027090873',
        amount: '\$200.00',
        commission: '+2.00 USDT',
      ),
      OrderInfo(
        id: 'Order 2027090873',
        amount: '\$200.00',
        commission: '+2.00 USDT',
      ),
      OrderInfo(
        id: 'Order 2027090873',
        amount: '\$200.00',
        commission: '+2.00 USDT',
      ),
    ];
    
    // 初始化产品数据
    products.value = [
      ProductInfo(
        name: 'Daily Routine: Natural Finish Full Face',
        views: '20k Views',
        orders: '899 paid orders',
      ),
      ProductInfo(
        name: 'Daily Routine: Natural Finish Full Face Kit (4 PC)',
        views: '15k Views',
        orders: '652 paid orders',
      ),
    ];
  }
  
  // 提现操作
  void onWithdrawTap() {
    // TODO: 实现提现逻辑
  }
  
  // 查看更多订单
  void onViewMoreOrdersTap() {
    // TODO: 跳转到订单详情页
  }
  
  // 查看客户详情
  void onCustomersTap() {
    // TODO: 跳转到客户页面
  }
  
  // 查看销售详情
  void onSalesTap() {
    // TODO: 跳转到销售页面
  }
  
  // 查看等级详情
  void onAffiliateTierTap() {
    // TODO: 跳转到等级页面
  }
}

// 订单信息模型
class OrderInfo {
  final String id;
  final String amount;
  final String commission;
  
  OrderInfo({
    required this.id,
    required this.amount,
    required this.commission,
  });
}

// 产品信息模型
class ProductInfo {
  final String name;
  final String views;
  final String orders;
  
  ProductInfo({
    required this.name,
    required this.views,
    required this.orders,
  });
} 