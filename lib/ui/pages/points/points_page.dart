import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharely/ui/pages/points/points_controller.dart';
import '../../../base/base_scaffold.dart';
import '../../../models/reward_model.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/assets_utils.dart';

class PointsPage extends StatelessWidget {
  PointsPage({super.key});

  final controller = Get.put(PointsController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: Colors.white,
      title: 'Points'.tr,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(
            () => controller.isDataLoad.value
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.verticalSpace,
                      _buildPointsCard(),
                      30.verticalSpace,
                      _buildSectionTitle('Rewards'),
                      15.verticalSpace,
                      _buildRewardsList(),
                      50.verticalSpace,
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  // 积分卡片
  Widget _buildPointsCard() => Container(
    width: 1.sw,
    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
    decoration: BoxDecoration(
      color: toColor("#F0ECE1"),
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My points'.tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: toColor("#79716B"),
                  fontWeight: FontWeight.w400,
                ),
              ),
              Obx(
                () => Text(
                  controller.rewardModel.value!.pointsBalance.toString().replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]},',
                  ),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: toColor('#292524'),
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: controller.viewPointHistory,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Point history',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: toColor("666666"),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // 章节标题
  Widget _buildSectionTitle(String title) => Text(
    title,
    style: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  // 奖励列表
  Widget _buildRewardsList() => Obx(
    () => Column(
      children: controller.rewardModel.value!.availableTasks
          .map(
            (reward) => _buildRewardItem(
              reward: reward,
              onTap: () {},
            ),
          )
          .toList(),
    ),
  );

  // 奖励项目
  Widget _buildRewardItem({
    required AvailableTask reward,
    required VoidCallback onTap,
  }) => Container(
    margin: EdgeInsets.only(bottom: 12.h),
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: toColor("#F5F5F4"),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Row(
      children: [
        Image.asset(AssetsUtils.wallet_ic, width: 40.w),
        16.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reward.title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              4.verticalSpace,
              Text(
                reward.description,
                style: TextStyle(fontSize: 12.sp, color: toColor("666666")),
              ),
            ],
          ),
        ),
        _buildActionButton(reward, onTap),
      ],
    ),
  );

  // 操作按钮
  Widget _buildActionButton(AvailableTask reward, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        alignment: Alignment.center,
        child: Text(
          "GO".tr,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: toColor("#292524"),
          ),
        ),
      ),
    );
  }
}
