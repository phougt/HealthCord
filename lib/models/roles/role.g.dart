// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Role _$RoleFromJson(Map<String, dynamic> json) => _Role(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  groupId: (json['group_id'] as num).toInt(),
  type: const RoleTypeConverter().fromJson(json['type'] as String),
  permissions:
      (json['permissions'] as List<dynamic>?)
          ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$RoleToJson(_Role instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'group_id': instance.groupId,
  'type': const RoleTypeConverter().toJson(instance.type),
  'permissions': instance.permissions,
};
