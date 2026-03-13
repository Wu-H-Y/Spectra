// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rule_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RuleMetadata {

 String get ruleId; String get name; String? get description;
/// Create a copy of RuleMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuleMetadataCopyWith<RuleMetadata> get copyWith => _$RuleMetadataCopyWithImpl<RuleMetadata>(this as RuleMetadata, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuleMetadata&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,ruleId,name,description);

@override
String toString() {
  return 'RuleMetadata(ruleId: $ruleId, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $RuleMetadataCopyWith<$Res>  {
  factory $RuleMetadataCopyWith(RuleMetadata value, $Res Function(RuleMetadata) _then) = _$RuleMetadataCopyWithImpl;
@useResult
$Res call({
 String ruleId, String name, String? description
});




}
/// @nodoc
class _$RuleMetadataCopyWithImpl<$Res>
    implements $RuleMetadataCopyWith<$Res> {
  _$RuleMetadataCopyWithImpl(this._self, this._then);

  final RuleMetadata _self;
  final $Res Function(RuleMetadata) _then;

/// Create a copy of RuleMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ruleId = null,Object? name = null,Object? description = freezed,}) {
  return _then(_self.copyWith(
ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RuleMetadata].
extension RuleMetadataPatterns on RuleMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RuleMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RuleMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RuleMetadata value)  $default,){
final _that = this;
switch (_that) {
case _RuleMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RuleMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _RuleMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ruleId,  String name,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RuleMetadata() when $default != null:
return $default(_that.ruleId,_that.name,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ruleId,  String name,  String? description)  $default,) {final _that = this;
switch (_that) {
case _RuleMetadata():
return $default(_that.ruleId,_that.name,_that.description);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ruleId,  String name,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _RuleMetadata() when $default != null:
return $default(_that.ruleId,_that.name,_that.description);case _:
  return null;

}
}

}

/// @nodoc


class _RuleMetadata extends RuleMetadata {
  const _RuleMetadata({required this.ruleId, required this.name, this.description}): super._();
  

@override final  String ruleId;
@override final  String name;
@override final  String? description;

/// Create a copy of RuleMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RuleMetadataCopyWith<_RuleMetadata> get copyWith => __$RuleMetadataCopyWithImpl<_RuleMetadata>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuleMetadata&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}


@override
int get hashCode => Object.hash(runtimeType,ruleId,name,description);

@override
String toString() {
  return 'RuleMetadata(ruleId: $ruleId, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class _$RuleMetadataCopyWith<$Res> implements $RuleMetadataCopyWith<$Res> {
  factory _$RuleMetadataCopyWith(_RuleMetadata value, $Res Function(_RuleMetadata) _then) = __$RuleMetadataCopyWithImpl;
@override @useResult
$Res call({
 String ruleId, String name, String? description
});




}
/// @nodoc
class __$RuleMetadataCopyWithImpl<$Res>
    implements _$RuleMetadataCopyWith<$Res> {
  __$RuleMetadataCopyWithImpl(this._self, this._then);

  final _RuleMetadata _self;
  final $Res Function(_RuleMetadata) _then;

/// Create a copy of RuleMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ruleId = null,Object? name = null,Object? description = freezed,}) {
  return _then(_RuleMetadata(
ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
