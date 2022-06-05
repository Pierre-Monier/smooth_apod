import 'package:flutter/material.dart';

import '../../../../../style/app_text_style.dart';

class ApodErrorVisualContent extends StatelessWidget {
  const ApodErrorVisualContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: (screenHeight / 6) * 5,
      child: Center(
        child: Text(
          'Unable to fetch data',
          style: AppTextStyle.subtitleTextStyle(context),
        ),
      ),
    );
  }
}
