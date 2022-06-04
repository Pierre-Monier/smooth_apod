import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smooth_apod/shared/data/dto/app_user_dto.dart';

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
const mockUID = 'some_random_uid';

const mockAppUser =
    AppUserDTO(uid: mockUID, username: AppUserDTO.anonymousUserName);
final mockFirebaseUser = MockFirebaseUser();
final mockFirebaseAuthDatasource = MockFirebaseAuthDatasource();
final mockFirebaseAuth = MockFirebaseAuth();
final mockUserCredential = MockUserCredential();
final mockAuthRepository = MockAuthRepository();
const mockGithubToken = 'fakegithubtoken';
const mockGoogleAccessToken = 'fakegoogleaccesstoken';
const mockGoogleIdToken = 'fakegoogleidtoken';
const mockUsername = 'fakeUsername';
final mockFirebaseAuthStream = BehaviorSubject<User?>();
