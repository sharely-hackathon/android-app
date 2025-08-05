import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:sharely/utils/assets_utils.dart';

import '../../../utils/color_utils.dart';
import '../../../utils/network_image_util.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUserProfile(controller),
        20.verticalSpace,
        _buildMenuItems(controller),
      ],
    );
  }

  Widget _buildUserProfile(ProfileController controller) => SafeArea(
    child: Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.only(top: 20.h),
      child: Row(
        children: [
          Obx(
            () => NetworkImageUtil.loadCircleImage(
              "${controller.profileModel.value?.metadata?.avatar}",
              size: 40.r,
              fit: BoxFit.cover,
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    controller.profileModel.value?.lastName ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: toColor('1A1A1A'),
                    ),
                  ),
                ),
                4.verticalSpace,
                Row(
                  children: [
                    Obx(
                      () => Text(
                        controller.profileModel.value?.email ?? '',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: toColor('6B7280'),
                        ),
                      ),
                    ),
                    if (controller.profileModel.value?.metadata?.verified ==
                        true) ...[
                      8.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.w,
                        ),
                        decoration: BoxDecoration(
                          color: toColor('#F0F9F2'),
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                        child: Text(
                          'verified'.tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: toColor('22C55E'),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (controller.hasNotification.value)
            badges.Badge(
              showBadge: true,
              position: badges.BadgePosition.topEnd(top: 2.h, end: 1.w),
              child: Icon(Icons.notifications_none_sharp, size: 24.r),
            ),
        ],
      ),
    ),
  );

  Widget _buildMenuItems(ProfileController controller) => Column(
    children: [
      _buildMenuItem(
        icon: AssetsUtils.user_ic,
        title: 'Account settings'.tr,
        onTap: controller.onAccountSettingsTap,
      ),
      _buildMenuItem(
        icon: AssetsUtils.points_ic,
        title: 'Points'.tr,
        onTap: controller.onPointsTap,
      ),
      _buildMenuItem(
        icon: AssetsUtils.payment_ic,
        title: 'Payment'.tr,
        rightTextDesc: AssetsUtils.payment_desc_ic,
        onTap: controller.onPaymentTap,
      ),
      _buildMenuItem(
        icon: AssetsUtils.distribution_ic,
        title: 'Distribution'.tr,
        onTap: controller.onDistributionTap,
      ),
      _buildMenuItem(
        icon: AssetsUtils.follow_ic,
        title: 'Follow @sharely'.tr,
        onTap: controller.onFollowSharelyTap,
      ),
      _buildMenuItem(
        icon: AssetsUtils.language_ic,
        title: 'English'.tr,
        onTap: controller.switchLanguage,
      ),
      _buildMenuItem(
        icon: AssetsUtils.logout_ic,
        title: 'Sign out'.tr,
        titleColor: toColor('EF4444'),
        onTap: controller.onSignOutTap,
      ),
    ],
  );

  Widget _buildMenuItem({
    required String icon,
    required String title,
    Color? titleColor,
    String? rightTextDesc,
    required VoidCallback onTap,
  }) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16.w),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 24.w),
          16.horizontalSpace,
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: titleColor ?? toColor('374151'),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (rightTextDesc != null) ...[
            6.horizontalSpace,
            SvgPicture.asset(rightTextDesc, height: 12.h),
          ],
        ],
      ),
    ),
  );
}
