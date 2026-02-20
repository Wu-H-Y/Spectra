// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selector.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Selector {

/// 选择器类型（css、xpath、regex、jsonpath、js）。
 SelectorType get type;/// 选择器表达式。
 String get expression;/// 要提取的属性（例如 "href"、"src"、"text"）。
/// 使用 "text" 或留空表示文本内容。
/// 使用 "html" 表示内部 HTML。
 String? get attribute;/// 主选择器失败时的回退选择器。
 List<Selector>? get fallbacks;/// 是否只返回第一个匹配。
 bool get firstOnly;
/// Create a copy of Selector
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectorCopyWith<Selector> get copyWith => _$SelectorCopyWithImpl<Selector>(this as Selector, _$identity);

  /// Serializes this Selector to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Selector&&(identical(other.type, type) || other.type == type)&&(identical(other.expression, expression) || other.expression == expression)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&const DeepCollectionEquality().equals(other.fallbacks, fallbacks)&&(identical(other.firstOnly, firstOnly) || other.firstOnly == firstOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,expression,attribute,const DeepCollectionEquality().hash(fallbacks),firstOnly);

@override
String toString() {
  return 'Selector(type: $type, expression: $expression, attribute: $attribute, fallbacks: $fallbacks, firstOnly: $firstOnly)';
}


}

/// @nodoc
abstract mixin class $SelectorCopyWith<$Res>  {
  factory $SelectorCopyWith(Selector value, $Res Function(Selector) _then) = _$SelectorCopyWithImpl;
@useResult
$Res call({
 SelectorType type, String expression, String? attribute, List<Selector>? fallbacks, bool firstOnly
});




}
/// @nodoc
class _$SelectorCopyWithImpl<$Res>
    implements $SelectorCopyWith<$Res> {
  _$SelectorCopyWithImpl(this._self, this._then);

  final Selector _self;
  final $Res Function(Selector) _then;

/// Create a copy of Selector
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? expression = null,Object? attribute = freezed,Object? fallbacks = freezed,Object? firstOnly = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SelectorType,expression: null == expression ? _self.expression : expression // ignore: cast_nullable_to_non_nullable
as String,attribute: freezed == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as String?,fallbacks: freezed == fallbacks ? _self.fallbacks : fallbacks // ignore: cast_nullable_to_non_nullable
as List<Selector>?,firstOnly: null == firstOnly ? _self.firstOnly : firstOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Selector].
extension SelectorPatterns on Selector {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Selector value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Selector() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Selector value)  $default,){
final _that = this;
switch (_that) {
case _Selector():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Selector value)?  $default,){
final _that = this;
switch (_that) {
case _Selector() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SelectorType type,  String expression,  String? attribute,  List<Selector>? fallbacks,  bool firstOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Selector() when $default != null:
return $default(_that.type,_that.expression,_that.attribute,_that.fallbacks,_that.firstOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SelectorType type,  String expression,  String? attribute,  List<Selector>? fallbacks,  bool firstOnly)  $default,) {final _that = this;
switch (_that) {
case _Selector():
return $default(_that.type,_that.expression,_that.attribute,_that.fallbacks,_that.firstOnly);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SelectorType type,  String expression,  String? attribute,  List<Selector>? fallbacks,  bool firstOnly)?  $default,) {final _that = this;
switch (_that) {
case _Selector() when $default != null:
return $default(_that.type,_that.expression,_that.attribute,_that.fallbacks,_that.firstOnly);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Selector implements Selector {
  const _Selector({required this.type, required this.expression, this.attribute, final  List<Selector>? fallbacks, this.firstOnly = false}): _fallbacks = fallbacks;
  factory _Selector.fromJson(Map<String, dynamic> json) => _$SelectorFromJson(json);

/// 选择器类型（css、xpath、regex、jsonpath、js）。
@override final  SelectorType type;
/// 选择器表达式。
@override final  String expression;
/// 要提取的属性（例如 "href"、"src"、"text"）。
/// 使用 "text" 或留空表示文本内容。
/// 使用 "html" 表示内部 HTML。
@override final  String? attribute;
/// 主选择器失败时的回退选择器。
 final  List<Selector>? _fallbacks;
/// 主选择器失败时的回退选择器。
@override List<Selector>? get fallbacks {
  final value = _fallbacks;
  if (value == null) return null;
  if (_fallbacks is EqualUnmodifiableListView) return _fallbacks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// 是否只返回第一个匹配。
@override@JsonKey() final  bool firstOnly;

/// Create a copy of Selector
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectorCopyWith<_Selector> get copyWith => __$SelectorCopyWithImpl<_Selector>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Selector&&(identical(other.type, type) || other.type == type)&&(identical(other.expression, expression) || other.expression == expression)&&(identical(other.attribute, attribute) || other.attribute == attribute)&&const DeepCollectionEquality().equals(other._fallbacks, _fallbacks)&&(identical(other.firstOnly, firstOnly) || other.firstOnly == firstOnly));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,expression,attribute,const DeepCollectionEquality().hash(_fallbacks),firstOnly);

@override
String toString() {
  return 'Selector(type: $type, expression: $expression, attribute: $attribute, fallbacks: $fallbacks, firstOnly: $firstOnly)';
}


}

/// @nodoc
abstract mixin class _$SelectorCopyWith<$Res> implements $SelectorCopyWith<$Res> {
  factory _$SelectorCopyWith(_Selector value, $Res Function(_Selector) _then) = __$SelectorCopyWithImpl;
@override @useResult
$Res call({
 SelectorType type, String expression, String? attribute, List<Selector>? fallbacks, bool firstOnly
});




}
/// @nodoc
class __$SelectorCopyWithImpl<$Res>
    implements _$SelectorCopyWith<$Res> {
  __$SelectorCopyWithImpl(this._self, this._then);

  final _Selector _self;
  final $Res Function(_Selector) _then;

/// Create a copy of Selector
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? expression = null,Object? attribute = freezed,Object? fallbacks = freezed,Object? firstOnly = null,}) {
  return _then(_Selector(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SelectorType,expression: null == expression ? _self.expression : expression // ignore: cast_nullable_to_non_nullable
as String,attribute: freezed == attribute ? _self.attribute : attribute // ignore: cast_nullable_to_non_nullable
as String?,fallbacks: freezed == fallbacks ? _self._fallbacks : fallbacks // ignore: cast_nullable_to_non_nullable
as List<Selector>?,firstOnly: null == firstOnly ? _self.firstOnly : firstOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
