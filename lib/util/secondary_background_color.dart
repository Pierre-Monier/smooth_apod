import 'package:flutter/material.dart';

import '../style/app_color.dart';

extension SecondaryBackgroundColor on ThemeData {
  Color get secondaryBackgroundColor {
    return brightness == Brightness.light
        ? AppColor.secondaryLightBackgroundColor
        : AppColor.secondaryDarkBackgroundColor;
  }
}
