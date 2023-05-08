import 'package:dartz/dartz.dart';

import '../../core/errors/failures/server_failure.dart';
import '../model/user_settings_params.dart';
import '../../core/MVVM/model/user_settings_response.dart';

abstract class IInitialPreferencesRepository {

  Future<Either<ServerFailure, UserSettingsResponse>> cacheData(UserSettingsParams params);

  Future<Either<ServerFailure, UserSettingsResponse>> getCachedData();


}