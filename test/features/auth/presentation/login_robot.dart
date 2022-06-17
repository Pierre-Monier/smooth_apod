import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_apod/features/auth/presentation/ui/login_decoration.dart';
import 'package:smooth_apod/features/auth/presentation/ui/login_page.dart';
import 'package:smooth_apod/features/auth/presentation/ui/sign_in_button.dart';
import 'package:smooth_apod/shared/data/datasource/firebase_auth_datasource.dart';

class LoginRobot {
  const LoginRobot({required this.tester});

  final WidgetTester tester;

  Future<void> pumpLoginPage({
    required FirebaseAuthDataSource mockFirebaseAuthDatasource,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          firebaseAuthDatasourceProvider
              .overrideWithValue(mockFirebaseAuthDatasource)
        ],
        child: const MaterialApp(
          home: LoginPage(),
        ),
      ),
    );
  }

  void expectLoginDecoration() {
    final decorationFinder = find.byType(LoginDecoration);
    expect(decorationFinder, findsOneWidget);
  }

  void expectSignInButtons() {
    final signInButtons = _findSignInButtons();
    expect(signInButtons, findsNWidgets(3));
  }

  Future<void> tapSignInWithGithubButton() async {
    final signInButtons = _findSignInButtons();

    await tester.tap(signInButtons.first);
    await tester.pump();
  }

  Future<void> tapSignInAnonymouslyButton() async {
    final signInButtons = _findSignInButtons();

    await tester.tap(signInButtons.last);
    await tester.pump();
  }

  void expectLoader() {
    final loader = find.byType(CircularProgressIndicator);
    expect(loader, findsOneWidget);
  }

  Future<void> expectErrorSnackbar() async {
    final errorSnackbar = find.byType(SnackBar);
    expect(errorSnackbar, findsOneWidget);
  }

  Finder _findSignInButtons() => find.byType(SignInButton);
}
