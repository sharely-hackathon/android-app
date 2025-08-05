import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharely/utils/color_utils.dart';
import 'package:sharely/utils/network_image_util.dart';
import 'package:sharely/utils/toast_utils.dart';

class ShareDialog extends StatelessWidget {
  const ShareDialog({
    super.key,
    required this.productTitle,
    required this.productPrice,
    required this.originalPrice,
    required this.rating,
    required this.reviews,
    required this.productImage,
    required this.shareUrl,
  });

  final String productTitle;
  final String productPrice;
  final String originalPrice;
  final String rating;
  final String reviews;
  final String productImage;
  final String shareUrl;

  @override
  Widget build(BuildContext context) => Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 标题栏
        _buildHeader(),

        // 产品图片
        _buildProductImage(productImage),

        // 产品信息
        _buildProductInfo(
          productTitle,
          rating,
          reviews,
          productPrice,
          originalPrice,
        ),

        // 分享链接
        _buildShareLink(shareUrl),

        // 分享选项
        _buildShareOptions(),

        20.verticalSpace,
      ],
    ),
  );

  Widget _buildHeader() => Container(
    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Share Product'.tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: toColor('#292524'),
          ),
        ),
        InkWell(
          onTap: () => dismissLoading(),
          child: Container(
            padding: EdgeInsets.all(4.w),
            child: Icon(Icons.close, color: toColor('#666666'), size: 20.sp),
          ),
        ),
      ],
    ),
  );

  Widget _buildProductImage(String imageUrl) => Container(
    margin: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
    height: 200.h,
    decoration: BoxDecoration(
      color: toColor('#F6F3F3'),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Center(
      child: NetworkImageUtil.loadRoundedImage(
        imageUrl,
        radius: 8.r,
        fit: BoxFit.contain,
        width: 180.w,
        height: 180.h,
      ),
    ),
  );

  Widget _buildProductInfo(
    String title,
    String rating,
    String reviews,
    String price,
    String originalPrice,
  ) => Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: toColor('#292524'),
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        8.verticalSpace,
        Row(
          children: [
            Icon(Icons.star, color: toColor('#292524'), size: 14.sp),
            4.horizontalSpace,
            Text(
              rating,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: toColor('#292524'),
              ),
            ),
            8.horizontalSpace,
            Text(
              '($reviews ${'reviews'.tr})',
              style: TextStyle(fontSize: 14.sp, color: toColor('999999')),
            ),
          ],
        ),
        12.verticalSpace,
        Row(
          children: [
            Text(
              price,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: toColor('FF6B6B'),
              ),
            ),
            8.horizontalSpace,
            Text(
              originalPrice,
              style: TextStyle(
                fontSize: 14.sp,
                color: toColor('999999'),
                decoration: TextDecoration.lineThrough,
              ),
            ).paddingOnly(top: 6.h),
          ],
        ),
      ],
    ),
  );

  Widget _buildShareLink(String shareUrl) => Container(
    margin: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: toColor('#F8F8F8'),
      borderRadius: BorderRadius.circular(20.r),
      border: Border.all(color: toColor('#E5E5E5')),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(
            shareUrl,
            style: TextStyle(fontSize: 14.sp, color: toColor('#292524')),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        8.horizontalSpace,
        InkWell(
          onTap: () {
            Clipboard.setData(ClipboardData(text: shareUrl));
            showToast('Link copied to clipboard');
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 6.h),
            decoration: BoxDecoration(
              color: toColor('#007AFF'),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Copy link',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildShareOptions() => Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildShareOption(
          icon: Icons.download,
          label: 'Download',
          color: toColor('#666666'),
          onTap: () {
            showToast('Download feature coming soon');
          },
        ),
        _buildShareOption(
          icon: Icons.chat,
          label: 'WhatsApp',
          color: toColor('#25D366'),
          onTap: () {
            showToast('WhatsApp share feature coming soon');
          },
        ),
        _buildShareOption(
          icon: Icons.discord,
          label: 'Discord',
          color: toColor('#5865F2'),
          onTap: () {
            showToast('Discord share feature coming soon');
          },
        ),
        _buildShareOption(
          icon: Icons.telegram,
          label: 'Telegram',
          color: toColor('#0088cc'),
          onTap: () {
            showToast('Telegram share feature coming soon');
          },
        ),
      ],
    ),
  );

  Widget _buildShareOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) => InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 24.sp),
        ),
        8.verticalSpace,
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: toColor('#666666')),
        ),
      ],
    ),
  );
}
