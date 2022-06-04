import 'package:firebase_auth/firebase_auth.dart';

import '../../model/app_user.dart';

class AppUserDTO extends AppUser {
  const AppUserDTO({
    required super.uid,
    required super.username,
  });

  factory AppUserDTO.fromFirebaseUser({required User user}) {
    return AppUserDTO(
      uid: user.uid,
      username: user.displayName ?? anonymousUserName,
    );
  }

  static const anonymousUserName = 'anonymous';

  // // * convert the DTO to an AppUser entity
  // AppUser get toAppUser => AppUser(uid: uid, username: username);
}
