import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_apod/features/auth/presentation/ui/login_decoration.dart';
import 'package:smooth_apod/features/auth/presentation/ui/login_page.dart';

void main() {
  testWidgets('login page ...', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    final decorationFinder = find.byType(LoginDecoration);

    expect(decorationFinder, findsOneWidget);
  });
}
