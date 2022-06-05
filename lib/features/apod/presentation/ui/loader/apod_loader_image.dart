import 'package:flutter/material.dart';

import '../../../../../util/secondary_background_color.dart';

class ApodLoaderImage extends StatelessWidget {
  const ApodLoaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: Theme.of(context).secondaryBackgroundColor,
      height: screenHeight,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
