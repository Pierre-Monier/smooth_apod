import 'package:flutter/cupertino.dart';

import '../../../../../style/app_spacing.dart';
import '../apod_title.dart';
import 'apod_loader_dot_indicator.dart';

class ApodLoaderTitle extends StatelessWidget {
  const ApodLoaderTitle({super.key});

  @override
  Widget build(BuildContext context) => Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        children: const [
          ApodTitle(apodTitle: 'Loading'),
          AppSpacing.gapW8,
          ApodLoaderDotIndicator(),
        ],
      );
}
