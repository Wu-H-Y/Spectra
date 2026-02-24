// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworkConfig {

/// 网络策略。
 NetworkStrategy get strategy;/// 请求超时时间 (毫秒)。
 int get timeout;/// 默认请求头。
 Map<String, String>? get headers;/// Cookie 管理。
 Map<String, String>? get cookies;/// 是否跟随重定向。
 bool get followRedirects;/// 最大重定向次数。
 int get maxRedirects;/// User-Agent 字符串。
 String? get userAgent;/// Referer 头值。
 String? get referer;/// TLS 指纹配置。
 TlsFingerprint? get tlsFingerprint;/// 请求拦截器配置。
 Interceptors? get interceptors;/// 代理配置。
 ProxyConfig? get proxy;
/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkConfigCopyWith<NetworkConfig> get copyWith => _$NetworkConfigCopyWithImpl<NetworkConfig>(this as NetworkConfig, _$identity);

  /// Serializes this NetworkConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkConfig&&(identical(other.strategy, strategy) || other.strategy == strategy)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&const DeepCollectionEquality().equals(other.headers, headers)&&const DeepCollectionEquality().equals(other.cookies, cookies)&&(identical(other.followRedirects, followRedirects) || other.followRedirects == followRedirects)&&(identical(other.maxRedirects, maxRedirects) || other.maxRedirects == maxRedirects)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.referer, referer) || other.referer == referer)&&(identical(other.tlsFingerprint, tlsFingerprint) || other.tlsFingerprint == tlsFingerprint)&&(identical(other.interceptors, interceptors) || other.interceptors == interceptors)&&(identical(other.proxy, proxy) || other.proxy == proxy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strategy,timeout,const DeepCollectionEquality().hash(headers),const DeepCollectionEquality().hash(cookies),followRedirects,maxRedirects,userAgent,referer,tlsFingerprint,interceptors,proxy);

@override
String toString() {
  return 'NetworkConfig(strategy: $strategy, timeout: $timeout, headers: $headers, cookies: $cookies, followRedirects: $followRedirects, maxRedirects: $maxRedirects, userAgent: $userAgent, referer: $referer, tlsFingerprint: $tlsFingerprint, interceptors: $interceptors, proxy: $proxy)';
}


}

/// @nodoc
abstract mixin class $NetworkConfigCopyWith<$Res>  {
  factory $NetworkConfigCopyWith(NetworkConfig value, $Res Function(NetworkConfig) _then) = _$NetworkConfigCopyWithImpl;
@useResult
$Res call({
 NetworkStrategy strategy, int timeout, Map<String, String>? headers, Map<String, String>? cookies, bool followRedirects, int maxRedirects, String? userAgent, String? referer, TlsFingerprint? tlsFingerprint, Interceptors? interceptors, ProxyConfig? proxy
});


$TlsFingerprintCopyWith<$Res>? get tlsFingerprint;$InterceptorsCopyWith<$Res>? get interceptors;$ProxyConfigCopyWith<$Res>? get proxy;

}
/// @nodoc
class _$NetworkConfigCopyWithImpl<$Res>
    implements $NetworkConfigCopyWith<$Res> {
  _$NetworkConfigCopyWithImpl(this._self, this._then);

  final NetworkConfig _self;
  final $Res Function(NetworkConfig) _then;

/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? strategy = null,Object? timeout = null,Object? headers = freezed,Object? cookies = freezed,Object? followRedirects = null,Object? maxRedirects = null,Object? userAgent = freezed,Object? referer = freezed,Object? tlsFingerprint = freezed,Object? interceptors = freezed,Object? proxy = freezed,}) {
  return _then(_self.copyWith(
strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as NetworkStrategy,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as int,headers: freezed == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,cookies: freezed == cookies ? _self.cookies : cookies // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,followRedirects: null == followRedirects ? _self.followRedirects : followRedirects // ignore: cast_nullable_to_non_nullable
as bool,maxRedirects: null == maxRedirects ? _self.maxRedirects : maxRedirects // ignore: cast_nullable_to_non_nullable
as int,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,referer: freezed == referer ? _self.referer : referer // ignore: cast_nullable_to_non_nullable
as String?,tlsFingerprint: freezed == tlsFingerprint ? _self.tlsFingerprint : tlsFingerprint // ignore: cast_nullable_to_non_nullable
as TlsFingerprint?,interceptors: freezed == interceptors ? _self.interceptors : interceptors // ignore: cast_nullable_to_non_nullable
as Interceptors?,proxy: freezed == proxy ? _self.proxy : proxy // ignore: cast_nullable_to_non_nullable
as ProxyConfig?,
  ));
}
/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TlsFingerprintCopyWith<$Res>? get tlsFingerprint {
    if (_self.tlsFingerprint == null) {
    return null;
  }

  return $TlsFingerprintCopyWith<$Res>(_self.tlsFingerprint!, (value) {
    return _then(_self.copyWith(tlsFingerprint: value));
  });
}/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterceptorsCopyWith<$Res>? get interceptors {
    if (_self.interceptors == null) {
    return null;
  }

  return $InterceptorsCopyWith<$Res>(_self.interceptors!, (value) {
    return _then(_self.copyWith(interceptors: value));
  });
}/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProxyConfigCopyWith<$Res>? get proxy {
    if (_self.proxy == null) {
    return null;
  }

  return $ProxyConfigCopyWith<$Res>(_self.proxy!, (value) {
    return _then(_self.copyWith(proxy: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NetworkStrategy strategy,  int timeout,  Map<String, String>? headers,  Map<String, String>? cookies,  bool followRedirects,  int maxRedirects,  String? userAgent,  String? referer,  TlsFingerprint? tlsFingerprint,  Interceptors? interceptors,  ProxyConfig? proxy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkConfig() when $default != null:
return $default(_that.strategy,_that.timeout,_that.headers,_that.cookies,_that.followRedirects,_that.maxRedirects,_that.userAgent,_that.referer,_that.tlsFingerprint,_that.interceptors,_that.proxy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NetworkStrategy strategy,  int timeout,  Map<String, String>? headers,  Map<String, String>? cookies,  bool followRedirects,  int maxRedirects,  String? userAgent,  String? referer,  TlsFingerprint? tlsFingerprint,  Interceptors? interceptors,  ProxyConfig? proxy)  $default,) {final _that = this;
switch (_that) {
case _NetworkConfig():
return $default(_that.strategy,_that.timeout,_that.headers,_that.cookies,_that.followRedirects,_that.maxRedirects,_that.userAgent,_that.referer,_that.tlsFingerprint,_that.interceptors,_that.proxy);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NetworkStrategy strategy,  int timeout,  Map<String, String>? headers,  Map<String, String>? cookies,  bool followRedirects,  int maxRedirects,  String? userAgent,  String? referer,  TlsFingerprint? tlsFingerprint,  Interceptors? interceptors,  ProxyConfig? proxy)?  $default,) {final _that = this;
switch (_that) {
case _NetworkConfig() when $default != null:
return $default(_that.strategy,_that.timeout,_that.headers,_that.cookies,_that.followRedirects,_that.maxRedirects,_that.userAgent,_that.referer,_that.tlsFingerprint,_that.interceptors,_that.proxy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NetworkConfig implements NetworkConfig {
  const _NetworkConfig({this.strategy = NetworkStrategy.http, this.timeout = 15000, final  Map<String, String>? headers, final  Map<String, String>? cookies, this.followRedirects = true, this.maxRedirects = 5, this.userAgent, this.referer, this.tlsFingerprint, this.interceptors, this.proxy}): _headers = headers,_cookies = cookies;
  factory _NetworkConfig.fromJson(Map<String, dynamic> json) => _$NetworkConfigFromJson(json);

/// 网络策略。
@override@JsonKey() final  NetworkStrategy strategy;
/// 请求超时时间 (毫秒)。
@override@JsonKey() final  int timeout;
/// 默认请求头。
 final  Map<String, String>? _headers;
/// 默认请求头。
@override Map<String, String>? get headers {
  final value = _headers;
  if (value == null) return null;
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Cookie 管理。
 final  Map<String, String>? _cookies;
/// Cookie 管理。
@override Map<String, String>? get cookies {
  final value = _cookies;
  if (value == null) return null;
  if (_cookies is EqualUnmodifiableMapView) return _cookies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// 是否跟随重定向。
@override@JsonKey() final  bool followRedirects;
/// 最大重定向次数。
@override@JsonKey() final  int maxRedirects;
/// User-Agent 字符串。
@override final  String? userAgent;
/// Referer 头值。
@override final  String? referer;
/// TLS 指纹配置。
@override final  TlsFingerprint? tlsFingerprint;
/// 请求拦截器配置。
@override final  Interceptors? interceptors;
/// 代理配置。
@override final  ProxyConfig? proxy;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkConfig&&(identical(other.strategy, strategy) || other.strategy == strategy)&&(identical(other.timeout, timeout) || other.timeout == timeout)&&const DeepCollectionEquality().equals(other._headers, _headers)&&const DeepCollectionEquality().equals(other._cookies, _cookies)&&(identical(other.followRedirects, followRedirects) || other.followRedirects == followRedirects)&&(identical(other.maxRedirects, maxRedirects) || other.maxRedirects == maxRedirects)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.referer, referer) || other.referer == referer)&&(identical(other.tlsFingerprint, tlsFingerprint) || other.tlsFingerprint == tlsFingerprint)&&(identical(other.interceptors, interceptors) || other.interceptors == interceptors)&&(identical(other.proxy, proxy) || other.proxy == proxy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strategy,timeout,const DeepCollectionEquality().hash(_headers),const DeepCollectionEquality().hash(_cookies),followRedirects,maxRedirects,userAgent,referer,tlsFingerprint,interceptors,proxy);

@override
String toString() {
  return 'NetworkConfig(strategy: $strategy, timeout: $timeout, headers: $headers, cookies: $cookies, followRedirects: $followRedirects, maxRedirects: $maxRedirects, userAgent: $userAgent, referer: $referer, tlsFingerprint: $tlsFingerprint, interceptors: $interceptors, proxy: $proxy)';
}


}

/// @nodoc
abstract mixin class _$NetworkConfigCopyWith<$Res> implements $NetworkConfigCopyWith<$Res> {
  factory _$NetworkConfigCopyWith(_NetworkConfig value, $Res Function(_NetworkConfig) _then) = __$NetworkConfigCopyWithImpl;
@override @useResult
$Res call({
 NetworkStrategy strategy, int timeout, Map<String, String>? headers, Map<String, String>? cookies, bool followRedirects, int maxRedirects, String? userAgent, String? referer, TlsFingerprint? tlsFingerprint, Interceptors? interceptors, ProxyConfig? proxy
});


@override $TlsFingerprintCopyWith<$Res>? get tlsFingerprint;@override $InterceptorsCopyWith<$Res>? get interceptors;@override $ProxyConfigCopyWith<$Res>? get proxy;

}
/// @nodoc
class __$NetworkConfigCopyWithImpl<$Res>
    implements _$NetworkConfigCopyWith<$Res> {
  __$NetworkConfigCopyWithImpl(this._self, this._then);

  final _NetworkConfig _self;
  final $Res Function(_NetworkConfig) _then;

/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? strategy = null,Object? timeout = null,Object? headers = freezed,Object? cookies = freezed,Object? followRedirects = null,Object? maxRedirects = null,Object? userAgent = freezed,Object? referer = freezed,Object? tlsFingerprint = freezed,Object? interceptors = freezed,Object? proxy = freezed,}) {
  return _then(_NetworkConfig(
strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as NetworkStrategy,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as int,headers: freezed == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,cookies: freezed == cookies ? _self._cookies : cookies // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,followRedirects: null == followRedirects ? _self.followRedirects : followRedirects // ignore: cast_nullable_to_non_nullable
as bool,maxRedirects: null == maxRedirects ? _self.maxRedirects : maxRedirects // ignore: cast_nullable_to_non_nullable
as int,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,referer: freezed == referer ? _self.referer : referer // ignore: cast_nullable_to_non_nullable
as String?,tlsFingerprint: freezed == tlsFingerprint ? _self.tlsFingerprint : tlsFingerprint // ignore: cast_nullable_to_non_nullable
as TlsFingerprint?,interceptors: freezed == interceptors ? _self.interceptors : interceptors // ignore: cast_nullable_to_non_nullable
as Interceptors?,proxy: freezed == proxy ? _self.proxy : proxy // ignore: cast_nullable_to_non_nullable
as ProxyConfig?,
  ));
}

/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TlsFingerprintCopyWith<$Res>? get tlsFingerprint {
    if (_self.tlsFingerprint == null) {
    return null;
  }

  return $TlsFingerprintCopyWith<$Res>(_self.tlsFingerprint!, (value) {
    return _then(_self.copyWith(tlsFingerprint: value));
  });
}/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InterceptorsCopyWith<$Res>? get interceptors {
    if (_self.interceptors == null) {
    return null;
  }

  return $InterceptorsCopyWith<$Res>(_self.interceptors!, (value) {
    return _then(_self.copyWith(interceptors: value));
  });
}/// Create a copy of NetworkConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProxyConfigCopyWith<$Res>? get proxy {
    if (_self.proxy == null) {
    return null;
  }

  return $ProxyConfigCopyWith<$Res>(_self.proxy!, (value) {
    return _then(_self.copyWith(proxy: value));
  });
}
}


/// @nodoc
mixin _$Interceptors {

/// 请求前拦截器。
 List<Interceptor>? get onBeforeRequest;/// 失败回退配置。
 FallbackConfig? get onFallback;
/// Create a copy of Interceptors
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterceptorsCopyWith<Interceptors> get copyWith => _$InterceptorsCopyWithImpl<Interceptors>(this as Interceptors, _$identity);

  /// Serializes this Interceptors to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Interceptors&&const DeepCollectionEquality().equals(other.onBeforeRequest, onBeforeRequest)&&(identical(other.onFallback, onFallback) || other.onFallback == onFallback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(onBeforeRequest),onFallback);

@override
String toString() {
  return 'Interceptors(onBeforeRequest: $onBeforeRequest, onFallback: $onFallback)';
}


}

/// @nodoc
abstract mixin class $InterceptorsCopyWith<$Res>  {
  factory $InterceptorsCopyWith(Interceptors value, $Res Function(Interceptors) _then) = _$InterceptorsCopyWithImpl;
@useResult
$Res call({
 List<Interceptor>? onBeforeRequest, FallbackConfig? onFallback
});


$FallbackConfigCopyWith<$Res>? get onFallback;

}
/// @nodoc
class _$InterceptorsCopyWithImpl<$Res>
    implements $InterceptorsCopyWith<$Res> {
  _$InterceptorsCopyWithImpl(this._self, this._then);

  final Interceptors _self;
  final $Res Function(Interceptors) _then;

/// Create a copy of Interceptors
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onBeforeRequest = freezed,Object? onFallback = freezed,}) {
  return _then(_self.copyWith(
onBeforeRequest: freezed == onBeforeRequest ? _self.onBeforeRequest : onBeforeRequest // ignore: cast_nullable_to_non_nullable
as List<Interceptor>?,onFallback: freezed == onFallback ? _self.onFallback : onFallback // ignore: cast_nullable_to_non_nullable
as FallbackConfig?,
  ));
}
/// Create a copy of Interceptors
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FallbackConfigCopyWith<$Res>? get onFallback {
    if (_self.onFallback == null) {
    return null;
  }

  return $FallbackConfigCopyWith<$Res>(_self.onFallback!, (value) {
    return _then(_self.copyWith(onFallback: value));
  });
}
}


/// Adds pattern-matching-related methods to [Interceptors].
extension InterceptorsPatterns on Interceptors {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Interceptors value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Interceptors() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Interceptors value)  $default,){
final _that = this;
switch (_that) {
case _Interceptors():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Interceptors value)?  $default,){
final _that = this;
switch (_that) {
case _Interceptors() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Interceptor>? onBeforeRequest,  FallbackConfig? onFallback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Interceptors() when $default != null:
return $default(_that.onBeforeRequest,_that.onFallback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Interceptor>? onBeforeRequest,  FallbackConfig? onFallback)  $default,) {final _that = this;
switch (_that) {
case _Interceptors():
return $default(_that.onBeforeRequest,_that.onFallback);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Interceptor>? onBeforeRequest,  FallbackConfig? onFallback)?  $default,) {final _that = this;
switch (_that) {
case _Interceptors() when $default != null:
return $default(_that.onBeforeRequest,_that.onFallback);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Interceptors implements Interceptors {
  const _Interceptors({final  List<Interceptor>? onBeforeRequest, this.onFallback}): _onBeforeRequest = onBeforeRequest;
  factory _Interceptors.fromJson(Map<String, dynamic> json) => _$InterceptorsFromJson(json);

/// 请求前拦截器。
 final  List<Interceptor>? _onBeforeRequest;
/// 请求前拦截器。
@override List<Interceptor>? get onBeforeRequest {
  final value = _onBeforeRequest;
  if (value == null) return null;
  if (_onBeforeRequest is EqualUnmodifiableListView) return _onBeforeRequest;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// 失败回退配置。
@override final  FallbackConfig? onFallback;

/// Create a copy of Interceptors
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterceptorsCopyWith<_Interceptors> get copyWith => __$InterceptorsCopyWithImpl<_Interceptors>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterceptorsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Interceptors&&const DeepCollectionEquality().equals(other._onBeforeRequest, _onBeforeRequest)&&(identical(other.onFallback, onFallback) || other.onFallback == onFallback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_onBeforeRequest),onFallback);

@override
String toString() {
  return 'Interceptors(onBeforeRequest: $onBeforeRequest, onFallback: $onFallback)';
}


}

/// @nodoc
abstract mixin class _$InterceptorsCopyWith<$Res> implements $InterceptorsCopyWith<$Res> {
  factory _$InterceptorsCopyWith(_Interceptors value, $Res Function(_Interceptors) _then) = __$InterceptorsCopyWithImpl;
@override @useResult
$Res call({
 List<Interceptor>? onBeforeRequest, FallbackConfig? onFallback
});


@override $FallbackConfigCopyWith<$Res>? get onFallback;

}
/// @nodoc
class __$InterceptorsCopyWithImpl<$Res>
    implements _$InterceptorsCopyWith<$Res> {
  __$InterceptorsCopyWithImpl(this._self, this._then);

  final _Interceptors _self;
  final $Res Function(_Interceptors) _then;

/// Create a copy of Interceptors
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onBeforeRequest = freezed,Object? onFallback = freezed,}) {
  return _then(_Interceptors(
onBeforeRequest: freezed == onBeforeRequest ? _self._onBeforeRequest : onBeforeRequest // ignore: cast_nullable_to_non_nullable
as List<Interceptor>?,onFallback: freezed == onFallback ? _self.onFallback : onFallback // ignore: cast_nullable_to_non_nullable
as FallbackConfig?,
  ));
}

/// Create a copy of Interceptors
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FallbackConfigCopyWith<$Res>? get onFallback {
    if (_self.onFallback == null) {
    return null;
  }

  return $FallbackConfigCopyWith<$Res>(_self.onFallback!, (value) {
    return _then(_self.copyWith(onFallback: value));
  });
}
}


/// @nodoc
mixin _$Interceptor {

/// 拦截器类型。
 InterceptorType get type;/// JavaScript 脚本 (type = js 时使用)。
 String? get script;/// 自定义请求头 (type = headers 时使用)。
 Map<String, String>? get headers;
/// Create a copy of Interceptor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterceptorCopyWith<Interceptor> get copyWith => _$InterceptorCopyWithImpl<Interceptor>(this as Interceptor, _$identity);

  /// Serializes this Interceptor to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Interceptor&&(identical(other.type, type) || other.type == type)&&(identical(other.script, script) || other.script == script)&&const DeepCollectionEquality().equals(other.headers, headers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,script,const DeepCollectionEquality().hash(headers));

@override
String toString() {
  return 'Interceptor(type: $type, script: $script, headers: $headers)';
}


}

/// @nodoc
abstract mixin class $InterceptorCopyWith<$Res>  {
  factory $InterceptorCopyWith(Interceptor value, $Res Function(Interceptor) _then) = _$InterceptorCopyWithImpl;
@useResult
$Res call({
 InterceptorType type, String? script, Map<String, String>? headers
});




}
/// @nodoc
class _$InterceptorCopyWithImpl<$Res>
    implements $InterceptorCopyWith<$Res> {
  _$InterceptorCopyWithImpl(this._self, this._then);

  final Interceptor _self;
  final $Res Function(Interceptor) _then;

/// Create a copy of Interceptor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? script = freezed,Object? headers = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InterceptorType,script: freezed == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as String?,headers: freezed == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Interceptor].
extension InterceptorPatterns on Interceptor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Interceptor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Interceptor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Interceptor value)  $default,){
final _that = this;
switch (_that) {
case _Interceptor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Interceptor value)?  $default,){
final _that = this;
switch (_that) {
case _Interceptor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InterceptorType type,  String? script,  Map<String, String>? headers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Interceptor() when $default != null:
return $default(_that.type,_that.script,_that.headers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InterceptorType type,  String? script,  Map<String, String>? headers)  $default,) {final _that = this;
switch (_that) {
case _Interceptor():
return $default(_that.type,_that.script,_that.headers);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InterceptorType type,  String? script,  Map<String, String>? headers)?  $default,) {final _that = this;
switch (_that) {
case _Interceptor() when $default != null:
return $default(_that.type,_that.script,_that.headers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Interceptor implements Interceptor {
  const _Interceptor({required this.type, this.script, final  Map<String, String>? headers}): _headers = headers;
  factory _Interceptor.fromJson(Map<String, dynamic> json) => _$InterceptorFromJson(json);

/// 拦截器类型。
@override final  InterceptorType type;
/// JavaScript 脚本 (type = js 时使用)。
@override final  String? script;
/// 自定义请求头 (type = headers 时使用)。
 final  Map<String, String>? _headers;
/// 自定义请求头 (type = headers 时使用)。
@override Map<String, String>? get headers {
  final value = _headers;
  if (value == null) return null;
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of Interceptor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InterceptorCopyWith<_Interceptor> get copyWith => __$InterceptorCopyWithImpl<_Interceptor>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InterceptorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Interceptor&&(identical(other.type, type) || other.type == type)&&(identical(other.script, script) || other.script == script)&&const DeepCollectionEquality().equals(other._headers, _headers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,script,const DeepCollectionEquality().hash(_headers));

@override
String toString() {
  return 'Interceptor(type: $type, script: $script, headers: $headers)';
}


}

/// @nodoc
abstract mixin class _$InterceptorCopyWith<$Res> implements $InterceptorCopyWith<$Res> {
  factory _$InterceptorCopyWith(_Interceptor value, $Res Function(_Interceptor) _then) = __$InterceptorCopyWithImpl;
@override @useResult
$Res call({
 InterceptorType type, String? script, Map<String, String>? headers
});




}
/// @nodoc
class __$InterceptorCopyWithImpl<$Res>
    implements _$InterceptorCopyWith<$Res> {
  __$InterceptorCopyWithImpl(this._self, this._then);

  final _Interceptor _self;
  final $Res Function(_Interceptor) _then;

/// Create a copy of Interceptor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? script = freezed,Object? headers = freezed,}) {
  return _then(_Interceptor(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InterceptorType,script: freezed == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as String?,headers: freezed == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

// dart format on
