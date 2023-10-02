import 'package:maslaha/core/services/secured_storage_data/secured_storage_data.dart';
import 'package:maslaha/core/utils/enums/cache_enums.dart';
import 'package:maslaha/core/home_layout/model/user_data_params.dart';
import 'package:maslaha/core/MVVM/model/user_settings_response.dart';

abstract class IInitialPrefsLocalDataSource{

  Future<void> cacheData(UserSettingsParams params);

  Future<UserSettingsResponse> getCachedData();
}


class FSSInitialPrefsLocalDataSource extends IInitialPrefsLocalDataSource{

  final ISecuredStorageData securedStorageData;

  FSSInitialPrefsLocalDataSource(this.securedStorageData);

  @override
  Future<void> cacheData(UserSettingsParams params) {
    return securedStorageData.cacheLoggedInUserSettings(params.toJson());
  }

  @override
  Future<UserSettingsResponse> getCachedData() async {
    final cacheTemp = await securedStorageData.loggedInUserData;
    if(cacheTemp != null){
      return UserSettingsResponse.fromJson(cacheTemp);
    }
    else{
      return const UserSettingsResponse(lang: "", region: "", state: CacheState.empty);
    }
  }
}