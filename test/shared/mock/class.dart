import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/shared/data/client/http_client.dart';
import 'package:smooth_apod/shared/data/datasource/apod_datasource.dart';

class MockDio extends Mock implements Dio {}

class MockDioResponse<T> extends Mock implements Response<T> {}

class FakeOptions extends Fake implements Options {}

class MockDioError extends Mock implements DioError {}

class MockHttpClient extends Mock implements HttpClient {}

class FakeUri extends Fake implements Uri {}

class MockApodDatasource extends Mock implements ApodDatasource {}
