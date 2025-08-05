import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../base/base_scaffold.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/assets_utils.dart';
import '../../../utils/network_image_util.dart';
import 'rewards_controller.dart';

class RewardsPage extends StatelessWidget {
  RewardsPage({super.key});

  final controller = Get.put(RewardsController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: toColor("F7F7F7"),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Rewards pool'.tr,
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
            children: [
              20.verticalSpace,
              Obx(
                () => Column(
                  children: controller.rewardPools
                      .map((pool) => _buildRewardPoolCard(pool, controller))
                      .toList(),
                ),
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  // 奖励池卡片
  Widget _buildRewardPoolCard(
    RewardPoolItem pool,
    RewardsController controller,
  ) => Container(
    margin: EdgeInsets.only(bottom: 24.h),
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCardHeader(pool),
        20.verticalSpace,
        _buildPriceInfo(pool),
        16.verticalSpace,
        _buildProgressSection(pool),
        20.verticalSpace,
        _buildParticipantsInfo(pool),
        16.verticalSpace,
        _buildCountdownSection(pool),
        20.verticalSpace,
        _buildUnlockButton(pool, controller),
      ],
    ),
  );

  // 卡片头部
  Widget _buildCardHeader(RewardPoolItem pool) => Row(
    children: [
      _buildLogo(pool.logo),
      10.horizontalSpace,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pool.title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            4.verticalSpace,
            Text(
              pool.brand,
              style: TextStyle(fontSize: 14.sp, color: toColor("666666")),
            ),
          ],
        ),
      ),
      _buildStatusBadge(pool),
    ],
  );

  // Logo组件
  Widget _buildLogo(String logo) => Container(
    width: 40.w,
    height: 40.w,
    decoration: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Center(
      child: SvgPicture.asset(logo, width: 34.w, height: 34.w),
    ),
  );

  // 状态徽章
  Widget _buildStatusBadge(RewardPoolItem pool) {
    if (pool.isOfficial) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: toColor("FFF3E0"),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Text(
          'Official',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: toColor("FF9800"),
          ),
        ),
      );
    } else if (pool.isHot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: toColor("FFF3E0"),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.local_fire_department,
              size: 16.w,
              color: toColor("FF5722"),
            ),
            4.horizontalSpace,
            Text(
              'Hot',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: toColor("FF5722"),
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }

  // 价格信息
  Widget _buildPriceInfo(RewardPoolItem pool) => Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total price',
            style: TextStyle(fontSize: 14.sp, color: toColor("666666")),
          ),
          Text(
            '\$${_formatNumber(pool.totalPrice)}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
      8.verticalSpace,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            pool.goalLabel,
            style: TextStyle(fontSize: 14.sp, color: toColor("666666")),
          ),
          Text(
            pool.goalUnit.isEmpty
                ? '\$${_formatNumber(pool.goalAmount)}'
                : '${_formatNumber(pool.goalAmount)} ${pool.goalUnit}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    ],
  );

  // 进度条部分
  Widget _buildProgressSection(RewardPoolItem pool) => Column(
    children: [
      // 当前进度数值
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        color: Colors.black,
        child: Text(
          pool.goalUnit.isEmpty
              ? '\$${_formatNumber(pool.currentAmount)}'
              : _formatNumber(pool.currentAmount),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      8.verticalSpace,
      // 进度条
      Stack(
        children: [
          Container(
            width: 1.sw,
            height: 8.h,
            decoration: BoxDecoration(
              color: toColor("#FEF3F2"),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          Container(
            width: 1.sw * pool.progress,
            height: 8.h,
            decoration: BoxDecoration(
              color: toColor("#F65B52"),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
      8.verticalSpace,
      // 进度范围
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '0',
            style: TextStyle(fontSize: 14.sp, color: toColor("999999")),
          ),
          Text(
            pool.goalUnit.isEmpty
                ? '\$${_formatNumber(pool.goalAmount)}'
                : _formatNumber(pool.goalAmount),
            style: TextStyle(fontSize: 14.sp, color: toColor("999999")),
          ),
        ],
      ),
    ],
  );

  // 参与者信息
  Widget _buildParticipantsInfo(RewardPoolItem pool) => Row(
    children: [
      // 头像列表
      SizedBox(
        width: (pool.avatars.take(5).length * 20 + 12).w,
        height: 32.w,
        child: Stack(
          children: List.generate(
            pool.avatars.take(5).length,
            (index) => Positioned(
              left: index * 20.0.w,
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: NetworkImageUtil.loadRoundedImage(
                  pool.avatars[index],
                  width: 28.w,
                  height: 28.w,
                  fit: BoxFit.cover,
                  radius: 14.r,
                ),
              ),
            ),
          ),
        ),
      ),
      12.horizontalSpace,
      Text(
        '${_formatNumber(pool.joinedCount)} joined',
        style: TextStyle(fontSize: 14.sp, color: toColor("#292524")),
      ),
    ],
  );

  // 倒计时部分
  Widget _buildCountdownSection(RewardPoolItem pool) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Ends in',
        style: TextStyle(fontSize: 12.sp, color: toColor("666666")),
      ),
      8.verticalSpace,
      Obx(() => Text(
        pool.formattedTime.value,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      )),
    ],
  );

  // 解锁按钮
  Widget _buildUnlockButton(
    RewardPoolItem pool,
    RewardsController controller,
  ) => GestureDetector(
    onTap: () => controller.unlockRewards(pool),
    child: Container(
      width: 1.sw,
      height: 44.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Center(
        child: Text(
          'Unlock rewards',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );

  // 格式化数字（添加千位分隔符）
  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}
