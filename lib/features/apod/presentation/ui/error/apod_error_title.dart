import 'package:flutter/material.dart';

import '../apod_title.dart';

class ApodErrorTitle extends StatelessWidget {
  const ApodErrorTitle({super.key});

  @override
  Widget build(BuildContext context) =>
      const ApodTitle(apodTitle: 'Something went wrong');
}
