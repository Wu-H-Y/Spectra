// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rules_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RulesImportState {

 bool get isImporting; Failure? get failure;
/// Create a copy of RulesImportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RulesImportStateCopyWith<RulesImportState> get copyWith => _$RulesImportStateCopyWithImpl<RulesImportState>(this as RulesImportState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RulesImportState&&(identical(other.isImporting, isImporting) || other.isImporting == isImporting)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isImporting,failure);

@override
String toString() {
  return 'RulesImportState(isImporting: $isImporting, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $RulesImportStateCopyWith<$Res>  {
  factory $RulesImportStateCopyWith(RulesImportState value, $Res Function(RulesImportState) _then) = _$RulesImportStateCopyWithImpl;
@useResult
$Res call({
 bool isImporting, Failure? failure
});




}
/// @nodoc
class _$RulesImportStateCopyWithImpl<$Res>
    implements $RulesImportStateCopyWith<$Res> {
  _$RulesImportStateCopyWithImpl(this._self, this._then);

  final RulesImportState _self;
  final $Res Function(RulesImportState) _then;

/// Create a copy of RulesImportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isImporting = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
isImporting: null == isImporting ? _self.isImporting : isImporting // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

}


/// Adds pattern-matching-related methods to [RulesImportState].
extension RulesImportStatePatterns on RulesImportState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RulesImportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RulesImportState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RulesImportState value)  $default,){
final _that = this;
switch (_that) {
case _RulesImportState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RulesImportState value)?  $default,){
final _that = this;
switch (_that) {
case _RulesImportState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isImporting,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RulesImportState() when $default != null:
return $default(_that.isImporting,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isImporting,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _RulesImportState():
return $default(_that.isImporting,_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isImporting,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _RulesImportState() when $default != null:
return $default(_that.isImporting,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _RulesImportState implements RulesImportState {
  const _RulesImportState({this.isImporting = false, this.failure});
  

@override@JsonKey() final  bool isImporting;
@override final  Failure? failure;

/// Create a copy of RulesImportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RulesImportStateCopyWith<_RulesImportState> get copyWith => __$RulesImportStateCopyWithImpl<_RulesImportState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RulesImportState&&(identical(other.isImporting, isImporting) || other.isImporting == isImporting)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,isImporting,failure);

@override
String toString() {
  return 'RulesImportState(isImporting: $isImporting, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$RulesImportStateCopyWith<$Res> implements $RulesImportStateCopyWith<$Res> {
  factory _$RulesImportStateCopyWith(_RulesImportState value, $Res Function(_RulesImportState) _then) = __$RulesImportStateCopyWithImpl;
@override @useResult
$Res call({
 bool isImporting, Failure? failure
});




}
/// @nodoc
class __$RulesImportStateCopyWithImpl<$Res>
    implements _$RulesImportStateCopyWith<$Res> {
  __$RulesImportStateCopyWithImpl(this._self, this._then);

  final _RulesImportState _self;
  final $Res Function(_RulesImportState) _then;

/// Create a copy of RulesImportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isImporting = null,Object? failure = freezed,}) {
  return _then(_RulesImportState(
isImporting: null == isImporting ? _self.isImporting : isImporting // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}


}

// dart format on
