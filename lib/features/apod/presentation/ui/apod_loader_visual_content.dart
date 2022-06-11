import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../util/app_duration.dart';

class ApodLoaderVisualContent extends StatefulWidget {
  const ApodLoaderVisualContent({super.key});

  @override
  State<StatefulWidget> createState() => _ApodLoaderVisualContentState();
}

class _ApodLoaderVisualContentState extends State<ApodLoaderVisualContent>
    with TickerProviderStateMixin {
  late final Animation<double> _animation;
  late final AnimationController _controller;

  @override
  void initState() {
    final tween = Tween(begin: 0.0, end: 1.0);

    _controller = AnimationController(
      vsync: this,
      duration: AppDuration.longDuration,
    );

    _animation = tween.animate(
      _controller,
    );

    _controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight,
      child: Lottie.asset(
        'assets/animation/loader_lottie.json',
        repeat: true,
        alignment: Alignment.topCenter,
        controller: _animation,
      ),
    );
  }
}
