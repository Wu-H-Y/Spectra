// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detection_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DetectionConfig {

/// 验证码检测配置。
 CaptchaDetection? get captcha;/// 频率限制检测配置。
 RateLimitDetection? get rateLimit;/// 登录检测配置。
 LoginDetection? get login;/// Cloudflare 检测。
 bool get detectCloudflare;/// 检测到时自动重试。
 bool get autoRetry;/// 最大重试次数。
 int get maxRetries;
/// Create a copy of DetectionConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetectionConfigCopyWith<DetectionConfig> get copyWith => _$DetectionConfigCopyWithImpl<DetectionConfig>(this as DetectionConfig, _$identity);

  /// Serializes this DetectionConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetectionConfig&&(identical(other.captcha, captcha) || other.captcha == captcha)&&(identical(other.rateLimit, rateLimit) || other.rateLimit == rateLimit)&&(identical(other.login, login) || other.login == login)&&(identical(other.detectCloudflare, detectCloudflare) || other.detectCloudflare == detectCloudflare)&&(identical(other.autoRetry, autoRetry) || other.autoRetry == autoRetry)&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,captcha,rateLimit,login,detectCloudflare,autoRetry,maxRetries);

@override
String toString() {
  return 'DetectionConfig(captcha: $captcha, rateLimit: $rateLimit, login: $login, detectCloudflare: $detectCloudflare, autoRetry: $autoRetry, maxRetries: $maxRetries)';
}


}

/// @nodoc
abstract mixin class $DetectionConfigCopyWith<$Res>  {
  factory $DetectionConfigCopyWith(DetectionConfig value, $Res Function(DetectionConfig) _then) = _$DetectionConfigCopyWithImpl;
@useResult
$Res call({
 CaptchaDetection? captcha, RateLimitDetection? rateLimit, LoginDetection? login, bool detectCloudflare, bool autoRetry, int maxRetries
});


$CaptchaDetectionCopyWith<$Res>? get captcha;$RateLimitDetectionCopyWith<$Res>? get rateLimit;$LoginDetectionCopyWith<$Res>? get login;

}
/// @nodoc
class _$DetectionConfigCopyWithImpl<$Res>
    implements $DetectionConfigCopyWith<$Res> {
  _$DetectionConfigCopyWithImpl(this._self, this._then);

  final DetectionConfig _self;
  final $Res Function(DetectionConfig) _then;

/// Create a copy of DetectionConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? captcha = freezed,Object? rateLimit = freezed,Object? login = freezed,Object? detectCloudflare = null,Object? autoRetry = null,Object? maxRetries = null,}) {
  return _then(_self.copyWith(
captcha: freezed == captcha ? _self.captcha : captcha // ignore: cast_nullable_to_non_nullable
as CaptchaDetection?,rateLimit: freezed == rateLimit ? _self.rateLimit : rateLimit // ignore: cast_nullable_to_non_nullable
as RateLimitDetection?,login: freezed == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as LoginDetection?,detectCloudflare: null == detectCloudflare ? _self.detectCloudflare : detectCloudflare // ignore: cast_nullable_to_non_nullable
as bool,autoRetry: null == autoRetry ? _self.autoRetry : autoRetry // ignore: cast_nullable_to_non_nullable
as bool,maxRetries: null == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of DetectionConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CaptchaDetectionCopyWith<$Res>? get captcha {
    if (_self.captcha == null) {
    return null;
  }

  return $CaptchaDetectionCopyWith<$Res>(_self.captcha!, (value) {
    return _then(_self.copyWith(captcha: value));
  });
}/// Create a copy of DetectionConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateLimitDetectionCopyWith<$Res>? get rateLimit {
    if (_self.rateLimit == null) {
    return null;
  }

  return $RateLimitDetectionCopyWith<$Res>(_self.rateLimit!, (value) {
    return _then(_self.copyWith(rateLimit: value));
  });
}/// Create a copy of DetectionConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginDetectionCopyWith<$Res>? get login {
    if (_self.login == null) {
    return null;
  }

  return $LoginDetectionCopyWith<$Res>(_self.login!, (value) {
    return _then(_self.copyWith(login: value));
  });
}
}


/// Adds pattern-matching-related methods to [DetectionConfig].
extension DetectionConfigPatterns on DetectionConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DetectionConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetectionConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DetectionConfig value)  $default,){
final _that = this;
switch (_that) {
case _DetectionConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DetectionConfig value)?  $default,){
final _that = this;
switch (_that) {
case _DetectionConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CaptchaDetection? captcha,  RateLimitDetection? rateLimit,  LoginDetection? login,  bool detectCloudflare,  bool autoRetry,  int maxRetries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetectionConfig() when $default != null:
return $default(_that.captcha,_that.rateLimit,_that.login,_that.detectCloudflare,_that.autoRetry,_that.maxRetries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CaptchaDetection? captcha,  RateLimitDetection? rateLimit,  LoginDetection? login,  bool detectCloudflare,  bool autoRetry,  int maxRetries)  $default,) {final _that = this;
switch (_that) {
case _DetectionConfig():
return $default(_that.captcha,_that.rateLimit,_that.login,_that.detectCloudflare,_that.autoRetry,_that.maxRetries);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CaptchaDetection? captcha,  RateLimitDetection? rateLimit,  LoginDetection? login,  bool detectCloudflare,  bool autoRetry,  int maxRetries)?  $default,) {final _that = this;
switch (_that) {
case _DetectionConfig() when $default != null:
return $default(_that.captcha,_that.rateLimit,_that.login,_that.detectCloudflare,_that.autoRetry,_that.maxRetries);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DetectionConfig implements DetectionConfig {
  const _DetectionConfig({this.captcha, this.rateLimit, this.login, this.detectCloudflare = true, this.autoRetry = true, this.maxRetries = 3});
  factory _DetectionConfig.fromJson(Map<String, dynamic> json) => _$DetectionConfigFromJson(json);

/// 验证码检测配置。
@override final  CaptchaDetection? captcha;
/// 频率限制检测配置。
@override final  RateLimitDetection? rateLimit;
/// 登录检测配置。
@override final  LoginDetection? login;
/// Cloudflare 检测。
@override@JsonKey() final  bool detectCloudflare;
/// 检测到时自动重试。
@override@JsonKey() final  bool autoRetry;
/// 最大重试次数。
@override@JsonKey() final  int maxRetries;

/// Create a copy of DetectionConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetectionConfigCopyWith<_DetectionConfig> get copyWith => __$DetectionConfigCopyWithImpl<_DetectionConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DetectionConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetectionConfig&&(identical(other.captcha, captcha) || other.captcha == captcha)&&(identical(other.rateLimit, rateLimit) || other.rateLimit == rateLimit)&&(identical(other.login, login) || other.login == login)&&(identical(other.detectCloudflare, detectCloudflare) || other.detectCloudflare == detectCloudflare)&&(identical(other.autoRetry, autoRetry) || other.autoRetry == autoRetry)&&(identical(other.maxRetries, maxRetries) || other.maxRetries == maxRetries));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,captcha,rateLimit,login,detectCloudflare,autoRetry,maxRetries);

@override
String toString() {
  return 'DetectionConfig(captcha: $captcha, rateLimit: $rateLimit, login: $login, detectCloudflare: $detectCloudflare, autoRetry: $autoRetry, maxRetries: $maxRetries)';
}


}

/// @nodoc
abstract mixin class _$DetectionConfigCopyWith<$Res> implements $DetectionConfigCopyWith<$Res> {
  factory _$DetectionConfigCopyWith(_DetectionConfig value, $Res Function(_DetectionConfig) _then) = __$DetectionConfigCopyWithImpl;
@override @useResult
$Res call({
 CaptchaDetection? captcha, RateLimitDetection? rateLimit, LoginDetection? login, bool detectCloudflare, bool autoRetry, int maxRetries
});


@override $CaptchaDetectionCopyWith<$Res>? get captcha;@override $RateLimitDetectionCopyWith<$Res>? get rateLimit;@override $LoginDetectionCopyWith<$Res>? get login;

}
/// @nodoc
class __$DetectionConfigCopyWithImpl<$Res>
    implements _$DetectionConfigCopyWith<$Res> {
  __$DetectionConfigCopyWithImpl(this._self, this._then);

  final _DetectionConfig _self;
  final $Res Function(_DetectionConfig) _then;

/// Create a copy of DetectionConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? captcha = freezed,Object? rateLimit = freezed,Object? login = freezed,Object? detectCloudflare = null,Object? autoRetry = null,Object? maxRetries = null,}) {
  return _then(_DetectionConfig(
captcha: freezed == captcha ? _self.captcha : captcha // ignore: cast_nullable_to_non_nullable
as CaptchaDetection?,rateLimit: freezed == rateLimit ? _self.rateLimit : rateLimit // ignore: cast_nullable_to_non_nullable
as RateLimitDetection?,login: freezed == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as LoginDetection?,detectCloudflare: null == detectCloudflare ? _self.detectCloudflare : detectCloudflare // ignore: cast_nullable_to_non_nullable
as bool,autoRetry: null == autoRetry ? _self.autoRetry : autoRetry // ignore: cast_nullable_to_non_nullable
as bool,maxRetries: null == maxRetries ? _self.maxRetries : maxRetries // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of DetectionConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CaptchaDetectionCopyWith<$Res>? get captcha {
    if (_self.captcha == null) {
    return null;
  }

  return $CaptchaDetectionCopyWith<$Res>(_self.captcha!, (value) {
    return _then(_self.copyWith(captcha: value));
  });
}/// Create a copy of DetectionConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RateLimitDetectionCopyWith<$Res>? get rateLimit {
    if (_self.rateLimit == null) {
    return null;
  }

  return $RateLimitDetectionCopyWith<$Res>(_self.rateLimit!, (value) {
    return _then(_self.copyWith(rateLimit: value));
  });
}/// Create a copy of DetectionConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LoginDetectionCopyWith<$Res>? get login {
    if (_self.login == null) {
    return null;
  }

  return $LoginDetectionCopyWith<$Res>(_self.login!, (value) {
    return _then(_self.copyWith(login: value));
  });
}
}


/// @nodoc
mixin _$CaptchaDetection {

/// 是否检测 reCAPTCHA。
 bool get detectRecaptcha;/// 是否检测 hCaptcha。
 bool get detectHcaptcha;/// 是否检测通用验证码图片。
 bool get detectGeneric;/// 第三方验证码破解服务 API 密钥。
 String? get solverApiKey;/// 破解服务类型（2captcha、anticaptcha 等）。
 String? get solverService;
/// Create a copy of CaptchaDetection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CaptchaDetectionCopyWith<CaptchaDetection> get copyWith => _$CaptchaDetectionCopyWithImpl<CaptchaDetection>(this as CaptchaDetection, _$identity);

  /// Serializes this CaptchaDetection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CaptchaDetection&&(identical(other.detectRecaptcha, detectRecaptcha) || other.detectRecaptcha == detectRecaptcha)&&(identical(other.detectHcaptcha, detectHcaptcha) || other.detectHcaptcha == detectHcaptcha)&&(identical(other.detectGeneric, detectGeneric) || other.detectGeneric == detectGeneric)&&(identical(other.solverApiKey, solverApiKey) || other.solverApiKey == solverApiKey)&&(identical(other.solverService, solverService) || other.solverService == solverService));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detectRecaptcha,detectHcaptcha,detectGeneric,solverApiKey,solverService);

@override
String toString() {
  return 'CaptchaDetection(detectRecaptcha: $detectRecaptcha, detectHcaptcha: $detectHcaptcha, detectGeneric: $detectGeneric, solverApiKey: $solverApiKey, solverService: $solverService)';
}


}

/// @nodoc
abstract mixin class $CaptchaDetectionCopyWith<$Res>  {
  factory $CaptchaDetectionCopyWith(CaptchaDetection value, $Res Function(CaptchaDetection) _then) = _$CaptchaDetectionCopyWithImpl;
@useResult
$Res call({
 bool detectRecaptcha, bool detectHcaptcha, bool detectGeneric, String? solverApiKey, String? solverService
});




}
/// @nodoc
class _$CaptchaDetectionCopyWithImpl<$Res>
    implements $CaptchaDetectionCopyWith<$Res> {
  _$CaptchaDetectionCopyWithImpl(this._self, this._then);

  final CaptchaDetection _self;
  final $Res Function(CaptchaDetection) _then;

/// Create a copy of CaptchaDetection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? detectRecaptcha = null,Object? detectHcaptcha = null,Object? detectGeneric = null,Object? solverApiKey = freezed,Object? solverService = freezed,}) {
  return _then(_self.copyWith(
detectRecaptcha: null == detectRecaptcha ? _self.detectRecaptcha : detectRecaptcha // ignore: cast_nullable_to_non_nullable
as bool,detectHcaptcha: null == detectHcaptcha ? _self.detectHcaptcha : detectHcaptcha // ignore: cast_nullable_to_non_nullable
as bool,detectGeneric: null == detectGeneric ? _self.detectGeneric : detectGeneric // ignore: cast_nullable_to_non_nullable
as bool,solverApiKey: freezed == solverApiKey ? _self.solverApiKey : solverApiKey // ignore: cast_nullable_to_non_nullable
as String?,solverService: freezed == solverService ? _self.solverService : solverService // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CaptchaDetection].
extension CaptchaDetectionPatterns on CaptchaDetection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CaptchaDetection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CaptchaDetection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CaptchaDetection value)  $default,){
final _that = this;
switch (_that) {
case _CaptchaDetection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CaptchaDetection value)?  $default,){
final _that = this;
switch (_that) {
case _CaptchaDetection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool detectRecaptcha,  bool detectHcaptcha,  bool detectGeneric,  String? solverApiKey,  String? solverService)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CaptchaDetection() when $default != null:
return $default(_that.detectRecaptcha,_that.detectHcaptcha,_that.detectGeneric,_that.solverApiKey,_that.solverService);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool detectRecaptcha,  bool detectHcaptcha,  bool detectGeneric,  String? solverApiKey,  String? solverService)  $default,) {final _that = this;
switch (_that) {
case _CaptchaDetection():
return $default(_that.detectRecaptcha,_that.detectHcaptcha,_that.detectGeneric,_that.solverApiKey,_that.solverService);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool detectRecaptcha,  bool detectHcaptcha,  bool detectGeneric,  String? solverApiKey,  String? solverService)?  $default,) {final _that = this;
switch (_that) {
case _CaptchaDetection() when $default != null:
return $default(_that.detectRecaptcha,_that.detectHcaptcha,_that.detectGeneric,_that.solverApiKey,_that.solverService);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CaptchaDetection implements CaptchaDetection {
  const _CaptchaDetection({this.detectRecaptcha = true, this.detectHcaptcha = true, this.detectGeneric = true, this.solverApiKey, this.solverService});
  factory _CaptchaDetection.fromJson(Map<String, dynamic> json) => _$CaptchaDetectionFromJson(json);

/// 是否检测 reCAPTCHA。
@override@JsonKey() final  bool detectRecaptcha;
/// 是否检测 hCaptcha。
@override@JsonKey() final  bool detectHcaptcha;
/// 是否检测通用验证码图片。
@override@JsonKey() final  bool detectGeneric;
/// 第三方验证码破解服务 API 密钥。
@override final  String? solverApiKey;
/// 破解服务类型（2captcha、anticaptcha 等）。
@override final  String? solverService;

/// Create a copy of CaptchaDetection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CaptchaDetectionCopyWith<_CaptchaDetection> get copyWith => __$CaptchaDetectionCopyWithImpl<_CaptchaDetection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CaptchaDetectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CaptchaDetection&&(identical(other.detectRecaptcha, detectRecaptcha) || other.detectRecaptcha == detectRecaptcha)&&(identical(other.detectHcaptcha, detectHcaptcha) || other.detectHcaptcha == detectHcaptcha)&&(identical(other.detectGeneric, detectGeneric) || other.detectGeneric == detectGeneric)&&(identical(other.solverApiKey, solverApiKey) || other.solverApiKey == solverApiKey)&&(identical(other.solverService, solverService) || other.solverService == solverService));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detectRecaptcha,detectHcaptcha,detectGeneric,solverApiKey,solverService);

@override
String toString() {
  return 'CaptchaDetection(detectRecaptcha: $detectRecaptcha, detectHcaptcha: $detectHcaptcha, detectGeneric: $detectGeneric, solverApiKey: $solverApiKey, solverService: $solverService)';
}


}

/// @nodoc
abstract mixin class _$CaptchaDetectionCopyWith<$Res> implements $CaptchaDetectionCopyWith<$Res> {
  factory _$CaptchaDetectionCopyWith(_CaptchaDetection value, $Res Function(_CaptchaDetection) _then) = __$CaptchaDetectionCopyWithImpl;
@override @useResult
$Res call({
 bool detectRecaptcha, bool detectHcaptcha, bool detectGeneric, String? solverApiKey, String? solverService
});




}
/// @nodoc
class __$CaptchaDetectionCopyWithImpl<$Res>
    implements _$CaptchaDetectionCopyWith<$Res> {
  __$CaptchaDetectionCopyWithImpl(this._self, this._then);

  final _CaptchaDetection _self;
  final $Res Function(_CaptchaDetection) _then;

/// Create a copy of CaptchaDetection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? detectRecaptcha = null,Object? detectHcaptcha = null,Object? detectGeneric = null,Object? solverApiKey = freezed,Object? solverService = freezed,}) {
  return _then(_CaptchaDetection(
detectRecaptcha: null == detectRecaptcha ? _self.detectRecaptcha : detectRecaptcha // ignore: cast_nullable_to_non_nullable
as bool,detectHcaptcha: null == detectHcaptcha ? _self.detectHcaptcha : detectHcaptcha // ignore: cast_nullable_to_non_nullable
as bool,detectGeneric: null == detectGeneric ? _self.detectGeneric : detectGeneric // ignore: cast_nullable_to_non_nullable
as bool,solverApiKey: freezed == solverApiKey ? _self.solverApiKey : solverApiKey // ignore: cast_nullable_to_non_nullable
as String?,solverService: freezed == solverService ? _self.solverService : solverService // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RateLimitDetection {

/// 视为频率限制的 HTTP 状态码。
 List<int> get statusCodes;/// 表示频率限制的响应文本模式。
 List<String>? get textPatterns;/// 请求之间的最小延迟（毫秒）。
 int get minDelayMs;/// 请求之间的最大延迟（毫秒）。
 int get maxDelayMs;/// 是否使用指数退避。
 bool get exponentialBackoff;
/// Create a copy of RateLimitDetection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RateLimitDetectionCopyWith<RateLimitDetection> get copyWith => _$RateLimitDetectionCopyWithImpl<RateLimitDetection>(this as RateLimitDetection, _$identity);

  /// Serializes this RateLimitDetection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RateLimitDetection&&const DeepCollectionEquality().equals(other.statusCodes, statusCodes)&&const DeepCollectionEquality().equals(other.textPatterns, textPatterns)&&(identical(other.minDelayMs, minDelayMs) || other.minDelayMs == minDelayMs)&&(identical(other.maxDelayMs, maxDelayMs) || other.maxDelayMs == maxDelayMs)&&(identical(other.exponentialBackoff, exponentialBackoff) || other.exponentialBackoff == exponentialBackoff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(statusCodes),const DeepCollectionEquality().hash(textPatterns),minDelayMs,maxDelayMs,exponentialBackoff);

@override
String toString() {
  return 'RateLimitDetection(statusCodes: $statusCodes, textPatterns: $textPatterns, minDelayMs: $minDelayMs, maxDelayMs: $maxDelayMs, exponentialBackoff: $exponentialBackoff)';
}


}

/// @nodoc
abstract mixin class $RateLimitDetectionCopyWith<$Res>  {
  factory $RateLimitDetectionCopyWith(RateLimitDetection value, $Res Function(RateLimitDetection) _then) = _$RateLimitDetectionCopyWithImpl;
@useResult
$Res call({
 List<int> statusCodes, List<String>? textPatterns, int minDelayMs, int maxDelayMs, bool exponentialBackoff
});




}
/// @nodoc
class _$RateLimitDetectionCopyWithImpl<$Res>
    implements $RateLimitDetectionCopyWith<$Res> {
  _$RateLimitDetectionCopyWithImpl(this._self, this._then);

  final RateLimitDetection _self;
  final $Res Function(RateLimitDetection) _then;

/// Create a copy of RateLimitDetection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCodes = null,Object? textPatterns = freezed,Object? minDelayMs = null,Object? maxDelayMs = null,Object? exponentialBackoff = null,}) {
  return _then(_self.copyWith(
statusCodes: null == statusCodes ? _self.statusCodes : statusCodes // ignore: cast_nullable_to_non_nullable
as List<int>,textPatterns: freezed == textPatterns ? _self.textPatterns : textPatterns // ignore: cast_nullable_to_non_nullable
as List<String>?,minDelayMs: null == minDelayMs ? _self.minDelayMs : minDelayMs // ignore: cast_nullable_to_non_nullable
as int,maxDelayMs: null == maxDelayMs ? _self.maxDelayMs : maxDelayMs // ignore: cast_nullable_to_non_nullable
as int,exponentialBackoff: null == exponentialBackoff ? _self.exponentialBackoff : exponentialBackoff // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RateLimitDetection].
extension RateLimitDetectionPatterns on RateLimitDetection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RateLimitDetection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RateLimitDetection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RateLimitDetection value)  $default,){
final _that = this;
switch (_that) {
case _RateLimitDetection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RateLimitDetection value)?  $default,){
final _that = this;
switch (_that) {
case _RateLimitDetection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<int> statusCodes,  List<String>? textPatterns,  int minDelayMs,  int maxDelayMs,  bool exponentialBackoff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RateLimitDetection() when $default != null:
return $default(_that.statusCodes,_that.textPatterns,_that.minDelayMs,_that.maxDelayMs,_that.exponentialBackoff);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<int> statusCodes,  List<String>? textPatterns,  int minDelayMs,  int maxDelayMs,  bool exponentialBackoff)  $default,) {final _that = this;
switch (_that) {
case _RateLimitDetection():
return $default(_that.statusCodes,_that.textPatterns,_that.minDelayMs,_that.maxDelayMs,_that.exponentialBackoff);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<int> statusCodes,  List<String>? textPatterns,  int minDelayMs,  int maxDelayMs,  bool exponentialBackoff)?  $default,) {final _that = this;
switch (_that) {
case _RateLimitDetection() when $default != null:
return $default(_that.statusCodes,_that.textPatterns,_that.minDelayMs,_that.maxDelayMs,_that.exponentialBackoff);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RateLimitDetection implements RateLimitDetection {
  const _RateLimitDetection({final  List<int> statusCodes = const [429, 503, 520, 521, 522, 523, 524], final  List<String>? textPatterns, this.minDelayMs = 1000, this.maxDelayMs = 5000, this.exponentialBackoff = true}): _statusCodes = statusCodes,_textPatterns = textPatterns;
  factory _RateLimitDetection.fromJson(Map<String, dynamic> json) => _$RateLimitDetectionFromJson(json);

/// 视为频率限制的 HTTP 状态码。
 final  List<int> _statusCodes;
/// 视为频率限制的 HTTP 状态码。
@override@JsonKey() List<int> get statusCodes {
  if (_statusCodes is EqualUnmodifiableListView) return _statusCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_statusCodes);
}

/// 表示频率限制的响应文本模式。
 final  List<String>? _textPatterns;
/// 表示频率限制的响应文本模式。
@override List<String>? get textPatterns {
  final value = _textPatterns;
  if (value == null) return null;
  if (_textPatterns is EqualUnmodifiableListView) return _textPatterns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// 请求之间的最小延迟（毫秒）。
@override@JsonKey() final  int minDelayMs;
/// 请求之间的最大延迟（毫秒）。
@override@JsonKey() final  int maxDelayMs;
/// 是否使用指数退避。
@override@JsonKey() final  bool exponentialBackoff;

/// Create a copy of RateLimitDetection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RateLimitDetectionCopyWith<_RateLimitDetection> get copyWith => __$RateLimitDetectionCopyWithImpl<_RateLimitDetection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RateLimitDetectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RateLimitDetection&&const DeepCollectionEquality().equals(other._statusCodes, _statusCodes)&&const DeepCollectionEquality().equals(other._textPatterns, _textPatterns)&&(identical(other.minDelayMs, minDelayMs) || other.minDelayMs == minDelayMs)&&(identical(other.maxDelayMs, maxDelayMs) || other.maxDelayMs == maxDelayMs)&&(identical(other.exponentialBackoff, exponentialBackoff) || other.exponentialBackoff == exponentialBackoff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_statusCodes),const DeepCollectionEquality().hash(_textPatterns),minDelayMs,maxDelayMs,exponentialBackoff);

@override
String toString() {
  return 'RateLimitDetection(statusCodes: $statusCodes, textPatterns: $textPatterns, minDelayMs: $minDelayMs, maxDelayMs: $maxDelayMs, exponentialBackoff: $exponentialBackoff)';
}


}

/// @nodoc
abstract mixin class _$RateLimitDetectionCopyWith<$Res> implements $RateLimitDetectionCopyWith<$Res> {
  factory _$RateLimitDetectionCopyWith(_RateLimitDetection value, $Res Function(_RateLimitDetection) _then) = __$RateLimitDetectionCopyWithImpl;
@override @useResult
$Res call({
 List<int> statusCodes, List<String>? textPatterns, int minDelayMs, int maxDelayMs, bool exponentialBackoff
});




}
/// @nodoc
class __$RateLimitDetectionCopyWithImpl<$Res>
    implements _$RateLimitDetectionCopyWith<$Res> {
  __$RateLimitDetectionCopyWithImpl(this._self, this._then);

  final _RateLimitDetection _self;
  final $Res Function(_RateLimitDetection) _then;

/// Create a copy of RateLimitDetection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCodes = null,Object? textPatterns = freezed,Object? minDelayMs = null,Object? maxDelayMs = null,Object? exponentialBackoff = null,}) {
  return _then(_RateLimitDetection(
statusCodes: null == statusCodes ? _self._statusCodes : statusCodes // ignore: cast_nullable_to_non_nullable
as List<int>,textPatterns: freezed == textPatterns ? _self._textPatterns : textPatterns // ignore: cast_nullable_to_non_nullable
as List<String>?,minDelayMs: null == minDelayMs ? _self.minDelayMs : minDelayMs // ignore: cast_nullable_to_non_nullable
as int,maxDelayMs: null == maxDelayMs ? _self.maxDelayMs : maxDelayMs // ignore: cast_nullable_to_non_nullable
as int,exponentialBackoff: null == exponentialBackoff ? _self.exponentialBackoff : exponentialBackoff // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$LoginDetection {

/// 是否检测登录页面。
 bool get detectLoginPage;/// 表示登录页面的选择器。
 List<String>? get loginSelectors;/// 需要登录时是否暂停。
 bool get pauseOnLogin;
/// Create a copy of LoginDetection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginDetectionCopyWith<LoginDetection> get copyWith => _$LoginDetectionCopyWithImpl<LoginDetection>(this as LoginDetection, _$identity);

  /// Serializes this LoginDetection to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginDetection&&(identical(other.detectLoginPage, detectLoginPage) || other.detectLoginPage == detectLoginPage)&&const DeepCollectionEquality().equals(other.loginSelectors, loginSelectors)&&(identical(other.pauseOnLogin, pauseOnLogin) || other.pauseOnLogin == pauseOnLogin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detectLoginPage,const DeepCollectionEquality().hash(loginSelectors),pauseOnLogin);

@override
String toString() {
  return 'LoginDetection(detectLoginPage: $detectLoginPage, loginSelectors: $loginSelectors, pauseOnLogin: $pauseOnLogin)';
}


}

/// @nodoc
abstract mixin class $LoginDetectionCopyWith<$Res>  {
  factory $LoginDetectionCopyWith(LoginDetection value, $Res Function(LoginDetection) _then) = _$LoginDetectionCopyWithImpl;
@useResult
$Res call({
 bool detectLoginPage, List<String>? loginSelectors, bool pauseOnLogin
});




}
/// @nodoc
class _$LoginDetectionCopyWithImpl<$Res>
    implements $LoginDetectionCopyWith<$Res> {
  _$LoginDetectionCopyWithImpl(this._self, this._then);

  final LoginDetection _self;
  final $Res Function(LoginDetection) _then;

/// Create a copy of LoginDetection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? detectLoginPage = null,Object? loginSelectors = freezed,Object? pauseOnLogin = null,}) {
  return _then(_self.copyWith(
detectLoginPage: null == detectLoginPage ? _self.detectLoginPage : detectLoginPage // ignore: cast_nullable_to_non_nullable
as bool,loginSelectors: freezed == loginSelectors ? _self.loginSelectors : loginSelectors // ignore: cast_nullable_to_non_nullable
as List<String>?,pauseOnLogin: null == pauseOnLogin ? _self.pauseOnLogin : pauseOnLogin // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginDetection].
extension LoginDetectionPatterns on LoginDetection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginDetection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginDetection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginDetection value)  $default,){
final _that = this;
switch (_that) {
case _LoginDetection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginDetection value)?  $default,){
final _that = this;
switch (_that) {
case _LoginDetection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool detectLoginPage,  List<String>? loginSelectors,  bool pauseOnLogin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginDetection() when $default != null:
return $default(_that.detectLoginPage,_that.loginSelectors,_that.pauseOnLogin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool detectLoginPage,  List<String>? loginSelectors,  bool pauseOnLogin)  $default,) {final _that = this;
switch (_that) {
case _LoginDetection():
return $default(_that.detectLoginPage,_that.loginSelectors,_that.pauseOnLogin);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool detectLoginPage,  List<String>? loginSelectors,  bool pauseOnLogin)?  $default,) {final _that = this;
switch (_that) {
case _LoginDetection() when $default != null:
return $default(_that.detectLoginPage,_that.loginSelectors,_that.pauseOnLogin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginDetection implements LoginDetection {
  const _LoginDetection({this.detectLoginPage = true, final  List<String>? loginSelectors, this.pauseOnLogin = true}): _loginSelectors = loginSelectors;
  factory _LoginDetection.fromJson(Map<String, dynamic> json) => _$LoginDetectionFromJson(json);

/// 是否检测登录页面。
@override@JsonKey() final  bool detectLoginPage;
/// 表示登录页面的选择器。
 final  List<String>? _loginSelectors;
/// 表示登录页面的选择器。
@override List<String>? get loginSelectors {
  final value = _loginSelectors;
  if (value == null) return null;
  if (_loginSelectors is EqualUnmodifiableListView) return _loginSelectors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// 需要登录时是否暂停。
@override@JsonKey() final  bool pauseOnLogin;

/// Create a copy of LoginDetection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginDetectionCopyWith<_LoginDetection> get copyWith => __$LoginDetectionCopyWithImpl<_LoginDetection>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginDetectionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginDetection&&(identical(other.detectLoginPage, detectLoginPage) || other.detectLoginPage == detectLoginPage)&&const DeepCollectionEquality().equals(other._loginSelectors, _loginSelectors)&&(identical(other.pauseOnLogin, pauseOnLogin) || other.pauseOnLogin == pauseOnLogin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,detectLoginPage,const DeepCollectionEquality().hash(_loginSelectors),pauseOnLogin);

@override
String toString() {
  return 'LoginDetection(detectLoginPage: $detectLoginPage, loginSelectors: $loginSelectors, pauseOnLogin: $pauseOnLogin)';
}


}

/// @nodoc
abstract mixin class _$LoginDetectionCopyWith<$Res> implements $LoginDetectionCopyWith<$Res> {
  factory _$LoginDetectionCopyWith(_LoginDetection value, $Res Function(_LoginDetection) _then) = __$LoginDetectionCopyWithImpl;
@override @useResult
$Res call({
 bool detectLoginPage, List<String>? loginSelectors, bool pauseOnLogin
});




}
/// @nodoc
class __$LoginDetectionCopyWithImpl<$Res>
    implements _$LoginDetectionCopyWith<$Res> {
  __$LoginDetectionCopyWithImpl(this._self, this._then);

  final _LoginDetection _self;
  final $Res Function(_LoginDetection) _then;

/// Create a copy of LoginDetection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? detectLoginPage = null,Object? loginSelectors = freezed,Object? pauseOnLogin = null,}) {
  return _then(_LoginDetection(
detectLoginPage: null == detectLoginPage ? _self.detectLoginPage : detectLoginPage // ignore: cast_nullable_to_non_nullable
as bool,loginSelectors: freezed == loginSelectors ? _self._loginSelectors : loginSelectors // ignore: cast_nullable_to_non_nullable
as List<String>?,pauseOnLogin: null == pauseOnLogin ? _self.pauseOnLogin : pauseOnLogin // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
