import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/auth/data/data_source/firebase_auth_datasource.dart';
import 'package:smooth_apod/features/auth/data/repository/auth_repository.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseAuthDatasource extends Mock
    implements FirebaseAuthDataSource {}

class MockFirebaseUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class MockStream extends Mock implements Stream<User?> {}

class OAuthCredentialFake extends Fake implements OAuthCredential {}

class MockAuthRepository extends Mock implements AuthRepository {}

class MockGithubSignIn extends Mock implements GitHubSignIn {}

class MockGithubSignInResult extends Mock implements GitHubSignInResult {}

class MockBuildContext extends Mock implements BuildContext {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}
