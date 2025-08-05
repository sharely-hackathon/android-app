import 'package:get/get.dart';
import 'package:sharely/apis/profile_api.dart';
import '../../../../base/base_controller.dart';
import '../../../../models/points_history_model.dart';
import '../../../../models/reward_model.dart';
import '../../../../utils/toast_utils.dart';

class PointHistoryController extends BaseController {
  // 积分历史记录列表
  final pointsHistoryModel = Rxn<PointsHistoryModel>();

  @override
  Future<void> fetchData() async {
    // 模拟获取积分历史数据
    pointsHistoryModel.value = await ProfileApi.getPoints();
  }

  // 刷新数据
  void refreshData() {
    fetchData();
  }

  String formatDateTime(DateTime? dateTime) {
    return '${dateTime?.year.toString().padLeft(4, '0')}-'
        '${dateTime?.month.toString().padLeft(2, '0')}-'
        '${dateTime?.day.toString().padLeft(2, '0')} '
        '${dateTime?.hour.toString().padLeft(2, '0')}:'
        '${dateTime?.minute.toString().padLeft(2, '0')}:'
        '${dateTime?.second.toString().padLeft(2, '0')}';
  }
}
