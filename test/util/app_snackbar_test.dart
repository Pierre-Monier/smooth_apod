import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_apod/style/app_color.dart';
import 'package:smooth_apod/util/app_snackbar.dart';

import 'mock/data.dart';

void main() {
  test('it should be able to create an error snackbar', () async {
    final errorSnackBar =
        getSnackbar(type: SnackbarType.error, text: mockSnackBarMessage);

    expect(errorSnackBar.backgroundColor, AppColor.errorColor);
    expect((errorSnackBar.content as Text).data, mockSnackBarMessage);
    expect(
      (errorSnackBar.content as Text).style?.color,
      AppColor.lightBackgroundColor,
    );
  });
}
