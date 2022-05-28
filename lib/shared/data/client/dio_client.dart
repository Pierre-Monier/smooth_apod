import 'package:dio/dio.dart';

import 'http_client.dart';

class DioClient extends HttpClient {
  DioClient({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;
  static const Duration _timeoutDuration = Duration(seconds: 15);

  @override
  Future<T> get<T>(Uri uri, {Map<String, String>? headers}) async {
    try {
      final _requestHeaders = <String, dynamic>{...headers ?? {}};
      final response = await _dio
          .getUri<T>(uri, options: Options(headers: _requestHeaders))
          .timeout(_timeoutDuration);
      return response.data as T;
    } on DioError catch (e) {
      final code = e.response?.statusCode ?? 0;
      throw getHttpException(code);
    }
  }
}
