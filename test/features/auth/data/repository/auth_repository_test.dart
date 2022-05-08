import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/auth/data/data_source/firebase_auth_datasource.dart';
import 'package:smooth_apod/features/auth/data/repository/auth_repository.dart';

import '../../../../mock/class.dart';
import '../../../../mock/data.dart';

final firebaseMock = MockFirebaseAuthDatasource();

void main() {
  setUpAll(() {
    when(() => mockUserCredential.user).thenReturn(mockUser);
    when(() => mockUser.uid).thenReturn(mockUID);
    when(mockFirebaseAuth.signInAnonymously)
        .thenAnswer((invocation) => Future.value(mockUserCredential));
  });

  test('it should be able to sign user anonymously', () async {
    final authRepository = AuthRepository(
      firebaseAuthDatasource:
          FirebaseAuthDataSource(firebaseAuth: mockFirebaseAuth),
    );
    final user = await authRepository.signUserAnonymously();

    expect(user, mockAppUser);
  });
}
