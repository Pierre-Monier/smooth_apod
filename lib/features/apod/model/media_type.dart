enum MediaType {
  image,
  video,
}

extension MediaTypeFromJson on MediaType {
  static MediaType fromJson(String json) {
    switch (json) {
      case 'image':
        return MediaType.image;
      case 'video':
        return MediaType.video;
      default:
        throw Exception('Unknown MediaType: $json');
    }
  }
}
