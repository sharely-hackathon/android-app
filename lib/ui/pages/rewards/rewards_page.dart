import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../base/base_scaffold.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/assets_utils.dart';
import 'rewards_controller.dart';

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RewardsController());

    return BaseScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Rewards',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              _buildPointsCard(controller),
              30.verticalSpace,
              _buildSectionTitle('Rewards'),
              15.verticalSpace,
              _buildRewardsList(controller),
              30.verticalSpace,
              _buildSectionTitle('Social quests'),
              15.verticalSpace,
              _buildSocialQuestsList(controller),
              50.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  // 积分卡片
  Widget _buildPointsCard(RewardsController controller) => Container(
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
                  controller.myPoints.value.toString().replaceAllMapped(
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
  Widget _buildRewardsList(RewardsController controller) => Obx(
    () => Column(
      children: controller.rewards
          .map(
            (reward) => _buildRewardItem(
              reward: reward,
              onTap: () {
                if (reward.title == 'Wallet Wrangler') {
                  controller.connectWallet();
                } else if (reward.title == 'X Spy') {
                  controller.followX();
                }
              },
            ),
          )
          .toList(),
    ),
  );

  // 社交任务列表
  Widget _buildSocialQuestsList(RewardsController controller) => Obx(
    () => Column(
      children: controller.socialQuests
          .map(
            (quest) => _buildRewardItem(
              reward: RewardItem(
                icon: quest.icon,
                title: quest.title,
                description: quest.description,
                buttonText: quest.buttonText,
                isCompleted: quest.isCompleted,
              ),
              onTap: () {
                if (quest.title == 'Wallet Wrangler') {
                  controller.connectWallet();
                } else if (quest.title == 'X Spy') {
                  controller.followX();
                }
              },
            ),
          )
          .toList(),
    ),
  );

  // 奖励项目
  Widget _buildRewardItem({
    required RewardItem reward,
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
        _buildRewardIcon(reward.icon),
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

  // 奖励图标
  Widget _buildRewardIcon(String iconName) {
    if (iconName == 'wallet_ic') {
      // 钱包图标
      return Image.asset(AssetsUtils.wallet_ic, width: 40.w);
    } else if (iconName == 'duck_ic') {
      // 小鸭子图标
      return Image.asset(AssetsUtils.duck_ic, width: 40.w);
    } else {
      return Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: toColor("CCCCCC"),
          borderRadius: BorderRadius.circular(8.r),
        ),
      );
    }
  }

  // 操作按钮
  Widget _buildActionButton(RewardItem reward, VoidCallback onTap) {
    if (reward.isCompleted) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: toColor("E8F5E8"),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          'Completed',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: toColor("4CAF50"),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (reward.buttonText == 'Follow') ...[
              Icon(Icons.open_in_new, size: 12.w, color: toColor("#292524")),
              4.horizontalSpace,
            ],
            Text(
              reward.buttonText,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: toColor("#292524"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
