import 'package:flutter/material.dart';

import '../style/app_color.dart';
import 'app_color.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  errorColor: AppColor.errorColor,
  colorSchemeSeed: AppColor.primaryColor,
  scaffoldBackgroundColor: AppColor.secondaryLightBackgroundColor,
);

final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  errorColor: AppColor.errorColor,
  colorSchemeSeed: AppColor.primaryColor,
  scaffoldBackgroundColor: AppColor.secondaryDarkBackgroundColor,
);
