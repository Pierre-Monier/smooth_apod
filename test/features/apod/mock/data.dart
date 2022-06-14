import 'package:smooth_apod/shared/data/dto/apod_dto.dart';

import '../../../shared/mock/data.dart';
import 'class.dart';

final mockApod = ApodDTO.fromJson(mockApodJsonDataImage);
final mockApodRepository = MockApodRepository();
