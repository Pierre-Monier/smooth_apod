import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/opposite_main_content_background_color.dart';

abstract class AppTextStyle {
  static final _bodyTextTheme = GoogleFonts.merriweatherTextTheme();

  static TextStyle? secondaryInfoTextStyle(
    BuildContext context, {
    TextTheme? customTextTheme,
    Color? color,
  }) {
    final textTheme = customTextTheme ?? Theme.of(context).textTheme;
    return textTheme.caption
        ?.copyWith(color: color, fontStyle: FontStyle.italic);
  }

  static TextStyle? titleTextStyle(
    BuildContext context, {
    TextTheme? customTextTheme,
    Color? color,
  }) {
    final textTheme = customTextTheme ?? Theme.of(context).textTheme;
    return textTheme.headline2
        ?.copyWith(color: Theme.of(context).oppositeMainContentBackgroundColor);
  }

  static TextStyle? subtitleTextStyle(
    BuildContext context, {
    TextTheme? customTextTheme,
    Color? color,
  }) {
    final textTheme = customTextTheme ?? Theme.of(context).textTheme;
    return textTheme.headline4
        ?.copyWith(color: Theme.of(context).oppositeMainContentBackgroundColor);
  }

  static TextStyle? bodyTextStyle(BuildContext context, {Color? color}) =>
      _bodyTextTheme.bodyText1?.copyWith(
        color: color ?? Theme.of(context).oppositeMainContentBackgroundColor,
      );
}
