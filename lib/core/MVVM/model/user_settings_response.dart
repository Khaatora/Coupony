import 'package:equatable/equatable.dart';
import 'package:maslaha/core/utils/enums/cache_enums.dart';

import '../../constants/cache_constants.dart';

class UserSettingsResponse extends Equatable {
  final String lang;
  final String region;
  final CacheState state;


  const UserSettingsResponse({
    required this.lang,
    required this.region,
    this.state = CacheState.init,
  });

  factory UserSettingsResponse.fromJson(Map<String, dynamic> json) {
    return UserSettingsResponse(
      lang: json[CachedJsonKeys.lang],
      region: json[CachedJsonKeys.region],
      state: CacheState.exists,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      CachedJsonKeys.lang: lang,
      CachedJsonKeys.region: region,
    };
  }

  @override
  List<Object?> get props => [
    lang,
    region,
    state,
  ];
}


