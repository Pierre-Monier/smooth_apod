import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../shared/data/repository/auth_repository.dart';

class SignInState {
  const SignInState({
    required this.githubSignIn,
    required this.googleSignIn,
    required this.anonymousSignIn,
  });

  factory SignInState.initial() => const SignInState(
        githubSignIn: AsyncValue.data(null),
        googleSignIn: AsyncValue.data(null),
        anonymousSignIn: AsyncValue.data(null),
      );

  final AsyncValue<void> githubSignIn;
  final AsyncValue<void> googleSignIn;
  final AsyncValue<void> anonymousSignIn;

  SignInState copyWith({
    AsyncValue<void>? githubSignIn,
    AsyncValue<void>? googleSignIn,
    AsyncValue<void>? anonymousSignIn,
  }) =>
      SignInState(
        githubSignIn: githubSignIn ?? this.githubSignIn,
        googleSignIn: googleSignIn ?? this.googleSignIn,
        anonymousSignIn: anonymousSignIn ?? this.anonymousSignIn,
      );
}

class SignInController extends StateNotifier<SignInState> {
  SignInController({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(SignInState.initial());

  final AuthRepository _authRepository;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> signInAnonymously() async {
    state = state.copyWith(anonymousSignIn: const AsyncValue.loading());

    final newState =
        await AsyncValue.guard(_authRepository.signUserAnonymously);
    state = state.copyWith(anonymousSignIn: newState);
  }

  Future<void> signInWithGithub({
    required BuildContext context,
    required GitHubSignIn githubSignIn,
  }) async {
    state = state.copyWith(githubSignIn: const AsyncValue.loading());

    final result = await githubSignIn.signIn(context);

    final newState = await AsyncValue.guard(
      () => _authRepository.signUserWithGithub(token: result.token),
    );
    state = state.copyWith(githubSignIn: newState);
  }

  Future<void> signInWithGoogle({
    required GoogleSignIn googleSignIn,
  }) async {
    state = state.copyWith(googleSignIn: const AsyncValue.loading());
    // * Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final newState = await AsyncValue.guard(
      () => _authRepository.signUserWithGoogle(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      ),
    );
    state = state.copyWith(googleSignIn: newState);
  }
}

final signInControllerProvider =
    StateNotifierProvider<SignInController, SignInState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);

  return SignInController(
    authRepository: authRepository,
  );
});
