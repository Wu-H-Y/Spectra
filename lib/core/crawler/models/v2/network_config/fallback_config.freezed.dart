// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fallback_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TriggerCondition {

/// HTTP 状态码。
 int? get statusCode;/// 正则匹配响应体。
 String? get bodyRegex;/// 响应头匹配。
 String? get headerPattern;
/// Create a copy of TriggerCondition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TriggerConditionCopyWith<TriggerCondition> get copyWith => _$TriggerConditionCopyWithImpl<TriggerCondition>(this as TriggerCondition, _$identity);

  /// Serializes this TriggerCondition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TriggerCondition&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.bodyRegex, bodyRegex) || other.bodyRegex == bodyRegex)&&(identical(other.headerPattern, headerPattern) || other.headerPattern == headerPattern));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,bodyRegex,headerPattern);

@override
String toString() {
  return 'TriggerCondition(statusCode: $statusCode, bodyRegex: $bodyRegex, headerPattern: $headerPattern)';
}


}

/// @nodoc
abstract mixin class $TriggerConditionCopyWith<$Res>  {
  factory $TriggerConditionCopyWith(TriggerCondition value, $Res Function(TriggerCondition) _then) = _$TriggerConditionCopyWithImpl;
@useResult
$Res call({
 int? statusCode, String? bodyRegex, String? headerPattern
});




}
/// @nodoc
class _$TriggerConditionCopyWithImpl<$Res>
    implements $TriggerConditionCopyWith<$Res> {
  _$TriggerConditionCopyWithImpl(this._self, this._then);

  final TriggerCondition _self;
  final $Res Function(TriggerCondition) _then;

/// Create a copy of TriggerCondition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCode = freezed,Object? bodyRegex = freezed,Object? headerPattern = freezed,}) {
  return _then(_self.copyWith(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,bodyRegex: freezed == bodyRegex ? _self.bodyRegex : bodyRegex // ignore: cast_nullable_to_non_nullable
as String?,headerPattern: freezed == headerPattern ? _self.headerPattern : headerPattern // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TriggerCondition].
extension TriggerConditionPatterns on TriggerCondition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TriggerCondition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TriggerCondition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TriggerCondition value)  $default,){
final _that = this;
switch (_that) {
case _TriggerCondition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TriggerCondition value)?  $default,){
final _that = this;
switch (_that) {
case _TriggerCondition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? statusCode,  String? bodyRegex,  String? headerPattern)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TriggerCondition() when $default != null:
return $default(_that.statusCode,_that.bodyRegex,_that.headerPattern);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? statusCode,  String? bodyRegex,  String? headerPattern)  $default,) {final _that = this;
switch (_that) {
case _TriggerCondition():
return $default(_that.statusCode,_that.bodyRegex,_that.headerPattern);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? statusCode,  String? bodyRegex,  String? headerPattern)?  $default,) {final _that = this;
switch (_that) {
case _TriggerCondition() when $default != null:
return $default(_that.statusCode,_that.bodyRegex,_that.headerPattern);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TriggerCondition implements TriggerCondition {
  const _TriggerCondition({this.statusCode, this.bodyRegex, this.headerPattern});
  factory _TriggerCondition.fromJson(Map<String, dynamic> json) => _$TriggerConditionFromJson(json);

/// HTTP 状态码。
@override final  int? statusCode;
/// 正则匹配响应体。
@override final  String? bodyRegex;
/// 响应头匹配。
@override final  String? headerPattern;

/// Create a copy of TriggerCondition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TriggerConditionCopyWith<_TriggerCondition> get copyWith => __$TriggerConditionCopyWithImpl<_TriggerCondition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TriggerConditionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TriggerCondition&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.bodyRegex, bodyRegex) || other.bodyRegex == bodyRegex)&&(identical(other.headerPattern, headerPattern) || other.headerPattern == headerPattern));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,bodyRegex,headerPattern);

@override
String toString() {
  return 'TriggerCondition(statusCode: $statusCode, bodyRegex: $bodyRegex, headerPattern: $headerPattern)';
}


}

/// @nodoc
abstract mixin class _$TriggerConditionCopyWith<$Res> implements $TriggerConditionCopyWith<$Res> {
  factory _$TriggerConditionCopyWith(_TriggerCondition value, $Res Function(_TriggerCondition) _then) = __$TriggerConditionCopyWithImpl;
@override @useResult
$Res call({
 int? statusCode, String? bodyRegex, String? headerPattern
});




}
/// @nodoc
class __$TriggerConditionCopyWithImpl<$Res>
    implements _$TriggerConditionCopyWith<$Res> {
  __$TriggerConditionCopyWithImpl(this._self, this._then);

  final _TriggerCondition _self;
  final $Res Function(_TriggerCondition) _then;

/// Create a copy of TriggerCondition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCode = freezed,Object? bodyRegex = freezed,Object? headerPattern = freezed,}) {
  return _then(_TriggerCondition(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,bodyRegex: freezed == bodyRegex ? _self.bodyRegex : bodyRegex // ignore: cast_nullable_to_non_nullable
as String?,headerPattern: freezed == headerPattern ? _self.headerPattern : headerPattern // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$FallbackConfig {

/// 触发条件列表 (任一满足即触发)。
 List<TriggerCondition> get trigger;/// 回退动作。
 FallbackAction get action;/// 解决超时时间 (毫秒)。
 int get timeout;/// 是否同步 Cookie。
 bool get syncCookies;/// 最大重试次数。
 int get maxRetries;
/// Create a copy of FallbackConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FallbackConfigCopyWith<FallbackConfig> get copyWith => _$FallbackConfigCopyWithImpl<FallbackConfig>(this as FallbackConfig, _$identity);

  /// Serializes this FallbackConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FallbackConfig&&const DeepCollectionEquality().equals(other.trigger, trigger)&&(identical(other.action, action) || other.action == action)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&(identical(other.syncCookies, syncCookies) || other.syncCookies == syncCookies)&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(trigger),action,timeout,syncCookies,maxRetries);

@override
String toString() {
  return 'FallbackConfig(trigger: $trigger, action: $action, timeout: $timeout, syncCookies: $syncCookies, maxRetries: $maxRetries)';
}


}

/// @nodoc
abstract mixin class $FallbackConfigCopyWith<$Res>  {
  factory $FallbackConfigCopyWith(FallbackConfig value, $Res Function(FallbackConfig) _then) = _$FallbackConfigCopyWithImpl;
@useResult
$Res call({
 List<TriggerCondition> trigger, FallbackAction action, int timeout, bool syncCookies, int maxRetries
});




}
/// @nodoc
class _$FallbackConfigCopyWithImpl<$Res>
    implements $FallbackConfigCopyWith<$Res> {
  _$FallbackConfigCopyWithImpl(this._self, this._then);

  final FallbackConfig _self;
  final $Res Function(FallbackConfig) _then;

/// Create a copy of FallbackConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trigger = null,Object? action = null,Object? timeout = null,Object? syncCookies = null,Object? maxRetries = null,}) {
  return _then(_self.copyWith(
trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as List<TriggerCondition>,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as FallbackAction,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as int,syncCookies: null == syncCookies ? _self.syncCookies : syncCookies // ignore: cast_nullable_to_non_nullable
as bool,maxRetries: null == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FallbackConfig].
extension FallbackConfigPatterns on FallbackConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FallbackConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FallbackConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FallbackConfig value)  $default,){
final _that = this;
switch (_that) {
case _FallbackConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FallbackConfig value)?  $default,){
final _that = this;
switch (_that) {
case _FallbackConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TriggerCondition> trigger,  FallbackAction action,  int timeout,  bool syncCookies,  int maxRetries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FallbackConfig() when $default != null:
return $default(_that.trigger,_that.action,_that.timeout,_that.syncCookies,_that.maxRetries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TriggerCondition> trigger,  FallbackAction action,  int timeout,  bool syncCookies,  int maxRetries)  $default,) {final _that = this;
switch (_that) {
case _FallbackConfig():
return $default(_that.trigger,_that.action,_that.timeout,_that.syncCookies,_that.maxRetries);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TriggerCondition> trigger,  FallbackAction action,  int timeout,  bool syncCookies,  int maxRetries)?  $default,) {final _that = this;
switch (_that) {
case _FallbackConfig() when $default != null:
return $default(_that.trigger,_that.action,_that.timeout,_that.syncCookies,_that.maxRetries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FallbackConfig implements FallbackConfig {
  const _FallbackConfig({required final  List<TriggerCondition> trigger, required this.action, this.timeout = 30000, this.syncCookies = true, this.maxRetries = 3}): _trigger = trigger;
  factory _FallbackConfig.fromJson(Map<String, dynamic> json) => _$FallbackConfigFromJson(json);

/// 触发条件列表 (任一满足即触发)。
 final  List<TriggerCondition> _trigger;
/// 触发条件列表 (任一满足即触发)。
@override List<TriggerCondition> get trigger {
  if (_trigger is EqualUnmodifiableListView) return _trigger;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trigger);
}

/// 回退动作。
@override final  FallbackAction action;
/// 解决超时时间 (毫秒)。
@override@JsonKey() final  int timeout;
/// 是否同步 Cookie。
@override@JsonKey() final  bool syncCookies;
/// 最大重试次数。
@override@JsonKey() final  int maxRetries;

/// Create a copy of FallbackConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FallbackConfigCopyWith<_FallbackConfig> get copyWith => __$FallbackConfigCopyWithImpl<_FallbackConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FallbackConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FallbackConfig&&const DeepCollectionEquality().equals(other._trigger, _trigger)&&(identical(other.action, action) || other.action == action)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&(identical(other.syncCookies, syncCookies) || other.syncCookies == syncCookies)&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_trigger),action,timeout,syncCookies,maxRetries);

@override
String toString() {
  return 'FallbackConfig(trigger: $trigger, action: $action, timeout: $timeout, syncCookies: $syncCookies, maxRetries: $maxRetries)';
}


}

/// @nodoc
abstract mixin class _$FallbackConfigCopyWith<$Res> implements $FallbackConfigCopyWith<$Res> {
  factory _$FallbackConfigCopyWith(_FallbackConfig value, $Res Function(_FallbackConfig) _then) = __$FallbackConfigCopyWithImpl;
@override @useResult
$Res call({
 List<TriggerCondition> trigger, FallbackAction action, int timeout, bool syncCookies, int maxRetries
});




}
/// @nodoc
class __$FallbackConfigCopyWithImpl<$Res>
    implements _$FallbackConfigCopyWith<$Res> {
  __$FallbackConfigCopyWithImpl(this._self, this._then);

  final _FallbackConfig _self;
  final $Res Function(_FallbackConfig) _then;

/// Create a copy of FallbackConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trigger = null,Object? action = null,Object? timeout = null,Object? syncCookies = null,Object? maxRetries = null,}) {
  return _then(_FallbackConfig(
trigger: null == trigger ? _self._trigger : trigger // ignore: cast_nullable_to_non_nullable
as List<TriggerCondition>,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as FallbackAction,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as int,syncCookies: null == syncCookies ? _self.syncCookies : syncCookies // ignore: cast_nullable_to_non_nullable
as bool,maxRetries: null == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
