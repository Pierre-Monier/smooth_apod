import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/auth/data/repository/auth_repository.dart';
import 'package:smooth_apod/features/auth/presentation/controller/sign_in_controller.dart';

import '../../mock/data.dart';

const loadingDelay = Duration(seconds: 1);
const loadingState = AsyncLoading<void>();
const dataState = AsyncData<void>(null);

void main() {
  setUpAll(() {
    when(() => mockGithubSignIn.signIn(mockBuildContext))
        .thenAnswer((_) => Future.value(mockGithubSignInResult));
    when(() => mockGithubSignInResult.token).thenReturn(mockGithubToken);
    when(mockGoogleSignIn.signIn).thenAnswer((_) => Future.value());
  });
  test('it should have an defined initial state', () async {
    final signInController =
        SignInController(authRepository: mockAuthRepository);

    expect(signInController.debugState, SignInState.initial());
  });

  test(
      'it should emit a AsyncLoading anonymousSignIn state then a AsyncData'
      ' anonymousSignIn state when signInAnonymously', () async {
    final signInController =
        SignInController(authRepository: mockAuthRepository);
    when(mockAuthRepository.signUserAnonymously).thenAnswer(
      (_) => Future.delayed(loadingDelay, () {}),
    );

    signInController.signInAnonymously();

    expect(
      signInController.debugState.anonymousSignIn,
      loadingState,
    );

    await Future.delayed(loadingDelay);

    expect(
      signInController.debugState.anonymousSignIn,
      dataState,
    );
  });

  test(
      'it should emit a AsyncLoading anonymousSignIn state then an AsyncError'
      ' anonymousSignIn state when signInAnonymously failed', () async {
    final signInController =
        SignInController(authRepository: mockAuthRepository);
    when(mockAuthRepository.signUserAnonymously).thenAnswer(
      (_) => Future.delayed(loadingDelay, throw AuthFailedException),
    );

    signInController.signInAnonymously();

    expect(
      signInController.debugState.anonymousSignIn,
      loadingState,
    );

    await Future.delayed(loadingDelay);

    expect(
      signInController.debugState.anonymousSignIn.hasError,
      true,
    );
    expect(
      signInController.debugState.anonymousSignIn,
      isA<AsyncError>(),
    );
  });

  test(
      'it should emit a AsyncLoading githubSignIn state then a AsyncData'
      ' githubSignIn state when signInAnonymously', () async {
    final signInController =
        SignInController(authRepository: mockAuthRepository);
    when(() => mockAuthRepository.signUserWithGithub(token: mockGithubToken))
        .thenAnswer(
      (_) => Future.value(),
    );

    signInController.signInWithGithub(
      context: mockBuildContext,
      githubSignIn: mockGithubSignIn,
    );

    expect(
      signInController.debugState.githubSignIn,
      loadingState,
    );

    await Future.delayed(loadingDelay * 2);

    expect(
      signInController.debugState.githubSignIn,
      dataState,
    );
  });

  test(
      'it should emit a AsyncLoading githubSignIn state then an AsyncError'
      ' githubSignIn state when signInWithGithub failed', () async {
    final signInController =
        SignInController(authRepository: mockAuthRepository);
    when(() => mockAuthRepository.signUserWithGithub(token: mockGithubToken))
        .thenAnswer(
      (_) => Future.delayed(loadingDelay, throw AuthFailedException),
    );

    signInController.signInWithGithub(
      context: mockBuildContext,
      githubSignIn: mockGithubSignIn,
    );

    expect(
      signInController.debugState.githubSignIn,
      loadingState,
    );

    await Future.delayed(loadingDelay);

    expect(
      signInController.debugState.githubSignIn.hasError,
      true,
    );
    expect(
      signInController.debugState.githubSignIn,
      isA<AsyncError>(),
    );
  });

  test(
      'it should emit a AsyncLoading googleSignIn state then a AsyncData'
      ' googleSignIn state when signInWithGoogle', () async {
    final signInController =
        SignInController(authRepository: mockAuthRepository);
    when(
      () => mockAuthRepository.signUserWithGoogle(
        accessToken: null,
        idToken: null,
      ),
    ).thenAnswer(
      (_) => Future.value(),
    );

    signInController.signInWithGoogle(
      googleSignIn: mockGoogleSignIn,
    );

    expect(
      signInController.debugState.googleSignIn,
      loadingState,
    );

    await Future.delayed(loadingDelay * 2);

    expect(
      signInController.debugState.googleSignIn,
      dataState,
    );
  });

  test(
      'it should emit a AsyncLoading googleSignIn state then an AsyncError'
      ' googleSignIn state when signInWIthGoogle failed', () async {
    final signInController =
        SignInController(authRepository: mockAuthRepository);
    when(
      () => mockAuthRepository.signUserWithGoogle(
        accessToken: null,
        idToken: null,
      ),
    ).thenAnswer(
      (_) => Future.delayed(loadingDelay, throw AuthFailedException),
    );

    signInController.signInWithGoogle(
      googleSignIn: mockGoogleSignIn,
    );

    expect(
      signInController.debugState.googleSignIn,
      loadingState,
    );

    await Future.delayed(loadingDelay);

    expect(
      signInController.debugState.googleSignIn.hasError,
      true,
    );
    expect(
      signInController.debugState.googleSignIn,
      isA<AsyncError>(),
    );
  });
}
