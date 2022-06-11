import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../style/app_color.dart';
import '../../controller/apod_template_controller.dart';

class ApodDataVisualVideoContent extends ConsumerStatefulWidget {
  const ApodDataVisualVideoContent({
    required this.url,
    required this.onVisualContentLoaded,
    super.key,
  });

  final String url;
  final void Function() onVisualContentLoaded;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ApodDataVisualVideoContentState();
}

class _ApodDataVisualVideoContentState
    extends ConsumerState<ApodDataVisualVideoContent> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
            widget.url,
          ) ??
          '',
      flags: const YoutubePlayerFlags(
        loop: true,
        autoPlay: false,
        enableCaption: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => YoutubePlayerBuilder(
        onEnterFullScreen: () {
          ref
              .read(apodTemplateProvider.notifier)
              .setIsInFullScreenMode(isInFullScreenMode: true);
        },
        onExitFullScreen: () {
          ref
              .read(apodTemplateProvider.notifier)
              .setIsInFullScreenMode(isInFullScreenMode: false);
        },
        player: YoutubePlayer(
          controller: _controller,
          onReady: widget.onVisualContentLoaded,
          progressIndicatorColor: AppColor.primaryColor,
          progressColors: const ProgressBarColors(
            playedColor: AppColor.primaryColor,
            handleColor: AppColor.primaryColor,
          ),
        ),
        builder: (context, player) => GestureDetector(
          onDoubleTap: _controller.toggleFullScreenMode,
          child: player,
        ),
      );
}
