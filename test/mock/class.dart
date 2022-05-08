import 'package:firebase_auth/firebase_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/auth/data/data_source/firebase_auth_datasource.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockFirebaseAuthDatasource extends FirebaseAuthDataSource
    implements Mock {
  MockFirebaseAuthDatasource() : super(firebaseAuth: mockFirebaseAuth);
}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

final mockFirebaseAuth = MockFirebaseAuth();
final mockFirebaseAuthDatasource = MockFirebaseAuthDatasource();
final mockUser = MockUser();
final mockUserCredential = MockUserCredential();
