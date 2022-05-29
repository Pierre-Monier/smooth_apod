import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/shared/data/datasource/apod_datasource.dart';

import '../../mock/data.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(fakeOptions);
    registerFallbackValue(fakeUri);
  });
  test('it can fetch the APOD jsonData', () async {
    when(
      () => mockHttpClient.get<Map<String, dynamic>>(
        any(),
        headers: any(named: 'headers'),
      ),
    ).thenAnswer((_) => Future.value(mockApodJsonData));

    final apodDatasource = ApodDatasource(httpClient: mockHttpClient);

    final response = await apodDatasource.getApod();

    expect(response, mockApodJsonData);
  });
}
