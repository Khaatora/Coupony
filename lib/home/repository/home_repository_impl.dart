import 'package:dartz/dartz.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';
import 'package:maslaha/home/model/get_data_campaigns_response.dart';
import 'package:maslaha/home/repository/i_home_repository.dart';

class HomeRepositoryImpl implements IHomeRepository{
  @override
  Future<Either<ServerFailure, GetDataCampaignsResponse>> getDataCampaigns() {
    // TODO: implement getDataCampaigns
    throw UnimplementedError();
  }

}