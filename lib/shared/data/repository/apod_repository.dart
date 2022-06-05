import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/apod.dart';
import '../datasource/apod_datasource.dart';
import '../dto/apod_dto.dart';

class ApodRepository {
  const ApodRepository({required ApodDatasource apodDatasource})
      : _apodDatasource = apodDatasource;

  final ApodDatasource _apodDatasource;

  Future<Apod> getApod() async {
    try {
      final apodJsonData = await _apodDatasource.getApod();

      return ApodDTO.fromJson(apodJsonData);
    } on Exception {
      throw const ApodFetchFailedException();
    } on TypeError {
      throw const ApodFetchFailedException();
    }
  }
}

class ApodFetchFailedException implements Exception {
  const ApodFetchFailedException();
}

final apodRepositoryProvider = Provider<ApodRepository>((ref) {
  final apodDatasource = ref.watch(apodDatasourceProvider);
  return ApodRepository(apodDatasource: apodDatasource);
});
