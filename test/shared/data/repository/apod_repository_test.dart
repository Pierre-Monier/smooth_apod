import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/apod/model/media_type.dart';
import 'package:smooth_apod/shared/data/repository/apod_repository.dart';

import '../../mock/data.dart';

void main() {
  setUpAll(() {
    when(mockApodDatasource.getApod)
        .thenAnswer((invocation) => Future.value(mockApodJsonData));
  });
  test('it can get APOD object', () async {
    final apodRepository = ApodRepository(apodDatasource: mockApodDatasource);
    final apod = await apodRepository.getApod();

    expect(apod.copyright, mockApodJsonData['copyright']);
    expect(apod.date, DateTime.parse(mockApodJsonData['date'] as String));
    expect(apod.explanation, mockApodJsonData['explanation']);
    expect(apod.hdurl, mockApodJsonData['hdurl']);
    expect(
      apod.mediaType,
      MediaTypeFromJson.fromJson(mockApodJsonData['media_type'] as String),
    );
    expect(apod.thumbnailUrl, mockApodJsonData['thumbnail_url']);
    expect(apod.title, mockApodJsonData['title']);
    expect(apod.url, mockApodJsonData['url']);
  });
}
