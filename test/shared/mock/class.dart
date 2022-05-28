import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockDioResponse<T> extends Mock implements Response<T> {}

class FakeOptions extends Fake implements Options {}

class MockDioError extends Mock implements DioError {}
