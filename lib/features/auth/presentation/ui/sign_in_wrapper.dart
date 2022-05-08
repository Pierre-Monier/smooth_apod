import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../util/app_icons.dart';
import '../../../../util/app_spacing.dart';
import '../../data/repository/auth_repository.dart';
import 'sign_in_button.dart';

class SignInWrapper extends ConsumerWidget {
  const SignInWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignInButton(
          icon: AppIcons.githubSignIn,
          text: 'Sign in with GitHub',
          onTap: () {
            // TODO implement
          },
        ),
        AppSpacing.gapH16,
        SignInButton(
          icon: AppIcons.googleSignIn,
          text: 'Sign in with Google',
          onTap: () {
            // TODO implement
          },
        ),
        AppSpacing.gapH16,
        SignInButton(
          icon: AppIcons.emailSignIn,
          text: 'Sign in with email/password',
          onTap: () {
            // TODO implement
          },
        ),
        AppSpacing.gapH16,
        SignInButton(
          icon: AppIcons.anonymousSignIn,
          text: 'Sign in anonymously',
          onTap: authRepository.signUserAnonymously,
        ),
      ],
    );
  }
}
