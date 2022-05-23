import 'package:flutter/material.dart';

import '../style/app_color.dart';
import 'app_color.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColor.primaryColor,
  errorColor: AppColor.errorColor,
  scaffoldBackgroundColor: AppColor.lightBackgroundColor,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColor.primaryColor,
  errorColor: AppColor.errorColor,
  scaffoldBackgroundColor: AppColor.darkBackgroundColor,
);
