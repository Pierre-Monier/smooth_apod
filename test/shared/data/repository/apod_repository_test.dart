import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/shared/data/repository/apod_repository.dart';
import 'package:smooth_apod/shared/model/media_type.dart';

import '../../mock/data.dart';

void main() {
  late ApodRepository apodRepository;

  setUp(() {
    apodRepository = ApodRepository(apodDatasource: mockApodDatasource);
  });

  test('it can get APOD object', () async {
    when(mockApodDatasource.getApod)
        .thenAnswer((_) => Future.value(mockApodJsonData));

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

  test('it should throw an ApodFetchFailedException when an Exception occured',
      () {
    when(mockApodDatasource.getApod).thenAnswer((_) => throw Exception());

    expect(apodRepository.getApod, throwsA(isA<ApodFetchFailedException>()));
  });

  test('it should throw an ApodFetchFailedException when a TypeError occured',
      () {
    when(mockApodDatasource.getApod).thenAnswer((_) => throw TypeError());

    expect(apodRepository.getApod, throwsA(isA<ApodFetchFailedException>()));
  });
}
