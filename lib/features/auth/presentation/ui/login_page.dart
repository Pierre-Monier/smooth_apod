import 'package:flutter/material.dart';

import 'login_decoration.dart';
import 'sign_in_form.dart';

// TODO listen to controller error and display toast
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        children: [
          LoginDecoration(
            height: screenHeight / 3,
          ),
          const SignInForm(),
        ],
      ),
    );
  }
}
