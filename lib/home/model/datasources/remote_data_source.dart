import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:maslaha/home/model/get_data_campaigns_response.dart';
import 'package:maslaha/home/repository/i_home_repository.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions/api/exceptions.dart';
import '../../../core/services/services_locator.dart';

abstract class IHomeRemoteDataSource {


  Future<GetDataCampaignsResponse> getCampaignData(GetCampaignsParams params);

  const IHomeRemoteDataSource();

}

class APIHomeRemoteDataSource extends IHomeRemoteDataSource {

  const APIHomeRemoteDataSource();

  @override
  Future<GetDataCampaignsResponse> getCampaignData(GetCampaignsParams params) async {
    final response = await sl<Dio>().get(ApiConstants.getCampaignsDataUrl(),
        data: params.region !=null ? jsonEncode(params.toJson()): null,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }));
    switch (response.statusCode) {
      case 200:
        return GetDataCampaignsResponse.fromJson(response.data);
      default:
        throw const GenericAPIException();
    }
  }

}