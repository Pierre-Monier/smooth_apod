import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/data/repository/apod_repository.dart';
import '../../../../shared/model/apod.dart';
import '../../../../shared/data/repository/auth_repository.dart';
import '../../../../shared/model/app_user.dart';

class ApodController extends StateNotifier<AsyncValue<Apod>> {
  ApodController({
    required ApodRepository apodRepository,
    required AsyncValue<AppUser?> authStream,
  })  : _apodRepository = apodRepository,
        super(const AsyncValue.loading()) {
    authStream.whenData((appUser) {
      if (appUser != null) {
        getApod();
      }
    });
  }

  final ApodRepository _apodRepository;

  Future<void> getApod() async {
    state = const AsyncValue.loading();
    final newState = await AsyncValue.guard(_apodRepository.getApod);

    state = newState;
  }
}

final apodControllerProvider =
    StateNotifierProvider<ApodController, AsyncValue<Apod>>((ref) {
  final apodRepository = ref.watch(apodRepositoryProvider);
  final authStream = ref.watch(authStreamProvidier);

  final apodController =
      ApodController(apodRepository: apodRepository, authStream: authStream);

  return apodController;
});
