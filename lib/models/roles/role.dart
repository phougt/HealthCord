// ignore_for_file: invalid_annotation_target

import 'package:family_health_record/enums/role_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'role.freezed.dart';
part 'role.g.dart';

@freezed
sealed class Role with _$Role {
  const factory Role({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'group_id') required int groupId,
    @RoleTypeConverter() @JsonKey(name: 'type') required RoleType type,
    @JsonKey(name: 'permissions') @Default([]) List<String> permissions,
  }) = _Role;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}

class RoleTypeConverter implements JsonConverter<RoleType, String> {
  const RoleTypeConverter();

  @override
  RoleType fromJson(String json) {
    return RoleType.fromValue(json);
  }

  @override
  String toJson(RoleType object) => object.value;
}
