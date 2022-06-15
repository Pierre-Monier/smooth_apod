import 'apod_overlay_info_mode.dart';

class ApodTemplateState {
  const ApodTemplateState({
    required this.infoContentHeightRatio,
    required this.initialOverlayPosition,
    required this.overlayMode,
    required this.isInFullScreenMode,
  });

  factory ApodTemplateState.initial() => const ApodTemplateState(
        infoContentHeightRatio: minHeightRatio,
        initialOverlayPosition: minHeightRatio,
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

  static const double minHeightRatio = 0.15;

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
