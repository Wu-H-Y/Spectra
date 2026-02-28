// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'http_client.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProxySettings {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxySettings);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProxySettings()';
}


}

/// @nodoc
class $ProxySettingsCopyWith<$Res>  {
$ProxySettingsCopyWith(ProxySettings _, $Res Function(ProxySettings) __);
}


/// Adds pattern-matching-related methods to [ProxySettings].
extension ProxySettingsPatterns on ProxySettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProxySettings_NoProxy value)?  noProxy,TResult Function( ProxySettings_Custom value)?  custom,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProxySettings_NoProxy() when noProxy != null:
return noProxy(_that);case ProxySettings_Custom() when custom != null:
return custom(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProxySettings_NoProxy value)  noProxy,required TResult Function( ProxySettings_Custom value)  custom,}){
final _that = this;
switch (_that) {
case ProxySettings_NoProxy():
return noProxy(_that);case ProxySettings_Custom():
return custom(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProxySettings_NoProxy value)?  noProxy,TResult? Function( ProxySettings_Custom value)?  custom,}){
final _that = this;
switch (_that) {
case ProxySettings_NoProxy() when noProxy != null:
return noProxy(_that);case ProxySettings_Custom() when custom != null:
return custom(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  noProxy,TResult Function( List<ProxyConfig> field0)?  custom,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProxySettings_NoProxy() when noProxy != null:
return noProxy();case ProxySettings_Custom() when custom != null:
return custom(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  noProxy,required TResult Function( List<ProxyConfig> field0)  custom,}) {final _that = this;
switch (_that) {
case ProxySettings_NoProxy():
return noProxy();case ProxySettings_Custom():
return custom(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  noProxy,TResult? Function( List<ProxyConfig> field0)?  custom,}) {final _that = this;
switch (_that) {
case ProxySettings_NoProxy() when noProxy != null:
return noProxy();case ProxySettings_Custom() when custom != null:
return custom(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class ProxySettings_NoProxy extends ProxySettings {
  const ProxySettings_NoProxy(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxySettings_NoProxy);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProxySettings.noProxy()';
}


}




/// @nodoc


class ProxySettings_Custom extends ProxySettings {
  const ProxySettings_Custom(final  List<ProxyConfig> field0): _field0 = field0,super._();
  

 final  List<ProxyConfig> _field0;
 List<ProxyConfig> get field0 {
  if (_field0 is EqualUnmodifiableListView) return _field0;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_field0);
}


/// Create a copy of ProxySettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProxySettings_CustomCopyWith<ProxySettings_Custom> get copyWith => _$ProxySettings_CustomCopyWithImpl<ProxySettings_Custom>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProxySettings_Custom&&const DeepCollectionEquality().equals(other._field0, _field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_field0));

@override
String toString() {
  return 'ProxySettings.custom(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ProxySettings_CustomCopyWith<$Res> implements $ProxySettingsCopyWith<$Res> {
  factory $ProxySettings_CustomCopyWith(ProxySettings_Custom value, $Res Function(ProxySettings_Custom) _then) = _$ProxySettings_CustomCopyWithImpl;
@useResult
$Res call({
 List<ProxyConfig> field0
});




}
/// @nodoc
class _$ProxySettings_CustomCopyWithImpl<$Res>
    implements $ProxySettings_CustomCopyWith<$Res> {
  _$ProxySettings_CustomCopyWithImpl(this._self, this._then);

  final ProxySettings_Custom _self;
  final $Res Function(ProxySettings_Custom) _then;

/// Create a copy of ProxySettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ProxySettings_Custom(
null == field0 ? _self._field0 : field0 // ignore: cast_nullable_to_non_nullable
as List<ProxyConfig>,
  ));
}


}

/// @nodoc
mixin _$RedirectSettings {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RedirectSettings);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RedirectSettings()';
}


}

/// @nodoc
class $RedirectSettingsCopyWith<$Res>  {
$RedirectSettingsCopyWith(RedirectSettings _, $Res Function(RedirectSettings) __);
}


/// Adds pattern-matching-related methods to [RedirectSettings].
extension RedirectSettingsPatterns on RedirectSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RedirectSettings_None value)?  none,TResult Function( RedirectSettings_Limited value)?  limited,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RedirectSettings_None() when none != null:
return none(_that);case RedirectSettings_Limited() when limited != null:
return limited(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RedirectSettings_None value)  none,required TResult Function( RedirectSettings_Limited value)  limited,}){
final _that = this;
switch (_that) {
case RedirectSettings_None():
return none(_that);case RedirectSettings_Limited():
return limited(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RedirectSettings_None value)?  none,TResult? Function( RedirectSettings_Limited value)?  limited,}){
final _that = this;
switch (_that) {
case RedirectSettings_None() when none != null:
return none(_that);case RedirectSettings_Limited() when limited != null:
return limited(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  none,TResult Function( int field0)?  limited,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RedirectSettings_None() when none != null:
return none();case RedirectSettings_Limited() when limited != null:
return limited(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  none,required TResult Function( int field0)  limited,}) {final _that = this;
switch (_that) {
case RedirectSettings_None():
return none();case RedirectSettings_Limited():
return limited(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  none,TResult? Function( int field0)?  limited,}) {final _that = this;
switch (_that) {
case RedirectSettings_None() when none != null:
return none();case RedirectSettings_Limited() when limited != null:
return limited(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class RedirectSettings_None extends RedirectSettings {
  const RedirectSettings_None(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RedirectSettings_None);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RedirectSettings.none()';
}


}




/// @nodoc


class RedirectSettings_Limited extends RedirectSettings {
  const RedirectSettings_Limited(this.field0): super._();
  

 final  int field0;

/// Create a copy of RedirectSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RedirectSettings_LimitedCopyWith<RedirectSettings_Limited> get copyWith => _$RedirectSettings_LimitedCopyWithImpl<RedirectSettings_Limited>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RedirectSettings_Limited&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'RedirectSettings.limited(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $RedirectSettings_LimitedCopyWith<$Res> implements $RedirectSettingsCopyWith<$Res> {
  factory $RedirectSettings_LimitedCopyWith(RedirectSettings_Limited value, $Res Function(RedirectSettings_Limited) _then) = _$RedirectSettings_LimitedCopyWithImpl;
@useResult
$Res call({
 int field0
});




}
/// @nodoc
class _$RedirectSettings_LimitedCopyWithImpl<$Res>
    implements $RedirectSettings_LimitedCopyWith<$Res> {
  _$RedirectSettings_LimitedCopyWithImpl(this._self, this._then);

  final RedirectSettings_Limited _self;
  final $Res Function(RedirectSettings_Limited) _then;

/// Create a copy of RedirectSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(RedirectSettings_Limited(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
