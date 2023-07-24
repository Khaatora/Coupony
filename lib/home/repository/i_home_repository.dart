import 'package:dartz/dartz.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';

import '../model/get_data_campaigns_response.dart';

abstract class IHomeRepository{

  Future<Either<ServerFailure,GetDataCampaignsResponse>> getDataCampaigns();
}

class GetCampaignsParams{
  final String? region;

  GetCampaignsParams(this.region);

  Map<String, dynamic> toJson() {
    return {
      GetDataCampaignsJsonKeys.region: region,
    };
  }
}