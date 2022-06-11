import 'package:flutter/material.dart';

import '../apod_overlay_info.dart';

class ApodErrorOverlayInfo extends StatelessWidget {
  const ApodErrorOverlayInfo({
    required this.apodDate,
    required this.scrollController,
    super.key,
  });

  final DateTime apodDate;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) => ApodOverlayInfo(
        apodDate: apodDate,
        apodTitle: 'Something went wrong',
        scrollController: scrollController,
      );
}
