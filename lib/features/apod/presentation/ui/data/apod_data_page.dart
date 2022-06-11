import 'package:flutter/material.dart';

import '../../../../../shared/model/apod.dart';
import '../../../util/apod_ui_type.dart';
import '../apod_template.dart';
import 'apod_data_overlay_info.dart';
import 'apod_data_visual_content.dart';

class ApodDataPage extends StatelessWidget {
  const ApodDataPage({required this.apod, super.key});

  final Apod apod;

  @override
  Widget build(BuildContext context) => ApodTemplate(
        type: ApodUIType.data,
        visualContentBuilder: (
          context,
          onVisualContentLoaded,
          visualContentKey,
        ) =>
            ApodDataVisualContent(
          apod: apod,
          onVisualContentLoaded: onVisualContentLoaded,
          visualContentKey: visualContentKey,
        ),
        infoContentBuilder: (_, scrollController) => ApodDataOverlayInfo(
          apod: apod,
          scrollController: scrollController,
        ),
      );
}
