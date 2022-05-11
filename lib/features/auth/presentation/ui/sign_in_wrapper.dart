import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../util/app_icons.dart';
import '../../../../util/app_spacing.dart';
import '../controller/sign_in_controller.dart';
import 'sign_in_button.dart';

class SignInWrapper extends ConsumerWidget {
  const SignInWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInController = ref.watch(signInControllerProvider.notifier);
    final signInState = ref.watch(signInControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignInButton(
          icon: AppIcons.githubSignIn,
          text: 'Sign in with GitHub',
          isLoading: signInState.isThisFormLoading(SignInForm.github),
          onTap: () {
            signInController.signIn(SignInForm.github);
          },
        ),
        AppSpacing.gapH16,
        SignInButton(
          icon: AppIcons.googleSignIn,
          text: 'Sign in with Google',
          isLoading: signInState.isThisFormLoading(SignInForm.google),
          onTap: () {
            signInController.signIn(SignInForm.google);
          },
        ),
        AppSpacing.gapH16,
        SignInButton(
          icon: AppIcons.emailSignIn,
          text: 'Sign in with email/password',
          isLoading: signInState.isThisFormLoading(SignInForm.email),
          onTap: () {
            signInController.signIn(SignInForm.email);
          },
        ),
        AppSpacing.gapH16,
        SignInButton(
          icon: AppIcons.anonymousSignIn,
          text: 'Sign in anonymously',
          isLoading: signInState.isThisFormLoading(SignInForm.anonymous),
          onTap: () {
            signInController.signIn(SignInForm.anonymous);
          },
        ),
      ],
    );
  }
}
