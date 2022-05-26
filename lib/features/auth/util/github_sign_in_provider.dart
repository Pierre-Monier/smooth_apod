import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_sign_in/github_sign_in.dart';

final githubSignInProvider = Provider<GitHubSignIn>((ref) {
  return GitHubSignIn(
    clientId: dotenv.env['GITHUB_CLIENT_ID'] ?? '',
    clientSecret: dotenv.env['GITHUB_CLIENT_SECRET'] ?? '',
    redirectUrl: dotenv.env['GITHUB_REDIRECT_URL'] ?? '',
  );
});
