// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
sealed class Group with _$Group {
  const factory Group({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'group_profile') String? groupProfile,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
