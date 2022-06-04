import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smooth_apod/features/apod/presentation/controller/apod_controller.dart';
import 'package:smooth_apod/shared/model/app_user.dart';
import 'package:smooth_apod/shared/data/repository/apod_repository.dart';
import 'package:smooth_apod/shared/model/apod.dart';

import '../../../../shared/mock/data.dart';
import '../../mock/data.dart';

const loadingState = AsyncLoading<Apod>();
final dataState = AsyncData<Apod>(mockApod);
const nullAppUserAsyncValue = AsyncValue<AppUser?>.data(null);
const appUserAsyncValue = AsyncValue<AppUser?>.data(mockAppUser);
final errorPredicate = predicate<AsyncValue<void>>((value) {
  expect(value.hasError, true);
  expect(value, isA<AsyncError>());
  return true;
});

void main() {
  test('it should have an initial state of loading state', () async {
    final apodController = ApodController(
      apodRepository: mockApodRepository,
      authStream: nullAppUserAsyncValue,
    );
    expect(apodController.debugState, loadingState);
  });

  test('it should call getApod when the authStream has an AppUser', () async {
    final apodController = ApodController(
      apodRepository: mockApodRepository,
      authStream: appUserAsyncValue,
    );

    verify(apodController.getApod).called(1);
  });

  test('it should have a data state when getApod is called', () async {
    final apodController = ApodController(
      apodRepository: mockApodRepository,
      authStream: nullAppUserAsyncValue,
    );
    when(mockApodRepository.getApod).thenAnswer((_) => Future.value(mockApod));

    // * the stream doesn't emit the loading state since it's the initial state
    // * stream emits async event, it's not emiting the current state
    expectLater(
      apodController.stream,
      emitsInOrder([
        dataState,
      ]),
    );

    await apodController.getApod();
  });

  test('it should have an error state when getApod throw an exception',
      () async {
    final apodController = ApodController(
      apodRepository: mockApodRepository,
      authStream: nullAppUserAsyncValue,
    );
    when(mockApodRepository.getApod)
        .thenAnswer((_) => throw const ApodFetchFailedException());

    // * the stream doesn't emit the loading state since it's the initial state
    // * stream emits async event, it's not emiting the current state
    expectLater(
      apodController.stream,
      emitsInOrder([
        errorPredicate,
      ]),
    );

    await apodController.getApod();
  });
}
