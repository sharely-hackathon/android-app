import 'dart:math' as math show sin, pi;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingWidget extends StatefulWidget {
  const CustomLoadingWidget({
    super.key,
    required this.color,
    required this.size,
    required this.msg,
    this.backgroundColor = Colors.black,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1200),
    this.controller,
  }) : assert(
            !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
                !(itemBuilder == null && color == null),
            'You should specify either a itemBuilder or a color');

  final Color color;
  final Color backgroundColor;
  final double size;
  final IndexedWidgetBuilder? itemBuilder;
  final Duration duration;
  final AnimationController? controller;
  final String msg;

  @override
  State<CustomLoadingWidget> createState() => _CustomLoadingWidgetState();
}

class _CustomLoadingWidgetState extends State<CustomLoadingWidget>
    with SingleTickerProviderStateMixin {
  final List<double> delays = [
    .0,
    -1.1,
    -1.0,
    -0.9,
    -0.8,
    -0.7,
    -0.6,
    -0.5,
    -0.4,
    -0.3,
    -0.2,
    -0.1
  ];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = (widget.controller ??
        AnimationController(vsync: this, duration: widget.duration))
      ..repeat();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: EdgeInsets.all(10.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.fromSize(
              size: Size.square(widget.size),
              child: Stack(
                children: List.generate(12, (i) {
                  final position = widget.size * .5;
                  return Positioned.fill(
                    left: position,
                    top: position,
                    child: Transform(
                      transform: Matrix4.rotationZ(30.0 * i * 0.0174533),
                      child: Align(
                        alignment: Alignment.center,
                        child: FadeTransition(
                          opacity:
                              DelayTween(begin: 0.0, end: 1.0, delay: delays[i])
                                  .animate(_controller),
                          child: SizedBox.fromSize(
                              size: Size.square(widget.size * 0.15),
                              child: _itemBuilder(i)),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            10.verticalSpace,
            Text(
              widget.msg,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => widget.itemBuilder != null
      ? widget.itemBuilder!(context, index)
      : DecoratedBox(
          decoration:
              BoxDecoration(color: widget.color, shape: BoxShape.circle));
}

class DelayTween extends Tween<double> {
  DelayTween({double? begin, double? end, required this.delay})
      : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) =>
      super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
