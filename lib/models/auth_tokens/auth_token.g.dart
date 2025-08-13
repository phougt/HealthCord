// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthToken _$AuthTokenFromJson(Map<String, dynamic> json) => _AuthToken(
  accessToken: json['access_token'] as String,
  accessTokenExpiryDate: DateTime.parse(json['access_token_expiry'] as String),
);

Map<String, dynamic> _$AuthTokenToJson(_AuthToken instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'access_token_expiry': instance.accessTokenExpiryDate.toIso8601String(),
    };
