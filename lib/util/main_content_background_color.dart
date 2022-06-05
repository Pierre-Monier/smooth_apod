import 'package:flutter/material.dart';

import '../style/app_color.dart';

extension MainContentBackgroundColor on ThemeData {
  Color get mainContentBackgroundColor {
    return brightness == Brightness.light
        ? AppColor.lightBackgroundColor
        : AppColor.darkBackgroundColor;
  }
}
