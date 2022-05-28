import 'package:smooth_apod/features/auth/data/dto/app_user_dto.dart';
import 'package:rxdart/subjects.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './class.dart';

const mockUID = 'some_random_uid';
const mockUsername = 'fakeUsername';
const mockAppUser =
    AppUserDTO(uid: mockUID, username: AppUserDTO.anonymousUserName);
const mockGithubToken = 'fakegithubtoken';
const mockGoogleAccessToken = 'fakegoogleaccesstoken';
const mockGoogleIdToken = 'fakegoogleidtoken';

final mockFirebaseAuth = MockFirebaseAuth();
final mockFirebaseAuthDatasource = MockFirebaseAuthDatasource();
final mockFirebaseUser = MockFirebaseUser();
final mockUserCredential = MockUserCredential();
final mockFirebaseAuthStream = BehaviorSubject<User?>();
final mockAuthRepository = MockAuthRepository();
final mockGithubSignIn = MockGithubSignIn();
final mockGithubSignInResult = MockGithubSignInResult();
final mockBuildContext = MockBuildContext();
final mockGoogleSignIn = MockGoogleSignIn();
