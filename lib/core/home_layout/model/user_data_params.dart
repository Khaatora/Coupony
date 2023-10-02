import 'package:equatable/equatable.dart';


import '../../constants/cache_constants.dart';

class UserSettingsParams extends Equatable {
  final String lang;
  final String region;

  const UserSettingsParams({required this.lang, required this.region});

  @override
  List<Object?> get props => [
        lang,
        region,
      ];

  Map<String, dynamic> toJson(){
    return {
      CachedJsonKeys.lang: lang,
      CachedJsonKeys.region: region,
    };
  }
}
