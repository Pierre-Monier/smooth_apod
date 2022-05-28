import 'package:flutter/material.dart';

import '../../../../style/app_spacing.dart';
import 'sign_in_disclaimer.dart';
import 'sign_in_wrapper.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(AppSpacing.p32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SignInWrapper(),
            AppSpacing.gapH32,
            SignInDisclaimer(),
          ],
        ),
      );
}
