import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';

class FirebaseAuthDataSource {
  const FirebaseAuthDataSource({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  Future<User?> signUserAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  Future<User?> signUserWithGithub({required String token}) async {
    final githubAuthCredential = GithubAuthProvider.credential(token);
    final userCredential =
        await _firebaseAuth.signInWithCredential(githubAuthCredential);

    return userCredential.user;
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

final firebaseAuthDatasourceProvider = Provider<FirebaseAuthDataSource>((ref) {
  return FirebaseAuthDataSource(firebaseAuth: FirebaseAuth.instance);
});
