import 'package:flutter/material.dart';

class SignInDisclaimer extends StatelessWidget {
  const SignInDisclaimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Text(
        'Sign in is used to retrieve your data accros multiple devices.'
        ' You can stay anonymous if you want.',
        textAlign: TextAlign.center,
      );
}
