
import 'package:dartz/dartz.dart';
import 'package:maslaha/core/errors/exceptions/cache_exception.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';
import 'package:maslaha/core/services/secured_storage_data/secured_storage_data.dart';
import 'package:maslaha/core/utils/enums/cache_enums.dart';
import 'package:maslaha/initial_preferences/model/user_settings_params.dart';
import 'package:maslaha/initial_preferences/repository/i_initial_preferences_repository.dart';
import '../model/datasource/local/local_data_source.dart';
import '../../core/MVVM/model/user_settings_response.dart';

class InitialPreferencesRepositoryImpl extends IInitialPreferencesRepository{

  final IInitialPrefsLocalDataSource localDataSource;


  InitialPreferencesRepositoryImpl(this.localDataSource);

  @override
  Future<Either<ServerFailure, UserSettingsResponse>> cacheData(UserSettingsParams params) async {
    try {
      await localDataSource.cacheData(params);
      await FSSSecuredStorageData.cacheTmpCache();
      return Right(UserSettingsResponse(region: params.region, lang: params.lang, state: CacheState.exists));
    } on CacheException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<ServerFailure, UserSettingsResponse>> getCachedData() async {
    try {
      final result = await localDataSource.getCachedData();
      return Right(result);
    } on CacheException catch (failure) {
      return Left(ServerFailure(failure.message));
    }
  }

}