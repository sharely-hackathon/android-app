import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

showLoading({String msg = 'Loading...'}) {
  SmartDialog.showLoading(
    msg: msg,
    maskColor: Colors.transparent,
    clickMaskDismiss: true,
  );
}

dismissLoading({
  var result,
  SmartStatus status = SmartStatus.smart,
}) async {
  return await SmartDialog.dismiss(
    result: result,
    status: status,
  );
}

Future<void> showToast(var msg, {Duration? duration}) async {
  return SmartDialog.showToast(msg, displayTime: duration);
}

showSuccess(var msg, {Duration? duration}) {
  return SmartDialog.showNotify(
    msg: msg,
    notifyType: NotifyType.success,
    displayTime: duration,
  );
}

showInfo(var msg, {Duration? duration}) {
  SmartDialog.showNotify(
    msg: msg,
    notifyType: NotifyType.warning,
    animationTime: duration,
  );
}

showError(var msg, {Duration? duration}) {
  SmartDialog.showNotify(
    msg: msg,
    notifyType: NotifyType.error,
    displayTime: duration,
  );
}

showCustom(
  Widget widget, {
  bool clickMaskDismiss = false,
  Alignment? alignment,
  Color? maskColor,
  // 点击事件是否穿透
  bool usePenetrate = false,
  VoidCallback? onDismiss,
  SmartBackType? backType,
  String? tag,
  bool? bindPage,
}) async {
  return await SmartDialog.show(
    tag: tag,
    bindPage: bindPage,
    builder: (builder) => widget,
    clickMaskDismiss: clickMaskDismiss,
    alignment: alignment,
    maskColor: maskColor,
    usePenetrate: usePenetrate,
    onDismiss: onDismiss,
    backType: backType,
  );
}

showAttach(
  Widget widget, {
  required BuildContext targetContext,
  bool clickMaskDismiss = true,
  Alignment? alignment,
  Color? maskColor,
}) async {
  return SmartDialog.showAttach(
    builder: (builder) => widget,
    clickMaskDismiss: clickMaskDismiss,
    alignment: alignment,
    targetContext: targetContext,
    maskColor: maskColor,
  );
}
