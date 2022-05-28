import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_apod/features/apod/model/apod.dart';
import 'package:smooth_apod/features/apod/model/media_type.dart';

import '../mock/data.dart';

void main() {
  test('we can create an APOD object with a MediaType of image', () {
    final apod = APOD(
      copyright: mockCopyright,
      date: mockDate,
      explanation: mockExplanation,
      mediaType: MediaTypeFromJson.fromJson(mockMediaTypeImageData),
      title: mockTitle,
      url: mockUrl,
      hdurl: mockHdurl,
    );

    expect(apod.copyright, mockCopyright);
    expect(apod.date, mockDate);
    expect(apod.explanation, mockExplanation);
    expect(apod.mediaType, MediaType.image);
    expect(apod.title, mockTitle);
    expect(apod.url, mockUrl);
    expect(apod.hdurl, mockHdurl);
  });

  test('we can create an APOD object with a MediaType of video', () {
    final apod = APOD(
      copyright: mockCopyright,
      date: mockDate,
      explanation: mockExplanation,
      mediaType: MediaTypeFromJson.fromJson(mockMediaTypeVideoData),
      title: mockTitle,
      url: mockUrl,
      hdurl: mockHdurl,
      thumbnailUrl: mockThumbnailUrl,
    );

    expect(apod.copyright, mockCopyright);
    expect(apod.date, mockDate);
    expect(apod.explanation, mockExplanation);
    expect(apod.mediaType, MediaType.video);
    expect(apod.title, mockTitle);
    expect(apod.url, mockUrl);
    expect(apod.hdurl, mockHdurl);
    expect(apod.thumbnailUrl, mockThumbnailUrl);
  });
}
