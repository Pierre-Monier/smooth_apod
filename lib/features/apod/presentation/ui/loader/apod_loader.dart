import 'package:flutter/material.dart';

import '../../../util/apod_ui_type.dart';
import '../apod_loader_visual_content.dart';
import '../apod_template.dart';
import 'apod_loader_overlay_info.dart';

class ApodLoader extends StatelessWidget {
  const ApodLoader({required this.apodDate, super.key});

  final DateTime apodDate;

  @override
  Widget build(BuildContext context) => ApodTemplate(
        type: ApodUIType.loading,
        visualContent: const ApodLoaderVisualContent(),
        infoContentBuilder: (_, scrollController) => ApodLoaderOverlayInfo(
          apodDate: apodDate,
          scrollController: scrollController,
        ),
      );
}
