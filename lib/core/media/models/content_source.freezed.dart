// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentSource {

/// Crawler rule ID that extracted this content.
 String get ruleId;/// Source site display name.
 String get siteName;/// Source site icon/favicon URL.
 String? get siteIcon;/// Original URL on the source site.
 String get originalUrl;/// Timestamp when content was crawled.
 DateTime get crawledAt;
/// Create a copy of ContentSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<ContentSource> get copyWith => _$ContentSourceCopyWithImpl<ContentSource>(this as ContentSource, _$identity);

  /// Serializes this ContentSource to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentSource&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.siteName, siteName) || other.siteName == siteName)&&(identical(other.siteIcon, siteIcon) || other.siteIcon == siteIcon)&&(identical(other.originalUrl, originalUrl) || other.originalUrl == originalUrl)&&(identical(other.crawledAt, crawledAt) || other.crawledAt == crawledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ruleId,siteName,siteIcon,originalUrl,crawledAt);

@override
String toString() {
  return 'ContentSource(ruleId: $ruleId, siteName: $siteName, siteIcon: $siteIcon, originalUrl: $originalUrl, crawledAt: $crawledAt)';
}


}

/// @nodoc
abstract mixin class $ContentSourceCopyWith<$Res>  {
  factory $ContentSourceCopyWith(ContentSource value, $Res Function(ContentSource) _then) = _$ContentSourceCopyWithImpl;
@useResult
$Res call({
 String ruleId, String siteName, String? siteIcon, String originalUrl, DateTime crawledAt
});




}
/// @nodoc
class _$ContentSourceCopyWithImpl<$Res>
    implements $ContentSourceCopyWith<$Res> {
  _$ContentSourceCopyWithImpl(this._self, this._then);

  final ContentSource _self;
  final $Res Function(ContentSource) _then;

/// Create a copy of ContentSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ruleId = null,Object? siteName = null,Object? siteIcon = freezed,Object? originalUrl = null,Object? crawledAt = null,}) {
  return _then(_self.copyWith(
ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,siteName: null == siteName ? _self.siteName : siteName // ignore: cast_nullable_to_non_nullable
as String,siteIcon: freezed == siteIcon ? _self.siteIcon : siteIcon // ignore: cast_nullable_to_non_nullable
as String?,originalUrl: null == originalUrl ? _self.originalUrl : originalUrl // ignore: cast_nullable_to_non_nullable
as String,crawledAt: null == crawledAt ? _self.crawledAt : crawledAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentSource].
extension ContentSourcePatterns on ContentSource {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentSource() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentSource value)  $default,){
final _that = this;
switch (_that) {
case _ContentSource():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentSource value)?  $default,){
final _that = this;
switch (_that) {
case _ContentSource() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ruleId,  String siteName,  String? siteIcon,  String originalUrl,  DateTime crawledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentSource() when $default != null:
return $default(_that.ruleId,_that.siteName,_that.siteIcon,_that.originalUrl,_that.crawledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ruleId,  String siteName,  String? siteIcon,  String originalUrl,  DateTime crawledAt)  $default,) {final _that = this;
switch (_that) {
case _ContentSource():
return $default(_that.ruleId,_that.siteName,_that.siteIcon,_that.originalUrl,_that.crawledAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ruleId,  String siteName,  String? siteIcon,  String originalUrl,  DateTime crawledAt)?  $default,) {final _that = this;
switch (_that) {
case _ContentSource() when $default != null:
return $default(_that.ruleId,_that.siteName,_that.siteIcon,_that.originalUrl,_that.crawledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentSource implements ContentSource {
  const _ContentSource({required this.ruleId, required this.siteName, this.siteIcon, required this.originalUrl, required this.crawledAt});
  factory _ContentSource.fromJson(Map<String, dynamic> json) => _$ContentSourceFromJson(json);

/// Crawler rule ID that extracted this content.
@override final  String ruleId;
/// Source site display name.
@override final  String siteName;
/// Source site icon/favicon URL.
@override final  String? siteIcon;
/// Original URL on the source site.
@override final  String originalUrl;
/// Timestamp when content was crawled.
@override final  DateTime crawledAt;

/// Create a copy of ContentSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentSourceCopyWith<_ContentSource> get copyWith => __$ContentSourceCopyWithImpl<_ContentSource>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentSourceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentSource&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.siteName, siteName) || other.siteName == siteName)&&(identical(other.siteIcon, siteIcon) || other.siteIcon == siteIcon)&&(identical(other.originalUrl, originalUrl) || other.originalUrl == originalUrl)&&(identical(other.crawledAt, crawledAt) || other.crawledAt == crawledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ruleId,siteName,siteIcon,originalUrl,crawledAt);

@override
String toString() {
  return 'ContentSource(ruleId: $ruleId, siteName: $siteName, siteIcon: $siteIcon, originalUrl: $originalUrl, crawledAt: $crawledAt)';
}


}

/// @nodoc
abstract mixin class _$ContentSourceCopyWith<$Res> implements $ContentSourceCopyWith<$Res> {
  factory _$ContentSourceCopyWith(_ContentSource value, $Res Function(_ContentSource) _then) = __$ContentSourceCopyWithImpl;
@override @useResult
$Res call({
 String ruleId, String siteName, String? siteIcon, String originalUrl, DateTime crawledAt
});




}
/// @nodoc
class __$ContentSourceCopyWithImpl<$Res>
    implements _$ContentSourceCopyWith<$Res> {
  __$ContentSourceCopyWithImpl(this._self, this._then);

  final _ContentSource _self;
  final $Res Function(_ContentSource) _then;

/// Create a copy of ContentSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ruleId = null,Object? siteName = null,Object? siteIcon = freezed,Object? originalUrl = null,Object? crawledAt = null,}) {
  return _then(_ContentSource(
ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,siteName: null == siteName ? _self.siteName : siteName // ignore: cast_nullable_to_non_nullable
as String,siteIcon: freezed == siteIcon ? _self.siteIcon : siteIcon // ignore: cast_nullable_to_non_nullable
as String?,originalUrl: null == originalUrl ? _self.originalUrl : originalUrl // ignore: cast_nullable_to_non_nullable
as String,crawledAt: null == crawledAt ? _self.crawledAt : crawledAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
