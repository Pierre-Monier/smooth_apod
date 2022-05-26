import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../style/app_icons.dart';
import '../../../../style/app_spacing.dart';
import '../../util/github_sign_in_provider.dart';
import '../../util/google_sign_in_provider.dart';
import '../controller/sign_in_controller.dart';
import 'sign_in_button.dart';

class SignInWrapper extends ConsumerWidget {
  const SignInWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signInController = ref.watch(signInControllerProvider.notifier);
    final signInState = ref.watch(signInControllerProvider);
    final gitHubSignIn = ref.watch(githubSignInProvider);
    final googleSignIn = ref.watch(googleSignInProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignInButton(
          icon: AppIcons.githubSignIn(
            customColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          text: 'Sign in with GitHub',
          isLoading: signInState.githubSignIn.isLoading,
          onTap: () {
            signInController.signInWithGithub(
              context: context,
              githubSignIn: gitHubSignIn,
            );
          },
        ),
        AppSpacing.gapH16,
        SignInButton(
          icon: AppIcons.googleSignIn(
            customColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          text: 'Sign in with Google',
          isLoading: signInState.googleSignIn.isLoading,
          onTap: () {
            signInController.signInWithGoogle(googleSignIn: googleSignIn);
          },
        ),
        AppSpacing.gapH16,
        SignInButton(
          icon: AppIcons.anonymousSignIn(
            customColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          text: 'Sign in anonymously',
          isLoading: signInState.anonymousSignIn.isLoading,
          onTap: signInController.signInAnonymously,
        ),
      ],
    );
  }
}
