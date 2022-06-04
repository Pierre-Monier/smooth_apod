import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/shared/data/client/http_client.dart';
import 'package:smooth_apod/shared/data/datasource/apod_datasource.dart';
import 'package:smooth_apod/shared/data/datasource/firebase_auth_datasource.dart';
import 'package:smooth_apod/shared/data/repository/auth_repository.dart';

class MockDio extends Mock implements Dio {}

class MockDioResponse<T> extends Mock implements Response<T> {}

class FakeOptions extends Fake implements Options {}

class MockDioError extends Mock implements DioError {}

class MockHttpClient extends Mock implements HttpClient {}

class FakeUri extends Fake implements Uri {}

class MockApodDatasource extends Mock implements ApodDatasource {}

class MockFirebaseUser extends Mock implements User {}

class MockFirebaseAuthDatasource extends Mock
    implements FirebaseAuthDataSource {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class OAuthCredentialFake extends Fake implements OAuthCredential {}

class MockAuthRepository extends Mock implements AuthRepository {}
