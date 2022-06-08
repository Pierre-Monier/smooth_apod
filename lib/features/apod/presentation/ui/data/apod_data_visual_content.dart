import 'package:flutter/material.dart';

import '../../../../../shared/model/apod.dart';
import 'apod_data_visual_image_content.dart';
import 'apod_data_visual_video_content.dart';

class ApodDataVisualContent extends StatelessWidget {
  const ApodDataVisualContent({
    required this.apod,
    required this.onVisualContentLoaded,
    required this.visualContentKey,
    super.key,
  });

  final Apod apod;

  final void Function() onVisualContentLoaded;
  final Key visualContentKey;

  @override
  Widget build(BuildContext context) {
    return apod.isImage
        ? ApodDataVisualImageContent(
            key: visualContentKey,
            url: apod.url,
            onVisualContentLoaded: onVisualContentLoaded,
          )
        : const ApodDataVisualVideoContent();
  }
}
