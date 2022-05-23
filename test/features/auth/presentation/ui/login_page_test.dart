import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/auth/data/data_source/firebase_auth_datasource.dart';
import 'package:smooth_apod/features/auth/presentation/ui/login_decoration.dart';
import 'package:smooth_apod/features/auth/presentation/ui/login_page.dart';
import 'package:smooth_apod/features/auth/presentation/ui/sign_in_button.dart';

import '../../../../mock/class.dart';

void main() {
  setUpAll(() async {
    await dotenv.load();

    when(() => mockFirebaseAuthDatasource.authStateChanges)
        .thenAnswer((_) => const Stream<User?>.empty());
  });

  testWidgets('it display a decoration', (tester) async {
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

    final decorationFinder = find.byType(LoginDecoration);

    expect(decorationFinder, findsOneWidget);
  });

  testWidgets('it display a loader when we tap a signIn button',
      (tester) async {
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

    final signInButton = find.byType(SignInButton);
    expect(signInButton, findsNWidgets(3));

    await tester.tap(signInButton.first);
    await tester.pump(const Duration(seconds: 1));

    final loader = find.byType(CircularProgressIndicator);
    expect(loader, findsOneWidget);
  });
}
