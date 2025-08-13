// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token.freezed.dart';
part 'auth_token.g.dart';

@freezed
sealed class AuthToken with _$AuthToken {
  const factory AuthToken({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'access_token_expiry')
    required DateTime accessTokenExpiryDate,
  }) = _AuthToken;

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);
}
