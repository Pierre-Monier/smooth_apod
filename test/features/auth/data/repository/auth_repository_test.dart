import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/auth/data/repository/auth_repository.dart';

import '../../mock/class.dart';
import '../../mock/data.dart';

void main() {
  setUpAll(() {
    when(() => mockUserCredential.user).thenReturn(mockFirebaseUser);
    when(() => mockFirebaseUser.uid).thenReturn(mockUID);
    when(() => mockFirebaseAuthDatasource.authStateChanges)
        .thenAnswer((_) => mockFirebaseAuthStream.stream);
    when(
      () => mockFirebaseAuthDatasource.signUserWithGithub(
        token: mockGithubToken,
      ),
    ).thenAnswer((_) {
      mockFirebaseAuthStream.add(mockFirebaseUser);
      return Future.value(mockFirebaseUser);
    });
    when(
      mockFirebaseAuthDatasource.signUserAnonymously,
    ).thenAnswer((_) {
      mockFirebaseAuthStream.add(mockFirebaseUser);
      return Future.value(mockFirebaseUser);
    });
    when(
      () => mockFirebaseAuthDatasource.signUserWithGoogle(
        accessToken: mockGoogleAccessToken,
        idToken: mockGoogleIdToken,
      ),
    ).thenAnswer((_) {
      mockFirebaseAuthStream.add(mockFirebaseUser);
      return Future.value(mockFirebaseUser);
    });
    when(
      mockFirebaseAuthDatasource.signOut,
    ).thenAnswer((_) async {
      mockFirebaseAuthStream.add(null);
      return Future.value();
    });
  });

  tearDownAll(mockFirebaseAuthStream.close);

  test('it should be able to sign user anonymously', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource: mockFirebaseAuthDatasource,
      initialUser: null,
    );

    await authRepository.signUserAnonymously();
    final userFromStore = authRepository.user;
    final userStream = authRepository.watchUser;

    expect(userFromStore, mockAppUser);
    expect(userStream, emits(mockAppUser));
  });

  test('it should be able to signOut', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource: mockFirebaseAuthDatasource,
      initialUser: null,
    );

    await authRepository.signUserAnonymously(); // user is signIn
    await authRepository.signOut();

    final user = authRepository.user;

    expect(user, null);
  });

  // * this test is place after the signOut test because we use
  // * signUserAnonymously, and we mock it's behavior in this test
  test(
    'it should throw a SignInReturnNullException'
    ' if anonymous sign in return null',
    () {
      final authRepository = AuthRepository(
        firebaseAuthDatasource: mockFirebaseAuthDatasource,
        initialUser: null,
      );

      when(
        mockFirebaseAuthDatasource.signUserAnonymously,
      ).thenAnswer((_) {
        mockFirebaseAuthStream.add(null);
        return Future.value();
      });

      expect(
        () async => await authRepository.signUserAnonymously(),
        throwsA(isA<AuthFailedException>()),
      );
    },
  );

  test('it should be able to sign in with github', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource: mockFirebaseAuthDatasource,
      initialUser: null,
    );

    await authRepository.signUserWithGithub(token: mockGithubToken);
    final userFromStore = authRepository.user;
    final userStream = authRepository.watchUser;

    expect(userFromStore, mockAppUser);
    expect(userStream, emits(mockAppUser));
  });

  test(
    'it should throw a SignInReturnNullException'
    ' if github sign in get a null token parameter',
    () {
      final authRepository = AuthRepository(
        firebaseAuthDatasource: mockFirebaseAuthDatasource,
        initialUser: null,
      );

      when(
        () => mockFirebaseAuthDatasource.signUserWithGithub(
          token: mockGithubToken,
        ),
      ).thenAnswer((_) {
        mockFirebaseAuthStream.add(null);
        return Future.value();
      });

      expect(
        () async =>
            await authRepository.signUserWithGithub(token: mockGithubToken),
        throwsA(isA<AuthFailedException>()),
      );
    },
  );

  test(
    'it should throw a SignInReturnNullException on github sign in'
    ' if firebase datasource return a null user',
    () {
      final authRepository = AuthRepository(
        firebaseAuthDatasource: mockFirebaseAuthDatasource,
        initialUser: null,
      );

      expect(
        () async => await authRepository.signUserWithGithub(token: null),
        throwsA(isA<AuthCancelledException>()),
      );
    },
  );

  test('it should be able to sign in with google', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource: mockFirebaseAuthDatasource,
      initialUser: null,
    );

    await authRepository.signUserWithGoogle(
      accessToken: mockGoogleAccessToken,
      idToken: mockGoogleIdToken,
    );
    final userFromStore = authRepository.user;
    final userStream = authRepository.watchUser;

    expect(userFromStore, mockAppUser);
    expect(userStream, emits(mockAppUser));
  });

  test(
    'it should throw a SignInReturnNullException'
    ' if google sign in get a null accessToken parameter or'
    ' a null idToken parameter',
    () {
      final authRepository = AuthRepository(
        firebaseAuthDatasource: mockFirebaseAuthDatasource,
        initialUser: null,
      );

      expect(
        () async => await authRepository.signUserWithGoogle(
          accessToken: null,
          idToken: null,
        ),
        throwsA(isA<AuthCancelledException>()),
      );
    },
  );

  test(
    'it should throw a SignInReturnNullException on google sign in'
    ' if firebase datasource return a null user',
    () {
      final authRepository = AuthRepository(
        firebaseAuthDatasource: mockFirebaseAuthDatasource,
        initialUser: null,
      );

      when(
        () => mockFirebaseAuthDatasource.signUserWithGoogle(
          accessToken: mockGoogleAccessToken,
          idToken: mockGoogleIdToken,
        ),
      ).thenAnswer((_) {
        mockFirebaseAuthStream.add(null);
        return Future.value();
      });

      expect(
        () async => await authRepository.signUserWithGoogle(
          accessToken: mockGoogleAccessToken,
          idToken: mockGoogleIdToken,
        ),
        throwsA(isA<AuthFailedException>()),
      );
    },
  );
}
