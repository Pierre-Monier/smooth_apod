import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/data.dart';
import 'apod_robot.dart';

void main() {
  testWidgets('it display loaders while loading data', (tester) async {
    when(mockApodRepository.getApod).thenAnswer((_) => Future.value(mockApod));
    final apodRobot = ApodRobot(tester: tester);

    await apodRobot.pumpApodPage(apodRepository: mockApodRepository);
    apodRobot.expectApodLoader();
  });
}
