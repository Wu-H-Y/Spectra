// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmulationOption {

 Emulation? get emulation; EmulationOS? get emulationOs; bool? get skipHttp2; bool? get skipHeaders;
/// Create a copy of EmulationOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmulationOptionCopyWith<EmulationOption> get copyWith => _$EmulationOptionCopyWithImpl<EmulationOption>(this as EmulationOption, _$identity);

  /// Serializes this EmulationOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmulationOption&&(identical(other.emulation, emulation) || other.emulation == emulation)&&(identical(other.emulationOs, emulationOs) || other.emulationOs == emulationOs)&&(identical(other.skipHttp2, skipHttp2) || other.skipHttp2 == skipHttp2)&&(identical(other.skipHeaders, skipHeaders) || other.skipHeaders == skipHeaders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,emulation,emulationOs,skipHttp2,skipHeaders);

@override
String toString() {
  return 'EmulationOption(emulation: $emulation, emulationOs: $emulationOs, skipHttp2: $skipHttp2, skipHeaders: $skipHeaders)';
}


}

/// @nodoc
abstract mixin class $EmulationOptionCopyWith<$Res>  {
  factory $EmulationOptionCopyWith(EmulationOption value, $Res Function(EmulationOption) _then) = _$EmulationOptionCopyWithImpl;
@useResult
$Res call({
 Emulation? emulation, EmulationOS? emulationOs, bool? skipHttp2, bool? skipHeaders
});




}
/// @nodoc
class _$EmulationOptionCopyWithImpl<$Res>
    implements $EmulationOptionCopyWith<$Res> {
  _$EmulationOptionCopyWithImpl(this._self, this._then);

  final EmulationOption _self;
  final $Res Function(EmulationOption) _then;

/// Create a copy of EmulationOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? emulation = freezed,Object? emulationOs = freezed,Object? skipHttp2 = freezed,Object? skipHeaders = freezed,}) {
  return _then(_self.copyWith(
emulation: freezed == emulation ? _self.emulation : emulation // ignore: cast_nullable_to_non_nullable
as Emulation?,emulationOs: freezed == emulationOs ? _self.emulationOs : emulationOs // ignore: cast_nullable_to_non_nullable
as EmulationOS?,skipHttp2: freezed == skipHttp2 ? _self.skipHttp2 : skipHttp2 // ignore: cast_nullable_to_non_nullable
as bool?,skipHeaders: freezed == skipHeaders ? _self.skipHeaders : skipHeaders // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmulationOption].
extension EmulationOptionPatterns on EmulationOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmulationOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmulationOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmulationOption value)  $default,){
final _that = this;
switch (_that) {
case _EmulationOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmulationOption value)?  $default,){
final _that = this;
switch (_that) {
case _EmulationOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Emulation? emulation,  EmulationOS? emulationOs,  bool? skipHttp2,  bool? skipHeaders)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmulationOption() when $default != null:
return $default(_that.emulation,_that.emulationOs,_that.skipHttp2,_that.skipHeaders);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Emulation? emulation,  EmulationOS? emulationOs,  bool? skipHttp2,  bool? skipHeaders)  $default,) {final _that = this;
switch (_that) {
case _EmulationOption():
return $default(_that.emulation,_that.emulationOs,_that.skipHttp2,_that.skipHeaders);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Emulation? emulation,  EmulationOS? emulationOs,  bool? skipHttp2,  bool? skipHeaders)?  $default,) {final _that = this;
switch (_that) {
case _EmulationOption() when $default != null:
return $default(_that.emulation,_that.emulationOs,_that.skipHttp2,_that.skipHeaders);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmulationOption implements EmulationOption {
  const _EmulationOption({this.emulation, this.emulationOs, this.skipHttp2, this.skipHeaders});
  factory _EmulationOption.fromJson(Map<String, dynamic> json) => _$EmulationOptionFromJson(json);

@override final  Emulation? emulation;
@override final  EmulationOS? emulationOs;
@override final  bool? skipHttp2;
@override final  bool? skipHeaders;

/// Create a copy of EmulationOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmulationOptionCopyWith<_EmulationOption> get copyWith => __$EmulationOptionCopyWithImpl<_EmulationOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmulationOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmulationOption&&(identical(other.emulation, emulation) || other.emulation == emulation)&&(identical(other.emulationOs, emulationOs) || other.emulationOs == emulationOs)&&(identical(other.skipHttp2, skipHttp2) || other.skipHttp2 == skipHttp2)&&(identical(other.skipHeaders, skipHeaders) || other.skipHeaders == skipHeaders));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,emulation,emulationOs,skipHttp2,skipHeaders);

@override
String toString() {
  return 'EmulationOption(emulation: $emulation, emulationOs: $emulationOs, skipHttp2: $skipHttp2, skipHeaders: $skipHeaders)';
}


}

/// @nodoc
abstract mixin class _$EmulationOptionCopyWith<$Res> implements $EmulationOptionCopyWith<$Res> {
  factory _$EmulationOptionCopyWith(_EmulationOption value, $Res Function(_EmulationOption) _then) = __$EmulationOptionCopyWithImpl;
@override @useResult
$Res call({
 Emulation? emulation, EmulationOS? emulationOs, bool? skipHttp2, bool? skipHeaders
});




}
/// @nodoc
class __$EmulationOptionCopyWithImpl<$Res>
    implements _$EmulationOptionCopyWith<$Res> {
  __$EmulationOptionCopyWithImpl(this._self, this._then);

  final _EmulationOption _self;
  final $Res Function(_EmulationOption) _then;

/// Create a copy of EmulationOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? emulation = freezed,Object? emulationOs = freezed,Object? skipHttp2 = freezed,Object? skipHeaders = freezed,}) {
  return _then(_EmulationOption(
emulation: freezed == emulation ? _self.emulation : emulation // ignore: cast_nullable_to_non_nullable
as Emulation?,emulationOs: freezed == emulationOs ? _self.emulationOs : emulationOs // ignore: cast_nullable_to_non_nullable
as EmulationOS?,skipHttp2: freezed == skipHttp2 ? _self.skipHttp2 : skipHttp2 // ignore: cast_nullable_to_non_nullable
as bool?,skipHeaders: freezed == skipHeaders ? _self.skipHeaders : skipHeaders // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$FallbackConfig {

 List<String> get triggerStatus; List<String> get triggerKeywords; String get action;
/// Create a copy of FallbackConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FallbackConfigCopyWith<FallbackConfig> get copyWith => _$FallbackConfigCopyWithImpl<FallbackConfig>(this as FallbackConfig, _$identity);

  /// Serializes this FallbackConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FallbackConfig&&const DeepCollectionEquality().equals(other.triggerStatus, triggerStatus)&&const DeepCollectionEquality().equals(other.triggerKeywords, triggerKeywords)&&(identical(other.action, action) || other.action == action));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(triggerStatus),const DeepCollectionEquality().hash(triggerKeywords),action);

@override
String toString() {
  return 'FallbackConfig(triggerStatus: $triggerStatus, triggerKeywords: $triggerKeywords, action: $action)';
}


}

/// @nodoc
abstract mixin class $FallbackConfigCopyWith<$Res>  {
  factory $FallbackConfigCopyWith(FallbackConfig value, $Res Function(FallbackConfig) _then) = _$FallbackConfigCopyWithImpl;
@useResult
$Res call({
 List<String> triggerStatus, List<String> triggerKeywords, String action
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
@pragma('vm:prefer-inline') @override $Res call({Object? triggerStatus = null,Object? triggerKeywords = null,Object? action = null,}) {
  return _then(_self.copyWith(
triggerStatus: null == triggerStatus ? _self.triggerStatus : triggerStatus // ignore: cast_nullable_to_non_nullable
as List<String>,triggerKeywords: null == triggerKeywords ? _self.triggerKeywords : triggerKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> triggerStatus,  List<String> triggerKeywords,  String action)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FallbackConfig() when $default != null:
return $default(_that.triggerStatus,_that.triggerKeywords,_that.action);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> triggerStatus,  List<String> triggerKeywords,  String action)  $default,) {final _that = this;
switch (_that) {
case _FallbackConfig():
return $default(_that.triggerStatus,_that.triggerKeywords,_that.action);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> triggerStatus,  List<String> triggerKeywords,  String action)?  $default,) {final _that = this;
switch (_that) {
case _FallbackConfig() when $default != null:
return $default(_that.triggerStatus,_that.triggerKeywords,_that.action);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FallbackConfig implements FallbackConfig {
  const _FallbackConfig({required final  List<String> triggerStatus, required final  List<String> triggerKeywords, required this.action}): _triggerStatus = triggerStatus,_triggerKeywords = triggerKeywords;
  factory _FallbackConfig.fromJson(Map<String, dynamic> json) => _$FallbackConfigFromJson(json);

 final  List<String> _triggerStatus;
@override List<String> get triggerStatus {
  if (_triggerStatus is EqualUnmodifiableListView) return _triggerStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_triggerStatus);
}

 final  List<String> _triggerKeywords;
@override List<String> get triggerKeywords {
  if (_triggerKeywords is EqualUnmodifiableListView) return _triggerKeywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_triggerKeywords);
}

@override final  String action;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FallbackConfig&&const DeepCollectionEquality().equals(other._triggerStatus, _triggerStatus)&&const DeepCollectionEquality().equals(other._triggerKeywords, _triggerKeywords)&&(identical(other.action, action) || other.action == action));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_triggerStatus),const DeepCollectionEquality().hash(_triggerKeywords),action);

@override
String toString() {
  return 'FallbackConfig(triggerStatus: $triggerStatus, triggerKeywords: $triggerKeywords, action: $action)';
}


}

/// @nodoc
abstract mixin class _$FallbackConfigCopyWith<$Res> implements $FallbackConfigCopyWith<$Res> {
  factory _$FallbackConfigCopyWith(_FallbackConfig value, $Res Function(_FallbackConfig) _then) = __$FallbackConfigCopyWithImpl;
@override @useResult
$Res call({
 List<String> triggerStatus, List<String> triggerKeywords, String action
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
@override @pragma('vm:prefer-inline') $Res call({Object? triggerStatus = null,Object? triggerKeywords = null,Object? action = null,}) {
  return _then(_FallbackConfig(
triggerStatus: null == triggerStatus ? _self._triggerStatus : triggerStatus // ignore: cast_nullable_to_non_nullable
as List<String>,triggerKeywords: null == triggerKeywords ? _self._triggerKeywords : triggerKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NetworkConfig {

 String get strategy; EmulationOption? get emulation; BigInt? get connectTimeout; BigInt? get readTimeout; Map<String, String>? get headers; RuleProxyConfig? get proxy; FallbackConfig? get fallback;
/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkConfigCopyWith<NetworkConfig> get copyWith => _$NetworkConfigCopyWithImpl<NetworkConfig>(this as NetworkConfig, _$identity);

  /// Serializes this NetworkConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkConfig&&(identical(other.strategy, strategy) || other.strategy == strategy)&&(identical(other.emulation, emulation) || other.emulation == emulation)&&(identical(other.connectTimeout, connectTimeout) || other.connectTimeout == connectTimeout)&&(identical(other.readTimeout, readTimeout) || other.readTimeout == readTimeout)&&const DeepCollectionEquality().equals(other.headers, headers)&&(identical(other.proxy, proxy) || other.proxy == proxy)&&(identical(other.fallback, fallback) || other.fallback == fallback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strategy,emulation,connectTimeout,readTimeout,const DeepCollectionEquality().hash(headers),proxy,fallback);

@override
String toString() {
  return 'NetworkConfig(strategy: $strategy, emulation: $emulation, connectTimeout: $connectTimeout, readTimeout: $readTimeout, headers: $headers, proxy: $proxy, fallback: $fallback)';
}


}

/// @nodoc
abstract mixin class $NetworkConfigCopyWith<$Res>  {
  factory $NetworkConfigCopyWith(NetworkConfig value, $Res Function(NetworkConfig) _then) = _$NetworkConfigCopyWithImpl;
@useResult
$Res call({
 String strategy, EmulationOption? emulation, BigInt? connectTimeout, BigInt? readTimeout, Map<String, String>? headers, RuleProxyConfig? proxy, FallbackConfig? fallback
});


$EmulationOptionCopyWith<$Res>? get emulation;$RuleProxyConfigCopyWith<$Res>? get proxy;$FallbackConfigCopyWith<$Res>? get fallback;

}
/// @nodoc
class _$NetworkConfigCopyWithImpl<$Res>
    implements $NetworkConfigCopyWith<$Res> {
  _$NetworkConfigCopyWithImpl(this._self, this._then);

  final NetworkConfig _self;
  final $Res Function(NetworkConfig) _then;

/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? strategy = null,Object? emulation = freezed,Object? connectTimeout = freezed,Object? readTimeout = freezed,Object? headers = freezed,Object? proxy = freezed,Object? fallback = freezed,}) {
  return _then(_self.copyWith(
strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as String,emulation: freezed == emulation ? _self.emulation : emulation // ignore: cast_nullable_to_non_nullable
as EmulationOption?,connectTimeout: freezed == connectTimeout ? _self.connectTimeout : connectTimeout // ignore: cast_nullable_to_non_nullable
as BigInt?,readTimeout: freezed == readTimeout ? _self.readTimeout : readTimeout // ignore: cast_nullable_to_non_nullable
as BigInt?,headers: freezed == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,proxy: freezed == proxy ? _self.proxy : proxy // ignore: cast_nullable_to_non_nullable
as RuleProxyConfig?,fallback: freezed == fallback ? _self.fallback : fallback // ignore: cast_nullable_to_non_nullable
as FallbackConfig?,
  ));
}
/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmulationOptionCopyWith<$Res>? get emulation {
    if (_self.emulation == null) {
    return null;
  }

  return $EmulationOptionCopyWith<$Res>(_self.emulation!, (value) {
    return _then(_self.copyWith(emulation: value));
  });
}/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RuleProxyConfigCopyWith<$Res>? get proxy {
    if (_self.proxy == null) {
    return null;
  }

  return $RuleProxyConfigCopyWith<$Res>(_self.proxy!, (value) {
    return _then(_self.copyWith(proxy: value));
  });
}/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FallbackConfigCopyWith<$Res>? get fallback {
    if (_self.fallback == null) {
    return null;
  }

  return $FallbackConfigCopyWith<$Res>(_self.fallback!, (value) {
    return _then(_self.copyWith(fallback: value));
  });
}
}


/// Adds pattern-matching-related methods to [NetworkConfig].
extension NetworkConfigPatterns on NetworkConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworkConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworkConfig value)  $default,){
final _that = this;
switch (_that) {
case _NetworkConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworkConfig value)?  $default,){
final _that = this;
switch (_that) {
case _NetworkConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String strategy,  EmulationOption? emulation,  BigInt? connectTimeout,  BigInt? readTimeout,  Map<String, String>? headers,  RuleProxyConfig? proxy,  FallbackConfig? fallback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkConfig() when $default != null:
return $default(_that.strategy,_that.emulation,_that.connectTimeout,_that.readTimeout,_that.headers,_that.proxy,_that.fallback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String strategy,  EmulationOption? emulation,  BigInt? connectTimeout,  BigInt? readTimeout,  Map<String, String>? headers,  RuleProxyConfig? proxy,  FallbackConfig? fallback)  $default,) {final _that = this;
switch (_that) {
case _NetworkConfig():
return $default(_that.strategy,_that.emulation,_that.connectTimeout,_that.readTimeout,_that.headers,_that.proxy,_that.fallback);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String strategy,  EmulationOption? emulation,  BigInt? connectTimeout,  BigInt? readTimeout,  Map<String, String>? headers,  RuleProxyConfig? proxy,  FallbackConfig? fallback)?  $default,) {final _that = this;
switch (_that) {
case _NetworkConfig() when $default != null:
return $default(_that.strategy,_that.emulation,_that.connectTimeout,_that.readTimeout,_that.headers,_that.proxy,_that.fallback);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NetworkConfig implements NetworkConfig {
  const _NetworkConfig({required this.strategy, this.emulation, this.connectTimeout, this.readTimeout, final  Map<String, String>? headers, this.proxy, this.fallback}): _headers = headers;
  factory _NetworkConfig.fromJson(Map<String, dynamic> json) => _$NetworkConfigFromJson(json);

@override final  String strategy;
@override final  EmulationOption? emulation;
@override final  BigInt? connectTimeout;
@override final  BigInt? readTimeout;
 final  Map<String, String>? _headers;
@override Map<String, String>? get headers {
  final value = _headers;
  if (value == null) return null;
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  RuleProxyConfig? proxy;
@override final  FallbackConfig? fallback;

/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkConfigCopyWith<_NetworkConfig> get copyWith => __$NetworkConfigCopyWithImpl<_NetworkConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworkConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkConfig&&(identical(other.strategy, strategy) || other.strategy == strategy)&&(identical(other.emulation, emulation) || other.emulation == emulation)&&(identical(other.connectTimeout, connectTimeout) || other.connectTimeout == connectTimeout)&&(identical(other.readTimeout, readTimeout) || other.readTimeout == readTimeout)&&const DeepCollectionEquality().equals(other._headers, _headers)&&(identical(other.proxy, proxy) || other.proxy == proxy)&&(identical(other.fallback, fallback) || other.fallback == fallback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strategy,emulation,connectTimeout,readTimeout,const DeepCollectionEquality().hash(_headers),proxy,fallback);

@override
String toString() {
  return 'NetworkConfig(strategy: $strategy, emulation: $emulation, connectTimeout: $connectTimeout, readTimeout: $readTimeout, headers: $headers, proxy: $proxy, fallback: $fallback)';
}


}

/// @nodoc
abstract mixin class _$NetworkConfigCopyWith<$Res> implements $NetworkConfigCopyWith<$Res> {
  factory _$NetworkConfigCopyWith(_NetworkConfig value, $Res Function(_NetworkConfig) _then) = __$NetworkConfigCopyWithImpl;
@override @useResult
$Res call({
 String strategy, EmulationOption? emulation, BigInt? connectTimeout, BigInt? readTimeout, Map<String, String>? headers, RuleProxyConfig? proxy, FallbackConfig? fallback
});


@override $EmulationOptionCopyWith<$Res>? get emulation;@override $RuleProxyConfigCopyWith<$Res>? get proxy;@override $FallbackConfigCopyWith<$Res>? get fallback;

}
/// @nodoc
class __$NetworkConfigCopyWithImpl<$Res>
    implements _$NetworkConfigCopyWith<$Res> {
  __$NetworkConfigCopyWithImpl(this._self, this._then);

  final _NetworkConfig _self;
  final $Res Function(_NetworkConfig) _then;

/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? strategy = null,Object? emulation = freezed,Object? connectTimeout = freezed,Object? readTimeout = freezed,Object? headers = freezed,Object? proxy = freezed,Object? fallback = freezed,}) {
  return _then(_NetworkConfig(
strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as String,emulation: freezed == emulation ? _self.emulation : emulation // ignore: cast_nullable_to_non_nullable
as EmulationOption?,connectTimeout: freezed == connectTimeout ? _self.connectTimeout : connectTimeout // ignore: cast_nullable_to_non_nullable
as BigInt?,readTimeout: freezed == readTimeout ? _self.readTimeout : readTimeout // ignore: cast_nullable_to_non_nullable
as BigInt?,headers: freezed == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,proxy: freezed == proxy ? _self.proxy : proxy // ignore: cast_nullable_to_non_nullable
as RuleProxyConfig?,fallback: freezed == fallback ? _self.fallback : fallback // ignore: cast_nullable_to_non_nullable
as FallbackConfig?,
  ));
}

/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmulationOptionCopyWith<$Res>? get emulation {
    if (_self.emulation == null) {
    return null;
  }

  return $EmulationOptionCopyWith<$Res>(_self.emulation!, (value) {
    return _then(_self.copyWith(emulation: value));
  });
}/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RuleProxyConfigCopyWith<$Res>? get proxy {
    if (_self.proxy == null) {
    return null;
  }

  return $RuleProxyConfigCopyWith<$Res>(_self.proxy!, (value) {
    return _then(_self.copyWith(proxy: value));
  });
}/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FallbackConfigCopyWith<$Res>? get fallback {
    if (_self.fallback == null) {
    return null;
  }

  return $FallbackConfigCopyWith<$Res>(_self.fallback!, (value) {
    return _then(_self.copyWith(fallback: value));
  });
}
}


/// @nodoc
mixin _$RuleProxyConfig {

 bool get enabled; String? get http; String? get https; String? get socks5;
/// Create a copy of RuleProxyConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuleProxyConfigCopyWith<RuleProxyConfig> get copyWith => _$RuleProxyConfigCopyWithImpl<RuleProxyConfig>(this as RuleProxyConfig, _$identity);

  /// Serializes this RuleProxyConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuleProxyConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.http, http) || other.http == http)&&(identical(other.https, https) || other.https == https)&&(identical(other.socks5, socks5) || other.socks5 == socks5));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,http,https,socks5);

@override
String toString() {
  return 'RuleProxyConfig(enabled: $enabled, http: $http, https: $https, socks5: $socks5)';
}


}

/// @nodoc
abstract mixin class $RuleProxyConfigCopyWith<$Res>  {
  factory $RuleProxyConfigCopyWith(RuleProxyConfig value, $Res Function(RuleProxyConfig) _then) = _$RuleProxyConfigCopyWithImpl;
@useResult
$Res call({
 bool enabled, String? http, String? https, String? socks5
});




}
/// @nodoc
class _$RuleProxyConfigCopyWithImpl<$Res>
    implements $RuleProxyConfigCopyWith<$Res> {
  _$RuleProxyConfigCopyWithImpl(this._self, this._then);

  final RuleProxyConfig _self;
  final $Res Function(RuleProxyConfig) _then;

/// Create a copy of RuleProxyConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? http = freezed,Object? https = freezed,Object? socks5 = freezed,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,http: freezed == http ? _self.http : http // ignore: cast_nullable_to_non_nullable
as String?,https: freezed == https ? _self.https : https // ignore: cast_nullable_to_non_nullable
as String?,socks5: freezed == socks5 ? _self.socks5 : socks5 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RuleProxyConfig].
extension RuleProxyConfigPatterns on RuleProxyConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RuleProxyConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RuleProxyConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RuleProxyConfig value)  $default,){
final _that = this;
switch (_that) {
case _RuleProxyConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RuleProxyConfig value)?  $default,){
final _that = this;
switch (_that) {
case _RuleProxyConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  String? http,  String? https,  String? socks5)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RuleProxyConfig() when $default != null:
return $default(_that.enabled,_that.http,_that.https,_that.socks5);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  String? http,  String? https,  String? socks5)  $default,) {final _that = this;
switch (_that) {
case _RuleProxyConfig():
return $default(_that.enabled,_that.http,_that.https,_that.socks5);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  String? http,  String? https,  String? socks5)?  $default,) {final _that = this;
switch (_that) {
case _RuleProxyConfig() when $default != null:
return $default(_that.enabled,_that.http,_that.https,_that.socks5);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RuleProxyConfig implements RuleProxyConfig {
  const _RuleProxyConfig({required this.enabled, this.http, this.https, this.socks5});
  factory _RuleProxyConfig.fromJson(Map<String, dynamic> json) => _$RuleProxyConfigFromJson(json);

@override final  bool enabled;
@override final  String? http;
@override final  String? https;
@override final  String? socks5;

/// Create a copy of RuleProxyConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RuleProxyConfigCopyWith<_RuleProxyConfig> get copyWith => __$RuleProxyConfigCopyWithImpl<_RuleProxyConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RuleProxyConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuleProxyConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.http, http) || other.http == http)&&(identical(other.https, https) || other.https == https)&&(identical(other.socks5, socks5) || other.socks5 == socks5));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,http,https,socks5);

@override
String toString() {
  return 'RuleProxyConfig(enabled: $enabled, http: $http, https: $https, socks5: $socks5)';
}


}

/// @nodoc
abstract mixin class _$RuleProxyConfigCopyWith<$Res> implements $RuleProxyConfigCopyWith<$Res> {
  factory _$RuleProxyConfigCopyWith(_RuleProxyConfig value, $Res Function(_RuleProxyConfig) _then) = __$RuleProxyConfigCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, String? http, String? https, String? socks5
});




}
/// @nodoc
class __$RuleProxyConfigCopyWithImpl<$Res>
    implements _$RuleProxyConfigCopyWith<$Res> {
  __$RuleProxyConfigCopyWithImpl(this._self, this._then);

  final _RuleProxyConfig _self;
  final $Res Function(_RuleProxyConfig) _then;

/// Create a copy of RuleProxyConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? http = freezed,Object? https = freezed,Object? socks5 = freezed,}) {
  return _then(_RuleProxyConfig(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,http: freezed == http ? _self.http : http // ignore: cast_nullable_to_non_nullable
as String?,https: freezed == https ? _self.https : https // ignore: cast_nullable_to_non_nullable
as String?,socks5: freezed == socks5 ? _self.socks5 : socks5 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
