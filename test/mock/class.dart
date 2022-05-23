import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/subjects.dart';
import 'package:smooth_apod/features/auth/data/data_source/firebase_auth_datasource.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseAuthDatasource extends Mock
    implements FirebaseAuthDataSource {}

class MockFirebaseUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class MockStream extends Mock implements Stream<User?> {}

class OAuthCredentialFake extends Fake implements OAuthCredential {}

final mockFirebaseAuth = MockFirebaseAuth();
final mockFirebaseAuthDatasource = MockFirebaseAuthDatasource();
final mockFirebaseUser = MockFirebaseUser();
final mockUserCredential = MockUserCredential();
final mockFirebaseAuthStream = BehaviorSubject<User?>();
