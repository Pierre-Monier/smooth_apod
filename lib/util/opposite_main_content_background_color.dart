import 'package:flutter/material.dart';

import '../style/app_color.dart';

extension OppositeMainContentBackgroundColor on ThemeData {
  Color get oppositeMainContentBackgroundColor {
    return brightness == Brightness.light
        ? AppColor.darkBackgroundColor
        : AppColor.lightBackgroundColor;
  }
}
