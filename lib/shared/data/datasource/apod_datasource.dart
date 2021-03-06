import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../client/dio_client.dart';
import '../client/http_client.dart';

class ApodDatasource {
  const ApodDatasource({required HttpClient httpClient})
      : _httpClient = httpClient;

  final HttpClient _httpClient;

  static final _apodUri = Uri(
    scheme: 'https',
    host: 'api.nasa.gov',
    path: '/planetary/apod',
    queryParameters: {'api_key': dotenv.env['NASA_API_KEY'] ?? 'DEMO_KEY'},
  );

  Future<Map<String, dynamic>> getApod() {
    return _httpClient.get<Map<String, dynamic>>(
      _apodUri,
    );
  }
}

final apodDatasourceProvider = Provider<ApodDatasource>((ref) {
  final httpClientProvider = ref.watch(dioClientProvider);

  return ApodDatasource(httpClient: httpClientProvider);
});
