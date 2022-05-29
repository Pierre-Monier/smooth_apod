import '../../model/apod.dart';
import '../../model/media_type.dart';

class ApodDTO extends Apod {
  ApodDTO({
    required super.copyright,
    required super.date,
    required super.explanation,
    required super.mediaType,
    required super.title,
    required super.url,
    required super.hdurl,
    required super.thumbnailUrl,
  });

  factory ApodDTO.fromJson(Map<String, dynamic> json) => ApodDTO(
        copyright: json['copyright'] as String?,
        date: DateTime.parse(json['date'] as String),
        explanation: json['explanation'] as String,
        mediaType: MediaTypeFromJson.fromJson(json['media_type'] as String),
        title: json['title'] as String,
        url: json['url'] as String,
        hdurl: json['hdurl'] as String?,
        thumbnailUrl: json['thumbnail_url'] as String?,
      );
}
