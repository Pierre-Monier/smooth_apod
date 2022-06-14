import 'package:flutter_test/flutter_test.dart';
import 'package:smooth_apod/shared/data/dto/apod_dto.dart';

import '../mock/data.dart';

void main() {
  test(
      'Apod should have getters that specify if they have an image or a'
      ' video for visual content', () {
    final apodImage = ApodDTO.fromJson(mockApodJsonDataImage);
    expect(apodImage.isImage, true);
    expect(apodImage.isVideo, false);

    final apodVideo = ApodDTO.fromJson(mockApodJsonDataVideo);
    expect(apodVideo.isImage, false);
    expect(apodVideo.isVideo, true);
  });
}
