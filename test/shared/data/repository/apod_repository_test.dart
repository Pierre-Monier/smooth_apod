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
        .thenAnswer((_) => Future.value(mockApodJsonDataImage));

    final apod = await apodRepository.getApod();

    expect(apod.copyright, mockApodJsonDataImage['copyright']);
    expect(apod.date, DateTime.parse(mockApodJsonDataImage['date'] as String));
    expect(apod.explanation, mockApodJsonDataImage['explanation']);
    expect(apod.hdurl, mockApodJsonDataImage['hdurl']);
    expect(
      apod.mediaType,
      MediaTypeFromJson.fromJson(mockApodJsonDataImage['media_type'] as String),
    );
    expect(apod.thumbnailUrl, mockApodJsonDataImage['thumbnail_url']);
    expect(apod.title, mockApodJsonDataImage['title']);
    expect(apod.url, mockApodJsonDataImage['url']);
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
