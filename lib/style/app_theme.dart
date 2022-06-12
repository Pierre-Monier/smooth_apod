import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../style/app_color.dart';
import 'app_color.dart';

final textTheme = GoogleFonts.montserratTextTheme();

final _baseTheme = ThemeData(
  textTheme: textTheme,
  useMaterial3: true,
  errorColor: AppColor.errorColor,
  colorSchemeSeed: AppColor.primaryColor,
);

final lightTheme = _baseTheme.copyWith(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColor.secondaryLightBackgroundColor,
);

final darkTheme = _baseTheme.copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColor.secondaryDarkBackgroundColor,
);
