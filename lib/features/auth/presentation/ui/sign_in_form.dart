import 'package:flutter/material.dart';

import '../../../../util/app_spacing.dart';
import 'sign_in_disclaimer.dart';
import 'sign_in_wrapper.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.p32),
        child: Column(
          children: const [
            SignInWrapper(),
            AppSpacing.gapH32,
            SignInDisclaimer(),
          ],
        ),
      );
}
