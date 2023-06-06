import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedCheck extends StatefulWidget {
  final bool condition;
  final String lottieFile;

  const AnimatedCheck({super.key, required this.condition, required this.lottieFile});

  @override
  MyLottieAnimationState createState() => MyLottieAnimationState();
}

class MyLottieAnimationState extends State<AnimatedCheck>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void didUpdateWidget(AnimatedCheck oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.condition != oldWidget.condition) {
      if (widget.condition) {
        _animationController.animateTo(0.5,
            duration: const Duration(milliseconds: 500));
      } else {
        _animationController.animateTo(1.0,
            duration: const Duration(milliseconds: 500));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      widget.lottieFile,
      width: 200,
      height: 200,
      animate: true,
      frameRate: FrameRate.max,
      controller: _animationController,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
