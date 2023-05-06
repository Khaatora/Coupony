import 'package:equatable/equatable.dart';

class TokenCacheResponse extends Equatable {
  final String jwt;

  const TokenCacheResponse({
    required this.jwt,
  });

  @override
  List<Object?> get props => [
        jwt,
      ];

  factory TokenCacheResponse.fromJson(Map<String, dynamic> json) {
    return TokenCacheResponse(
      jwt: json[TokenCacheJsonKeys.jwt],
    );
  }
}

class TokenCacheJsonKeys {
  static const String jwt = "jwt";
}
