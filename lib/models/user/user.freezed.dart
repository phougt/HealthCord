// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'username') String get username;@JsonKey(name: 'firstname') String get firstname;@JsonKey(name: 'lastname') String get lastname;@JsonKey(name: 'email') String get email;@JsonKey(name: 'phone') String? get phone;@JsonKey(name: 'profile') String? get profile;@JsonKey(name: 'blood_type_id') int? get bloodTypeId;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.firstname, firstname) || other.firstname == firstname)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.bloodTypeId, bloodTypeId) || other.bloodTypeId == bloodTypeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,firstname,lastname,email,phone,profile,bloodTypeId);

@override
String toString() {
  return 'User(id: $id, username: $username, firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, profile: $profile, bloodTypeId: $bloodTypeId)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'username') String username,@JsonKey(name: 'firstname') String firstname,@JsonKey(name: 'lastname') String lastname,@JsonKey(name: 'email') String email,@JsonKey(name: 'phone') String? phone,@JsonKey(name: 'profile') String? profile,@JsonKey(name: 'blood_type_id') int? bloodTypeId
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? username = null,Object? firstname = null,Object? lastname = null,Object? email = null,Object? phone = freezed,Object? profile = freezed,Object? bloodTypeId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstname: null == firstname ? _self.firstname : firstname // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as String?,bloodTypeId: freezed == bloodTypeId ? _self.bloodTypeId : bloodTypeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'username')  String username, @JsonKey(name: 'firstname')  String firstname, @JsonKey(name: 'lastname')  String lastname, @JsonKey(name: 'email')  String email, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'profile')  String? profile, @JsonKey(name: 'blood_type_id')  int? bloodTypeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.username,_that.firstname,_that.lastname,_that.email,_that.phone,_that.profile,_that.bloodTypeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'username')  String username, @JsonKey(name: 'firstname')  String firstname, @JsonKey(name: 'lastname')  String lastname, @JsonKey(name: 'email')  String email, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'profile')  String? profile, @JsonKey(name: 'blood_type_id')  int? bloodTypeId)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.id,_that.username,_that.firstname,_that.lastname,_that.email,_that.phone,_that.profile,_that.bloodTypeId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'username')  String username, @JsonKey(name: 'firstname')  String firstname, @JsonKey(name: 'lastname')  String lastname, @JsonKey(name: 'email')  String email, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'profile')  String? profile, @JsonKey(name: 'blood_type_id')  int? bloodTypeId)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.username,_that.firstname,_that.lastname,_that.email,_that.phone,_that.profile,_that.bloodTypeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User implements User {
  const _User({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'username') required this.username, @JsonKey(name: 'firstname') required this.firstname, @JsonKey(name: 'lastname') required this.lastname, @JsonKey(name: 'email') required this.email, @JsonKey(name: 'phone') this.phone, @JsonKey(name: 'profile') this.profile, @JsonKey(name: 'blood_type_id') this.bloodTypeId});
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'username') final  String username;
@override@JsonKey(name: 'firstname') final  String firstname;
@override@JsonKey(name: 'lastname') final  String lastname;
@override@JsonKey(name: 'email') final  String email;
@override@JsonKey(name: 'phone') final  String? phone;
@override@JsonKey(name: 'profile') final  String? profile;
@override@JsonKey(name: 'blood_type_id') final  int? bloodTypeId;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.username, username) || other.username == username)&&(identical(other.firstname, firstname) || other.firstname == firstname)&&(identical(other.lastname, lastname) || other.lastname == lastname)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.bloodTypeId, bloodTypeId) || other.bloodTypeId == bloodTypeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,username,firstname,lastname,email,phone,profile,bloodTypeId);

@override
String toString() {
  return 'User(id: $id, username: $username, firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, profile: $profile, bloodTypeId: $bloodTypeId)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'username') String username,@JsonKey(name: 'firstname') String firstname,@JsonKey(name: 'lastname') String lastname,@JsonKey(name: 'email') String email,@JsonKey(name: 'phone') String? phone,@JsonKey(name: 'profile') String? profile,@JsonKey(name: 'blood_type_id') int? bloodTypeId
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? username = null,Object? firstname = null,Object? lastname = null,Object? email = null,Object? phone = freezed,Object? profile = freezed,Object? bloodTypeId = freezed,}) {
  return _then(_User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,firstname: null == firstname ? _self.firstname : firstname // ignore: cast_nullable_to_non_nullable
as String,lastname: null == lastname ? _self.lastname : lastname // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as String?,bloodTypeId: freezed == bloodTypeId ? _self.bloodTypeId : bloodTypeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
