import '../../../services/secured_storage_data/secured_storage_data.dart';
import '../../../utils/enums/cache_enums.dart';
import '../token_cache_response.dart';
import '../user_settings_response.dart';

abstract class ITokenVerificationLocalDataSource {
  Future<TokenCacheResponse> cacheToken(String token);
  Future<String?> getToken();
  Future<UserSettingsResponse> getCachedUserSettings();
}

class FSSTokenVerificationLocalDataSource extends ITokenVerificationLocalDataSource{

  final  ISecuredStorageData securedStorageData;

  FSSTokenVerificationLocalDataSource(this.securedStorageData);

  @override
  Future<TokenCacheResponse> cacheToken(String token) async {
    await securedStorageData.addToken(token);
    return TokenCacheResponse(jwt: token);
  }

  @override
  Future<String?> getToken() async {
    return await securedStorageData.token;
  }

  @override
  Future<UserSettingsResponse> getCachedUserSettings() async {
    final cacheTemp = await securedStorageData.loggedInUserData;
    if(cacheTemp != null){
      return UserSettingsResponse.fromJson(cacheTemp);
    }
    else{
      return const UserSettingsResponse(lang: "", region: "", state: CacheState.empty);
    }
  }

}