// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  const factory User({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'firstname') required String firstname,
    @JsonKey(name: 'lastname') required String lastname,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'profile') String? profile,
    @JsonKey(name: 'blood_type_id') int? bloodTypeId,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
