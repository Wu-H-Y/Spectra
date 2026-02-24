// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tls_fingerprint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TlsFingerprint {

/// 模拟的浏览器类型。
 BrowserType get browser;/// 是否使用 curl-impersonate。
 bool get useImpersonate;
/// Create a copy of TlsFingerprint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TlsFingerprintCopyWith<TlsFingerprint> get copyWith => _$TlsFingerprintCopyWithImpl<TlsFingerprint>(this as TlsFingerprint, _$identity);

  /// Serializes this TlsFingerprint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TlsFingerprint&&(identical(other.browser, browser) || other.browser == browser)&&(identical(other.useImpersonate, useImpersonate) || other.useImpersonate == useImpersonate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,browser,useImpersonate);

@override
String toString() {
  return 'TlsFingerprint(browser: $browser, useImpersonate: $useImpersonate)';
}


}

/// @nodoc
abstract mixin class $TlsFingerprintCopyWith<$Res>  {
  factory $TlsFingerprintCopyWith(TlsFingerprint value, $Res Function(TlsFingerprint) _then) = _$TlsFingerprintCopyWithImpl;
@useResult
$Res call({
 BrowserType browser, bool useImpersonate
});




}
/// @nodoc
class _$TlsFingerprintCopyWithImpl<$Res>
    implements $TlsFingerprintCopyWith<$Res> {
  _$TlsFingerprintCopyWithImpl(this._self, this._then);

  final TlsFingerprint _self;
  final $Res Function(TlsFingerprint) _then;

/// Create a copy of TlsFingerprint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? browser = null,Object? useImpersonate = null,}) {
  return _then(_self.copyWith(
browser: null == browser ? _self.browser : browser // ignore: cast_nullable_to_non_nullable
as BrowserType,useImpersonate: null == useImpersonate ? _self.useImpersonate : useImpersonate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TlsFingerprint].
extension TlsFingerprintPatterns on TlsFingerprint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TlsFingerprint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TlsFingerprint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TlsFingerprint value)  $default,){
final _that = this;
switch (_that) {
case _TlsFingerprint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TlsFingerprint value)?  $default,){
final _that = this;
switch (_that) {
case _TlsFingerprint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BrowserType browser,  bool useImpersonate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TlsFingerprint() when $default != null:
return $default(_that.browser,_that.useImpersonate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BrowserType browser,  bool useImpersonate)  $default,) {final _that = this;
switch (_that) {
case _TlsFingerprint():
return $default(_that.browser,_that.useImpersonate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BrowserType browser,  bool useImpersonate)?  $default,) {final _that = this;
switch (_that) {
case _TlsFingerprint() when $default != null:
return $default(_that.browser,_that.useImpersonate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TlsFingerprint implements TlsFingerprint {
  const _TlsFingerprint({this.browser = BrowserType.chrome120, this.useImpersonate = true});
  factory _TlsFingerprint.fromJson(Map<String, dynamic> json) => _$TlsFingerprintFromJson(json);

/// 模拟的浏览器类型。
@override@JsonKey() final  BrowserType browser;
/// 是否使用 curl-impersonate。
@override@JsonKey() final  bool useImpersonate;

/// Create a copy of TlsFingerprint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TlsFingerprintCopyWith<_TlsFingerprint> get copyWith => __$TlsFingerprintCopyWithImpl<_TlsFingerprint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TlsFingerprintToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TlsFingerprint&&(identical(other.browser, browser) || other.browser == browser)&&(identical(other.useImpersonate, useImpersonate) || other.useImpersonate == useImpersonate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,browser,useImpersonate);

@override
String toString() {
  return 'TlsFingerprint(browser: $browser, useImpersonate: $useImpersonate)';
}


}

/// @nodoc
abstract mixin class _$TlsFingerprintCopyWith<$Res> implements $TlsFingerprintCopyWith<$Res> {
  factory _$TlsFingerprintCopyWith(_TlsFingerprint value, $Res Function(_TlsFingerprint) _then) = __$TlsFingerprintCopyWithImpl;
@override @useResult
$Res call({
 BrowserType browser, bool useImpersonate
});




}
/// @nodoc
class __$TlsFingerprintCopyWithImpl<$Res>
    implements _$TlsFingerprintCopyWith<$Res> {
  __$TlsFingerprintCopyWithImpl(this._self, this._then);

  final _TlsFingerprint _self;
  final $Res Function(_TlsFingerprint) _then;

/// Create a copy of TlsFingerprint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? browser = null,Object? useImpersonate = null,}) {
  return _then(_TlsFingerprint(
browser: null == browser ? _self.browser : browser // ignore: cast_nullable_to_non_nullable
as BrowserType,useImpersonate: null == useImpersonate ? _self.useImpersonate : useImpersonate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
