import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../base/base_scaffold.dart';
import '../../../../models/points_history_model.dart';
import '../../../../utils/color_utils.dart';
import '../../../../utils/assets_utils.dart';
import 'point_history_controller.dart';

class PointHistoryPage extends StatelessWidget {
  PointHistoryPage({super.key});

  final controller = Get.put(PointHistoryController());

  @override
  Widget build(BuildContext context) => BaseScaffold(
    backgroundColor: Colors.white,
    title: 'Point history'.tr,
    body: Obx(
      () => controller.isDataLoad.value ? Container() : _buildHistoryList(),
    ),
  );

  // 积分历史列表
  Widget _buildHistoryList() => Obx(
    () => controller.pointsHistoryModel.value?.transactions.isEmpty == true
        ? _buildEmptyWidget()
        : RefreshIndicator(
            onRefresh: () async => controller.refreshData(),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemCount:
                  controller.pointsHistoryModel.value?.transactions.length,
              itemBuilder: (context, index) => _buildHistoryItem(
                controller.pointsHistoryModel.value?.transactions[index],
              ),
            ),
          ),
  );

  // 空数据组件
  Widget _buildEmptyWidget() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.history, size: 64.w, color: toColor('CCCCCC')),
        20.verticalSpace,
        Text(
          'No point history yet',
          style: TextStyle(fontSize: 16.sp, color: toColor('999999')),
        ),
      ],
    ),
  );

  // 历史记录项
  Widget _buildHistoryItem(Transaction? item) => Container(
    margin: EdgeInsets.only(bottom: 16.h),
    child: Row(
      children: [
        _buildTaskIcon(),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item?.description ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              4.verticalSpace,
              Text(
                controller.formatDateTime(item?.createdAt),
                style: TextStyle(fontSize: 12.sp, color: toColor('999999')),
              ),
            ],
          ),
        ),
        _buildPointsText(item),
      ],
    ),
  );

  // 任务图标
  Widget _buildTaskIcon() => Container(
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      color: toColor('#F65B52'),
      borderRadius: BorderRadius.circular(50.r),
    ),
    child: SvgPicture.asset(
      AssetsUtils.points_ic,
      width: 24.w,
      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
    ),
  );

  // 积分文本
  Widget _buildPointsText(Transaction? item) => Text(
    '+${item?.points} Points',
    style: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: toColor('#F65B52'),
    ),
  );
}
