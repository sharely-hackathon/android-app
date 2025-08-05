import 'package:get/get.dart';
import 'package:sharely/apis/profile_api.dart';
import 'package:sharely/ui/pages/points/history/point_history_page.dart';
import '../../../base/base_controller.dart';
import '../../../models/reward_model.dart';

class PointsController extends BaseController {

  final rewardModel = Rxn<RewardModel>();

  // 查看积分历史
  void viewPointHistory() {
    Get.to(() => PointHistoryPage());
  }

  @override
  Future<void> fetchData() async {
    rewardModel.value = await ProfileApi.getRewardCenter();
  }
}