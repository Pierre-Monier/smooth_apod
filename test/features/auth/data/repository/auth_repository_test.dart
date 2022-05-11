import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/auth/data/data_source/firebase_auth_datasource.dart';
import 'package:smooth_apod/features/auth/data/repository/auth_repository.dart';

import '../../../../mock/class.dart';
import '../../../../mock/data.dart';

final firebaseMock = MockFirebaseAuthDatasource();

void main() {
  setUpAll(() {
    registerFallbackValue(GithubAuthProviderFake());
    when(() => mockUserCredential.user).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn(mockUID);
    when(mockFirebaseAuth.authStateChanges)
        .thenAnswer((_) => firebaseAuthStream.stream);
    when(mockFirebaseAuth.signOut)
        .thenAnswer((_) async => firebaseAuthStream.add(null));
    when(() => mockFirebaseAuth.currentUser).thenReturn(null);
    when(mockFirebaseAuth.signInAnonymously).thenAnswer((invocation) {
      firebaseAuthStream.add(mockUser);
      return Future.value(mockUserCredential);
    });
    when(() => mockFirebaseAuth.signInWithPopup(any()))
        .thenAnswer((invocation) {
      firebaseAuthStream.add(mockUser);
      return Future.value(mockUserCredential);
    });
  });

  tearDownAll(firebaseAuthStream.close);

  test('it should be able to sign user anonymously', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource:
          FirebaseAuthDataSource(firebaseAuth: mockFirebaseAuth),
      initialUser: null,
    );
    final user = await authRepository.signUserAnonymously();
    final userFromStore = authRepository.user;

    expect(user, mockAppUser);
    expect(userFromStore, mockAppUser);
  });

  test('it should be able to sign in with github', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource:
          FirebaseAuthDataSource(firebaseAuth: mockFirebaseAuth),
      initialUser: null,
    );
    final user = await authRepository.signUserWithGithub();
    final userFromStore = authRepository.user;

    expect(user, mockAppUser);
    expect(userFromStore, mockAppUser);
  });

  test('it should be able to signOut', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource:
          FirebaseAuthDataSource(firebaseAuth: mockFirebaseAuth),
      initialUser: null,
    );
    await authRepository.signUserAnonymously(); // user is signIn

    await authRepository.signOut();

    final user = authRepository.user;

    expect(user, null);
  });
}
