import '../../model/app_user.dart';

class AppUserDTO extends AppUser {
  AppUserDTO({
    required String uid,
    required String username,
  }) : super(uid: uid, username: username);

  factory AppUserDTO.fromAnonymousFirebaseUser({required String uid}) {
    return AppUserDTO(uid: uid, username: anonymousUserName);
  }

  static const anonymousUserName = 'anonymous';

  // * convert the DTO to an AppUser entity
  AppUser get toAppUser => AppUser(uid: uid, username: username);
}
