import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_apod/features/apod/data/dto/apod_dto.dart';
import 'package:smooth_apod/features/apod/model/media_type.dart';

void main() {
  test('We can parse APOD from json when the MediaType is an image', () {
    final file = File('test_ressources/apod_image.json');
    final json = jsonDecode(file.readAsStringSync());

    final apod = ApodDTO.fromJson(json as Map<String, dynamic>);

    expect(apod.copyright, json['copyright'] as String?);
    expect(apod.date, DateTime.parse(json['date'] as String));
    expect(apod.explanation, json['explanation']);
    expect(
      apod.mediaType,
      MediaTypeFromJson.fromJson(json['media_type'] as String),
    );
    expect(apod.title, json['title'] as String);
    expect(apod.url, json['url'] as String);
    expect(apod.hdurl, json['hdurl'] as String?);
  });

  test('We can parse APOD from json when the MediaType is an video', () {
    final file = File('test_ressources/apod_video.json');
    final json = jsonDecode(file.readAsStringSync());

    final apod = ApodDTO.fromJson(json as Map<String, dynamic>);

    expect(apod.copyright, json['copyright'] as String?);
    expect(apod.date, DateTime.parse(json['date'] as String));
    expect(apod.explanation, json['explanation']);
    expect(
      apod.mediaType,
      MediaTypeFromJson.fromJson(json['media_type'] as String),
    );
    expect(apod.title, json['title'] as String);
    expect(apod.url, json['url'] as String);
    expect(apod.hdurl, json['hdurl'] as String?);
    expect(apod.thumbnailUrl, json['thumbnail_url'] as String?);
  });
}
