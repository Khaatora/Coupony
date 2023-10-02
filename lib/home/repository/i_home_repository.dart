import 'package:dartz/dartz.dart';
import 'package:maslaha/core/errors/failures/server_failure.dart';
import 'package:maslaha/home/model/get_banner_response.dart';


abstract class IHomeRepository{


  Future<Either<ServerFailure,GetBannerResponse>> getBannerData(GetBannerParams params);
}

class GetBannerParams{
  final String region;

  GetBannerParams(this.region);

  Map<String, dynamic> toJson() {
    return {
      GetBannerJsonKeys.region: region,
    };
  }
}