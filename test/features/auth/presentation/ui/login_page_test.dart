import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared/mock/data.dart';
import 'login_robot.dart';

void main() {
  setUpAll(() async {
    await dotenv.load();

    when(() => mockFirebaseAuthDatasource.authStateChanges)
        .thenAnswer((_) => const Stream<User?>.empty());
  });

  testWidgets('it display a decoration', (tester) async {
    final loginRobot = LoginRobot(tester: tester);

    await loginRobot.pumpLoginPage(
      mockFirebaseAuthDatasource: mockFirebaseAuthDatasource,
    );
    loginRobot.expectLoginDecoration();
  });

  testWidgets('it display a loader when we tap a signIn button',
      (tester) async {
    final loginRobot = LoginRobot(tester: tester);

    await loginRobot.pumpLoginPage(
      mockFirebaseAuthDatasource: mockFirebaseAuthDatasource,
    );
    loginRobot.expectSignInButtons();
    await loginRobot.tapSignInWithGithubButton();
    loginRobot.expectLoader();
  });

  testWidgets('it should display an error snackbar when auth failed',
      (tester) async {
    when(
      mockFirebaseAuthDatasource.signUserAnonymously,
    ).thenThrow(Exception());
    // mock authRepository to make it throw when signInWithGithub is called
    final loginRobot = LoginRobot(tester: tester);

    await loginRobot.pumpLoginPage(
      mockFirebaseAuthDatasource: mockFirebaseAuthDatasource,
    );
    await loginRobot.tapSignInAnonymouslyButton();
    await loginRobot.expectErrorSnackbar();
  });
}
