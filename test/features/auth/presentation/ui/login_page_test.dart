import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/auth/data/data_source/firebase_auth_datasource.dart';
import 'package:smooth_apod/features/auth/presentation/ui/login_decoration.dart';
import 'package:smooth_apod/features/auth/presentation/ui/login_page.dart';

import '../../../../mock/class.dart';

void main() {
  setUpAll(() {
    when(() => mockFirebaseAuthDatasource.authStateChanges)
        .thenAnswer((_) => const Stream<User?>.empty());
  });

  testWidgets('login page ...', (tester) async {
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
}
