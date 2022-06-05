import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/apod_template_controller.dart';

class ApodTemplate extends ConsumerWidget {
  const ApodTemplate({
    required this.visualContent,
    required this.infoContent,
    super.key,
  });

  final Widget visualContent;
  final Widget infoContent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apodTemplateState = ref.watch(apodTemplateProvider);

    return Stack(
      children: [
        visualContent,
        DraggableScrollableSheet(
          // TODO should be based on visualContent height, with a min of 0.15
          initialChildSize: 0.15,
          minChildSize: 0.15,
          maxChildSize: apodTemplateState.infoContentHeightRatio,
          builder: ((context, scrollController) => SingleChildScrollView(
                controller: scrollController,
                child: SizedBox(
                  child: infoContent,
                ),
              )),
        ),
      ],
    );
  }
}
