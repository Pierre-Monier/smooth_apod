import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_apod/features/auth/model/app_user.dart';

import '../../../mock/data.dart';

void main() {
  test('we can create AppUser', () async {
    const user = AppUser(uid: mockUID, username: mockUsername);

    expect(user.uid, mockUID);
    expect(user.username, mockUsername);
  });
}
