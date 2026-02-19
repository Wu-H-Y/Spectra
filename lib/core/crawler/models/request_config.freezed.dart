// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequestConfig {

/// HTTP method (GET, POST, etc.).
 String get method;/// Request headers.
 Map<String, String>? get headers;/// Request body (for POST requests).
 String? get body;/// Query parameters.
 Map<String, String>? get query;/// Cookies to send.
 Map<String, String>? get cookies;/// Request timeout in milliseconds.
 int get timeoutMs;/// Whether to follow redirects.
 bool get followRedirects;/// Maximum redirects to follow.
 int get maxRedirects;/// User agent string.
 String? get userAgent;/// Whether to use mobile user agent.
 bool get mobileUserAgent;/// Referer header value.
 String? get referer;
/// Create a copy of RequestConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequestConfigCopyWith<RequestConfig> get copyWith => _$RequestConfigCopyWithImpl<RequestConfig>(this as RequestConfig, _$identity);

  /// Serializes this RequestConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequestConfig&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.headers, headers)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.query, query)&&const DeepCollectionEquality().equals(other.cookies, cookies)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs)&&(identical(other.followRedirects, followRedirects) || other.followRedirects == followRedirects)&&(identical(other.maxRedirects, maxRedirects) || other.maxRedirects == maxRedirects)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.mobileUserAgent, mobileUserAgent) || other.mobileUserAgent == mobileUserAgent)&&(identical(other.referer, referer) || other.referer == referer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,method,const DeepCollectionEquality().hash(headers),body,const DeepCollectionEquality().hash(query),const DeepCollectionEquality().hash(cookies),timeoutMs,followRedirects,maxRedirects,userAgent,mobileUserAgent,referer);

@override
String toString() {
  return 'RequestConfig(method: $method, headers: $headers, body: $body, query: $query, cookies: $cookies, timeoutMs: $timeoutMs, followRedirects: $followRedirects, maxRedirects: $maxRedirects, userAgent: $userAgent, mobileUserAgent: $mobileUserAgent, referer: $referer)';
}


}

/// @nodoc
abstract mixin class $RequestConfigCopyWith<$Res>  {
  factory $RequestConfigCopyWith(RequestConfig value, $Res Function(RequestConfig) _then) = _$RequestConfigCopyWithImpl;
@useResult
$Res call({
 String method, Map<String, String>? headers, String? body, Map<String, String>? query, Map<String, String>? cookies, int timeoutMs, bool followRedirects, int maxRedirects, String? userAgent, bool mobileUserAgent, String? referer
});




}
/// @nodoc
class _$RequestConfigCopyWithImpl<$Res>
    implements $RequestConfigCopyWith<$Res> {
  _$RequestConfigCopyWithImpl(this._self, this._then);

  final RequestConfig _self;
  final $Res Function(RequestConfig) _then;

/// Create a copy of RequestConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? method = null,Object? headers = freezed,Object? body = freezed,Object? query = freezed,Object? cookies = freezed,Object? timeoutMs = null,Object? followRedirects = null,Object? maxRedirects = null,Object? userAgent = freezed,Object? mobileUserAgent = null,Object? referer = freezed,}) {
  return _then(_self.copyWith(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,headers: freezed == headers ? _self.headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,cookies: freezed == cookies ? _self.cookies : cookies // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,followRedirects: null == followRedirects ? _self.followRedirects : followRedirects // ignore: cast_nullable_to_non_nullable
as bool,maxRedirects: null == maxRedirects ? _self.maxRedirects : maxRedirects // ignore: cast_nullable_to_non_nullable
as int,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,mobileUserAgent: null == mobileUserAgent ? _self.mobileUserAgent : mobileUserAgent // ignore: cast_nullable_to_non_nullable
as bool,referer: freezed == referer ? _self.referer : referer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RequestConfig].
extension RequestConfigPatterns on RequestConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RequestConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RequestConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RequestConfig value)  $default,){
final _that = this;
switch (_that) {
case _RequestConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RequestConfig value)?  $default,){
final _that = this;
switch (_that) {
case _RequestConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String method,  Map<String, String>? headers,  String? body,  Map<String, String>? query,  Map<String, String>? cookies,  int timeoutMs,  bool followRedirects,  int maxRedirects,  String? userAgent,  bool mobileUserAgent,  String? referer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequestConfig() when $default != null:
return $default(_that.method,_that.headers,_that.body,_that.query,_that.cookies,_that.timeoutMs,_that.followRedirects,_that.maxRedirects,_that.userAgent,_that.mobileUserAgent,_that.referer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String method,  Map<String, String>? headers,  String? body,  Map<String, String>? query,  Map<String, String>? cookies,  int timeoutMs,  bool followRedirects,  int maxRedirects,  String? userAgent,  bool mobileUserAgent,  String? referer)  $default,) {final _that = this;
switch (_that) {
case _RequestConfig():
return $default(_that.method,_that.headers,_that.body,_that.query,_that.cookies,_that.timeoutMs,_that.followRedirects,_that.maxRedirects,_that.userAgent,_that.mobileUserAgent,_that.referer);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String method,  Map<String, String>? headers,  String? body,  Map<String, String>? query,  Map<String, String>? cookies,  int timeoutMs,  bool followRedirects,  int maxRedirects,  String? userAgent,  bool mobileUserAgent,  String? referer)?  $default,) {final _that = this;
switch (_that) {
case _RequestConfig() when $default != null:
return $default(_that.method,_that.headers,_that.body,_that.query,_that.cookies,_that.timeoutMs,_that.followRedirects,_that.maxRedirects,_that.userAgent,_that.mobileUserAgent,_that.referer);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequestConfig implements RequestConfig {
  const _RequestConfig({this.method = 'GET', final  Map<String, String>? headers, this.body, final  Map<String, String>? query, final  Map<String, String>? cookies, this.timeoutMs = 30000, this.followRedirects = true, this.maxRedirects = 5, this.userAgent, this.mobileUserAgent = false, this.referer}): _headers = headers,_query = query,_cookies = cookies;
  factory _RequestConfig.fromJson(Map<String, dynamic> json) => _$RequestConfigFromJson(json);

/// HTTP method (GET, POST, etc.).
@override@JsonKey() final  String method;
/// Request headers.
 final  Map<String, String>? _headers;
/// Request headers.
@override Map<String, String>? get headers {
  final value = _headers;
  if (value == null) return null;
  if (_headers is EqualUnmodifiableMapView) return _headers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Request body (for POST requests).
@override final  String? body;
/// Query parameters.
 final  Map<String, String>? _query;
/// Query parameters.
@override Map<String, String>? get query {
  final value = _query;
  if (value == null) return null;
  if (_query is EqualUnmodifiableMapView) return _query;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Cookies to send.
 final  Map<String, String>? _cookies;
/// Cookies to send.
@override Map<String, String>? get cookies {
  final value = _cookies;
  if (value == null) return null;
  if (_cookies is EqualUnmodifiableMapView) return _cookies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Request timeout in milliseconds.
@override@JsonKey() final  int timeoutMs;
/// Whether to follow redirects.
@override@JsonKey() final  bool followRedirects;
/// Maximum redirects to follow.
@override@JsonKey() final  int maxRedirects;
/// User agent string.
@override final  String? userAgent;
/// Whether to use mobile user agent.
@override@JsonKey() final  bool mobileUserAgent;
/// Referer header value.
@override final  String? referer;

/// Create a copy of RequestConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestConfigCopyWith<_RequestConfig> get copyWith => __$RequestConfigCopyWithImpl<_RequestConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequestConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestConfig&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other._headers, _headers)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._query, _query)&&const DeepCollectionEquality().equals(other._cookies, _cookies)&&(identical(other.timeoutMs, timeoutMs) || other.timeoutMs == timeoutMs)&&(identical(other.followRedirects, followRedirects) || other.followRedirects == followRedirects)&&(identical(other.maxRedirects, maxRedirects) || other.maxRedirects == maxRedirects)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.mobileUserAgent, mobileUserAgent) || other.mobileUserAgent == mobileUserAgent)&&(identical(other.referer, referer) || other.referer == referer));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,method,const DeepCollectionEquality().hash(_headers),body,const DeepCollectionEquality().hash(_query),const DeepCollectionEquality().hash(_cookies),timeoutMs,followRedirects,maxRedirects,userAgent,mobileUserAgent,referer);

@override
String toString() {
  return 'RequestConfig(method: $method, headers: $headers, body: $body, query: $query, cookies: $cookies, timeoutMs: $timeoutMs, followRedirects: $followRedirects, maxRedirects: $maxRedirects, userAgent: $userAgent, mobileUserAgent: $mobileUserAgent, referer: $referer)';
}


}

/// @nodoc
abstract mixin class _$RequestConfigCopyWith<$Res> implements $RequestConfigCopyWith<$Res> {
  factory _$RequestConfigCopyWith(_RequestConfig value, $Res Function(_RequestConfig) _then) = __$RequestConfigCopyWithImpl;
@override @useResult
$Res call({
 String method, Map<String, String>? headers, String? body, Map<String, String>? query, Map<String, String>? cookies, int timeoutMs, bool followRedirects, int maxRedirects, String? userAgent, bool mobileUserAgent, String? referer
});




}
/// @nodoc
class __$RequestConfigCopyWithImpl<$Res>
    implements _$RequestConfigCopyWith<$Res> {
  __$RequestConfigCopyWithImpl(this._self, this._then);

  final _RequestConfig _self;
  final $Res Function(_RequestConfig) _then;

/// Create a copy of RequestConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? method = null,Object? headers = freezed,Object? body = freezed,Object? query = freezed,Object? cookies = freezed,Object? timeoutMs = null,Object? followRedirects = null,Object? maxRedirects = null,Object? userAgent = freezed,Object? mobileUserAgent = null,Object? referer = freezed,}) {
  return _then(_RequestConfig(
method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,headers: freezed == headers ? _self._headers : headers // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,query: freezed == query ? _self._query : query // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,cookies: freezed == cookies ? _self._cookies : cookies // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,timeoutMs: null == timeoutMs ? _self.timeoutMs : timeoutMs // ignore: cast_nullable_to_non_nullable
as int,followRedirects: null == followRedirects ? _self.followRedirects : followRedirects // ignore: cast_nullable_to_non_nullable
as bool,maxRedirects: null == maxRedirects ? _self.maxRedirects : maxRedirects // ignore: cast_nullable_to_non_nullable
as int,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,mobileUserAgent: null == mobileUserAgent ? _self.mobileUserAgent : mobileUserAgent // ignore: cast_nullable_to_non_nullable
as bool,referer: freezed == referer ? _self.referer : referer // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
