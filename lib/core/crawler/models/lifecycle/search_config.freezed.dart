// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchConfig {

/// 搜索 URL 模板 (支持 {{key}}, {{page}} 变量)。
 String get url;/// 搜索结果列表提取 Pipeline。
 Map<String, Pipeline> get list;/// 分页配置。
 PaginationConfig? get pagination;/// URL 编码方式。
 UrlEncoding get encoding;
/// Create a copy of SearchConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchConfigCopyWith<SearchConfig> get copyWith => _$SearchConfigCopyWithImpl<SearchConfig>(this as SearchConfig, _$identity);

  /// Serializes this SearchConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchConfig&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.list, list)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.encoding, encoding) || other.encoding == encoding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,const DeepCollectionEquality().hash(list),pagination,encoding);

@override
String toString() {
  return 'SearchConfig(url: $url, list: $list, pagination: $pagination, encoding: $encoding)';
}


}

/// @nodoc
abstract mixin class $SearchConfigCopyWith<$Res>  {
  factory $SearchConfigCopyWith(SearchConfig value, $Res Function(SearchConfig) _then) = _$SearchConfigCopyWithImpl;
@useResult
$Res call({
 String url, Map<String, Pipeline> list, PaginationConfig? pagination, UrlEncoding encoding
});


$PaginationConfigCopyWith<$Res>? get pagination;

}
/// @nodoc
class _$SearchConfigCopyWithImpl<$Res>
    implements $SearchConfigCopyWith<$Res> {
  _$SearchConfigCopyWithImpl(this._self, this._then);

  final SearchConfig _self;
  final $Res Function(SearchConfig) _then;

/// Create a copy of SearchConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? list = null,Object? pagination = freezed,Object? encoding = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as Map<String, Pipeline>,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationConfig?,encoding: null == encoding ? _self.encoding : encoding // ignore: cast_nullable_to_non_nullable
as UrlEncoding,
  ));
}
/// Create a copy of SearchConfig
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


/// Adds pattern-matching-related methods to [SearchConfig].
extension SearchConfigPatterns on SearchConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchConfig value)  $default,){
final _that = this;
switch (_that) {
case _SearchConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchConfig value)?  $default,){
final _that = this;
switch (_that) {
case _SearchConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  Map<String, Pipeline> list,  PaginationConfig? pagination,  UrlEncoding encoding)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchConfig() when $default != null:
return $default(_that.url,_that.list,_that.pagination,_that.encoding);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  Map<String, Pipeline> list,  PaginationConfig? pagination,  UrlEncoding encoding)  $default,) {final _that = this;
switch (_that) {
case _SearchConfig():
return $default(_that.url,_that.list,_that.pagination,_that.encoding);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  Map<String, Pipeline> list,  PaginationConfig? pagination,  UrlEncoding encoding)?  $default,) {final _that = this;
switch (_that) {
case _SearchConfig() when $default != null:
return $default(_that.url,_that.list,_that.pagination,_that.encoding);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchConfig implements SearchConfig {
  const _SearchConfig({required this.url, required final  Map<String, Pipeline> list, this.pagination, this.encoding = UrlEncoding.utf8}): _list = list;
  factory _SearchConfig.fromJson(Map<String, dynamic> json) => _$SearchConfigFromJson(json);

/// 搜索 URL 模板 (支持 {{key}}, {{page}} 变量)。
@override final  String url;
/// 搜索结果列表提取 Pipeline。
 final  Map<String, Pipeline> _list;
/// 搜索结果列表提取 Pipeline。
@override Map<String, Pipeline> get list {
  if (_list is EqualUnmodifiableMapView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_list);
}

/// 分页配置。
@override final  PaginationConfig? pagination;
/// URL 编码方式。
@override@JsonKey() final  UrlEncoding encoding;

/// Create a copy of SearchConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchConfigCopyWith<_SearchConfig> get copyWith => __$SearchConfigCopyWithImpl<_SearchConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchConfig&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._list, _list)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.encoding, encoding) || other.encoding == encoding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,const DeepCollectionEquality().hash(_list),pagination,encoding);

@override
String toString() {
  return 'SearchConfig(url: $url, list: $list, pagination: $pagination, encoding: $encoding)';
}


}

/// @nodoc
abstract mixin class _$SearchConfigCopyWith<$Res> implements $SearchConfigCopyWith<$Res> {
  factory _$SearchConfigCopyWith(_SearchConfig value, $Res Function(_SearchConfig) _then) = __$SearchConfigCopyWithImpl;
@override @useResult
$Res call({
 String url, Map<String, Pipeline> list, PaginationConfig? pagination, UrlEncoding encoding
});


@override $PaginationConfigCopyWith<$Res>? get pagination;

}
/// @nodoc
class __$SearchConfigCopyWithImpl<$Res>
    implements _$SearchConfigCopyWith<$Res> {
  __$SearchConfigCopyWithImpl(this._self, this._then);

  final _SearchConfig _self;
  final $Res Function(_SearchConfig) _then;

/// Create a copy of SearchConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? list = null,Object? pagination = freezed,Object? encoding = null,}) {
  return _then(_SearchConfig(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as Map<String, Pipeline>,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationConfig?,encoding: null == encoding ? _self.encoding : encoding // ignore: cast_nullable_to_non_nullable
as UrlEncoding,
  ));
}

/// Create a copy of SearchConfig
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
