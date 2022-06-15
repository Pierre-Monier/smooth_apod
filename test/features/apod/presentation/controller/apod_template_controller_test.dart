import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_apod/features/apod/presentation/controller/apod_overlay_info_mode.dart';
import 'package:smooth_apod/features/apod/presentation/controller/apod_template_controller.dart';
import 'package:smooth_apod/features/apod/presentation/controller/apod_template_state.dart';

void main() {
  test(
      '''
    it can update content height ratio with thresholds and emits events 
    on shouldUpdateInitialOverlayPositionStream when it's done
  ''',
      () async {
    final controller = ApodTemplateController();

    expectLater(
      controller.stream.map<double>((state) => state.infoContentHeightRatio),
      emitsInOrder([0.5, ApodTemplateState.minHeightRatio, 1.0]),
    );

    expectLater(
      controller.shouldUpdateInitialOverlayPositionStream,
      emitsInOrder([
        null,
        null,
        null,
      ]),
    );

    controller
      ..setInfoContentHeightRatio(0.5)
      ..setInfoContentHeightRatio(ApodTemplateState.minHeightRatio - 0.05)
      ..setInfoContentHeightRatio(1.25);
  });

  test('it can update initial overlay position with thresolds', () {
    const infoContentHeightRatio = 0.5;
    final controller = ApodTemplateController()
      // * set up max threshold
      ..setInfoContentHeightRatio(infoContentHeightRatio);

    expectLater(
      controller.stream.map<double>((state) => state.initialOverlayPosition),
      emitsInOrder(
        [0.25, ApodTemplateState.minHeightRatio, infoContentHeightRatio],
      ),
    );

    controller
      ..setInitialOverlayPosition(0.25)
      ..setInitialOverlayPosition(ApodTemplateState.minHeightRatio - 0.05)
      ..setInitialOverlayPosition(infoContentHeightRatio + 0.05);
  });

  test('it can update overlay mode', () {
    final controller = ApodTemplateController();

    expect(controller.debugState.overlayMode, ApodOverlayInfoMode.regular);

    controller.setApodOverlayMode(ApodOverlayInfoMode.overscroll);

    expect(controller.debugState.overlayMode, ApodOverlayInfoMode.overscroll);
  });

  test('it can update isInFullScreen', () {
    final controller = ApodTemplateController();

    expect(controller.debugState.isInFullScreenMode, false);

    controller.setIsInFullScreenMode(isInFullScreenMode: true);

    expect(controller.debugState.isInFullScreenMode, true);
  });
}
