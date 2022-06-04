import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class MockGithubSignIn extends Mock implements GitHubSignIn {}

class MockGithubSignInResult extends Mock implements GitHubSignInResult {}

class MockBuildContext extends Mock implements BuildContext {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}
