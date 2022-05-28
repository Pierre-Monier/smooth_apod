import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../style/app_spacing.dart';
import '../../../../util/app_snackbar.dart';
import '../controller/sign_in_controller.dart';
import 'login_decoration.dart';
import 'sign_in_form.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  bool _shouldShowSnackbar({
    required AsyncValue<void>? previous,
    required AsyncValue<void> next,
  }) =>
      (previous == null || next != previous) && next.hasError;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    ref.listen<SignInState>(
      signInControllerProvider,
      ((previous, next) {
        if (_shouldShowSnackbar(
              previous: previous?.anonymousSignIn,
              next: next.anonymousSignIn,
            ) ||
            _shouldShowSnackbar(
              previous: previous?.githubSignIn,
              next: next.githubSignIn,
            ) ||
            _shouldShowSnackbar(
              previous: previous?.googleSignIn,
              next: next.googleSignIn,
            )) {
          ScaffoldMessenger.of(context).showSnackBar(
            getSnackbar(
              type: SnackbarType.error,
              text: 'Auth failed',
            ),
          );
        }
      }),
    );

    return Scaffold(
      body: ListView(
        children: [
          LoginDecoration(
            height: screenHeight / 3,
          ),
          AppSpacing.gapH32,
          const SignInForm(),
        ],
      ),
    );
  }
}
