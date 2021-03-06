import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/shared/data/repository/auth_repository.dart';
import 'package:smooth_apod/features/auth/presentation/controller/sign_in_controller.dart';

import '../../../../shared/mock/data.dart';
import '../../mock/data.dart';

const loadingState = AsyncLoading<void>();
const dataState = AsyncData<void>(null);
final errorPredicate = predicate<AsyncValue<void>>((value) {
  expect(value.hasError, true);
  expect(value, isA<AsyncError>());
  return true;
});

void main() {
  late SignInController signInController;

  setUpAll(() {
    when(() => mockGithubSignIn.signIn(mockBuildContext))
        .thenAnswer((_) => Future.value(mockGithubSignInResult));
    when(() => mockGithubSignInResult.token).thenReturn(mockGithubToken);
    when(mockGoogleSignIn.signIn).thenAnswer((_) => Future.value());
  });

  setUp(() {
    signInController = SignInController(authRepository: mockAuthRepository);
  });

  test('it should have an defined initial state', () async {
    expect(signInController.debugState, SignInState.initial());
  });

  test(
      'it should emit a AsyncLoading anonymousSignIn state then a AsyncData'
      ' anonymousSignIn state when signInAnonymously', () async {
    when(mockAuthRepository.signUserAnonymously).thenAnswer(
      (_) => Future.value(),
    );

    expectLater(
      signInController.stream.map<AsyncValue>((event) => event.anonymousSignIn),
      emitsInOrder([
        loadingState,
        dataState,
      ]),
    );

    await signInController.signInAnonymously();
  });

  test(
      'it should emit a AsyncLoading anonymousSignIn state then an AsyncError'
      ' anonymousSignIn state when signInAnonymously failed', () async {
    when(mockAuthRepository.signUserAnonymously).thenAnswer(
      (_) => Future.delayed(throw AuthFailedException),
    );

    expectLater(
      signInController.stream.map<AsyncValue>((event) => event.anonymousSignIn),
      emitsInOrder([loadingState, errorPredicate]),
    );

    await signInController.signInAnonymously();
  });

  test(
      'it should emit a AsyncLoading githubSignIn state then a AsyncData'
      ' githubSignIn state when signInAnonymously', () async {
    when(() => mockAuthRepository.signUserWithGithub(token: mockGithubToken))
        .thenAnswer(
      (_) => Future.value(),
    );

    expectLater(
      signInController.stream.map<AsyncValue>((event) => event.githubSignIn),
      emitsInOrder([
        loadingState,
        dataState,
      ]),
    );

    await signInController.signInWithGithub(
      context: mockBuildContext,
      githubSignIn: mockGithubSignIn,
    );
  });

  test(
      'it should emit a AsyncLoading githubSignIn state then an AsyncError'
      ' githubSignIn state when signInWithGithub failed', () async {
    when(() => mockAuthRepository.signUserWithGithub(token: mockGithubToken))
        .thenAnswer(
      (_) => Future.delayed(throw AuthFailedException),
    );

    expectLater(
      signInController.stream.map<AsyncValue>((event) => event.githubSignIn),
      emitsInOrder([loadingState, errorPredicate]),
    );

    await signInController.signInWithGithub(
      context: mockBuildContext,
      githubSignIn: mockGithubSignIn,
    );
  });

  test(
      'it should emit a AsyncLoading googleSignIn state then a AsyncData'
      ' googleSignIn state when signInWithGoogle', () async {
    when(
      () => mockAuthRepository.signUserWithGoogle(
        accessToken: null,
        idToken: null,
      ),
    ).thenAnswer(
      (_) => Future.value(),
    );

    expectLater(
      signInController.stream.map<AsyncValue>((event) => event.googleSignIn),
      emitsInOrder([
        loadingState,
        dataState,
      ]),
    );

    await signInController.signInWithGoogle(
      googleSignIn: mockGoogleSignIn,
    );
  });

  test(
      'it should emit a AsyncLoading googleSignIn state then an AsyncError'
      ' googleSignIn state when signInWIthGoogle failed', () async {
    when(
      () => mockAuthRepository.signUserWithGoogle(
        accessToken: null,
        idToken: null,
      ),
    ).thenAnswer(
      (_) => Future.delayed(throw AuthFailedException),
    );

    expectLater(
      signInController.stream.map<AsyncValue>((event) => event.googleSignIn),
      emitsInOrder([loadingState, errorPredicate]),
    );

    await signInController.signInWithGoogle(
      googleSignIn: mockGoogleSignIn,
    );
  });
}
