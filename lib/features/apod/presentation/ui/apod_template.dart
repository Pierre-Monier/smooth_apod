import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../util/apod_overlay_staggering_top.dart';
import '../../util/apod_ui_type.dart';
import '../../util/app_duration.dart';
import '../controller/apod_template_controller.dart';

class ApodTemplate extends ConsumerStatefulWidget {
  const ApodTemplate({
    required this.infoContent,
    required this.type,
    this.visualContent,
    this.visualContentBuilder,
    super.key,
  }) : assert(
          visualContent != null || visualContentBuilder != null,
          'Either visualContent or visualContentBuilder must be provided',
        );

  final Widget? visualContent;
  final Widget Function(
    BuildContext context,
    void Function() onVisualContentLoaded,
    Key key,
  )? visualContentBuilder;
  final Widget infoContent;
  final ApodUIType type;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ApodTemplateState();
}

class _ApodTemplateState extends ConsumerState<ApodTemplate> {
  final _visualContentKey = GlobalKey<_ApodTemplateState>();
  final _scrollController = DraggableScrollableController();

  static const _animationDuration = AppDuration.mediumDuration;

  double? _getInitialOverlayPosition() {
    final visualContentRenderBox =
        _visualContentKey.currentContext?.findRenderObject() as RenderBox?;

    final visualContentSize = visualContentRenderBox?.size;

    if (visualContentSize != null) {
      final screenHeight = MediaQuery.of(context).size.height;

      // * we force visualContentSize because if visualContentHeight is null
      // * that means that visualContentSize is not null
      final visualContentHeight = visualContentSize.height;

      // * we add apodOverlayStaggeringTop to make the overlay render over
      // * the visual content
      final rawInitialOverlayPosition =
          1 - ((visualContentHeight - apodOverlayStaggeringTop) / screenHeight);

      return ref
          .read(apodTemplateProvider.notifier)
          .getInitialOverlayPosition(rawInitialOverlayPosition);
    }
    return null;
  }

  void _updateInitialOverlayPosition() {
    final initialOverlayPosition = _getInitialOverlayPosition();
    if (initialOverlayPosition != null) {
      _scrollController.animateTo(
        initialOverlayPosition,
        curve: Curves.fastOutSlowIn,
        duration: _animationDuration,
      );
      Future.delayed(_animationDuration, () {
        if (mounted) {
          ref
              .read(apodTemplateProvider.notifier)
              .setInitialOverlayPosition(initialOverlayPosition);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.type != ApodUIType.data) {
      ref
          .read(apodTemplateProvider.notifier)
          .shouldUpdateInitialOverlayPositionStream
          .listen((_) {
        _updateInitialOverlayPosition();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final apodTemplateState = ref.watch(apodTemplateProvider);

    return Stack(
      children: [
        if (widget.visualContent != null)
          SizedBox(key: _visualContentKey, child: widget.visualContent),
        if (widget.visualContentBuilder != null)
          widget.visualContentBuilder!(
            context,
            _updateInitialOverlayPosition,
            _visualContentKey,
          ),
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
