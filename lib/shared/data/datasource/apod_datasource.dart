import '../client/http_client.dart';

class ApodDatasource {
  const ApodDatasource({required HttpClient httpClient})
      : _httpClient = httpClient;

  final HttpClient _httpClient;

  static final _apodUri = Uri(
    scheme: 'https',
    host: 'api.nasa.gov',
    path: '/planetary/apod',
    queryParameters: {'api_key': 'DEMO_KEY'},
  );

  Future<Map<String, dynamic>> getApod() {
    return _httpClient.get<Map<String, dynamic>>(
      _apodUri,
    );
  }
}
