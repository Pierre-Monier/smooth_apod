import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../util/apod_overlay_staggering_top.dart';
import '../controller/apod_template_controller.dart';

class ApodTemplate extends ConsumerStatefulWidget {
  const ApodTemplate({
    required this.visualContent,
    required this.infoContent,
    super.key,
  });

  final Widget visualContent;
  final Widget infoContent;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ApodTemplateState();
}

class _ApodTemplateState extends ConsumerState<ApodTemplate> {
  final _visualContentKey = GlobalKey<_ApodTemplateState>();
  final _scrollController = DraggableScrollableController();

  static const _animationDuration = Duration(milliseconds: 600);

  double? _getInitialOverlayPosition() {
    final visualContentRenderBox =
        _visualContentKey.currentContext?.findRenderObject() as RenderBox?;

    final visualContentSize = visualContentRenderBox?.size;

    if (visualContentSize != null) {
      final screenHeight = MediaQuery.of(context).size.height;
      // * we add apodOverlayStaggeringTop to make the overlay render over
      // * the visual content
      final rawInitialOverlayPosition = 1 -
          ((visualContentSize.height - apodOverlayStaggeringTop) /
              screenHeight);

      return ref
          .read(apodTemplateProvider.notifier)
          .getInitialOverlayPosition(rawInitialOverlayPosition);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    ref
        .read(apodTemplateProvider.notifier)
        .shouldUpdateInitialOverlayPositionStream
        .listen((_) {
      final initialOverlayPosition = _getInitialOverlayPosition();
      if (initialOverlayPosition != null) {
        _scrollController.animateTo(
          initialOverlayPosition,
          curve: Curves.fastOutSlowIn,
          duration: _animationDuration,
        );
        Future.delayed(_animationDuration, () {
          ref
              .read(apodTemplateProvider.notifier)
              .setInitialOverlayPosition(initialOverlayPosition);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final apodTemplateState = ref.watch(apodTemplateProvider);

    return Stack(
      children: [
        SizedBox(key: _visualContentKey, child: widget.visualContent),
        DraggableScrollableSheet(
          controller: _scrollController,
          initialChildSize: apodTemplateState.initialOverlayPosition,
          minChildSize: apodTemplateState.initialOverlayPosition,
          maxChildSize: apodTemplateState.infoContentHeightRatio,
          builder: ((context, scrollController) => SingleChildScrollView(
                controller: scrollController,
                child: SizedBox(
                  child: widget.infoContent,
                ),
              )),
        ),
      ],
    );
  }
}
