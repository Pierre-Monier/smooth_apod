import 'package:flutter/cupertino.dart';

import '../../../../../style/app_spacing.dart';
import '../../../util/app_duration.dart';
import 'apod_title_dot.dart';

class ApodLoaderDotIndicator extends StatefulWidget {
  const ApodLoaderDotIndicator({super.key});

  @override
  State<ApodLoaderDotIndicator> createState() => _ApodLoaderDotIndicatorState();
}

class _ApodLoaderDotIndicatorState extends State<ApodLoaderDotIndicator>
    with TickerProviderStateMixin {
  late final List<Animation<double>> _animations;
  late final List<AnimationController> _animationControllers;
  int index = 0;

  static const _stackSize = Size(30, 30);

  @override
  void initState() {
    super.initState();
    final tween = Tween(begin: 0.0, end: AppSpacing.p6);
    _animationControllers = List<AnimationController>.generate(3, (index) {
      return AnimationController(
        vsync: this,
        duration: AppDuration.shortDuration,
      );
    });

    _animations = _animationControllers
        .map<Animation<double>>(
          (controller) => tween.animate(
            CurvedAnimation(parent: controller, curve: Curves.bounceInOut),
          ),
        )
        .toList();

    for (final animation in _animations) {
      animation
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _animationControllers[index].reverse();
            if (index < 2) {
              _animationControllers[index + 1].forward();
            }
          } else if (status == AnimationStatus.dismissed) {
            if (index == 2) {
              index = 0;
            } else {
              index++;
            }
            _animationControllers[index].forward();
          }
        });
    }

    _animationControllers[0].forward();
  }

  @override
  void dispose() {
    for (final controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        width: _stackSize.width,
        height: _stackSize.height,
        child: Stack(
          children: [
            Positioned(
              bottom: _animations[0].value,
              child: const ApodTitleDot(),
            ),
            Positioned(
              left: 10,
              bottom: _animations[1].value,
              child: const ApodTitleDot(),
            ),
            Positioned(
              left: 20,
              bottom: _animations[2].value,
              child: const ApodTitleDot(),
            ),
          ],
        ),
      );
}
