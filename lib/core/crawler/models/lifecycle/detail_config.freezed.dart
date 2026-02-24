// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DetailConfig {

/// 详情字段提取 Pipeline。
 Map<String, Pipeline> get fields;/// 详情页 URL 模板 (支持 {{id}} 变量)。
 String? get url;/// 从列表项获取详情 URL 的选择器 (如果不使用 URL 模板)。
 String? get urlFromList;
/// Create a copy of DetailConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailConfigCopyWith<DetailConfig> get copyWith => _$DetailConfigCopyWithImpl<DetailConfig>(this as DetailConfig, _$identity);

  /// Serializes this DetailConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailConfig&&const DeepCollectionEquality().equals(other.fields, fields)&&(identical(other.url, url) || other.url == url)&&(identical(other.urlFromList, urlFromList) || other.urlFromList == urlFromList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(fields),url,urlFromList);

@override
String toString() {
  return 'DetailConfig(fields: $fields, url: $url, urlFromList: $urlFromList)';
}


}

/// @nodoc
abstract mixin class $DetailConfigCopyWith<$Res>  {
  factory $DetailConfigCopyWith(DetailConfig value, $Res Function(DetailConfig) _then) = _$DetailConfigCopyWithImpl;
@useResult
$Res call({
 Map<String, Pipeline> fields, String? url, String? urlFromList
});




}
/// @nodoc
class _$DetailConfigCopyWithImpl<$Res>
    implements $DetailConfigCopyWith<$Res> {
  _$DetailConfigCopyWithImpl(this._self, this._then);

  final DetailConfig _self;
  final $Res Function(DetailConfig) _then;

/// Create a copy of DetailConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fields = null,Object? url = freezed,Object? urlFromList = freezed,}) {
  return _then(_self.copyWith(
fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, Pipeline>,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,urlFromList: freezed == urlFromList ? _self.urlFromList : urlFromList // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DetailConfig].
extension DetailConfigPatterns on DetailConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DetailConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetailConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DetailConfig value)  $default,){
final _that = this;
switch (_that) {
case _DetailConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DetailConfig value)?  $default,){
final _that = this;
switch (_that) {
case _DetailConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, Pipeline> fields,  String? url,  String? urlFromList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetailConfig() when $default != null:
return $default(_that.fields,_that.url,_that.urlFromList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, Pipeline> fields,  String? url,  String? urlFromList)  $default,) {final _that = this;
switch (_that) {
case _DetailConfig():
return $default(_that.fields,_that.url,_that.urlFromList);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, Pipeline> fields,  String? url,  String? urlFromList)?  $default,) {final _that = this;
switch (_that) {
case _DetailConfig() when $default != null:
return $default(_that.fields,_that.url,_that.urlFromList);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DetailConfig implements DetailConfig {
  const _DetailConfig({required final  Map<String, Pipeline> fields, this.url, this.urlFromList}): _fields = fields;
  factory _DetailConfig.fromJson(Map<String, dynamic> json) => _$DetailConfigFromJson(json);

/// 详情字段提取 Pipeline。
 final  Map<String, Pipeline> _fields;
/// 详情字段提取 Pipeline。
@override Map<String, Pipeline> get fields {
  if (_fields is EqualUnmodifiableMapView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fields);
}

/// 详情页 URL 模板 (支持 {{id}} 变量)。
@override final  String? url;
/// 从列表项获取详情 URL 的选择器 (如果不使用 URL 模板)。
@override final  String? urlFromList;

/// Create a copy of DetailConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailConfigCopyWith<_DetailConfig> get copyWith => __$DetailConfigCopyWithImpl<_DetailConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DetailConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailConfig&&const DeepCollectionEquality().equals(other._fields, _fields)&&(identical(other.url, url) || other.url == url)&&(identical(other.urlFromList, urlFromList) || other.urlFromList == urlFromList));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_fields),url,urlFromList);

@override
String toString() {
  return 'DetailConfig(fields: $fields, url: $url, urlFromList: $urlFromList)';
}


}

/// @nodoc
abstract mixin class _$DetailConfigCopyWith<$Res> implements $DetailConfigCopyWith<$Res> {
  factory _$DetailConfigCopyWith(_DetailConfig value, $Res Function(_DetailConfig) _then) = __$DetailConfigCopyWithImpl;
@override @useResult
$Res call({
 Map<String, Pipeline> fields, String? url, String? urlFromList
});




}
/// @nodoc
class __$DetailConfigCopyWithImpl<$Res>
    implements _$DetailConfigCopyWith<$Res> {
  __$DetailConfigCopyWithImpl(this._self, this._then);

  final _DetailConfig _self;
  final $Res Function(_DetailConfig) _then;

/// Create a copy of DetailConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fields = null,Object? url = freezed,Object? urlFromList = freezed,}) {
  return _then(_DetailConfig(
fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, Pipeline>,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,urlFromList: freezed == urlFromList ? _self.urlFromList : urlFromList // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
