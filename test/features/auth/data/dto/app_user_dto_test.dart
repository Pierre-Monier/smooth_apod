import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/auth/data/dto/app_user_dto.dart';

import '../../mock/class.dart';
import '../../mock/data.dart';

void main() {
  setUpAll(() {
    when(() => mockFirebaseUser.uid).thenReturn(mockUID);
  });

  test('it can create anonymous AppUser', () async {
    when(() => mockFirebaseUser.displayName).thenReturn(null);

    final anonymousDTO = AppUserDTO.fromFirebaseUser(user: mockFirebaseUser);

    expect(anonymousDTO.uid, mockUID);
    expect(anonymousDTO.username, AppUserDTO.anonymousUserName);
  });

  test('it can create regular AppUser', () async {
    when(() => mockFirebaseUser.displayName).thenReturn(mockUsername);

    final anonymousDTO = AppUserDTO.fromFirebaseUser(user: mockFirebaseUser);

    expect(anonymousDTO.uid, mockUID);
    expect(anonymousDTO.username, mockUsername);
  });
}
