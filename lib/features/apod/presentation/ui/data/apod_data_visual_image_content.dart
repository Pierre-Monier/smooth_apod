import 'package:flutter/material.dart';

import '../../../util/app_duration.dart';

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

  static const _animationDuration = AppDuration.mediumDuration;
  static const _safetyDelay = 1.3;

  void _updateLoadingStatus() {
    if (!_isImageLoaded) {
      // * image is loaded
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
        (_, __) {
          _updateLoadingStatus();
        },
      ),
    );

    return AnimatedSwitcher(
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      duration: _animationDuration,
      layoutBuilder: (child, previousChildren) {
        return SizedBox(
          height: (MediaQuery.of(context).size.height / 3),
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (final previousChild in previousChildren) previousChild,
              if (child != null) child
            ],
          ),
        );
      },
      child: _isImageLoaded ? image : const CircularProgressIndicator(),
    );
  }
}
