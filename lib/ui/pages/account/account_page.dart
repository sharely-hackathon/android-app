import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../base/base_scaffold.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/network_image_util.dart';
import '../../../main.dart';
import 'account_controller.dart';
import 'shipping_address/shipping_address_page.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});

  final controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) => BaseScaffold(
        title: 'Account settings'.tr,
        body: Obx(() => _buildContent()),
      );

  Widget _buildContent() => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBasicInformation(),
            _buildSocialMedia(),
          ],
        ),
      );

  Widget _buildBasicInformation() => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic information'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: toColor('9E9E9E'),
              ),
            ),
            24.verticalSpace,
            _buildEmailItem(),
            24.verticalSpace,
            _buildMobileItem(),
            24.verticalSpace,
            _buildAvatarItem(),
            24.verticalSpace,
            _buildShippingAddressItem(),
            32.verticalSpace,
          ],
        ),
      );

  Widget _buildEmailItem() => _buildInfoItem(
        title: 'Email'.tr,
        value: controller.userEmail.value,
        onTap: controller.editEmail,
      );

  Widget _buildMobileItem() => _buildInfoItem(
        title: 'Mobile'.tr,
        value: controller.userMobile.value,
        onTap: controller.editMobile,
      );

  Widget _buildAvatarItem() => InkWell(
        onTap: controller.editAvatar,
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Avatar'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: toColor('1A1A1A'),
                ),
              ),
            ),
            NetworkImageUtil.loadCircleImage(
              controller.userAvatar.value,
              size: 32.r,
              fit: BoxFit.cover,
            ),
          ],
        ),
      );

  Widget _buildShippingAddressItem() => _buildInfoItem(
        title: 'Shipping address'.tr,
        value: '',
        onTap: controller.editShippingAddress,
        showValue: false,
      );

  Widget _buildSocialMedia() => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Social media'.tr,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: toColor('9E9E9E'),
              ),
            ),
            24.verticalSpace,
            _buildSocialMediaItem('X', controller.xAccount.value, controller.editXAccount),
            // 24.verticalSpace,
            // _buildSocialMediaItem('Discord'.tr.tr, controller.discordAccount.value, controller.editDiscordAccount),
            24.verticalSpace,
            _buildSocialMediaItem('Telegram'.tr, controller.telegramAccount.value, controller.editTelegramAccount),
          ],
        ),
      );

  Widget _buildSocialMediaItem(String title, String value, VoidCallback onTap) => _buildInfoItem(
        title: title,
        value: value,
        onTap: onTap,
      );

  Widget _buildInfoItem({
    required String title,
    required String value,
    required VoidCallback onTap,
    bool showValue = true,
  }) => InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: toColor('1A1A1A'),
              ),
            ),
            Spacer(),
            if (showValue && value.isNotEmpty)
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: toColor('#79716B'),
                ),
              ),
            8.horizontalSpace,
            Icon(
              Icons.arrow_forward_ios,
              size: 12.r,
              color: toColor('9E9E9E'),
            ),
          ],
        ),
      );
} 