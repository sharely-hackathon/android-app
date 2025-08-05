import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../utils/color_utils.dart';

class VerificationCodeInput extends StatefulWidget {
  final Function(String) onCompleted;
  final Function(String)? onChanged;
  final int length;

  const VerificationCodeInput({
    super.key,
    required this.onCompleted,
    this.onChanged,
    this.length = 6,
  });

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  String code = '';
  List<String> previousValues = [];

  @override
  void initState() {
    super.initState();
    controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    focusNodes = List.generate(
      widget.length,
      (index) => FocusNode(),
    );
    previousValues = List.generate(widget.length, (index) => '');
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _handleBackspace(int index) {
    if (controllers[index].text.isNotEmpty) {
      // 如果当前输入框有内容，清空它
      controllers[index].clear();
      previousValues[index] = '';
    } else if (index > 0) {
      // 如果当前输入框为空，移动到前一个输入框并清空它
      controllers[index - 1].clear();
      previousValues[index - 1] = '';
      focusNodes[index - 1].requestFocus();
    }
    _updateCode();
  }

  void _onChanged(String value, int index) {
    // 只允许输入一个字符
    if (value.length > 1) {
      value = value.substring(value.length - 1);
      controllers[index].text = value;
      controllers[index].selection = TextSelection.fromPosition(
        TextPosition(offset: value.length),
      );
    }

    String previousValue = previousValues[index];
    
    if (value.isNotEmpty && previousValue.isEmpty) {
      // 输入新字符，移动到下一个输入框
      if (index < widget.length - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        // 最后一个输入框，失去焦点
        focusNodes[index].unfocus();
      }
    }
    
    // 更新前一个值
    previousValues[index] = value;

    // 更新完整验证码
    _updateCode();
  }

  void _updateCode() {
    String newCode = '';
    for (var controller in controllers) {
      newCode += controller.text;
    }
    
    code = newCode;
    widget.onChanged?.call(code);
    
    // 如果验证码完整，调用完成回调
    if (code.length == widget.length) {
      widget.onCompleted(code);
    }
  }

  // 添加一个公共方法来清除所有验证码（如果需要从外部调用）
  void clearAll() {
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].clear();
      previousValues[i] = '';
    }
    focusNodes[0].requestFocus();
    _updateCode();
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          widget.length,
          (index) => _buildCodeInput(index),
        ),
      );

  Widget _buildCodeInput(int index) => Container(
        width: 48.w,
        height: 56.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: controllers[index].text.isNotEmpty
                ? toColor('1A1A1A')
                : toColor('E5E5E5'),
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
                  child: Center(
            child: KeyboardListener(
              focusNode: FocusNode(),
              onKeyEvent: (KeyEvent event) {
                if (event is KeyDownEvent) {
                  if (event.logicalKey == LogicalKeyboardKey.backspace) {
                    _handleBackspace(index);
                  }
                }
              },
              child: TextField(
                controller: controllers[index],
                focusNode: focusNodes[index],
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: toColor('1A1A1A'),
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) => _onChanged(value, index),
                onTap: () {
                  // 点击时将光标放到末尾
                  controllers[index].selection = TextSelection.fromPosition(
                    TextPosition(offset: controllers[index].text.length),
                  );
                },
              ),
            ),
          ),
      );
} 