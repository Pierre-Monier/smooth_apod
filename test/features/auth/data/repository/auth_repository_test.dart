import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/auth/data/repository/auth_repository.dart';

import '../../../../mock/class.dart';
import '../../../../mock/data.dart';

void main() {
  setUpAll(() {
    when(() => mockUserCredential.user).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn(mockUID);
    when(() => mockFirebaseAuthDatasource.authStateChanges)
        .thenAnswer((_) => mockFirebaseAuthStream.stream);
    when(
      () => mockFirebaseAuthDatasource.signUserWithGithub(
        token: mockGithubToken,
      ),
    ).thenAnswer((_) {
      mockFirebaseAuthStream.add(mockUser);
      return Future.value(mockUser);
    });
    when(
      mockFirebaseAuthDatasource.signUserAnonymously,
    ).thenAnswer((_) {
      mockFirebaseAuthStream.add(mockUser);
      return Future.value(mockUser);
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
    final user = await authRepository.signUserAnonymously();
    final userFromStore = authRepository.user;

    expect(user, mockAppUser);
    expect(userFromStore, mockAppUser);
  });

  test('it should be able to sign in with github', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource: mockFirebaseAuthDatasource,
      initialUser: null,
    );
    final user =
        await authRepository.signUserWithGithub(token: mockGithubToken);
    final userFromStore = authRepository.user;

    expect(user, mockAppUser);
    expect(userFromStore, mockAppUser);
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
}
