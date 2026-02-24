// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginationConfig {

/// 分页类型。
 PaginationType get type;/// 下一页选择器 (type = url)。
 String? get nextSelector;/// 页码参数名 (type = url)。
 String get pageParam;/// 起始页码。
 int get startPage;/// 最大页数。
 int? get maxPages;/// 加载更多按钮选择器 (type = click)。
 String? get loadMoreSelector;/// 滚动加载等待时间 (type = scroll)。
 int get scrollWaitMs;
/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationConfigCopyWith<PaginationConfig> get copyWith => _$PaginationConfigCopyWithImpl<PaginationConfig>(this as PaginationConfig, _$identity);

  /// Serializes this PaginationConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.nextSelector, nextSelector) || other.nextSelector == nextSelector)&&(identical(other.pageParam, pageParam) || other.pageParam == pageParam)&&(identical(other.startPage, startPage) || other.startPage == startPage)&&(identical(other.maxPages, maxPages) || other.maxPages == maxPages)&&(identical(other.loadMoreSelector, loadMoreSelector) || other.loadMoreSelector == loadMoreSelector)&&(identical(other.scrollWaitMs, scrollWaitMs) || other.scrollWaitMs == scrollWaitMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,nextSelector,pageParam,startPage,maxPages,loadMoreSelector,scrollWaitMs);

@override
String toString() {
  return 'PaginationConfig(type: $type, nextSelector: $nextSelector, pageParam: $pageParam, startPage: $startPage, maxPages: $maxPages, loadMoreSelector: $loadMoreSelector, scrollWaitMs: $scrollWaitMs)';
}


}

/// @nodoc
abstract mixin class $PaginationConfigCopyWith<$Res>  {
  factory $PaginationConfigCopyWith(PaginationConfig value, $Res Function(PaginationConfig) _then) = _$PaginationConfigCopyWithImpl;
@useResult
$Res call({
 PaginationType type, String? nextSelector, String pageParam, int startPage, int? maxPages, String? loadMoreSelector, int scrollWaitMs
});




}
/// @nodoc
class _$PaginationConfigCopyWithImpl<$Res>
    implements $PaginationConfigCopyWith<$Res> {
  _$PaginationConfigCopyWithImpl(this._self, this._then);

  final PaginationConfig _self;
  final $Res Function(PaginationConfig) _then;

/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? nextSelector = freezed,Object? pageParam = null,Object? startPage = null,Object? maxPages = freezed,Object? loadMoreSelector = freezed,Object? scrollWaitMs = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PaginationType,nextSelector: freezed == nextSelector ? _self.nextSelector : nextSelector // ignore: cast_nullable_to_non_nullable
as String?,pageParam: null == pageParam ? _self.pageParam : pageParam // ignore: cast_nullable_to_non_nullable
as String,startPage: null == startPage ? _self.startPage : startPage // ignore: cast_nullable_to_non_nullable
as int,maxPages: freezed == maxPages ? _self.maxPages : maxPages // ignore: cast_nullable_to_non_nullable
as int?,loadMoreSelector: freezed == loadMoreSelector ? _self.loadMoreSelector : loadMoreSelector // ignore: cast_nullable_to_non_nullable
as String?,scrollWaitMs: null == scrollWaitMs ? _self.scrollWaitMs : scrollWaitMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PaginationConfig].
extension PaginationConfigPatterns on PaginationConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginationConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginationConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginationConfig value)  $default,){
final _that = this;
switch (_that) {
case _PaginationConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginationConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PaginationConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaginationType type,  String? nextSelector,  String pageParam,  int startPage,  int? maxPages,  String? loadMoreSelector,  int scrollWaitMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginationConfig() when $default != null:
return $default(_that.type,_that.nextSelector,_that.pageParam,_that.startPage,_that.maxPages,_that.loadMoreSelector,_that.scrollWaitMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaginationType type,  String? nextSelector,  String pageParam,  int startPage,  int? maxPages,  String? loadMoreSelector,  int scrollWaitMs)  $default,) {final _that = this;
switch (_that) {
case _PaginationConfig():
return $default(_that.type,_that.nextSelector,_that.pageParam,_that.startPage,_that.maxPages,_that.loadMoreSelector,_that.scrollWaitMs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaginationType type,  String? nextSelector,  String pageParam,  int startPage,  int? maxPages,  String? loadMoreSelector,  int scrollWaitMs)?  $default,) {final _that = this;
switch (_that) {
case _PaginationConfig() when $default != null:
return $default(_that.type,_that.nextSelector,_that.pageParam,_that.startPage,_that.maxPages,_that.loadMoreSelector,_that.scrollWaitMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginationConfig implements PaginationConfig {
  const _PaginationConfig({this.type = PaginationType.url, this.nextSelector, this.pageParam = 'page', this.startPage = 1, this.maxPages, this.loadMoreSelector, this.scrollWaitMs = 1000});
  factory _PaginationConfig.fromJson(Map<String, dynamic> json) => _$PaginationConfigFromJson(json);

/// 分页类型。
@override@JsonKey() final  PaginationType type;
/// 下一页选择器 (type = url)。
@override final  String? nextSelector;
/// 页码参数名 (type = url)。
@override@JsonKey() final  String pageParam;
/// 起始页码。
@override@JsonKey() final  int startPage;
/// 最大页数。
@override final  int? maxPages;
/// 加载更多按钮选择器 (type = click)。
@override final  String? loadMoreSelector;
/// 滚动加载等待时间 (type = scroll)。
@override@JsonKey() final  int scrollWaitMs;

/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginationConfigCopyWith<_PaginationConfig> get copyWith => __$PaginationConfigCopyWithImpl<_PaginationConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginationConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginationConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.nextSelector, nextSelector) || other.nextSelector == nextSelector)&&(identical(other.pageParam, pageParam) || other.pageParam == pageParam)&&(identical(other.startPage, startPage) || other.startPage == startPage)&&(identical(other.maxPages, maxPages) || other.maxPages == maxPages)&&(identical(other.loadMoreSelector, loadMoreSelector) || other.loadMoreSelector == loadMoreSelector)&&(identical(other.scrollWaitMs, scrollWaitMs) || other.scrollWaitMs == scrollWaitMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,nextSelector,pageParam,startPage,maxPages,loadMoreSelector,scrollWaitMs);

@override
String toString() {
  return 'PaginationConfig(type: $type, nextSelector: $nextSelector, pageParam: $pageParam, startPage: $startPage, maxPages: $maxPages, loadMoreSelector: $loadMoreSelector, scrollWaitMs: $scrollWaitMs)';
}


}

/// @nodoc
abstract mixin class _$PaginationConfigCopyWith<$Res> implements $PaginationConfigCopyWith<$Res> {
  factory _$PaginationConfigCopyWith(_PaginationConfig value, $Res Function(_PaginationConfig) _then) = __$PaginationConfigCopyWithImpl;
@override @useResult
$Res call({
 PaginationType type, String? nextSelector, String pageParam, int startPage, int? maxPages, String? loadMoreSelector, int scrollWaitMs
});




}
/// @nodoc
class __$PaginationConfigCopyWithImpl<$Res>
    implements _$PaginationConfigCopyWith<$Res> {
  __$PaginationConfigCopyWithImpl(this._self, this._then);

  final _PaginationConfig _self;
  final $Res Function(_PaginationConfig) _then;

/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? nextSelector = freezed,Object? pageParam = null,Object? startPage = null,Object? maxPages = freezed,Object? loadMoreSelector = freezed,Object? scrollWaitMs = null,}) {
  return _then(_PaginationConfig(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PaginationType,nextSelector: freezed == nextSelector ? _self.nextSelector : nextSelector // ignore: cast_nullable_to_non_nullable
as String?,pageParam: null == pageParam ? _self.pageParam : pageParam // ignore: cast_nullable_to_non_nullable
as String,startPage: null == startPage ? _self.startPage : startPage // ignore: cast_nullable_to_non_nullable
as int,maxPages: freezed == maxPages ? _self.maxPages : maxPages // ignore: cast_nullable_to_non_nullable
as int?,loadMoreSelector: freezed == loadMoreSelector ? _self.loadMoreSelector : loadMoreSelector // ignore: cast_nullable_to_non_nullable
as String?,scrollWaitMs: null == scrollWaitMs ? _self.scrollWaitMs : scrollWaitMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
