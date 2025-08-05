import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/color_utils.dart';

class BaseScaffold extends StatelessWidget {
  final String? title;
  Color? backgroundColor;
  Color? backColor;
  Color? titleColor;
  final Color? appBarBackgroundColor;
  final List<Widget>? actions;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final bool centerTitle;
  final Function? onBack;
  final PreferredSizeWidget? appBar;

  BaseScaffold({
    super.key,
    this.title,
    this.backgroundColor,
    this.backColor,
    this.titleColor,
    this.appBarBackgroundColor,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.onBack,
    this.appBar,
    this.resizeToAvoidBottomInset = true,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus(); // 关闭键盘
      },
      child: Scaffold(
        backgroundColor: backgroundColor ?? toColor('F5F5F5'),
        appBar: appBar ??
            AppBar(
              backgroundColor: appBarBackgroundColor ?? Colors.white,
              leading: InkWell(
                onTap: () => onBack?.call() ?? Get.back(),
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: backColor ?? toColor("3d3d3d"),
                ),
              ),
              elevation: 0,
              scrolledUnderElevation: 0,// 滚动时无阴影，解决白色的背景appbar滚动时候会变成灰色的
              title: Text(
                title ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: titleColor ?? toColor("3d3d3d"),
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: actions,
              centerTitle: centerTitle,
            ),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        body: body,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
