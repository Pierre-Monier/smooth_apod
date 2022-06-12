import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../style/app_spacing.dart';
import '../../../../style/app_text_style.dart';
import '../../../../util/opposite_main_content_background_color.dart';
import '../../../../util/main_content_background_color.dart';
import '../../util/apod_overlay_staggering_top.dart';
import '../../util/app_duration.dart';
import '../../util/date_time_helper.dart';
import '../controller/apod_template_controller.dart';
import 'apod_persistent_header_delegate.dart';
import 'apod_title.dart';

class ApodOverlayInfo extends ConsumerStatefulWidget {
  const ApodOverlayInfo({
    required this.apodDate,
    required this.scrollController,
    required this.apodTitle,
    this.apodTitleWidget,
    this.apodExplanation,
    this.apodCopyright,
    super.key,
  });

  final DateTime apodDate;
  final Widget? apodTitleWidget;

  /// this is required even if we pass apodTitleWidget parameter because we
  /// need it to calculate header height
  final String apodTitle;

  /// this is nullable because it can be used in Error or Loading state
  final String? apodExplanation;
  final String? apodCopyright;
  final ScrollController scrollController;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ApodOverlayInfoState();
}

class _ApodOverlayInfoState extends ConsumerState<ApodOverlayInfo> {
  final _dateKey = GlobalKey<_ApodOverlayInfoState>();
  final _titleKey = GlobalKey<_ApodOverlayInfoState>();
  final _explanationKey = GlobalKey<_ApodOverlayInfoState>();

  static const _paddingContentValue = AppSpacing.p16;

  /// we don't use AppSpacing.gapH16 because we are calulating height based on
  /// _paddingContentValue, if we change this variable everything will still
  /// work
  static const _heightSpacing = SizedBox(height: _paddingContentValue);
  static const _animationCurve = Curves.fastOutSlowIn;

  double _getContentSizeHeight({
    required Size dateSize,
    required Size titleSize,
    required Size explanationSize,
  }) =>
      dateSize.height +
      titleSize.height +
      explanationSize.height +
      // * we multi by 4 for we have top and bottom padding + two _heightSpacing
      // * widgets
      (_paddingContentValue * 4);

  void _updateContentSizeHeight() {
    final dateTextRenderBox =
        _dateKey.currentContext?.findRenderObject() as RenderBox?;
    final titleTextRenderBox =
        _titleKey.currentContext?.findRenderObject() as RenderBox?;
    final explanationTextRenderBox =
        _explanationKey.currentContext?.findRenderObject() as RenderBox?;

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

  Widget get _titleWidget => SizedBox(
        key: _titleKey,
        child: widget.apodTitleWidget ??
            ApodTitle(
              apodTitle: widget.apodTitle,
            ),
      );

  Widget get _explanationWidget => Text(
        widget.apodExplanation ?? '',
        style: AppTextStyle.bodyTextStyle(context),
        key: _explanationKey,
      );

  Widget get _dateWidget {
    String text = DateTimeHelper.getApodDateLabel(widget.apodDate);

    if (widget.apodCopyright != null) {
      text += ', ©${widget.apodCopyright}';
    }

    return Text(
      text,
      key: _dateKey,
      style: AppTextStyle.secondaryInfoTextStyle(
        context,
        color: Theme.of(context).oppositeMainContentBackgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final apodTemplateState = ref.watch(apodTemplateProvider);

    final maxScrollableSize = _getMaxScrollableSize(
      screenHeight: screenHeight,
      infoContentHeightRatio: apodTemplateState.infoContentHeightRatio,
    );

    return Stack(
      children: [
        Positioned(
          top: apodOverlayStaggeringTop,
          right: 0,
          left: 0,
          child: Container(
            height: maxScrollableSize,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        AnimatedPadding(
          curve: _animationCurve,
          duration: AppDuration.shortDuration,
          padding: apodTemplateState.overlayMode == ApodOverlayInfoMode.regular
              ? const EdgeInsets.symmetric(horizontal: _paddingContentValue)
              : EdgeInsets.zero,
          child: AnimatedContainer(
            curve: _animationCurve,
            duration: AppDuration.shortDuration,
            height: maxScrollableSize,
            padding:
                apodTemplateState.overlayMode == ApodOverlayInfoMode.regular
                    ? const EdgeInsets.all(_paddingContentValue)
                    : const EdgeInsets.fromLTRB(
                        _paddingContentValue * 2,
                        _paddingContentValue,
                        _paddingContentValue * 2,
                        _paddingContentValue,
                      ),
            color: Theme.of(context).mainContentBackgroundColor,
            child: CustomScrollView(
              controller: widget.scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: _dateWidget,
                ),
                const SliverToBoxAdapter(
                  child: _heightSpacing,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: ApodPersistentHeaderDelegate(
                    text: widget.apodTitle,
                    textStyle: AppTextStyle.titleTextStyle(
                      context,
                    ),
                    maxWidth: MediaQuery.of(context).size.width -
                        (_paddingContentValue * 2),
                    child: ColoredBox(
                      color: Theme.of(context).mainContentBackgroundColor,
                      child: _titleWidget,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: _heightSpacing,
                ),
                SliverToBoxAdapter(
                  child: _explanationWidget,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
