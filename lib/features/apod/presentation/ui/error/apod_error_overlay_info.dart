import 'package:flutter/material.dart';

import '../apod_overlay_info.dart';

class ApodErrorOverlayInfo extends StatelessWidget {
  const ApodErrorOverlayInfo({required this.apodDate, super.key});

  final DateTime apodDate;

  @override
  Widget build(BuildContext context) => ApodOverlayInfo(
        apodDate: apodDate,
        apodTitle: 'Something went wrong',
      );
}
