import 'package:flutter/material.dart';

import '../../../util/apod_ui_type.dart';
import '../apod_template.dart';
import 'apod_error_visual_content.dart';
import 'apod_error_overlay_info.dart';

class ApodError extends StatelessWidget {
  const ApodError({required this.apodDate, super.key});

  final DateTime apodDate;

  @override
  Widget build(BuildContext context) => ApodTemplate(
        type: ApodUIType.error,
        visualContent: const ApodErrorVisualContent(),
        infoContent: ApodErrorOverlayInfo(
          apodDate: apodDate,
        ),
      );
}
