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
    _firebaseAuthDatasource.authStateChanges.listen((user) {
      _appUserStore.value = _convertFirebaseUser(user: user);
    });
  }

  final FirebaseAuthDataSource _firebaseAuthDatasource;
  final InMemoryStore<AppUser?> _appUserStore;

  Future<AppUser> signUserAnonymously() => _withExceptionCatch(() async {
        final firebaseAnonymousUser =
            await _firebaseAuthDatasource.signUserAnonymously();

        if (firebaseAnonymousUser == null) {
          throw AuthFailedException();
        }

        final dto = AppUserDTO.fromFirebaseUser(
          user: firebaseAnonymousUser,
        );

        final newUser = dto.toAppUser;
        _appUserStore.value = newUser;

        return newUser;
      });

  Future<AppUser> signUserWithGithub({required String? token}) =>
      _withExceptionCatch(() async {
        if (token == null) {
          throw AuthCancelledException();
        }

        final firebaseGithubUser =
            await _firebaseAuthDatasource.signUserWithGithub(token: token);

        if (firebaseGithubUser == null) {
          throw AuthFailedException();
        }

        final dto = AppUserDTO.fromFirebaseUser(
          user: firebaseGithubUser,
        );

        final newUser = dto.toAppUser;
        _appUserStore.value = newUser;

        return newUser;
      });

  Future<AppUser> signUserWithGoogle({
    required String? accessToken,
    required String? idToken,
  }) =>
      _withExceptionCatch(() async {
        if (accessToken == null || idToken == null) {
          throw AuthCancelledException();
        }

        final firebaseGithubUser = await _firebaseAuthDatasource
            .signUserWithGoogle(accessToken: accessToken, idToken: idToken);

        if (firebaseGithubUser == null) {
          throw AuthFailedException();
        }

        final dto = AppUserDTO.fromFirebaseUser(
          user: firebaseGithubUser,
        );

        final newUser = dto.toAppUser;
        _appUserStore.value = newUser;

        return newUser;
      });

  Future<void> signOut() => _firebaseAuthDatasource.signOut();

  AppUser? get user => _appUserStore.value;
  Stream<AppUser?> get watchUser => _appUserStore.watch;

  static AppUser? _convertFirebaseUser({required User? user}) {
    if (user != null) {
      return AppUserDTO.fromFirebaseUser(user: user).toAppUser;
    }

    return null;
  }

  Future<AppUser> _withExceptionCatch(Future<AppUser> Function() authCallback) {
    try {
      return authCallback();
    } on AuthCancelledException {
      rethrow;
    } on Exception {
      throw AuthFailedException;
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuthDatasource = ref.watch(firebaseAuthDatasourceProvider);
  return AuthRepository(
    firebaseAuthDatasource: firebaseAuthDatasource,
    initialUser: firebaseAuthDatasource.currentUser,
  );
});

class AuthCancelledException implements Exception {}

class AuthFailedException implements Exception {}
