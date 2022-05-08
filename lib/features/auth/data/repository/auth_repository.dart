import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../util/in_memory_store.dart';
import '../../model/app_user.dart';
import '../data_source/firebase_auth_datasource.dart';
import '../dto/app_user_dto.dart';

class AuthRepository {
  AuthRepository({
    required FirebaseAuthDataSource firebaseAuthDatasource,
    required User? initialUser,
  })  : _firebaseAuthDatasource = firebaseAuthDatasource,
        _appUserStore =
            InMemoryStore<AppUser?>(_convertFirebaseUser(user: initialUser)) {
    // * we map firebase user stream to our user store
    _firebaseAuthDatasource.authStateChanges
        .listen((user) => _convertFirebaseUser(user: user));
  }

  final FirebaseAuthDataSource _firebaseAuthDatasource;
  final InMemoryStore<AppUser?> _appUserStore;

  Future<AppUser> signUserAnonymously() async {
    try {
      final firebaseAnonymousUser =
          await _firebaseAuthDatasource.signUserAnonymously();

      final dto = AppUserDTO.fromFirebaseUser(
        user: firebaseAnonymousUser,
      );
      return dto.toAppUser;
    } on Exception {
      throw AnonymousSignInException();
    } on TypeError {
      throw AnonymousSignInException();
    }
  }

  AppUser? get user => _appUserStore.value;
  Stream<AppUser?> get watchUser => _appUserStore.watch;

  static AppUser? _convertFirebaseUser({required User? user}) {
    if (user != null) {
      return AppUserDTO.fromFirebaseUser(user: user).toAppUser;
    }

    return null;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuthDatasource = ref.watch(firebaseAuthDatasourceProvider);
  return AuthRepository(
    firebaseAuthDatasource: firebaseAuthDatasource,
    initialUser: firebaseAuthDatasource.currentUser,
  );
});

class AnonymousSignInException implements Exception {
  @override
  String toString() {
    return 'AnonymousSignInException';
  }
}
