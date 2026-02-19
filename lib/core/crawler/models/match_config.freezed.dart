// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchConfig {

/// URL pattern (regex or glob pattern).
 String get pattern;/// Pattern type (regex or glob).
 MatchPatternType get type;/// Whether to match full URL or just path.
 bool get fullUrl;/// List of additional URL patterns to match.
 List<String>? get includePatterns;/// List of URL patterns to exclude.
 List<String>? get excludePatterns;
/// Create a copy of MatchConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchConfigCopyWith<MatchConfig> get copyWith => _$MatchConfigCopyWithImpl<MatchConfig>(this as MatchConfig, _$identity);

  /// Serializes this MatchConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchConfig&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.type, type) || other.type == type)&&(identical(other.fullUrl, fullUrl) || other.fullUrl == fullUrl)&&const DeepCollectionEquality().equals(other.includePatterns, includePatterns)&&const DeepCollectionEquality().equals(other.excludePatterns, excludePatterns));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pattern,type,fullUrl,const DeepCollectionEquality().hash(includePatterns),const DeepCollectionEquality().hash(excludePatterns));

@override
String toString() {
  return 'MatchConfig(pattern: $pattern, type: $type, fullUrl: $fullUrl, includePatterns: $includePatterns, excludePatterns: $excludePatterns)';
}


}

/// @nodoc
abstract mixin class $MatchConfigCopyWith<$Res>  {
  factory $MatchConfigCopyWith(MatchConfig value, $Res Function(MatchConfig) _then) = _$MatchConfigCopyWithImpl;
@useResult
$Res call({
 String pattern, MatchPatternType type, bool fullUrl, List<String>? includePatterns, List<String>? excludePatterns
});




}
/// @nodoc
class _$MatchConfigCopyWithImpl<$Res>
    implements $MatchConfigCopyWith<$Res> {
  _$MatchConfigCopyWithImpl(this._self, this._then);

  final MatchConfig _self;
  final $Res Function(MatchConfig) _then;

/// Create a copy of MatchConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pattern = null,Object? type = null,Object? fullUrl = null,Object? includePatterns = freezed,Object? excludePatterns = freezed,}) {
  return _then(_self.copyWith(
pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MatchPatternType,fullUrl: null == fullUrl ? _self.fullUrl : fullUrl // ignore: cast_nullable_to_non_nullable
as bool,includePatterns: freezed == includePatterns ? _self.includePatterns : includePatterns // ignore: cast_nullable_to_non_nullable
as List<String>?,excludePatterns: freezed == excludePatterns ? _self.excludePatterns : excludePatterns // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchConfig].
extension MatchConfigPatterns on MatchConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchConfig value)  $default,){
final _that = this;
switch (_that) {
case _MatchConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchConfig value)?  $default,){
final _that = this;
switch (_that) {
case _MatchConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pattern,  MatchPatternType type,  bool fullUrl,  List<String>? includePatterns,  List<String>? excludePatterns)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchConfig() when $default != null:
return $default(_that.pattern,_that.type,_that.fullUrl,_that.includePatterns,_that.excludePatterns);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pattern,  MatchPatternType type,  bool fullUrl,  List<String>? includePatterns,  List<String>? excludePatterns)  $default,) {final _that = this;
switch (_that) {
case _MatchConfig():
return $default(_that.pattern,_that.type,_that.fullUrl,_that.includePatterns,_that.excludePatterns);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pattern,  MatchPatternType type,  bool fullUrl,  List<String>? includePatterns,  List<String>? excludePatterns)?  $default,) {final _that = this;
switch (_that) {
case _MatchConfig() when $default != null:
return $default(_that.pattern,_that.type,_that.fullUrl,_that.includePatterns,_that.excludePatterns);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchConfig implements MatchConfig {
  const _MatchConfig({required this.pattern, this.type = MatchPatternType.regex, this.fullUrl = true, final  List<String>? includePatterns, final  List<String>? excludePatterns}): _includePatterns = includePatterns,_excludePatterns = excludePatterns;
  factory _MatchConfig.fromJson(Map<String, dynamic> json) => _$MatchConfigFromJson(json);

/// URL pattern (regex or glob pattern).
@override final  String pattern;
/// Pattern type (regex or glob).
@override@JsonKey() final  MatchPatternType type;
/// Whether to match full URL or just path.
@override@JsonKey() final  bool fullUrl;
/// List of additional URL patterns to match.
 final  List<String>? _includePatterns;
/// List of additional URL patterns to match.
@override List<String>? get includePatterns {
  final value = _includePatterns;
  if (value == null) return null;
  if (_includePatterns is EqualUnmodifiableListView) return _includePatterns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// List of URL patterns to exclude.
 final  List<String>? _excludePatterns;
/// List of URL patterns to exclude.
@override List<String>? get excludePatterns {
  final value = _excludePatterns;
  if (value == null) return null;
  if (_excludePatterns is EqualUnmodifiableListView) return _excludePatterns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of MatchConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchConfigCopyWith<_MatchConfig> get copyWith => __$MatchConfigCopyWithImpl<_MatchConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchConfig&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.type, type) || other.type == type)&&(identical(other.fullUrl, fullUrl) || other.fullUrl == fullUrl)&&const DeepCollectionEquality().equals(other._includePatterns, _includePatterns)&&const DeepCollectionEquality().equals(other._excludePatterns, _excludePatterns));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pattern,type,fullUrl,const DeepCollectionEquality().hash(_includePatterns),const DeepCollectionEquality().hash(_excludePatterns));

@override
String toString() {
  return 'MatchConfig(pattern: $pattern, type: $type, fullUrl: $fullUrl, includePatterns: $includePatterns, excludePatterns: $excludePatterns)';
}


}

/// @nodoc
abstract mixin class _$MatchConfigCopyWith<$Res> implements $MatchConfigCopyWith<$Res> {
  factory _$MatchConfigCopyWith(_MatchConfig value, $Res Function(_MatchConfig) _then) = __$MatchConfigCopyWithImpl;
@override @useResult
$Res call({
 String pattern, MatchPatternType type, bool fullUrl, List<String>? includePatterns, List<String>? excludePatterns
});




}
/// @nodoc
class __$MatchConfigCopyWithImpl<$Res>
    implements _$MatchConfigCopyWith<$Res> {
  __$MatchConfigCopyWithImpl(this._self, this._then);

  final _MatchConfig _self;
  final $Res Function(_MatchConfig) _then;

/// Create a copy of MatchConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pattern = null,Object? type = null,Object? fullUrl = null,Object? includePatterns = freezed,Object? excludePatterns = freezed,}) {
  return _then(_MatchConfig(
pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as MatchPatternType,fullUrl: null == fullUrl ? _self.fullUrl : fullUrl // ignore: cast_nullable_to_non_nullable
as bool,includePatterns: freezed == includePatterns ? _self._includePatterns : includePatterns // ignore: cast_nullable_to_non_nullable
as List<String>?,excludePatterns: freezed == excludePatterns ? _self._excludePatterns : excludePatterns // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
