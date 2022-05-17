import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/auth/data/data_source/firebase_auth_datasource.dart';

import '../../../../mock/class.dart';
import '../../../../mock/data.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(OAuthCredentialFake());
    when(() => mockUserCredential.user).thenReturn(mockUser);
    when(mockFirebaseAuth.signInAnonymously)
        .thenAnswer((_) => Future.value(mockUserCredential));
    when(
      () => mockFirebaseAuth.signInWithCredential(
        any(),
      ),
    ).thenAnswer((_) => Future.value(mockUserCredential));
    when(mockFirebaseAuth.signOut).thenAnswer((_) => Future.value());
  });
  test('it should be able to signUserAnonymously', () async {
    final firebaseAuthDatasource =
        FirebaseAuthDataSource(firebaseAuth: mockFirebaseAuth);

    final user = await firebaseAuthDatasource.signUserAnonymously();

    expect(user, mockUser);
  });

  test('it should be able to sign in with github', () async {
    final firebaseAuthDatasource =
        FirebaseAuthDataSource(firebaseAuth: mockFirebaseAuth);

    final user =
        await firebaseAuthDatasource.signUserWithGithub(token: mockGithubToken);

    expect(user, mockUser);
  });

  test('it should be able to sign out', () async {
    final firebaseAuthDatasource =
        FirebaseAuthDataSource(firebaseAuth: mockFirebaseAuth);

    await firebaseAuthDatasource.signOut();

    verify(mockFirebaseAuth.signOut).called(1);
  });
}
