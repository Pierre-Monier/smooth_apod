import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_apod/shared/model/media_type.dart';

void main() {
  test('it should be able to create a MediaType from a String', () {
    final imageMediaType = MediaTypeFromJson.fromJson('image');
    expect(imageMediaType, MediaType.image);

    final videoMediaType = MediaTypeFromJson.fromJson('video');
    expect(videoMediaType, MediaType.video);

    expect(() => MediaTypeFromJson.fromJson('bs'), throwsA(isA<Exception>()));
  });
}
