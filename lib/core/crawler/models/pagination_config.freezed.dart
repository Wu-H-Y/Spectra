// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pagination_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginationConfig {

/// 分页类型。
 PaginationType get type;/// 下一页链接的选择器（用于 URL 类型）。
 Selector? get nextSelector;/// 带页码占位符的 URL 模板（用于 URL 类型）。
/// 使用 {page} 作为占位符，例如 "list?page={page}"
 String? get urlTemplate;/// "加载更多"按钮的选择器（用于点击类型）。
 Selector? get clickSelector;/// 滚动容器选择器（用于无限滚动类型）。
 Selector? get scrollContainer;/// 最大爬取页数（0 = 无限制）。
 int get maxPages;/// 页面请求之间的延迟（毫秒）。
 int get delayMs;/// 分页后等待内容加载的时间。
 int get waitAfterLoadMs;
/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationConfigCopyWith<PaginationConfig> get copyWith => _$PaginationConfigCopyWithImpl<PaginationConfig>(this as PaginationConfig, _$identity);

  /// Serializes this PaginationConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.nextSelector, nextSelector) || other.nextSelector == nextSelector)&&(identical(other.urlTemplate, urlTemplate) || other.urlTemplate == urlTemplate)&&(identical(other.clickSelector, clickSelector) || other.clickSelector == clickSelector)&&(identical(other.scrollContainer, scrollContainer) || other.scrollContainer == scrollContainer)&&(identical(other.maxPages, maxPages) || other.maxPages == maxPages)&&(identical(other.delayMs, delayMs) || other.delayMs == delayMs)&&(identical(other.waitAfterLoadMs, waitAfterLoadMs) || other.waitAfterLoadMs == waitAfterLoadMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,nextSelector,urlTemplate,clickSelector,scrollContainer,maxPages,delayMs,waitAfterLoadMs);

@override
String toString() {
  return 'PaginationConfig(type: $type, nextSelector: $nextSelector, urlTemplate: $urlTemplate, clickSelector: $clickSelector, scrollContainer: $scrollContainer, maxPages: $maxPages, delayMs: $delayMs, waitAfterLoadMs: $waitAfterLoadMs)';
}


}

/// @nodoc
abstract mixin class $PaginationConfigCopyWith<$Res>  {
  factory $PaginationConfigCopyWith(PaginationConfig value, $Res Function(PaginationConfig) _then) = _$PaginationConfigCopyWithImpl;
@useResult
$Res call({
 PaginationType type, Selector? nextSelector, String? urlTemplate, Selector? clickSelector, Selector? scrollContainer, int maxPages, int delayMs, int waitAfterLoadMs
});


$SelectorCopyWith<$Res>? get nextSelector;$SelectorCopyWith<$Res>? get clickSelector;$SelectorCopyWith<$Res>? get scrollContainer;

}
/// @nodoc
class _$PaginationConfigCopyWithImpl<$Res>
    implements $PaginationConfigCopyWith<$Res> {
  _$PaginationConfigCopyWithImpl(this._self, this._then);

  final PaginationConfig _self;
  final $Res Function(PaginationConfig) _then;

/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? nextSelector = freezed,Object? urlTemplate = freezed,Object? clickSelector = freezed,Object? scrollContainer = freezed,Object? maxPages = null,Object? delayMs = null,Object? waitAfterLoadMs = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PaginationType,nextSelector: freezed == nextSelector ? _self.nextSelector : nextSelector // ignore: cast_nullable_to_non_nullable
as Selector?,urlTemplate: freezed == urlTemplate ? _self.urlTemplate : urlTemplate // ignore: cast_nullable_to_non_nullable
as String?,clickSelector: freezed == clickSelector ? _self.clickSelector : clickSelector // ignore: cast_nullable_to_non_nullable
as Selector?,scrollContainer: freezed == scrollContainer ? _self.scrollContainer : scrollContainer // ignore: cast_nullable_to_non_nullable
as Selector?,maxPages: null == maxPages ? _self.maxPages : maxPages // ignore: cast_nullable_to_non_nullable
as int,delayMs: null == delayMs ? _self.delayMs : delayMs // ignore: cast_nullable_to_non_nullable
as int,waitAfterLoadMs: null == waitAfterLoadMs ? _self.waitAfterLoadMs : waitAfterLoadMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get nextSelector {
    if (_self.nextSelector == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.nextSelector!, (value) {
    return _then(_self.copyWith(nextSelector: value));
  });
}/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get clickSelector {
    if (_self.clickSelector == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.clickSelector!, (value) {
    return _then(_self.copyWith(clickSelector: value));
  });
}/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get scrollContainer {
    if (_self.scrollContainer == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.scrollContainer!, (value) {
    return _then(_self.copyWith(scrollContainer: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaginationType type,  Selector? nextSelector,  String? urlTemplate,  Selector? clickSelector,  Selector? scrollContainer,  int maxPages,  int delayMs,  int waitAfterLoadMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginationConfig() when $default != null:
return $default(_that.type,_that.nextSelector,_that.urlTemplate,_that.clickSelector,_that.scrollContainer,_that.maxPages,_that.delayMs,_that.waitAfterLoadMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaginationType type,  Selector? nextSelector,  String? urlTemplate,  Selector? clickSelector,  Selector? scrollContainer,  int maxPages,  int delayMs,  int waitAfterLoadMs)  $default,) {final _that = this;
switch (_that) {
case _PaginationConfig():
return $default(_that.type,_that.nextSelector,_that.urlTemplate,_that.clickSelector,_that.scrollContainer,_that.maxPages,_that.delayMs,_that.waitAfterLoadMs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaginationType type,  Selector? nextSelector,  String? urlTemplate,  Selector? clickSelector,  Selector? scrollContainer,  int maxPages,  int delayMs,  int waitAfterLoadMs)?  $default,) {final _that = this;
switch (_that) {
case _PaginationConfig() when $default != null:
return $default(_that.type,_that.nextSelector,_that.urlTemplate,_that.clickSelector,_that.scrollContainer,_that.maxPages,_that.delayMs,_that.waitAfterLoadMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginationConfig implements PaginationConfig {
  const _PaginationConfig({required this.type, this.nextSelector, this.urlTemplate, this.clickSelector, this.scrollContainer, this.maxPages = 0, this.delayMs = 1000, this.waitAfterLoadMs = 2000});
  factory _PaginationConfig.fromJson(Map<String, dynamic> json) => _$PaginationConfigFromJson(json);

/// 分页类型。
@override final  PaginationType type;
/// 下一页链接的选择器（用于 URL 类型）。
@override final  Selector? nextSelector;
/// 带页码占位符的 URL 模板（用于 URL 类型）。
/// 使用 {page} 作为占位符，例如 "list?page={page}"
@override final  String? urlTemplate;
/// "加载更多"按钮的选择器（用于点击类型）。
@override final  Selector? clickSelector;
/// 滚动容器选择器（用于无限滚动类型）。
@override final  Selector? scrollContainer;
/// 最大爬取页数（0 = 无限制）。
@override@JsonKey() final  int maxPages;
/// 页面请求之间的延迟（毫秒）。
@override@JsonKey() final  int delayMs;
/// 分页后等待内容加载的时间。
@override@JsonKey() final  int waitAfterLoadMs;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginationConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.nextSelector, nextSelector) || other.nextSelector == nextSelector)&&(identical(other.urlTemplate, urlTemplate) || other.urlTemplate == urlTemplate)&&(identical(other.clickSelector, clickSelector) || other.clickSelector == clickSelector)&&(identical(other.scrollContainer, scrollContainer) || other.scrollContainer == scrollContainer)&&(identical(other.maxPages, maxPages) || other.maxPages == maxPages)&&(identical(other.delayMs, delayMs) || other.delayMs == delayMs)&&(identical(other.waitAfterLoadMs, waitAfterLoadMs) || other.waitAfterLoadMs == waitAfterLoadMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,nextSelector,urlTemplate,clickSelector,scrollContainer,maxPages,delayMs,waitAfterLoadMs);

@override
String toString() {
  return 'PaginationConfig(type: $type, nextSelector: $nextSelector, urlTemplate: $urlTemplate, clickSelector: $clickSelector, scrollContainer: $scrollContainer, maxPages: $maxPages, delayMs: $delayMs, waitAfterLoadMs: $waitAfterLoadMs)';
}


}

/// @nodoc
abstract mixin class _$PaginationConfigCopyWith<$Res> implements $PaginationConfigCopyWith<$Res> {
  factory _$PaginationConfigCopyWith(_PaginationConfig value, $Res Function(_PaginationConfig) _then) = __$PaginationConfigCopyWithImpl;
@override @useResult
$Res call({
 PaginationType type, Selector? nextSelector, String? urlTemplate, Selector? clickSelector, Selector? scrollContainer, int maxPages, int delayMs, int waitAfterLoadMs
});


@override $SelectorCopyWith<$Res>? get nextSelector;@override $SelectorCopyWith<$Res>? get clickSelector;@override $SelectorCopyWith<$Res>? get scrollContainer;

}
/// @nodoc
class __$PaginationConfigCopyWithImpl<$Res>
    implements _$PaginationConfigCopyWith<$Res> {
  __$PaginationConfigCopyWithImpl(this._self, this._then);

  final _PaginationConfig _self;
  final $Res Function(_PaginationConfig) _then;

/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? nextSelector = freezed,Object? urlTemplate = freezed,Object? clickSelector = freezed,Object? scrollContainer = freezed,Object? maxPages = null,Object? delayMs = null,Object? waitAfterLoadMs = null,}) {
  return _then(_PaginationConfig(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PaginationType,nextSelector: freezed == nextSelector ? _self.nextSelector : nextSelector // ignore: cast_nullable_to_non_nullable
as Selector?,urlTemplate: freezed == urlTemplate ? _self.urlTemplate : urlTemplate // ignore: cast_nullable_to_non_nullable
as String?,clickSelector: freezed == clickSelector ? _self.clickSelector : clickSelector // ignore: cast_nullable_to_non_nullable
as Selector?,scrollContainer: freezed == scrollContainer ? _self.scrollContainer : scrollContainer // ignore: cast_nullable_to_non_nullable
as Selector?,maxPages: null == maxPages ? _self.maxPages : maxPages // ignore: cast_nullable_to_non_nullable
as int,delayMs: null == delayMs ? _self.delayMs : delayMs // ignore: cast_nullable_to_non_nullable
as int,waitAfterLoadMs: null == waitAfterLoadMs ? _self.waitAfterLoadMs : waitAfterLoadMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get nextSelector {
    if (_self.nextSelector == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.nextSelector!, (value) {
    return _then(_self.copyWith(nextSelector: value));
  });
}/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get clickSelector {
    if (_self.clickSelector == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.clickSelector!, (value) {
    return _then(_self.copyWith(clickSelector: value));
  });
}/// Create a copy of PaginationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get scrollContainer {
    if (_self.scrollContainer == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.scrollContainer!, (value) {
    return _then(_self.copyWith(scrollContainer: value));
  });
}
}

// dart format on
