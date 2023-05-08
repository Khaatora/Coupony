import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:maslaha/core/MVVM/model/app_state_model.dart';
import 'package:maslaha/core/errors/exceptions/cache_exception.dart';
import 'package:maslaha/core/errors/exceptions/server_exception.dart';
import 'package:maslaha/core/errors/failures/IFailures.dart';
import 'package:maslaha/core/errors/failures/cache_failure.dart';
import 'package:maslaha/core/utils/enums/cache_enums.dart';
import 'package:maslaha/core/utils/enums/token_enums.dart';

import '../../errors/exceptions/api/exceptions.dart';
import '../../errors/failures/server_failure.dart';
import '../../services/network/network_info.dart';
import '../model/local/token_verification_local_data_source.dart';
import '../model/remote/token_verification_remote_data_source.dart';
import 'i_token_verification_repository.dart';

class TokenVerificationRepositoryImpl implements ITokenVerificationRepository{

  final INetworkInfo networkInfo;
  final ITokenVerificationLocalDataSource tokenVerificationLocalDataSource;
  final ITokenVerificationRemoteDataSource tokenVerificationRemoteDataSource;

  TokenVerificationRepositoryImpl(this.networkInfo, this.tokenVerificationLocalDataSource, this.tokenVerificationRemoteDataSource);

  @override
  Future<Either<IFailure, AppStateModel>> validateToken() async {
    try {
      await _checkInternetConnection();
      final token = await tokenVerificationLocalDataSource.getToken();
      final cachedSettings = await tokenVerificationLocalDataSource.getCachedUserSettings();
      if(cachedSettings.state == CacheState.empty){
        return const Right(AppStateModel(cacheState: CacheState.empty, tokenState: TokenState.init));
      }else{
        if(token == null){
            return const Right(AppStateModel(cacheState: CacheState.exists, tokenState: TokenState.init));
        }else{
          await tokenVerificationRemoteDataSource.validateToken(token);
          return const Right(AppStateModel(cacheState: CacheState.exists, tokenState: TokenState.valid));
        }
      }
    } on ServerException catch (failure) {
      if(failure.runtimeType is InvalidTokenException || failure.runtimeType is ExpiredTokenException || failure.runtimeType is MissingTokenException){
        final cachedSettings = await tokenVerificationLocalDataSource.getCachedUserSettings();
        if(cachedSettings.state == CacheState.empty){
          return const Right(AppStateModel(cacheState: CacheState.empty, tokenState: TokenState.invalid));
        }else{
          return const Right(AppStateModel(cacheState: CacheState.exists, tokenState: TokenState.invalid));
        }
      }else{
        return Left(ServerFailure(failure.message));
      }
    } on CacheException catch (failure){
      return Left(CacheFailure(failure.message));
    } on DioError catch (dioFailure) {
      log("${dioFailure.runtimeType}: ${dioFailure.message}, ${dioFailure.stackTrace}");
      return Left(ServerFailure(dioFailure.message!));
    }
  }


  Future<void> _checkInternetConnection() async {
    if (!await networkInfo.isConnected) throw const NoInternetException();
  }
}