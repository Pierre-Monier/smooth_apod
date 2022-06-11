import 'package:flutter/material.dart';

import '../apod_overlay_info.dart';
import 'apod_loader_title.dart';

class ApodLoaderOverlayInfo extends StatelessWidget {
  const ApodLoaderOverlayInfo({
    required this.apodDate,
    required this.scrollController,
    super.key,
  });

  final DateTime apodDate;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => ApodOverlayInfo(
        apodDate: apodDate,
        apodTitle: 'Loading ...',
        apodTitleWidget: const ApodLoaderTitle(),
        scrollController: scrollController,
      );
}
