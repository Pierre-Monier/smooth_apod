import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ApodOverlayInfoMode {
  regular,
  overscroll,
}

class ApodTemplateState {
  const ApodTemplateState({
    required this.infoContentHeightRatio,
    required this.initialOverlayPosition,
    required this.overlayMode,
    required this.isInFullScreenMode,
  });

  factory ApodTemplateState.initial() => const ApodTemplateState(
        infoContentHeightRatio: _minHeightRatio,
        initialOverlayPosition: _minHeightRatio,
        overlayMode: ApodOverlayInfoMode.regular,
        isInFullScreenMode: false,
      );
  // * this is a ratio of the infoContent height by the Screen height
  // * default is _minHeightRatio
  final double infoContentHeightRatio;

  // * this is the ratio for visualContent height by the Screen height
  // * default and min value are _minHeightRatio
  // * max value is infoContentHeightRatio
  final double initialOverlayPosition;

  final ApodOverlayInfoMode overlayMode;

  final bool isInFullScreenMode;

  static const double _minHeightRatio = 0.15;

  ApodTemplateState copyWith({
    double? infoContentHeightRatio,
    double? initialOverlayPosition,
    ApodOverlayInfoMode? overlayMode,
    bool? isInFullScreenMode,
  }) =>
      ApodTemplateState(
        infoContentHeightRatio:
            infoContentHeightRatio ?? this.infoContentHeightRatio,
        initialOverlayPosition:
            initialOverlayPosition ?? this.initialOverlayPosition,
        overlayMode: overlayMode ?? this.overlayMode,
        isInFullScreenMode: isInFullScreenMode ?? this.isInFullScreenMode,
      );
}

class ApodTemplateController extends StateNotifier<ApodTemplateState> {
  ApodTemplateController() : super(ApodTemplateState.initial());

  final StreamController<void> _shouldUpdateInitialOverlayPosition =
      StreamController.broadcast();

  void onDispose() {
    _shouldUpdateInitialOverlayPosition.close();
  }

  Stream<void> get shouldUpdateInitialOverlayPositionStream =>
      _shouldUpdateInitialOverlayPosition.stream.asBroadcastStream();

  void setInfoContentHeightRatio(double infoContentHeightRatio) {
    // * we add min thresolds of ApodTemplateState._minHeightRatio
    final withMinAndMaxThresholds = infoContentHeightRatio.clamp(
      ApodTemplateState._minHeightRatio,
      1.0,
    );

    state = state.copyWith(infoContentHeightRatio: withMinAndMaxThresholds);
    _shouldUpdateInitialOverlayPosition.sink.add(null);
  }

  double getInitialOverlayPosition(double rawInitialOverlayPosition) {
    final withMinAndMaxThresholds = rawInitialOverlayPosition.clamp(
      ApodTemplateState._minHeightRatio,
      state.infoContentHeightRatio,
    );

    return withMinAndMaxThresholds;
  }

  void setInitialOverlayPosition(double rawInitialOverlayPosition) {
    final initialOverlayPosition = getInitialOverlayPosition(
      rawInitialOverlayPosition,
    );
    state = state.copyWith(initialOverlayPosition: initialOverlayPosition);
  }

  void setApodOverlayMode(ApodOverlayInfoMode newOverlayMode) {
    state = state.copyWith(overlayMode: newOverlayMode);
  }

  void setIsInFullScreenMode({required bool isInFullScreenMode}) {
    state = state.copyWith(isInFullScreenMode: isInFullScreenMode);
  }
}

final apodTemplateProvider = StateNotifierProvider.autoDispose<
    ApodTemplateController, ApodTemplateState>((ref) {
  final apodTemplateController = ApodTemplateController();

  ref.onDispose(apodTemplateController.onDispose);

  return apodTemplateController;
});
