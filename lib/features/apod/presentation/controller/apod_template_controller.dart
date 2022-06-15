import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'apod_overlay_info_mode.dart';
import 'apod_template_state.dart';

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
      ApodTemplateState.minHeightRatio,
      1.0,
    );

    state = state.copyWith(infoContentHeightRatio: withMinAndMaxThresholds);
    _shouldUpdateInitialOverlayPosition.sink.add(null);
  }

  double getInitialOverlayPosition(double rawInitialOverlayPosition) {
    final withMinAndMaxThresholds = rawInitialOverlayPosition.clamp(
      ApodTemplateState.minHeightRatio,
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
