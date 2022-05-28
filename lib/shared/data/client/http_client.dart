abstract class HttpClient {
  Future<T> get<T>(Uri uri, {Map<String, String> headers});

  HttpException getHttpException(int code) => HttpException(code: code);
}

class HttpException implements Exception {
  const HttpException({required this.code});
  final int code;
}
