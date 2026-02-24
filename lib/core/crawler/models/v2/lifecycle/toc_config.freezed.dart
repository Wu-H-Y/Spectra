// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toc_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TocConfig {

/// 章节列表容器选择器。
 String get container;/// 章节字段提取 Pipeline。
 Map<String, Pipeline> get fields;/// 目录页 URL 模板 (支持 {{id}} 变量)。
 String? get url;/// 是否为逆序 (最新在前)。
 bool get reverseOrder;/// 分页配置 (多页目录)。
 PaginationConfig? get pagination;
/// Create a copy of TocConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TocConfigCopyWith<TocConfig> get copyWith => _$TocConfigCopyWithImpl<TocConfig>(this as TocConfig, _$identity);

  /// Serializes this TocConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TocConfig&&(identical(other.container, container) || other.container == container)&&const DeepCollectionEquality().equals(other.fields, fields)&&(identical(other.url, url) || other.url == url)&&(identical(other.reverseOrder, reverseOrder) || other.reverseOrder == reverseOrder)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,container,const DeepCollectionEquality().hash(fields),url,reverseOrder,pagination);

@override
String toString() {
  return 'TocConfig(container: $container, fields: $fields, url: $url, reverseOrder: $reverseOrder, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $TocConfigCopyWith<$Res>  {
  factory $TocConfigCopyWith(TocConfig value, $Res Function(TocConfig) _then) = _$TocConfigCopyWithImpl;
@useResult
$Res call({
 String container, Map<String, Pipeline> fields, String? url, bool reverseOrder, PaginationConfig? pagination
});


$PaginationConfigCopyWith<$Res>? get pagination;

}
/// @nodoc
class _$TocConfigCopyWithImpl<$Res>
    implements $TocConfigCopyWith<$Res> {
  _$TocConfigCopyWithImpl(this._self, this._then);

  final TocConfig _self;
  final $Res Function(TocConfig) _then;

/// Create a copy of TocConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? container = null,Object? fields = null,Object? url = freezed,Object? reverseOrder = null,Object? pagination = freezed,}) {
  return _then(_self.copyWith(
container: null == container ? _self.container : container // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, Pipeline>,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,reverseOrder: null == reverseOrder ? _self.reverseOrder : reverseOrder // ignore: cast_nullable_to_non_nullable
as bool,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationConfig?,
  ));
}
/// Create a copy of TocConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationConfigCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
    return null;
  }

  return $PaginationConfigCopyWith<$Res>(_self.pagination!, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}


/// Adds pattern-matching-related methods to [TocConfig].
extension TocConfigPatterns on TocConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TocConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TocConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TocConfig value)  $default,){
final _that = this;
switch (_that) {
case _TocConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TocConfig value)?  $default,){
final _that = this;
switch (_that) {
case _TocConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String container,  Map<String, Pipeline> fields,  String? url,  bool reverseOrder,  PaginationConfig? pagination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TocConfig() when $default != null:
return $default(_that.container,_that.fields,_that.url,_that.reverseOrder,_that.pagination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String container,  Map<String, Pipeline> fields,  String? url,  bool reverseOrder,  PaginationConfig? pagination)  $default,) {final _that = this;
switch (_that) {
case _TocConfig():
return $default(_that.container,_that.fields,_that.url,_that.reverseOrder,_that.pagination);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String container,  Map<String, Pipeline> fields,  String? url,  bool reverseOrder,  PaginationConfig? pagination)?  $default,) {final _that = this;
switch (_that) {
case _TocConfig() when $default != null:
return $default(_that.container,_that.fields,_that.url,_that.reverseOrder,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TocConfig implements TocConfig {
  const _TocConfig({required this.container, required final  Map<String, Pipeline> fields, this.url, this.reverseOrder = false, this.pagination}): _fields = fields;
  factory _TocConfig.fromJson(Map<String, dynamic> json) => _$TocConfigFromJson(json);

/// 章节列表容器选择器。
@override final  String container;
/// 章节字段提取 Pipeline。
 final  Map<String, Pipeline> _fields;
/// 章节字段提取 Pipeline。
@override Map<String, Pipeline> get fields {
  if (_fields is EqualUnmodifiableMapView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fields);
}

/// 目录页 URL 模板 (支持 {{id}} 变量)。
@override final  String? url;
/// 是否为逆序 (最新在前)。
@override@JsonKey() final  bool reverseOrder;
/// 分页配置 (多页目录)。
@override final  PaginationConfig? pagination;

/// Create a copy of TocConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TocConfigCopyWith<_TocConfig> get copyWith => __$TocConfigCopyWithImpl<_TocConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TocConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TocConfig&&(identical(other.container, container) || other.container == container)&&const DeepCollectionEquality().equals(other._fields, _fields)&&(identical(other.url, url) || other.url == url)&&(identical(other.reverseOrder, reverseOrder) || other.reverseOrder == reverseOrder)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,container,const DeepCollectionEquality().hash(_fields),url,reverseOrder,pagination);

@override
String toString() {
  return 'TocConfig(container: $container, fields: $fields, url: $url, reverseOrder: $reverseOrder, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$TocConfigCopyWith<$Res> implements $TocConfigCopyWith<$Res> {
  factory _$TocConfigCopyWith(_TocConfig value, $Res Function(_TocConfig) _then) = __$TocConfigCopyWithImpl;
@override @useResult
$Res call({
 String container, Map<String, Pipeline> fields, String? url, bool reverseOrder, PaginationConfig? pagination
});


@override $PaginationConfigCopyWith<$Res>? get pagination;

}
/// @nodoc
class __$TocConfigCopyWithImpl<$Res>
    implements _$TocConfigCopyWith<$Res> {
  __$TocConfigCopyWithImpl(this._self, this._then);

  final _TocConfig _self;
  final $Res Function(_TocConfig) _then;

/// Create a copy of TocConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? container = null,Object? fields = null,Object? url = freezed,Object? reverseOrder = null,Object? pagination = freezed,}) {
  return _then(_TocConfig(
container: null == container ? _self.container : container // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, Pipeline>,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,reverseOrder: null == reverseOrder ? _self.reverseOrder : reverseOrder // ignore: cast_nullable_to_non_nullable
as bool,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationConfig?,
  ));
}

/// Create a copy of TocConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationConfigCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
    return null;
  }

  return $PaginationConfigCopyWith<$Res>(_self.pagination!, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}

// dart format on
