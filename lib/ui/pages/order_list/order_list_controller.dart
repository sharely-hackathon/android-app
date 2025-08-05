import 'package:get/get.dart';
import 'package:sharely/apis/product_api.dart';
import 'package:sharely/base/base_controller.dart';
import 'package:sharely/dio/http_interceptor.dart';
import 'package:sharely/models/order_list_model.dart';
import 'package:sharely/utils/toast_utils.dart';

class OrderListController extends BaseController {
  static OrderListController get find => Get.isRegistered<OrderListController>()
      ? Get.find<OrderListController>()
      : Get.put(OrderListController());

  final orderListModel = Rxn<OrderListModel>();

  @override
  Future<void> fetchData() async {}

  void requestOrderList() async {
    try {
      orderListModel.value = await ProductApi.getOrders();
    } catch (e) {
      flog('获取订单列表失败: $e');
      showToast('获取订单列表失败');
    }
  }

  // 订单评价
  void reviewOrder(String orderId) {
    flog('评价订单: $orderId');
    showToast('订单评价功能');
  }

  // 分享订单
  void shareOrder(String orderId) {
    flog('分享订单: $orderId');
    showToast('订单分享功能');
  }

  // 追踪物流
  void trackDelivery(String orderId) {
    flog('追踪物流: $orderId');
    showToast('物流追踪功能');
  }

  // 获取订单状态颜色
  String getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return '#4CAF50'; // 绿色
      case 'pending':
        return '#FF9800'; // 橙色
      case 'archived':
        return '#2196F3'; // 蓝色
      case 'canceled':
        return '#F44336'; // 红色
      default:
        return '#9E9E9E'; // 灰色
    }
  }

  // 获取订单状态文本
  String getStatusText(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'completed':
        return 'Completed';
      case 'archived':
        return 'Archived';
      case 'canceled':
        return 'Canceled';
      case 'requires_action':
        return 'requires_action';
      default:
        return status;
    }
  }
}