import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_apod/features/apod/presentation/ui/apod_page.dart';
import 'package:smooth_apod/features/apod/presentation/ui/loader/apod_loader.dart';
import 'package:smooth_apod/shared/data/repository/apod_repository.dart';

class ApodRobot {
  const ApodRobot({required WidgetTester tester}) : _tester = tester;
  final WidgetTester _tester;

  Future<void> pumpApodPage({required ApodRepository apodRepository}) async {
    await _tester.pumpWidget(
      ProviderScope(
        overrides: [
          apodRepositoryProvider.overrideWithValue(apodRepository),
        ],
        child: const MaterialApp(
          home: ApodPage(),
        ),
      ),
    );
  }

  void expectApodLoader() {
    final loader = find.byType(ApodLoader);
    expect(loader, findsOneWidget);
  }
}
