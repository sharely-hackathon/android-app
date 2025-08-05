import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sharely/base/base_scaffold.dart';
import 'package:sharely/ui/pages/message/message_controller.dart';
import 'package:sharely/utils/color_utils.dart';
import 'package:sharely/utils/network_image_util.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MessageController());

    return BaseScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Messages'.tr,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isDataLoad.value
            ? _buildLoadingWidget()
            : _buildMessageList(controller),
      ),
    );
  }

  Widget _buildLoadingWidget() =>
      Center(child: CircularProgressIndicator(color: toColor("98DEFE")));

  Widget _buildMessageList(MessageController controller) => ListView.separated(
    padding: EdgeInsets.all(6.w),
    itemCount: controller.messageList.length,
    separatorBuilder: (context, index) => 0.verticalSpace,
    itemBuilder: (context, index) {
      final message = controller.messageList[index];
      return _buildMessageItem(message, controller);
    },
  );

  Widget _buildMessageItem(
    MessageModel message,
    MessageController controller,
  ) => Container(
    padding: EdgeInsets.all(16.w),
    child: Row(
      children: [
        _buildAvatar(message.avatar),
        12.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNameRow(message),
              _buildMessageText(message),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildAvatar(String avatarUrl) => NetworkImageUtil.loadCircleImage(
    avatarUrl,
    size: 40.r,
    fit: BoxFit.cover,
  );

  Widget _buildNameRow(MessageModel message) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        message.name,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      if (!message.isRead)
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: toColor("FF6B6B"),
            shape: BoxShape.circle,
          ),
        ),
    ],
  );

  Widget _buildMessageText(MessageModel message) => Text(
    message.message,
    style: TextStyle(fontSize: 12.sp, color: toColor("888888")),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}
