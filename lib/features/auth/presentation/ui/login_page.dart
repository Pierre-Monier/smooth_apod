import 'package:flutter/material.dart';

import 'login_decoration.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: LoginDecoration(),
        ),
      );
}
