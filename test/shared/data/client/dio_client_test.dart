import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/shared/data/client/dio_client.dart';
import 'package:smooth_apod/shared/data/client/http_client.dart';
import '../../mock/data.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(fakeOptions);
  });

  test('it can make GET request', () async {
    when(
      () => mockDio.getUri<Map<String, dynamic>>(
        mockUri,
        options: any(named: 'options'),
      ),
    ).thenAnswer((_) => Future.value(mockDioResponse));
    when(() => mockDioResponse.data).thenReturn(mockDioResponseData);

    final dioClient = DioClient(dio: mockDio);

    final response =
        await dioClient.get<Map<String, dynamic>>(mockUri, headers: {});

    expect(response, mockDioResponseData);
  });

  test('it throw an HTTPException with a status code when Dio throw an error',
      () async {
    when(
      () => mockDio.getUri<Map<String, dynamic>>(
        mockUri,
        options: any(named: 'options'),
      ),
    ).thenAnswer((_) => throw mockDioError);
    when(() => mockDioError.response).thenReturn(mockDioResponse);
    when(() => mockDioResponse.statusCode).thenReturn(mockErrorStatusCode);

    final dioClient = DioClient(dio: mockDio);

    expect(
      () async =>
          await dioClient.get<Map<String, dynamic>>(mockUri, headers: {}),
      throwsA(
        predicate(
          (e) => e is HttpException && e.code == mockErrorStatusCode,
        ),
      ),
    );
  });
}
