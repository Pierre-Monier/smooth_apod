import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/data/repository/apod_repository.dart';
import '../../../../shared/model/apod.dart';

class ApodController extends StateNotifier<AsyncValue<Apod>> {
  ApodController({
    required ApodRepository apodRepository,
  })  : _apodRepository = apodRepository,
        super(const AsyncValue.loading());

  final ApodRepository _apodRepository;

  Future<void> getApod() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(_apodRepository.getApod);
  }
}
