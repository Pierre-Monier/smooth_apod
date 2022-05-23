import 'package:flutter/material.dart';

abstract class AppSpacing {
  static const double p4 = 8.0;
  static const double p8 = 8.0;
  static const double p12 = 12.0;
  static const double p16 = 16.0;
  static const double p20 = 20.0;
  static const double p24 = 24.0;
  static const double p28 = 28.0;
  static const double p32 = 32.0;
  static const double p36 = 36.0;
  static const double p40 = 40.0;
  static const double p44 = 44.0;
  static const double p48 = 48.0;
  static const double p52 = 52.0;
  static const double p56 = 56.0;
  static const double p60 = 60.0;
  static const double p64 = 64.0;

  static const gapH8 = SizedBox(height: p8);
  static const gapH16 = SizedBox(height: p16);
  static const gapH32 = SizedBox(height: p32);
  static const gapH64 = SizedBox(height: p64);

  static const gapW8 = SizedBox(width: p8);
  static const gapW16 = SizedBox(width: p16);
  static const gapW32 = SizedBox(width: p32);
  static const gapW64 = SizedBox(width: p64);
}
