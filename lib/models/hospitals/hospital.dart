// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hospital.freezed.dart';
part 'hospital.g.dart';

@freezed
sealed class Hospital with _$Hospital {
  const factory Hospital({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
  }) = _Hospital;

  factory Hospital.fromJson(Map<String, dynamic> json) =>
      _$HospitalFromJson(json);
}
