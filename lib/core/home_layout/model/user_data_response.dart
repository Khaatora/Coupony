import 'dart:convert';

import 'package:equatable/equatable.dart';
import '../../constants/cache_constants.dart';

class UserDataResponse extends Equatable {
  final UserSettings userSettings;
  final String token;


  const UserDataResponse({
    required this.userSettings,
    required this.token,
  });

  factory UserDataResponse.fromJson(Map<String, dynamic> json) {
    return UserDataResponse(
      userSettings: UserSettings.fromJson(jsonDecode(json[CachedJsonKeys.cachedLoggedInUserDataKey])),
      token: json[CachedJsonKeys.token] ?? "",
    );
  }

  Map<String, dynamic> toJson(){
    return {
      CachedJsonKeys.lang: userSettings.lang,
      CachedJsonKeys.region: userSettings.region,
      CachedJsonKeys.token: token,
    };
  }

  @override
  List<Object?> get props => [
    token,
    userSettings,
  ];
}

class UserSettings{
  final String lang;
  final String region;

  const UserSettings({required this.lang, required this.region});

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(lang: json[CachedJsonKeys.lang], region: json[CachedJsonKeys.region],);
  }


}