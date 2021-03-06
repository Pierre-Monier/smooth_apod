import 'package:flutter/material.dart';

import '../../../../style/app_text_style.dart';

class ApodTitle extends StatelessWidget {
  const ApodTitle({required this.apodTitle, super.key});

  final String apodTitle;

  @override
  Widget build(BuildContext context) => Text(
        apodTitle,
        style: AppTextStyle.titleTextStyle(
          context,
        ),
      );
}
