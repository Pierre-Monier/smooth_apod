import 'package:flutter/material.dart';

import '../../../../../shared/model/apod.dart';
import '../apod_overlay_info.dart';

class ApodDataOverlayInfo extends StatelessWidget {
  const ApodDataOverlayInfo({
    required this.apod,
    required this.scrollController,
    super.key,
  });

  final Apod apod;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => ApodOverlayInfo(
        apodDate: apod.date,
        apodTitle: apod.title,
        apodExplanation: apod.explanation,
        scrollController: scrollController,
      );
}
