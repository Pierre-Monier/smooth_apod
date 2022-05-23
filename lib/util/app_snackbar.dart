import 'package:flutter/material.dart';

import '../style/app_color.dart';
import '../style/app_spacing.dart';

enum SnackbarType { error }

extension _SnackbarBackgroundColor on SnackbarType {
  Color get backgroundColor {
    switch (this) {
      case SnackbarType.error:
        return AppColor.errorColor;
    }
  }
}

extension _SnackbarTextColor on SnackbarType {
  Color get textColor {
    switch (this) {
      case SnackbarType.error:
        return AppColor.lightBackgroundColor;
    }
  }
}

SnackBar getSnackbar({
  required SnackbarType type,
  required String text,
}) {
  return SnackBar(
    content: Text(
      text,
      style: TextStyle(color: type.textColor),
    ),
    backgroundColor: type.backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.p16),
    ),
  );
}
