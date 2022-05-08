import '../../model/app_user.dart';
import '../data_source/firebase_auth_datasource.dart';
import '../dto/app_user_dto.dart';

class AuthRepository {
  const AuthRepository({required FirebaseAuthDataSource firebaseAuthDatasource})
      : _firebaseAuthDatasource = firebaseAuthDatasource;

  final FirebaseAuthDataSource _firebaseAuthDatasource;

  Future<AppUser> signUserAnonymously() async {
    final firebaseAnonymousUser =
        await _firebaseAuthDatasource.signUserAnonymously();

    // TODO: add null check error
    final dto = AppUserDTO.fromAnonymousFirebaseUser(
      uid: firebaseAnonymousUser?.uid ?? '',
    );

    return dto.toAppUser;
  }
}
