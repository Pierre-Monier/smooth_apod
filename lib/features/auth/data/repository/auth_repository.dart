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

  Future<AppUser> signUserAnonymously() async {
    try {
      final firebaseAnonymousUser =
          await _firebaseAuthDatasource.signUserAnonymously();

      if (firebaseAnonymousUser == null) {
        throw SignInReturnNullException();
      }

      final dto = AppUserDTO.fromFirebaseUser(
        user: firebaseAnonymousUser,
      );

      final newUser = dto.toAppUser;
      _appUserStore.value = newUser;

      return newUser;
    } on SignInReturnNullException {
      rethrow;
    } on Exception {
      throw AnonymousSignInException();
    }
  }

  // TODO: clean up this code
  Future<AppUser> signUserWithGithub({required String? token}) async {
    try {
      if (token == null) {
        throw SignInReturnNullException();
      }

      final firebaseGithubUser =
          await _firebaseAuthDatasource.signUserWithGithub(token: token);

      if (firebaseGithubUser == null) {
        throw SignInReturnNullException();
      }

      final dto = AppUserDTO.fromFirebaseUser(
        user: firebaseGithubUser,
      );

      final newUser = dto.toAppUser;
      _appUserStore.value = newUser;

      return newUser;
    } on SignInReturnNullException {
      rethrow;
    } on Exception {
      throw GithubSignInException();
    }
  }

  Future<AppUser> signUserWithGoogle(
      {required String? accessToken, required String? idToken}) async {
    try {
      if (accessToken == null || idToken == null) {
        throw SignInReturnNullException();
      }

      final firebaseGithubUser = await _firebaseAuthDatasource
          .signUserWithGoogle(accessToken: accessToken, idToken: idToken);

      if (firebaseGithubUser == null) {
        throw SignInReturnNullException();
      }

      final dto = AppUserDTO.fromFirebaseUser(
        user: firebaseGithubUser,
      );

      final newUser = dto.toAppUser;
      _appUserStore.value = newUser;

      return newUser;
    } on SignInReturnNullException {
      rethrow;
    } on Exception {
      throw GithubSignInException();
    }
  }

  Future<void> signOut() => _firebaseAuthDatasource.signOut();

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

class SignInReturnNullException implements Exception {
  @override
  String toString() {
    return 'SignInReturnNullException';
  }
}

class AnonymousSignInException implements Exception {
  @override
  String toString() {
    return 'AnonymousSignInException';
  }
}

class GithubSignInException implements Exception {
  @override
  String toString() {
    return 'GithubSignInException';
  }
}
