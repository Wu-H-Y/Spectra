// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transform.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Transform {

/// 转换类型。
 TransformType get type;/// 转换参数（根据类型而异）。
/// - regex: 模式（带可选替换）
/// - replace: {find: string, replace: string}
/// - date: 格式字符串（例如 "yyyy-MM-dd"）
/// - url: 用于解析相对 URL 的基础 URL
/// - substring: {start: int, end: int?}
/// - split: 分隔符
/// - join: 分隔符
/// - map: {key1: value1, key2: value2}
 dynamic get params;
/// Create a copy of Transform
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransformCopyWith<Transform> get copyWith => _$TransformCopyWithImpl<Transform>(this as Transform, _$identity);

  /// Serializes this Transform to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transform&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.params, params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(params));

@override
String toString() {
  return 'Transform(type: $type, params: $params)';
}


}

/// @nodoc
abstract mixin class $TransformCopyWith<$Res>  {
  factory $TransformCopyWith(Transform value, $Res Function(Transform) _then) = _$TransformCopyWithImpl;
@useResult
$Res call({
 TransformType type, dynamic params
});




}
/// @nodoc
class _$TransformCopyWithImpl<$Res>
    implements $TransformCopyWith<$Res> {
  _$TransformCopyWithImpl(this._self, this._then);

  final Transform _self;
  final $Res Function(Transform) _then;

/// Create a copy of Transform
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? params = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransformType,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [Transform].
extension TransformPatterns on Transform {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transform value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transform() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transform value)  $default,){
final _that = this;
switch (_that) {
case _Transform():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transform value)?  $default,){
final _that = this;
switch (_that) {
case _Transform() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransformType type,  dynamic params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transform() when $default != null:
return $default(_that.type,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransformType type,  dynamic params)  $default,) {final _that = this;
switch (_that) {
case _Transform():
return $default(_that.type,_that.params);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransformType type,  dynamic params)?  $default,) {final _that = this;
switch (_that) {
case _Transform() when $default != null:
return $default(_that.type,_that.params);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Transform implements Transform {
  const _Transform({required this.type, this.params});
  factory _Transform.fromJson(Map<String, dynamic> json) => _$TransformFromJson(json);

/// 转换类型。
@override final  TransformType type;
/// 转换参数（根据类型而异）。
/// - regex: 模式（带可选替换）
/// - replace: {find: string, replace: string}
/// - date: 格式字符串（例如 "yyyy-MM-dd"）
/// - url: 用于解析相对 URL 的基础 URL
/// - substring: {start: int, end: int?}
/// - split: 分隔符
/// - join: 分隔符
/// - map: {key1: value1, key2: value2}
@override final  dynamic params;

/// Create a copy of Transform
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransformCopyWith<_Transform> get copyWith => __$TransformCopyWithImpl<_Transform>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransformToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transform&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.params, params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(params));

@override
String toString() {
  return 'Transform(type: $type, params: $params)';
}


}

/// @nodoc
abstract mixin class _$TransformCopyWith<$Res> implements $TransformCopyWith<$Res> {
  factory _$TransformCopyWith(_Transform value, $Res Function(_Transform) _then) = __$TransformCopyWithImpl;
@override @useResult
$Res call({
 TransformType type, dynamic params
});




}
/// @nodoc
class __$TransformCopyWithImpl<$Res>
    implements _$TransformCopyWith<$Res> {
  __$TransformCopyWithImpl(this._self, this._then);

  final _Transform _self;
  final $Res Function(_Transform) _then;

/// Create a copy of Transform
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? params = freezed,}) {
  return _then(_Transform(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransformType,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

// dart format on
