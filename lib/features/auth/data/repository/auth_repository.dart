import '../../../../util/in_memory_store.dart';
import '../../model/app_user.dart';
import '../data_source/firebase_auth_datasource.dart';
import '../dto/app_user_dto.dart';

class AuthRepository {
  AuthRepository({required FirebaseAuthDataSource firebaseAuthDatasource})
      : _firebaseAuthDatasource = firebaseAuthDatasource {
    // * we map firebase user stream to our user store
    _firebaseAuthDatasource.authStateChanges.listen((user) {
      if (user != null) {
        _appUserStore.value = AppUserDTO.fromFirebaseUser(user: user);
      } else {
        _appUserStore.value = null;
      }
    });
  }

  final FirebaseAuthDataSource _firebaseAuthDatasource;
  late final InMemoryStore<AppUser?> _appUserStore =
      InMemoryStore<AppUser?>(currentUser);

  Future<AppUser> signUserAnonymously() async {
    try {
      final firebaseAnonymousUser =
          await _firebaseAuthDatasource.signUserAnonymously();
      final dto = AppUserDTO.fromAnonymousFirebaseUser(
        uid: firebaseAnonymousUser?.uid ?? '',
      );

      return dto.toAppUser;
    } on Exception {
      throw AnonymousSignInException();
    }
  }

  AppUser? get currentUser => _appUserStore.value;

  Stream<AppUser?> get watchCurrentUser => _appUserStore.watch;
}

class AnonymousSignInException implements Exception {
  @override
  String toString() {
    return 'AnonymousSignInException';
  }
}
