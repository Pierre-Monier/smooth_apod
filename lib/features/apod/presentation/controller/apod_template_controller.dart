import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApodTemplateState {
  const ApodTemplateState({
    required this.infoContentHeightRatio,
    required this.initialOverlayPosition,
  });

  factory ApodTemplateState.initial() => const ApodTemplateState(
        infoContentHeightRatio: _minHeightRatio,
        initialOverlayPosition: _minHeightRatio,
      );
  // * this is a ratio of the infoContent height by the Screen height
  // * default is _minHeightRatio
  final double infoContentHeightRatio;

  // * this is the ratio for visualContent height by the Screen height
  // * default and min value are _minHeightRatio
  // * max value is infoContentHeightRatio
  final double initialOverlayPosition;

  static const double _minHeightRatio = 0.15;

  ApodTemplateState copyWith({
    double? infoContentHeightRatio,
    double? initialOverlayPosition,
  }) =>
      ApodTemplateState(
        infoContentHeightRatio:
            infoContentHeightRatio ?? this.infoContentHeightRatio,
        initialOverlayPosition:
            initialOverlayPosition ?? this.initialOverlayPosition,
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
}

final apodTemplateProvider = StateNotifierProvider.autoDispose<
    ApodTemplateController, ApodTemplateState>((ref) {
  final apodTemplateController = ApodTemplateController();

  ref.onDispose(apodTemplateController.onDispose);

  return apodTemplateController;
});
