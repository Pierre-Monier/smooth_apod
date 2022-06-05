import 'package:flutter/material.dart';

import '../util/opposite_background_color.dart';

abstract class AppTextStyle {
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
        ?.copyWith(color: Theme.of(context).oppositeBackgroundColor);
  }
}
