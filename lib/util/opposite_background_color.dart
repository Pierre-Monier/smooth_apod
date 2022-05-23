import 'package:flutter/material.dart';

import '../style/app_color.dart';

extension OppositeBackgroundColor on ThemeData {
  Color get oppositeBackgroundColor {
    return brightness == Brightness.light
        ? AppColor.darkBackgroundColor
        : AppColor.lightBackgroundColor;
  }
}
