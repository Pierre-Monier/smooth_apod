import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class AppIcons {
  static Widget googleSignIn({Color? customColor}) => FaIcon(
        FontAwesomeIcons.google,
        color: customColor,
      );
  static Widget githubSignIn({Color? customColor}) => FaIcon(
        FontAwesomeIcons.github,
        color: customColor,
      );
  static Widget anonymousSignIn({Color? customColor}) =>
      FaIcon(FontAwesomeIcons.userSecret, color: customColor);
}
