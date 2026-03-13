// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rule_validator.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RuleValidationResult {

 bool get isValid; List<String> get errors;
/// Create a copy of RuleValidationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuleValidationResultCopyWith<RuleValidationResult> get copyWith => _$RuleValidationResultCopyWithImpl<RuleValidationResult>(this as RuleValidationResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuleValidationResult&&(identical(other.isValid, isValid) || other.isValid == isValid)&&const DeepCollectionEquality().equals(other.errors, errors));
}


@override
int get hashCode => Object.hash(runtimeType,isValid,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'RuleValidationResult(isValid: $isValid, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $RuleValidationResultCopyWith<$Res>  {
  factory $RuleValidationResultCopyWith(RuleValidationResult value, $Res Function(RuleValidationResult) _then) = _$RuleValidationResultCopyWithImpl;
@useResult
$Res call({
 bool isValid, List<String> errors
});




}
/// @nodoc
class _$RuleValidationResultCopyWithImpl<$Res>
    implements $RuleValidationResultCopyWith<$Res> {
  _$RuleValidationResultCopyWithImpl(this._self, this._then);

  final RuleValidationResult _self;
  final $Res Function(RuleValidationResult) _then;

/// Create a copy of RuleValidationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isValid = null,Object? errors = null,}) {
  return _then(_self.copyWith(
isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RuleValidationResult].
extension RuleValidationResultPatterns on RuleValidationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RuleValidationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RuleValidationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RuleValidationResult value)  $default,){
final _that = this;
switch (_that) {
case _RuleValidationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RuleValidationResult value)?  $default,){
final _that = this;
switch (_that) {
case _RuleValidationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isValid,  List<String> errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RuleValidationResult() when $default != null:
return $default(_that.isValid,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isValid,  List<String> errors)  $default,) {final _that = this;
switch (_that) {
case _RuleValidationResult():
return $default(_that.isValid,_that.errors);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isValid,  List<String> errors)?  $default,) {final _that = this;
switch (_that) {
case _RuleValidationResult() when $default != null:
return $default(_that.isValid,_that.errors);case _:
  return null;

}
}

}

/// @nodoc


class _RuleValidationResult implements RuleValidationResult {
  const _RuleValidationResult({required this.isValid, required final  List<String> errors}): _errors = errors;
  

@override final  bool isValid;
 final  List<String> _errors;
@override List<String> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}


/// Create a copy of RuleValidationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RuleValidationResultCopyWith<_RuleValidationResult> get copyWith => __$RuleValidationResultCopyWithImpl<_RuleValidationResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuleValidationResult&&(identical(other.isValid, isValid) || other.isValid == isValid)&&const DeepCollectionEquality().equals(other._errors, _errors));
}


@override
int get hashCode => Object.hash(runtimeType,isValid,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'RuleValidationResult(isValid: $isValid, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$RuleValidationResultCopyWith<$Res> implements $RuleValidationResultCopyWith<$Res> {
  factory _$RuleValidationResultCopyWith(_RuleValidationResult value, $Res Function(_RuleValidationResult) _then) = __$RuleValidationResultCopyWithImpl;
@override @useResult
$Res call({
 bool isValid, List<String> errors
});




}
/// @nodoc
class __$RuleValidationResultCopyWithImpl<$Res>
    implements _$RuleValidationResultCopyWith<$Res> {
  __$RuleValidationResultCopyWithImpl(this._self, this._then);

  final _RuleValidationResult _self;
  final $Res Function(_RuleValidationResult) _then;

/// Create a copy of RuleValidationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isValid = null,Object? errors = null,}) {
  return _then(_RuleValidationResult(
isValid: null == isValid ? _self.isValid : isValid // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
