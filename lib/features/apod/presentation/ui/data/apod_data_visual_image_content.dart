import 'package:flutter/material.dart';

import '../../../util/app_duration.dart';
import '../apod_loader_visual_content.dart';

class ApodDataVisualImageContent extends StatefulWidget {
  const ApodDataVisualImageContent({
    required this.url,
    required this.onVisualContentLoaded,
    super.key,
  });

  final String url;
  final void Function() onVisualContentLoaded;

  @override
  State<StatefulWidget> createState() => _ApodDataVisualImageContentState();
}

class _ApodDataVisualImageContentState
    extends State<ApodDataVisualImageContent> {
  bool _isImageLoaded = false;
  double _loadingValue = 0.0;

  static const _animationDuration = AppDuration.mediumDuration;
  static const _safetyDelay = 1.3;

  void _updateLoadingStatus(double loadingValue) {
    setState(() {
      _loadingValue = loadingValue;
    });

    // * image is loaded
    if (loadingValue >= 1.0) {
      setState(() {
        _isImageLoaded = true;
      });

      Future.delayed(
        // * we multiply the animation duration by the safety delay because
        // * sometimes the image widget is not loaded yet
        _animationDuration * _safetyDelay,
        widget.onVisualContentLoaded,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final image = Image.network(
      widget.url,
    );
    image.image.resolve(ImageConfiguration.empty).addListener(
          ImageStreamListener(
            // * I prefer to process data coming from only one stream
            // * that's why I don't use the onImage callback
            (_, __) {},
            onChunk: (imageChunk) {
              final expectedTotalBytes = imageChunk.expectedTotalBytes;
              if (expectedTotalBytes != null) {
                _updateLoadingStatus(
                  imageChunk.cumulativeBytesLoaded / expectedTotalBytes,
                );
              }
            },
          ),
        );

    return AnimatedSwitcher(
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: _animationDuration,
      child: _isImageLoaded
          ? image
          : ApodLoaderVisualContent(
              value: _loadingValue,
            ),
    );
  }
}
