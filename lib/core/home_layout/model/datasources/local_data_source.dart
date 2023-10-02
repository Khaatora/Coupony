import 'dart:developer';

import 'package:maslaha/core/home_layout/model/user_data_response.dart';

import '../../../services/secured_storage_data/secured_storage_data.dart';

abstract class IHomeLayoutLocalDataSource {
  Future<UserDataResponse> getCachedData();
}

class FSSHomeLayoutLocalDataSource implements IHomeLayoutLocalDataSource{
  final ISecuredStorageData securedStorageData;

  FSSHomeLayoutLocalDataSource(this.securedStorageData);

  @override
  Future<UserDataResponse> getCachedData() async {
    final cacheTemp = await securedStorageData.readAll();
      log(cacheTemp.toString());
    if(cacheTemp != null){
      return UserDataResponse.fromJson(cacheTemp);
    }
    else{
      return const UserDataResponse(token: "", userSettings: UserSettings(region: "", lang: ""));
    }
  }
}
