import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDataSource {
  const FirebaseAuthDataSource({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;
  Future<User?> signUserAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }
}
