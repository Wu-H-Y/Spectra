// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_mapping.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldMapping {

/// 输出中的目标字段名。
 String get field;/// 用于提取值的选择器。
 Selector get selector;/// 提取失败时的默认值。
 String? get defaultValue;/// 要应用的转换列表。
 List<Transform>? get transforms;/// 此字段是否为必需。
 bool get required;
/// Create a copy of FieldMapping
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldMappingCopyWith<FieldMapping> get copyWith => _$FieldMappingCopyWithImpl<FieldMapping>(this as FieldMapping, _$identity);

  /// Serializes this FieldMapping to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldMapping&&(identical(other.field, field) || other.field == field)&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.defaultValue, defaultValue) || other.defaultValue == defaultValue)&&const DeepCollectionEquality().equals(other.transforms, transforms)&&(identical(other.required, required) || other.required == required));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,selector,defaultValue,const DeepCollectionEquality().hash(transforms),required);

@override
String toString() {
  return 'FieldMapping(field: $field, selector: $selector, defaultValue: $defaultValue, transforms: $transforms, required: $required)';
}


}

/// @nodoc
abstract mixin class $FieldMappingCopyWith<$Res>  {
  factory $FieldMappingCopyWith(FieldMapping value, $Res Function(FieldMapping) _then) = _$FieldMappingCopyWithImpl;
@useResult
$Res call({
 String field, Selector selector, String? defaultValue, List<Transform>? transforms, bool required
});


$SelectorCopyWith<$Res> get selector;

}
/// @nodoc
class _$FieldMappingCopyWithImpl<$Res>
    implements $FieldMappingCopyWith<$Res> {
  _$FieldMappingCopyWithImpl(this._self, this._then);

  final FieldMapping _self;
  final $Res Function(FieldMapping) _then;

/// Create a copy of FieldMapping
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field = null,Object? selector = null,Object? defaultValue = freezed,Object? transforms = freezed,Object? required = null,}) {
  return _then(_self.copyWith(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,selector: null == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as Selector,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as String?,transforms: freezed == transforms ? _self.transforms : transforms // ignore: cast_nullable_to_non_nullable
as List<Transform>?,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of FieldMapping
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res> get selector {
  
  return $SelectorCopyWith<$Res>(_self.selector, (value) {
    return _then(_self.copyWith(selector: value));
  });
}
}


/// Adds pattern-matching-related methods to [FieldMapping].
extension FieldMappingPatterns on FieldMapping {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldMapping value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldMapping() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldMapping value)  $default,){
final _that = this;
switch (_that) {
case _FieldMapping():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldMapping value)?  $default,){
final _that = this;
switch (_that) {
case _FieldMapping() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String field,  Selector selector,  String? defaultValue,  List<Transform>? transforms,  bool required)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldMapping() when $default != null:
return $default(_that.field,_that.selector,_that.defaultValue,_that.transforms,_that.required);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String field,  Selector selector,  String? defaultValue,  List<Transform>? transforms,  bool required)  $default,) {final _that = this;
switch (_that) {
case _FieldMapping():
return $default(_that.field,_that.selector,_that.defaultValue,_that.transforms,_that.required);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String field,  Selector selector,  String? defaultValue,  List<Transform>? transforms,  bool required)?  $default,) {final _that = this;
switch (_that) {
case _FieldMapping() when $default != null:
return $default(_that.field,_that.selector,_that.defaultValue,_that.transforms,_that.required);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FieldMapping implements FieldMapping {
  const _FieldMapping({required this.field, required this.selector, this.defaultValue, final  List<Transform>? transforms, this.required = false}): _transforms = transforms;
  factory _FieldMapping.fromJson(Map<String, dynamic> json) => _$FieldMappingFromJson(json);

/// 输出中的目标字段名。
@override final  String field;
/// 用于提取值的选择器。
@override final  Selector selector;
/// 提取失败时的默认值。
@override final  String? defaultValue;
/// 要应用的转换列表。
 final  List<Transform>? _transforms;
/// 要应用的转换列表。
@override List<Transform>? get transforms {
  final value = _transforms;
  if (value == null) return null;
  if (_transforms is EqualUnmodifiableListView) return _transforms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// 此字段是否为必需。
@override@JsonKey() final  bool required;

/// Create a copy of FieldMapping
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldMappingCopyWith<_FieldMapping> get copyWith => __$FieldMappingCopyWithImpl<_FieldMapping>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FieldMappingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldMapping&&(identical(other.field, field) || other.field == field)&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.defaultValue, defaultValue) || other.defaultValue == defaultValue)&&const DeepCollectionEquality().equals(other._transforms, _transforms)&&(identical(other.required, required) || other.required == required));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,selector,defaultValue,const DeepCollectionEquality().hash(_transforms),required);

@override
String toString() {
  return 'FieldMapping(field: $field, selector: $selector, defaultValue: $defaultValue, transforms: $transforms, required: $required)';
}


}

/// @nodoc
abstract mixin class _$FieldMappingCopyWith<$Res> implements $FieldMappingCopyWith<$Res> {
  factory _$FieldMappingCopyWith(_FieldMapping value, $Res Function(_FieldMapping) _then) = __$FieldMappingCopyWithImpl;
@override @useResult
$Res call({
 String field, Selector selector, String? defaultValue, List<Transform>? transforms, bool required
});


@override $SelectorCopyWith<$Res> get selector;

}
/// @nodoc
class __$FieldMappingCopyWithImpl<$Res>
    implements _$FieldMappingCopyWith<$Res> {
  __$FieldMappingCopyWithImpl(this._self, this._then);

  final _FieldMapping _self;
  final $Res Function(_FieldMapping) _then;

/// Create a copy of FieldMapping
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field = null,Object? selector = null,Object? defaultValue = freezed,Object? transforms = freezed,Object? required = null,}) {
  return _then(_FieldMapping(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,selector: null == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as Selector,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as String?,transforms: freezed == transforms ? _self._transforms : transforms // ignore: cast_nullable_to_non_nullable
as List<Transform>?,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of FieldMapping
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res> get selector {
  
  return $SelectorCopyWith<$Res>(_self.selector, (value) {
    return _then(_self.copyWith(selector: value));
  });
}
}

// dart format on
