import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services_locator.dart';

abstract class ISecuredStorageData {
  const ISecuredStorageData();

  Future<String?> get token;

  Future<Map<String, dynamic>?> get loggedInUserData;

  Future<void> addToken(String token);

  Future<void> cacheLoggedInUserSettings(Map<String, dynamic> token);

  Future<void> deleteCachedLoggedInUserSettings();

  Future<void> addItem(String key, dynamic value);

  Future<String?> getItem(String key);

  Future<void> deleteAll();

  Future<Map<String, String>> readAll();
}

class FSSSecuredStorageData extends ISecuredStorageData {
  final FlutterSecureStorage _storage;

  //runtime cache
  static Map<String, dynamic> tempCache = {};

  /// Recaches data whenever settings change, call whenever add data to SecureSharedPreferences
  static Future<void> cacheTmpCache() async {
    final tmpResult = await sl<FlutterSecureStorage>().readAll();
    log("CACHING tempCACHE ENDPOINT.....");
    if(tmpResult[SecuredStorageKeys.cachedLoggedInUserDataKey]!= null){
      tempCache.addAll(json
          .decode(tmpResult[SecuredStorageKeys.cachedLoggedInUserDataKey]!));
      tempCache.forEach((key, value) {
        log("Key: $key, Value: $value");
      });
    }
  }

  const FSSSecuredStorageData(this._storage);

  @override
  Future<Map<String, String>> readAll() async {
    final tmpResult= await _storage.readAll();

    return tmpResult;
  }

  @override
  Future<void> addToken(String token) async {
    return _storage.write(
      key: SecuredStorageKeys.accessTokenKey,
      value: token,
    );
  }

  @override
  Future<void> cacheLoggedInUserSettings(Map<String, dynamic> token) async {
    return _storage.write(
      key: SecuredStorageKeys.cachedLoggedInUserDataKey,
      value: json.encode(token),
    );
  }

  Future<Map<String, dynamic>?> _getCachedLoggedInUserSettings() async {
    final jsonString = await _storage.read(
      key: SecuredStorageKeys.cachedLoggedInUserDataKey,
    );
    if(jsonString !=null) {
      log(json.decode(jsonString).toString());
      return json.decode(jsonString);
    } else {
      return null;
    }
  }


  @override
  Future<void> deleteCachedLoggedInUserSettings() async {
    return _storage.delete( key: SecuredStorageKeys.cachedLoggedInUserDataKey,);
  }

  @override
  Future<void> addItem(String key, dynamic value) async {
    return _storage.write(
      key: key,
      value: value,
    );
  }

  @override
  Future<String?> getItem(String key) {
    return _getItem(key);
  }

  @override
  Future<void> deleteAll() async {
    return _storage.deleteAll();
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  @override
  Future<Map<String, dynamic>?> get loggedInUserData =>
      _getCachedLoggedInUserSettings();

  @override
  Future<String?> get token => _getToken();

  Future<String?> _getToken() async {
    return await _storage.read(
      key: SecuredStorageKeys.accessTokenKey,
    );
  }

  Future<String?> _getItem(String key) async {
    return await _storage.read(
      key: key,
    );
  }



}

class SecuredStorageKeys {
  static const String accessTokenKey = "accessToken";
  static const String cachedLoggedInUserDataKey = "cachedLoggedInUserData";
  static const String lang = "lang";
  static const String region = "region";
}
