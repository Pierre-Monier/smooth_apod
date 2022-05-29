import 'dart:convert';
import 'dart:io';

import 'class.dart';

final mockDio = MockDio();
final mockDioResponse = MockDioResponse<Map<String, dynamic>>();
final mockDioResponseData = {'data': 'data'};
final mockUri = Uri.parse('https://example.com');
final fakeOptions = FakeOptions();
final mockDioError = MockDioError();
const mockErrorStatusCode = 418;
final mockHttpClient = MockHttpClient();
final fakeUri = FakeUri();
final mockApodJsonData =
    jsonDecode(File('test_ressources/apod_image.json').readAsStringSync())
        as Map<String, dynamic>;
final mockApodDatasource = MockApodDatasource();
