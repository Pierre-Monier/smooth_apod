import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class AppIcons {
  static const emailSignIn = Icon(Icons.email_outlined);
  static const googleSignIn = FaIcon(FontAwesomeIcons.google);
  static const githubSignIn = FaIcon(FontAwesomeIcons.github);
  static const anonymousSignIn = FaIcon(FontAwesomeIcons.userSecret);
}
