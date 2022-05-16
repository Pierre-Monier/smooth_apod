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
          isLoading: signInState.githubSignIn.isLoading,
          onTap: () {
            signInController.signInWithGithub(context: context);
          },
        ),
        AppSpacing.gapH16,
        SignInButton(
          icon: AppIcons.googleSignIn,
          text: 'Sign in with Google',
          isLoading: signInState.googleSignIn.isLoading,
          onTap: () {},
        ),
        AppSpacing.gapH16,
        SignInButton(
          icon: AppIcons.emailSignIn,
          text: 'Sign in with email/password',
          isLoading: signInState.emailSignIn.isLoading,
          onTap: () {},
        ),
        AppSpacing.gapH16,
        SignInButton(
          icon: AppIcons.anonymousSignIn,
          text: 'Sign in anonymously',
          isLoading: signInState.anonymousSignIn.isLoading,
          onTap: signInController.signInAnonymously,
        ),
      ],
    );
  }
}
