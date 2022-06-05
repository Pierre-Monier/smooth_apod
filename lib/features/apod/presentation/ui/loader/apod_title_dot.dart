import 'package:flutter/material.dart';

import '../../../../../style/app_text_style.dart';

class ApodTitleDot extends StatelessWidget {
  const ApodTitleDot({super.key});

  @override
  Widget build(BuildContext context) => Text(
        '.',
        style: AppTextStyle.titleTextStyle(context),
      );
}
