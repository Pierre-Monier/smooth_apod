import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../style/app_spacing.dart';
import '../../../../style/app_text_style.dart';
import '../../../../util/opposite_main_content_background_color.dart';
import '../../../../util/main_content_background_color.dart';
import '../../util/apod_overlay_staggering_top.dart';
import '../../util/date_time_helper.dart';
import '../controller/apod_template_controller.dart';

class ApodOverlayInfo extends ConsumerStatefulWidget {
  const ApodOverlayInfo({
    required this.apodDate,
    required this.apodTitleWidget,
    this.apodExplanation,
    super.key,
  });

  final DateTime apodDate;
  final Widget apodTitleWidget;
  // * this is nullable because it can be used in Error or Loading state
  final String? apodExplanation;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ApodOverlayInfoState();
}

class _ApodOverlayInfoState extends ConsumerState<ApodOverlayInfo> {
  final dateKey = GlobalKey<_ApodOverlayInfoState>();
  final titleKey = GlobalKey<_ApodOverlayInfoState>();
  final explanationKey = GlobalKey<_ApodOverlayInfoState>();

  static const _paddingContentValue = AppSpacing.p16;

  double _getContentSizeHeight({
    required Size dateSize,
    required Size titleSize,
    required Size explanationSize,
  }) =>
      dateSize.height +
      titleSize.height +
      explanationSize.height +
      (_paddingContentValue * 2);

  void _updateContentSizeHeight() {
    final dateTextRenderBox =
        dateKey.currentContext?.findRenderObject() as RenderBox?;
    final titleTextRenderBox =
        titleKey.currentContext?.findRenderObject() as RenderBox?;
    final explanationTextRenderBox =
        explanationKey.currentContext?.findRenderObject() as RenderBox?;

    final dateSize = dateTextRenderBox?.size;
    final titleSize = titleTextRenderBox?.size;
    final explanationSize = explanationTextRenderBox?.size;

    if (dateSize != null && titleSize != null && explanationSize != null) {
      final contentSizeHeight = _getContentSizeHeight(
        dateSize: dateSize,
        titleSize: titleSize,
        explanationSize: explanationSize,
      );
      final screenHeight = MediaQuery.of(context).size.height;
      final rawNewInfoContentHeightRatio = contentSizeHeight / screenHeight;

      ref
          .read(apodTemplateProvider.notifier)
          .setInfoContentHeightRatio(rawNewInfoContentHeightRatio);
    }
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _updateContentSizeHeight();
    });
  }

  @override
  void didUpdateWidget(covariant ApodOverlayInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.apodDate != widget.apodDate ||
        oldWidget.apodTitleWidget != widget.apodTitleWidget ||
        oldWidget.apodExplanation != widget.apodExplanation) {
      _updateContentSizeHeight();
    }
  }

  double _getMaxScrollableSize({
    required double screenHeight,
    required double infoContentHeightRatio,
  }) =>
      screenHeight * infoContentHeightRatio;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final apodTemplateState = ref.watch(apodTemplateProvider);

    final maxScrollableSize = _getMaxScrollableSize(
      screenHeight: screenHeight,
      infoContentHeightRatio: apodTemplateState.infoContentHeightRatio,
    );

    return SizedBox(
      height: maxScrollableSize,
      child: Stack(
        children: [
          Positioned(
            top: apodOverlayStaggeringTop,
            right: 0,
            left: 0,
            child: Container(
              // color: Theme.of(context).mainContentBackgroundColor,
              height: maxScrollableSize,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.p16),
            child: Container(
              padding: const EdgeInsets.all(_paddingContentValue),
              color: Theme.of(context).mainContentBackgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    DateTimeHelper.getApodDateLabel(widget.apodDate),
                    key: dateKey,
                    style: AppTextStyle.secondaryInfoTextStyle(
                      context,
                      color:
                          Theme.of(context).oppositeMainContentBackgroundColor,
                    ),
                  ),
                  SizedBox(
                    key: titleKey,
                    child: widget.apodTitleWidget,
                  ),
                  Text(widget.apodExplanation ?? '', key: explanationKey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
