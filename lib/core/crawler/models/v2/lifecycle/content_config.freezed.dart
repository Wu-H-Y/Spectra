// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SniffConfig {

/// 匹配正则列表。
 List<String> get matchRegex;/// 排除正则列表。
 List<String>? get excludeRegex;/// 嗅探超时时间 (毫秒)。
 int get timeout;/// 后处理 JavaScript 脚本。
 String? get script;
/// Create a copy of SniffConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SniffConfigCopyWith<SniffConfig> get copyWith => _$SniffConfigCopyWithImpl<SniffConfig>(this as SniffConfig, _$identity);

  /// Serializes this SniffConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SniffConfig&&const DeepCollectionEquality().equals(other.matchRegex, matchRegex)&&const DeepCollectionEquality().equals(other.excludeRegex, excludeRegex)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&(identical(other.script, script) || other.script == script));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(matchRegex),const DeepCollectionEquality().hash(excludeRegex),timeout,script);

@override
String toString() {
  return 'SniffConfig(matchRegex: $matchRegex, excludeRegex: $excludeRegex, timeout: $timeout, script: $script)';
}


}

/// @nodoc
abstract mixin class $SniffConfigCopyWith<$Res>  {
  factory $SniffConfigCopyWith(SniffConfig value, $Res Function(SniffConfig) _then) = _$SniffConfigCopyWithImpl;
@useResult
$Res call({
 List<String> matchRegex, List<String>? excludeRegex, int timeout, String? script
});




}
/// @nodoc
class _$SniffConfigCopyWithImpl<$Res>
    implements $SniffConfigCopyWith<$Res> {
  _$SniffConfigCopyWithImpl(this._self, this._then);

  final SniffConfig _self;
  final $Res Function(SniffConfig) _then;

/// Create a copy of SniffConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchRegex = null,Object? excludeRegex = freezed,Object? timeout = null,Object? script = freezed,}) {
  return _then(_self.copyWith(
matchRegex: null == matchRegex ? _self.matchRegex : matchRegex // ignore: cast_nullable_to_non_nullable
as List<String>,excludeRegex: freezed == excludeRegex ? _self.excludeRegex : excludeRegex // ignore: cast_nullable_to_non_nullable
as List<String>?,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as int,script: freezed == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SniffConfig].
extension SniffConfigPatterns on SniffConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SniffConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SniffConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SniffConfig value)  $default,){
final _that = this;
switch (_that) {
case _SniffConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SniffConfig value)?  $default,){
final _that = this;
switch (_that) {
case _SniffConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> matchRegex,  List<String>? excludeRegex,  int timeout,  String? script)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SniffConfig() when $default != null:
return $default(_that.matchRegex,_that.excludeRegex,_that.timeout,_that.script);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> matchRegex,  List<String>? excludeRegex,  int timeout,  String? script)  $default,) {final _that = this;
switch (_that) {
case _SniffConfig():
return $default(_that.matchRegex,_that.excludeRegex,_that.timeout,_that.script);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> matchRegex,  List<String>? excludeRegex,  int timeout,  String? script)?  $default,) {final _that = this;
switch (_that) {
case _SniffConfig() when $default != null:
return $default(_that.matchRegex,_that.excludeRegex,_that.timeout,_that.script);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SniffConfig implements SniffConfig {
  const _SniffConfig({required final  List<String> matchRegex, final  List<String>? excludeRegex, this.timeout = 15000, this.script}): _matchRegex = matchRegex,_excludeRegex = excludeRegex;
  factory _SniffConfig.fromJson(Map<String, dynamic> json) => _$SniffConfigFromJson(json);

/// 匹配正则列表。
 final  List<String> _matchRegex;
/// 匹配正则列表。
@override List<String> get matchRegex {
  if (_matchRegex is EqualUnmodifiableListView) return _matchRegex;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matchRegex);
}

/// 排除正则列表。
 final  List<String>? _excludeRegex;
/// 排除正则列表。
@override List<String>? get excludeRegex {
  final value = _excludeRegex;
  if (value == null) return null;
  if (_excludeRegex is EqualUnmodifiableListView) return _excludeRegex;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// 嗅探超时时间 (毫秒)。
@override@JsonKey() final  int timeout;
/// 后处理 JavaScript 脚本。
@override final  String? script;

/// Create a copy of SniffConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SniffConfigCopyWith<_SniffConfig> get copyWith => __$SniffConfigCopyWithImpl<_SniffConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SniffConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SniffConfig&&const DeepCollectionEquality().equals(other._matchRegex, _matchRegex)&&const DeepCollectionEquality().equals(other._excludeRegex, _excludeRegex)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&(identical(other.script, script) || other.script == script));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_matchRegex),const DeepCollectionEquality().hash(_excludeRegex),timeout,script);

@override
String toString() {
  return 'SniffConfig(matchRegex: $matchRegex, excludeRegex: $excludeRegex, timeout: $timeout, script: $script)';
}


}

/// @nodoc
abstract mixin class _$SniffConfigCopyWith<$Res> implements $SniffConfigCopyWith<$Res> {
  factory _$SniffConfigCopyWith(_SniffConfig value, $Res Function(_SniffConfig) _then) = __$SniffConfigCopyWithImpl;
@override @useResult
$Res call({
 List<String> matchRegex, List<String>? excludeRegex, int timeout, String? script
});




}
/// @nodoc
class __$SniffConfigCopyWithImpl<$Res>
    implements _$SniffConfigCopyWith<$Res> {
  __$SniffConfigCopyWithImpl(this._self, this._then);

  final _SniffConfig _self;
  final $Res Function(_SniffConfig) _then;

/// Create a copy of SniffConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchRegex = null,Object? excludeRegex = freezed,Object? timeout = null,Object? script = freezed,}) {
  return _then(_SniffConfig(
matchRegex: null == matchRegex ? _self._matchRegex : matchRegex // ignore: cast_nullable_to_non_nullable
as List<String>,excludeRegex: freezed == excludeRegex ? _self._excludeRegex : excludeRegex // ignore: cast_nullable_to_non_nullable
as List<String>?,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as int,script: freezed == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ContentConfig {

/// 媒体内容类型。
 MediaContentType get type;/// 内容页 URL 模板 (支持 {{id}}, {{chapterId}} 变量)。
 String? get url;/// 提取策略。
 ContentStrategy get strategy;/// 解析字段提取 Pipeline (strategy = parse)。
 Map<String, Pipeline>? get fields;/// 嗅探配置 (strategy = sniff)。
 SniffConfig? get sniff;
/// Create a copy of ContentConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentConfigCopyWith<ContentConfig> get copyWith => _$ContentConfigCopyWithImpl<ContentConfig>(this as ContentConfig, _$identity);

  /// Serializes this ContentConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.strategy, strategy) || other.strategy == strategy)&&const DeepCollectionEquality().equals(other.fields, fields)&&(identical(other.sniff, sniff) || other.sniff == sniff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,url,strategy,const DeepCollectionEquality().hash(fields),sniff);

@override
String toString() {
  return 'ContentConfig(type: $type, url: $url, strategy: $strategy, fields: $fields, sniff: $sniff)';
}


}

/// @nodoc
abstract mixin class $ContentConfigCopyWith<$Res>  {
  factory $ContentConfigCopyWith(ContentConfig value, $Res Function(ContentConfig) _then) = _$ContentConfigCopyWithImpl;
@useResult
$Res call({
 MediaContentType type, String? url, ContentStrategy strategy, Map<String, Pipeline>? fields, SniffConfig? sniff
});


$SniffConfigCopyWith<$Res>? get sniff;

}
/// @nodoc
class _$ContentConfigCopyWithImpl<$Res>
    implements $ContentConfigCopyWith<$Res> {
  _$ContentConfigCopyWithImpl(this._self, this._then);

  final ContentConfig _self;
  final $Res Function(ContentConfig) _then;

/// Create a copy of ContentConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? url = freezed,Object? strategy = null,Object? fields = freezed,Object? sniff = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MediaContentType,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as ContentStrategy,fields: freezed == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, Pipeline>?,sniff: freezed == sniff ? _self.sniff : sniff // ignore: cast_nullable_to_non_nullable
as SniffConfig?,
  ));
}
/// Create a copy of ContentConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SniffConfigCopyWith<$Res>? get sniff {
    if (_self.sniff == null) {
    return null;
  }

  return $SniffConfigCopyWith<$Res>(_self.sniff!, (value) {
    return _then(_self.copyWith(sniff: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContentConfig].
extension ContentConfigPatterns on ContentConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentConfig value)  $default,){
final _that = this;
switch (_that) {
case _ContentConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ContentConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MediaContentType type,  String? url,  ContentStrategy strategy,  Map<String, Pipeline>? fields,  SniffConfig? sniff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentConfig() when $default != null:
return $default(_that.type,_that.url,_that.strategy,_that.fields,_that.sniff);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MediaContentType type,  String? url,  ContentStrategy strategy,  Map<String, Pipeline>? fields,  SniffConfig? sniff)  $default,) {final _that = this;
switch (_that) {
case _ContentConfig():
return $default(_that.type,_that.url,_that.strategy,_that.fields,_that.sniff);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MediaContentType type,  String? url,  ContentStrategy strategy,  Map<String, Pipeline>? fields,  SniffConfig? sniff)?  $default,) {final _that = this;
switch (_that) {
case _ContentConfig() when $default != null:
return $default(_that.type,_that.url,_that.strategy,_that.fields,_that.sniff);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentConfig implements ContentConfig {
  const _ContentConfig({required this.type, this.url, this.strategy = ContentStrategy.parse, final  Map<String, Pipeline>? fields, this.sniff}): _fields = fields;
  factory _ContentConfig.fromJson(Map<String, dynamic> json) => _$ContentConfigFromJson(json);

/// 媒体内容类型。
@override final  MediaContentType type;
/// 内容页 URL 模板 (支持 {{id}}, {{chapterId}} 变量)。
@override final  String? url;
/// 提取策略。
@override@JsonKey() final  ContentStrategy strategy;
/// 解析字段提取 Pipeline (strategy = parse)。
 final  Map<String, Pipeline>? _fields;
/// 解析字段提取 Pipeline (strategy = parse)。
@override Map<String, Pipeline>? get fields {
  final value = _fields;
  if (value == null) return null;
  if (_fields is EqualUnmodifiableMapView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// 嗅探配置 (strategy = sniff)。
@override final  SniffConfig? sniff;

/// Create a copy of ContentConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentConfigCopyWith<_ContentConfig> get copyWith => __$ContentConfigCopyWithImpl<_ContentConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.url, url) || other.url == url)&&(identical(other.strategy, strategy) || other.strategy == strategy)&&const DeepCollectionEquality().equals(other._fields, _fields)&&(identical(other.sniff, sniff) || other.sniff == sniff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,url,strategy,const DeepCollectionEquality().hash(_fields),sniff);

@override
String toString() {
  return 'ContentConfig(type: $type, url: $url, strategy: $strategy, fields: $fields, sniff: $sniff)';
}


}

/// @nodoc
abstract mixin class _$ContentConfigCopyWith<$Res> implements $ContentConfigCopyWith<$Res> {
  factory _$ContentConfigCopyWith(_ContentConfig value, $Res Function(_ContentConfig) _then) = __$ContentConfigCopyWithImpl;
@override @useResult
$Res call({
 MediaContentType type, String? url, ContentStrategy strategy, Map<String, Pipeline>? fields, SniffConfig? sniff
});


@override $SniffConfigCopyWith<$Res>? get sniff;

}
/// @nodoc
class __$ContentConfigCopyWithImpl<$Res>
    implements _$ContentConfigCopyWith<$Res> {
  __$ContentConfigCopyWithImpl(this._self, this._then);

  final _ContentConfig _self;
  final $Res Function(_ContentConfig) _then;

/// Create a copy of ContentConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? url = freezed,Object? strategy = null,Object? fields = freezed,Object? sniff = freezed,}) {
  return _then(_ContentConfig(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MediaContentType,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as ContentStrategy,fields: freezed == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, Pipeline>?,sniff: freezed == sniff ? _self.sniff : sniff // ignore: cast_nullable_to_non_nullable
as SniffConfig?,
  ));
}

/// Create a copy of ContentConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SniffConfigCopyWith<$Res>? get sniff {
    if (_self.sniff == null) {
    return null;
  }

  return $SniffConfigCopyWith<$Res>(_self.sniff!, (value) {
    return _then(_self.copyWith(sniff: value));
  });
}
}

// dart format on
