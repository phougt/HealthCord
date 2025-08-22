// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_link.freezed.dart';
part 'group_link.g.dart';

@freezed
sealed class GroupLink with _$GroupLink {
  const factory GroupLink({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'link') required String link,
  }) = _GroupLink;

  factory GroupLink.fromJson(Map<String, dynamic> json) =>
      _$GroupLinkFromJson(json);
}
