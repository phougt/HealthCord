// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthToken {

@JsonKey(name: 'access_token') String get accessToken;@JsonKey(name: 'access_token_expiry') DateTime get accessTokenExpiryDate;@JsonKey(name: 'refresh_token') String get refreshToken;@JsonKey(name: 'refresh_token_expiry') DateTime get refreshTokenExpiryDate;
/// Create a copy of AuthToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthTokenCopyWith<AuthToken> get copyWith => _$AuthTokenCopyWithImpl<AuthToken>(this as AuthToken, _$identity);

  /// Serializes this AuthToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthToken&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.accessTokenExpiryDate, accessTokenExpiryDate) || other.accessTokenExpiryDate == accessTokenExpiryDate)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.refreshTokenExpiryDate, refreshTokenExpiryDate) || other.refreshTokenExpiryDate == refreshTokenExpiryDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,accessTokenExpiryDate,refreshToken,refreshTokenExpiryDate);

@override
String toString() {
  return 'AuthToken(accessToken: $accessToken, accessTokenExpiryDate: $accessTokenExpiryDate, refreshToken: $refreshToken, refreshTokenExpiryDate: $refreshTokenExpiryDate)';
}


}

/// @nodoc
abstract mixin class $AuthTokenCopyWith<$Res>  {
  factory $AuthTokenCopyWith(AuthToken value, $Res Function(AuthToken) _then) = _$AuthTokenCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'access_token') String accessToken,@JsonKey(name: 'access_token_expiry') DateTime accessTokenExpiryDate,@JsonKey(name: 'refresh_token') String refreshToken,@JsonKey(name: 'refresh_token_expiry') DateTime refreshTokenExpiryDate
});




}
/// @nodoc
class _$AuthTokenCopyWithImpl<$Res>
    implements $AuthTokenCopyWith<$Res> {
  _$AuthTokenCopyWithImpl(this._self, this._then);

  final AuthToken _self;
  final $Res Function(AuthToken) _then;

/// Create a copy of AuthToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? accessTokenExpiryDate = null,Object? refreshToken = null,Object? refreshTokenExpiryDate = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,accessTokenExpiryDate: null == accessTokenExpiryDate ? _self.accessTokenExpiryDate : accessTokenExpiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,refreshTokenExpiryDate: null == refreshTokenExpiryDate ? _self.refreshTokenExpiryDate : refreshTokenExpiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthToken].
extension AuthTokenPatterns on AuthToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthToken value)  $default,){
final _that = this;
switch (_that) {
case _AuthToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthToken value)?  $default,){
final _that = this;
switch (_that) {
case _AuthToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'access_token_expiry')  DateTime accessTokenExpiryDate, @JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'refresh_token_expiry')  DateTime refreshTokenExpiryDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthToken() when $default != null:
return $default(_that.accessToken,_that.accessTokenExpiryDate,_that.refreshToken,_that.refreshTokenExpiryDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'access_token_expiry')  DateTime accessTokenExpiryDate, @JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'refresh_token_expiry')  DateTime refreshTokenExpiryDate)  $default,) {final _that = this;
switch (_that) {
case _AuthToken():
return $default(_that.accessToken,_that.accessTokenExpiryDate,_that.refreshToken,_that.refreshTokenExpiryDate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'access_token_expiry')  DateTime accessTokenExpiryDate, @JsonKey(name: 'refresh_token')  String refreshToken, @JsonKey(name: 'refresh_token_expiry')  DateTime refreshTokenExpiryDate)?  $default,) {final _that = this;
switch (_that) {
case _AuthToken() when $default != null:
return $default(_that.accessToken,_that.accessTokenExpiryDate,_that.refreshToken,_that.refreshTokenExpiryDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthToken implements AuthToken {
  const _AuthToken({@JsonKey(name: 'access_token') required this.accessToken, @JsonKey(name: 'access_token_expiry') required this.accessTokenExpiryDate, @JsonKey(name: 'refresh_token') required this.refreshToken, @JsonKey(name: 'refresh_token_expiry') required this.refreshTokenExpiryDate});
  factory _AuthToken.fromJson(Map<String, dynamic> json) => _$AuthTokenFromJson(json);

@override@JsonKey(name: 'access_token') final  String accessToken;
@override@JsonKey(name: 'access_token_expiry') final  DateTime accessTokenExpiryDate;
@override@JsonKey(name: 'refresh_token') final  String refreshToken;
@override@JsonKey(name: 'refresh_token_expiry') final  DateTime refreshTokenExpiryDate;

/// Create a copy of AuthToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthTokenCopyWith<_AuthToken> get copyWith => __$AuthTokenCopyWithImpl<_AuthToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthToken&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.accessTokenExpiryDate, accessTokenExpiryDate) || other.accessTokenExpiryDate == accessTokenExpiryDate)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.refreshTokenExpiryDate, refreshTokenExpiryDate) || other.refreshTokenExpiryDate == refreshTokenExpiryDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,accessTokenExpiryDate,refreshToken,refreshTokenExpiryDate);

@override
String toString() {
  return 'AuthToken(accessToken: $accessToken, accessTokenExpiryDate: $accessTokenExpiryDate, refreshToken: $refreshToken, refreshTokenExpiryDate: $refreshTokenExpiryDate)';
}


}

/// @nodoc
abstract mixin class _$AuthTokenCopyWith<$Res> implements $AuthTokenCopyWith<$Res> {
  factory _$AuthTokenCopyWith(_AuthToken value, $Res Function(_AuthToken) _then) = __$AuthTokenCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'access_token') String accessToken,@JsonKey(name: 'access_token_expiry') DateTime accessTokenExpiryDate,@JsonKey(name: 'refresh_token') String refreshToken,@JsonKey(name: 'refresh_token_expiry') DateTime refreshTokenExpiryDate
});




}
/// @nodoc
class __$AuthTokenCopyWithImpl<$Res>
    implements _$AuthTokenCopyWith<$Res> {
  __$AuthTokenCopyWithImpl(this._self, this._then);

  final _AuthToken _self;
  final $Res Function(_AuthToken) _then;

/// Create a copy of AuthToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? accessTokenExpiryDate = null,Object? refreshToken = null,Object? refreshTokenExpiryDate = null,}) {
  return _then(_AuthToken(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,accessTokenExpiryDate: null == accessTokenExpiryDate ? _self.accessTokenExpiryDate : accessTokenExpiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,refreshTokenExpiryDate: null == refreshTokenExpiryDate ? _self.refreshTokenExpiryDate : refreshTokenExpiryDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
