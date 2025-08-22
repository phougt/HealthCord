// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupLink {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'link') String get link;
/// Create a copy of GroupLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupLinkCopyWith<GroupLink> get copyWith => _$GroupLinkCopyWithImpl<GroupLink>(this as GroupLink, _$identity);

  /// Serializes this GroupLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupLink&&(identical(other.id, id) || other.id == id)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,link);

@override
String toString() {
  return 'GroupLink(id: $id, link: $link)';
}


}

/// @nodoc
abstract mixin class $GroupLinkCopyWith<$Res>  {
  factory $GroupLinkCopyWith(GroupLink value, $Res Function(GroupLink) _then) = _$GroupLinkCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'link') String link
});




}
/// @nodoc
class _$GroupLinkCopyWithImpl<$Res>
    implements $GroupLinkCopyWith<$Res> {
  _$GroupLinkCopyWithImpl(this._self, this._then);

  final GroupLink _self;
  final $Res Function(GroupLink) _then;

/// Create a copy of GroupLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? link = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupLink].
extension GroupLinkPatterns on GroupLink {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupLink() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupLink value)  $default,){
final _that = this;
switch (_that) {
case _GroupLink():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupLink value)?  $default,){
final _that = this;
switch (_that) {
case _GroupLink() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'link')  String link)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupLink() when $default != null:
return $default(_that.id,_that.link);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'link')  String link)  $default,) {final _that = this;
switch (_that) {
case _GroupLink():
return $default(_that.id,_that.link);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'link')  String link)?  $default,) {final _that = this;
switch (_that) {
case _GroupLink() when $default != null:
return $default(_that.id,_that.link);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupLink implements GroupLink {
  const _GroupLink({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'link') required this.link});
  factory _GroupLink.fromJson(Map<String, dynamic> json) => _$GroupLinkFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'link') final  String link;

/// Create a copy of GroupLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupLinkCopyWith<_GroupLink> get copyWith => __$GroupLinkCopyWithImpl<_GroupLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupLink&&(identical(other.id, id) || other.id == id)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,link);

@override
String toString() {
  return 'GroupLink(id: $id, link: $link)';
}


}

/// @nodoc
abstract mixin class _$GroupLinkCopyWith<$Res> implements $GroupLinkCopyWith<$Res> {
  factory _$GroupLinkCopyWith(_GroupLink value, $Res Function(_GroupLink) _then) = __$GroupLinkCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'link') String link
});




}
/// @nodoc
class __$GroupLinkCopyWithImpl<$Res>
    implements _$GroupLinkCopyWith<$Res> {
  __$GroupLinkCopyWithImpl(this._self, this._then);

  final _GroupLink _self;
  final $Res Function(_GroupLink) _then;

/// Create a copy of GroupLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? link = null,}) {
  return _then(_GroupLink(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
