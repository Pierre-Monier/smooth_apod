import 'media_type.dart';

class APOD {
  APOD({
    required this.copyright,
    required this.date,
    required this.explanation,
    required this.mediaType,
    required this.title,
    required this.url,
    this.hdurl,
    this.thumbnailUrl,
  });

  final String copyright;
  final DateTime date;
  final String explanation;
  final MediaType mediaType;
  final String title;
  final String url;
  final String? hdurl;
  final String? thumbnailUrl;
}
