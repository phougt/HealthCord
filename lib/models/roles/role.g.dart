// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Role _$RoleFromJson(Map<String, dynamic> json) => _Role(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  groupId: (json['group_id'] as num).toInt(),
  isOwner: (json['is_owner'] as num).toInt(),
);

Map<String, dynamic> _$RoleToJson(_Role instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'group_id': instance.groupId,
  'is_owner': instance.isOwner,
};
