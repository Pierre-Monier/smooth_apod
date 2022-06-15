import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_apod/features/apod/presentation/controller/apod_overlay_info_mode.dart';
import 'package:smooth_apod/features/apod/presentation/controller/apod_template_state.dart';

void main() {
  test('it set default value when initialized', () async {
    final initialState = ApodTemplateState.initial();
    expect(
      initialState.infoContentHeightRatio,
      ApodTemplateState.minHeightRatio,
    );
    expect(
      initialState.initialOverlayPosition,
      ApodTemplateState.minHeightRatio,
    );
    expect(
      initialState.overlayMode,
      ApodOverlayInfoMode.regular,
    );
    expect(
      initialState.isInFullScreenMode,
      false,
    );
  });

  test('it can return a newState with copyWith', () async {
    final initialState = ApodTemplateState.initial();
    final copiedState = initialState.copyWith(
      infoContentHeightRatio: 0.5,
      initialOverlayPosition: 0.5,
      overlayMode: ApodOverlayInfoMode.overscroll,
      isInFullScreenMode: true,
    );

    expect(copiedState, isNot(initialState));
    expect(
      copiedState.infoContentHeightRatio,
      0.5,
    );
    expect(
      copiedState.infoContentHeightRatio,
      0.5,
    );
    expect(
      copiedState.overlayMode,
      ApodOverlayInfoMode.overscroll,
    );
    expect(
      copiedState.isInFullScreenMode,
      true,
    );
  });
}
