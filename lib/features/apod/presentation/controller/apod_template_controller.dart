import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApodTemplateState {
  const ApodTemplateState({required this.infoContentHeightRatio});

  factory ApodTemplateState.initial() => const ApodTemplateState(
        infoContentHeightRatio: _minInfoContentHeightRatio,
      );
  // * this is a ration of the infoContentHeightRatio by the Screen height
  // * default is _minInfoContentHeightRatio
  final double infoContentHeightRatio;

  static const double _minInfoContentHeightRatio = 0.15;

  ApodTemplateState copyWith({
    double? infoContentHeightRatio,
  }) =>
      ApodTemplateState(
        infoContentHeightRatio:
            infoContentHeightRatio ?? this.infoContentHeightRatio,
      );
}

class ApodTemplateController extends StateNotifier<ApodTemplateState> {
  ApodTemplateController() : super(ApodTemplateState.initial());

  void setInfoContentHeightRatio(double infoContentHeightRatio) {
    final withMinAndMaxThresholds = infoContentHeightRatio.clamp(
      ApodTemplateState._minInfoContentHeightRatio,
      1.0,
    );
    state = state.copyWith(infoContentHeightRatio: withMinAndMaxThresholds);
  }
}

final apodTemplateProvider =
    StateNotifierProvider<ApodTemplateController, ApodTemplateState>((ref) {
  return ApodTemplateController();
});
