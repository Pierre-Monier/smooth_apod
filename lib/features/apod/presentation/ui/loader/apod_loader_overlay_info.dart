import 'package:flutter/material.dart';

import '../apod_overlay_info.dart';
import 'apod_loader_title.dart';

class ApodLoaderOverlayInfo extends StatelessWidget {
  const ApodLoaderOverlayInfo({required this.apodDate, super.key});

  final DateTime apodDate;

  @override
  Widget build(BuildContext context) => ApodOverlayInfo(
        apodDate: apodDate,
        apodTitleWidget: const ApodLoaderTitle(),
      );
}
