import '../dto/apod_dto.dart';
import '../../model/apod.dart';
import '../datasource/apod_datasource.dart';

class ApodRepository {
  const ApodRepository({required ApodDatasource apodDatasource})
      : _apodDatasource = apodDatasource;

  final ApodDatasource _apodDatasource;

  Future<Apod> getApod() async {
    final apodJsonData = await _apodDatasource.getApod();

    return ApodDTO.fromJson(apodJsonData);
  }
}