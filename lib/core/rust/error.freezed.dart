// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BuildError {

 String get field0;
/// Create a copy of BuildError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuildErrorCopyWith<BuildError> get copyWith => _$BuildErrorCopyWithImpl<BuildError>(this as BuildError, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuildError&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'BuildError(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $BuildErrorCopyWith<$Res>  {
  factory $BuildErrorCopyWith(BuildError value, $Res Function(BuildError) _then) = _$BuildErrorCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$BuildErrorCopyWithImpl<$Res>
    implements $BuildErrorCopyWith<$Res> {
  _$BuildErrorCopyWithImpl(this._self, this._then);

  final BuildError _self;
  final $Res Function(BuildError) _then;

/// Create a copy of BuildError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field0 = null,}) {
  return _then(_self.copyWith(
field0: null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BuildError].
extension BuildErrorPatterns on BuildError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BuildError_InvalidConfig value)?  invalidConfig,TResult Function( BuildError_MissingParameter value)?  missingParameter,TResult Function( BuildError_UnsupportedOperation value)?  unsupportedOperation,TResult Function( BuildError_InitializationFailed value)?  initializationFailed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BuildError_InvalidConfig() when invalidConfig != null:
return invalidConfig(_that);case BuildError_MissingParameter() when missingParameter != null:
return missingParameter(_that);case BuildError_UnsupportedOperation() when unsupportedOperation != null:
return unsupportedOperation(_that);case BuildError_InitializationFailed() when initializationFailed != null:
return initializationFailed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BuildError_InvalidConfig value)  invalidConfig,required TResult Function( BuildError_MissingParameter value)  missingParameter,required TResult Function( BuildError_UnsupportedOperation value)  unsupportedOperation,required TResult Function( BuildError_InitializationFailed value)  initializationFailed,}){
final _that = this;
switch (_that) {
case BuildError_InvalidConfig():
return invalidConfig(_that);case BuildError_MissingParameter():
return missingParameter(_that);case BuildError_UnsupportedOperation():
return unsupportedOperation(_that);case BuildError_InitializationFailed():
return initializationFailed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BuildError_InvalidConfig value)?  invalidConfig,TResult? Function( BuildError_MissingParameter value)?  missingParameter,TResult? Function( BuildError_UnsupportedOperation value)?  unsupportedOperation,TResult? Function( BuildError_InitializationFailed value)?  initializationFailed,}){
final _that = this;
switch (_that) {
case BuildError_InvalidConfig() when invalidConfig != null:
return invalidConfig(_that);case BuildError_MissingParameter() when missingParameter != null:
return missingParameter(_that);case BuildError_UnsupportedOperation() when unsupportedOperation != null:
return unsupportedOperation(_that);case BuildError_InitializationFailed() when initializationFailed != null:
return initializationFailed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String field0)?  invalidConfig,TResult Function( String field0)?  missingParameter,TResult Function( String field0)?  unsupportedOperation,TResult Function( String field0)?  initializationFailed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BuildError_InvalidConfig() when invalidConfig != null:
return invalidConfig(_that.field0);case BuildError_MissingParameter() when missingParameter != null:
return missingParameter(_that.field0);case BuildError_UnsupportedOperation() when unsupportedOperation != null:
return unsupportedOperation(_that.field0);case BuildError_InitializationFailed() when initializationFailed != null:
return initializationFailed(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String field0)  invalidConfig,required TResult Function( String field0)  missingParameter,required TResult Function( String field0)  unsupportedOperation,required TResult Function( String field0)  initializationFailed,}) {final _that = this;
switch (_that) {
case BuildError_InvalidConfig():
return invalidConfig(_that.field0);case BuildError_MissingParameter():
return missingParameter(_that.field0);case BuildError_UnsupportedOperation():
return unsupportedOperation(_that.field0);case BuildError_InitializationFailed():
return initializationFailed(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String field0)?  invalidConfig,TResult? Function( String field0)?  missingParameter,TResult? Function( String field0)?  unsupportedOperation,TResult? Function( String field0)?  initializationFailed,}) {final _that = this;
switch (_that) {
case BuildError_InvalidConfig() when invalidConfig != null:
return invalidConfig(_that.field0);case BuildError_MissingParameter() when missingParameter != null:
return missingParameter(_that.field0);case BuildError_UnsupportedOperation() when unsupportedOperation != null:
return unsupportedOperation(_that.field0);case BuildError_InitializationFailed() when initializationFailed != null:
return initializationFailed(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class BuildError_InvalidConfig extends BuildError {
  const BuildError_InvalidConfig(this.field0): super._();
  

@override final  String field0;

/// Create a copy of BuildError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuildError_InvalidConfigCopyWith<BuildError_InvalidConfig> get copyWith => _$BuildError_InvalidConfigCopyWithImpl<BuildError_InvalidConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuildError_InvalidConfig&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'BuildError.invalidConfig(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $BuildError_InvalidConfigCopyWith<$Res> implements $BuildErrorCopyWith<$Res> {
  factory $BuildError_InvalidConfigCopyWith(BuildError_InvalidConfig value, $Res Function(BuildError_InvalidConfig) _then) = _$BuildError_InvalidConfigCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$BuildError_InvalidConfigCopyWithImpl<$Res>
    implements $BuildError_InvalidConfigCopyWith<$Res> {
  _$BuildError_InvalidConfigCopyWithImpl(this._self, this._then);

  final BuildError_InvalidConfig _self;
  final $Res Function(BuildError_InvalidConfig) _then;

/// Create a copy of BuildError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(BuildError_InvalidConfig(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BuildError_MissingParameter extends BuildError {
  const BuildError_MissingParameter(this.field0): super._();
  

@override final  String field0;

/// Create a copy of BuildError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuildError_MissingParameterCopyWith<BuildError_MissingParameter> get copyWith => _$BuildError_MissingParameterCopyWithImpl<BuildError_MissingParameter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuildError_MissingParameter&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'BuildError.missingParameter(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $BuildError_MissingParameterCopyWith<$Res> implements $BuildErrorCopyWith<$Res> {
  factory $BuildError_MissingParameterCopyWith(BuildError_MissingParameter value, $Res Function(BuildError_MissingParameter) _then) = _$BuildError_MissingParameterCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$BuildError_MissingParameterCopyWithImpl<$Res>
    implements $BuildError_MissingParameterCopyWith<$Res> {
  _$BuildError_MissingParameterCopyWithImpl(this._self, this._then);

  final BuildError_MissingParameter _self;
  final $Res Function(BuildError_MissingParameter) _then;

/// Create a copy of BuildError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(BuildError_MissingParameter(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BuildError_UnsupportedOperation extends BuildError {
  const BuildError_UnsupportedOperation(this.field0): super._();
  

@override final  String field0;

/// Create a copy of BuildError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuildError_UnsupportedOperationCopyWith<BuildError_UnsupportedOperation> get copyWith => _$BuildError_UnsupportedOperationCopyWithImpl<BuildError_UnsupportedOperation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuildError_UnsupportedOperation&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'BuildError.unsupportedOperation(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $BuildError_UnsupportedOperationCopyWith<$Res> implements $BuildErrorCopyWith<$Res> {
  factory $BuildError_UnsupportedOperationCopyWith(BuildError_UnsupportedOperation value, $Res Function(BuildError_UnsupportedOperation) _then) = _$BuildError_UnsupportedOperationCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$BuildError_UnsupportedOperationCopyWithImpl<$Res>
    implements $BuildError_UnsupportedOperationCopyWith<$Res> {
  _$BuildError_UnsupportedOperationCopyWithImpl(this._self, this._then);

  final BuildError_UnsupportedOperation _self;
  final $Res Function(BuildError_UnsupportedOperation) _then;

/// Create a copy of BuildError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(BuildError_UnsupportedOperation(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BuildError_InitializationFailed extends BuildError {
  const BuildError_InitializationFailed(this.field0): super._();
  

@override final  String field0;

/// Create a copy of BuildError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuildError_InitializationFailedCopyWith<BuildError_InitializationFailed> get copyWith => _$BuildError_InitializationFailedCopyWithImpl<BuildError_InitializationFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuildError_InitializationFailed&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'BuildError.initializationFailed(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $BuildError_InitializationFailedCopyWith<$Res> implements $BuildErrorCopyWith<$Res> {
  factory $BuildError_InitializationFailedCopyWith(BuildError_InitializationFailed value, $Res Function(BuildError_InitializationFailed) _then) = _$BuildError_InitializationFailedCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$BuildError_InitializationFailedCopyWithImpl<$Res>
    implements $BuildError_InitializationFailedCopyWith<$Res> {
  _$BuildError_InitializationFailedCopyWithImpl(this._self, this._then);

  final BuildError_InitializationFailed _self;
  final $Res Function(BuildError_InitializationFailed) _then;

/// Create a copy of BuildError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(BuildError_InitializationFailed(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CrawlerError {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CrawlerError()';
}


}

/// @nodoc
class $CrawlerErrorCopyWith<$Res>  {
$CrawlerErrorCopyWith(CrawlerError _, $Res Function(CrawlerError) __);
}


/// Adds pattern-matching-related methods to [CrawlerError].
extension CrawlerErrorPatterns on CrawlerError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CrawlerError_ParseError value)?  parseError,TResult Function( CrawlerError_BuildError value)?  buildError,TResult Function( CrawlerError_JsError value)?  jsError,TResult Function( CrawlerError_InvalidInput value)?  invalidInput,TResult Function( CrawlerError_NoMatch value)?  noMatch,TResult Function( CrawlerError_AuthRequired value)?  authRequired,TResult Function( CrawlerError_MissingPhaseConfig value)?  missingPhaseConfig,TResult Function( CrawlerError_UrlTemplateError value)?  urlTemplateError,TResult Function( CrawlerError_UnsupportedContentType value)?  unsupportedContentType,TResult Function( CrawlerError_DataParseError value)?  dataParseError,TResult Function( CrawlerError_MissingRequiredContext value)?  missingRequiredContext,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CrawlerError_ParseError() when parseError != null:
return parseError(_that);case CrawlerError_BuildError() when buildError != null:
return buildError(_that);case CrawlerError_JsError() when jsError != null:
return jsError(_that);case CrawlerError_InvalidInput() when invalidInput != null:
return invalidInput(_that);case CrawlerError_NoMatch() when noMatch != null:
return noMatch(_that);case CrawlerError_AuthRequired() when authRequired != null:
return authRequired(_that);case CrawlerError_MissingPhaseConfig() when missingPhaseConfig != null:
return missingPhaseConfig(_that);case CrawlerError_UrlTemplateError() when urlTemplateError != null:
return urlTemplateError(_that);case CrawlerError_UnsupportedContentType() when unsupportedContentType != null:
return unsupportedContentType(_that);case CrawlerError_DataParseError() when dataParseError != null:
return dataParseError(_that);case CrawlerError_MissingRequiredContext() when missingRequiredContext != null:
return missingRequiredContext(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CrawlerError_ParseError value)  parseError,required TResult Function( CrawlerError_BuildError value)  buildError,required TResult Function( CrawlerError_JsError value)  jsError,required TResult Function( CrawlerError_InvalidInput value)  invalidInput,required TResult Function( CrawlerError_NoMatch value)  noMatch,required TResult Function( CrawlerError_AuthRequired value)  authRequired,required TResult Function( CrawlerError_MissingPhaseConfig value)  missingPhaseConfig,required TResult Function( CrawlerError_UrlTemplateError value)  urlTemplateError,required TResult Function( CrawlerError_UnsupportedContentType value)  unsupportedContentType,required TResult Function( CrawlerError_DataParseError value)  dataParseError,required TResult Function( CrawlerError_MissingRequiredContext value)  missingRequiredContext,}){
final _that = this;
switch (_that) {
case CrawlerError_ParseError():
return parseError(_that);case CrawlerError_BuildError():
return buildError(_that);case CrawlerError_JsError():
return jsError(_that);case CrawlerError_InvalidInput():
return invalidInput(_that);case CrawlerError_NoMatch():
return noMatch(_that);case CrawlerError_AuthRequired():
return authRequired(_that);case CrawlerError_MissingPhaseConfig():
return missingPhaseConfig(_that);case CrawlerError_UrlTemplateError():
return urlTemplateError(_that);case CrawlerError_UnsupportedContentType():
return unsupportedContentType(_that);case CrawlerError_DataParseError():
return dataParseError(_that);case CrawlerError_MissingRequiredContext():
return missingRequiredContext(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CrawlerError_ParseError value)?  parseError,TResult? Function( CrawlerError_BuildError value)?  buildError,TResult? Function( CrawlerError_JsError value)?  jsError,TResult? Function( CrawlerError_InvalidInput value)?  invalidInput,TResult? Function( CrawlerError_NoMatch value)?  noMatch,TResult? Function( CrawlerError_AuthRequired value)?  authRequired,TResult? Function( CrawlerError_MissingPhaseConfig value)?  missingPhaseConfig,TResult? Function( CrawlerError_UrlTemplateError value)?  urlTemplateError,TResult? Function( CrawlerError_UnsupportedContentType value)?  unsupportedContentType,TResult? Function( CrawlerError_DataParseError value)?  dataParseError,TResult? Function( CrawlerError_MissingRequiredContext value)?  missingRequiredContext,}){
final _that = this;
switch (_that) {
case CrawlerError_ParseError() when parseError != null:
return parseError(_that);case CrawlerError_BuildError() when buildError != null:
return buildError(_that);case CrawlerError_JsError() when jsError != null:
return jsError(_that);case CrawlerError_InvalidInput() when invalidInput != null:
return invalidInput(_that);case CrawlerError_NoMatch() when noMatch != null:
return noMatch(_that);case CrawlerError_AuthRequired() when authRequired != null:
return authRequired(_that);case CrawlerError_MissingPhaseConfig() when missingPhaseConfig != null:
return missingPhaseConfig(_that);case CrawlerError_UrlTemplateError() when urlTemplateError != null:
return urlTemplateError(_that);case CrawlerError_UnsupportedContentType() when unsupportedContentType != null:
return unsupportedContentType(_that);case CrawlerError_DataParseError() when dataParseError != null:
return dataParseError(_that);case CrawlerError_MissingRequiredContext() when missingRequiredContext != null:
return missingRequiredContext(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ParseError field0)?  parseError,TResult Function( BuildError field0)?  buildError,TResult Function( String field0)?  jsError,TResult Function( String field0)?  invalidInput,TResult Function( String field0)?  noMatch,TResult Function( String field0)?  authRequired,TResult Function( String phase)?  missingPhaseConfig,TResult Function( String reason)?  urlTemplateError,TResult Function( String contentType)?  unsupportedContentType,TResult Function( String reason)?  dataParseError,TResult Function( String field)?  missingRequiredContext,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CrawlerError_ParseError() when parseError != null:
return parseError(_that.field0);case CrawlerError_BuildError() when buildError != null:
return buildError(_that.field0);case CrawlerError_JsError() when jsError != null:
return jsError(_that.field0);case CrawlerError_InvalidInput() when invalidInput != null:
return invalidInput(_that.field0);case CrawlerError_NoMatch() when noMatch != null:
return noMatch(_that.field0);case CrawlerError_AuthRequired() when authRequired != null:
return authRequired(_that.field0);case CrawlerError_MissingPhaseConfig() when missingPhaseConfig != null:
return missingPhaseConfig(_that.phase);case CrawlerError_UrlTemplateError() when urlTemplateError != null:
return urlTemplateError(_that.reason);case CrawlerError_UnsupportedContentType() when unsupportedContentType != null:
return unsupportedContentType(_that.contentType);case CrawlerError_DataParseError() when dataParseError != null:
return dataParseError(_that.reason);case CrawlerError_MissingRequiredContext() when missingRequiredContext != null:
return missingRequiredContext(_that.field);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ParseError field0)  parseError,required TResult Function( BuildError field0)  buildError,required TResult Function( String field0)  jsError,required TResult Function( String field0)  invalidInput,required TResult Function( String field0)  noMatch,required TResult Function( String field0)  authRequired,required TResult Function( String phase)  missingPhaseConfig,required TResult Function( String reason)  urlTemplateError,required TResult Function( String contentType)  unsupportedContentType,required TResult Function( String reason)  dataParseError,required TResult Function( String field)  missingRequiredContext,}) {final _that = this;
switch (_that) {
case CrawlerError_ParseError():
return parseError(_that.field0);case CrawlerError_BuildError():
return buildError(_that.field0);case CrawlerError_JsError():
return jsError(_that.field0);case CrawlerError_InvalidInput():
return invalidInput(_that.field0);case CrawlerError_NoMatch():
return noMatch(_that.field0);case CrawlerError_AuthRequired():
return authRequired(_that.field0);case CrawlerError_MissingPhaseConfig():
return missingPhaseConfig(_that.phase);case CrawlerError_UrlTemplateError():
return urlTemplateError(_that.reason);case CrawlerError_UnsupportedContentType():
return unsupportedContentType(_that.contentType);case CrawlerError_DataParseError():
return dataParseError(_that.reason);case CrawlerError_MissingRequiredContext():
return missingRequiredContext(_that.field);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ParseError field0)?  parseError,TResult? Function( BuildError field0)?  buildError,TResult? Function( String field0)?  jsError,TResult? Function( String field0)?  invalidInput,TResult? Function( String field0)?  noMatch,TResult? Function( String field0)?  authRequired,TResult? Function( String phase)?  missingPhaseConfig,TResult? Function( String reason)?  urlTemplateError,TResult? Function( String contentType)?  unsupportedContentType,TResult? Function( String reason)?  dataParseError,TResult? Function( String field)?  missingRequiredContext,}) {final _that = this;
switch (_that) {
case CrawlerError_ParseError() when parseError != null:
return parseError(_that.field0);case CrawlerError_BuildError() when buildError != null:
return buildError(_that.field0);case CrawlerError_JsError() when jsError != null:
return jsError(_that.field0);case CrawlerError_InvalidInput() when invalidInput != null:
return invalidInput(_that.field0);case CrawlerError_NoMatch() when noMatch != null:
return noMatch(_that.field0);case CrawlerError_AuthRequired() when authRequired != null:
return authRequired(_that.field0);case CrawlerError_MissingPhaseConfig() when missingPhaseConfig != null:
return missingPhaseConfig(_that.phase);case CrawlerError_UrlTemplateError() when urlTemplateError != null:
return urlTemplateError(_that.reason);case CrawlerError_UnsupportedContentType() when unsupportedContentType != null:
return unsupportedContentType(_that.contentType);case CrawlerError_DataParseError() when dataParseError != null:
return dataParseError(_that.reason);case CrawlerError_MissingRequiredContext() when missingRequiredContext != null:
return missingRequiredContext(_that.field);case _:
  return null;

}
}

}

/// @nodoc


class CrawlerError_ParseError extends CrawlerError {
  const CrawlerError_ParseError(this.field0): super._();
  

 final  ParseError field0;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerError_ParseErrorCopyWith<CrawlerError_ParseError> get copyWith => _$CrawlerError_ParseErrorCopyWithImpl<CrawlerError_ParseError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerError_ParseError&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'CrawlerError.parseError(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $CrawlerError_ParseErrorCopyWith<$Res> implements $CrawlerErrorCopyWith<$Res> {
  factory $CrawlerError_ParseErrorCopyWith(CrawlerError_ParseError value, $Res Function(CrawlerError_ParseError) _then) = _$CrawlerError_ParseErrorCopyWithImpl;
@useResult
$Res call({
 ParseError field0
});


$ParseErrorCopyWith<$Res> get field0;

}
/// @nodoc
class _$CrawlerError_ParseErrorCopyWithImpl<$Res>
    implements $CrawlerError_ParseErrorCopyWith<$Res> {
  _$CrawlerError_ParseErrorCopyWithImpl(this._self, this._then);

  final CrawlerError_ParseError _self;
  final $Res Function(CrawlerError_ParseError) _then;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(CrawlerError_ParseError(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as ParseError,
  ));
}

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ParseErrorCopyWith<$Res> get field0 {
  
  return $ParseErrorCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

/// @nodoc


class CrawlerError_BuildError extends CrawlerError {
  const CrawlerError_BuildError(this.field0): super._();
  

 final  BuildError field0;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerError_BuildErrorCopyWith<CrawlerError_BuildError> get copyWith => _$CrawlerError_BuildErrorCopyWithImpl<CrawlerError_BuildError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerError_BuildError&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'CrawlerError.buildError(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $CrawlerError_BuildErrorCopyWith<$Res> implements $CrawlerErrorCopyWith<$Res> {
  factory $CrawlerError_BuildErrorCopyWith(CrawlerError_BuildError value, $Res Function(CrawlerError_BuildError) _then) = _$CrawlerError_BuildErrorCopyWithImpl;
@useResult
$Res call({
 BuildError field0
});


$BuildErrorCopyWith<$Res> get field0;

}
/// @nodoc
class _$CrawlerError_BuildErrorCopyWithImpl<$Res>
    implements $CrawlerError_BuildErrorCopyWith<$Res> {
  _$CrawlerError_BuildErrorCopyWithImpl(this._self, this._then);

  final CrawlerError_BuildError _self;
  final $Res Function(CrawlerError_BuildError) _then;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(CrawlerError_BuildError(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as BuildError,
  ));
}

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BuildErrorCopyWith<$Res> get field0 {
  
  return $BuildErrorCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

/// @nodoc


class CrawlerError_JsError extends CrawlerError {
  const CrawlerError_JsError(this.field0): super._();
  

 final  String field0;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerError_JsErrorCopyWith<CrawlerError_JsError> get copyWith => _$CrawlerError_JsErrorCopyWithImpl<CrawlerError_JsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerError_JsError&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'CrawlerError.jsError(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $CrawlerError_JsErrorCopyWith<$Res> implements $CrawlerErrorCopyWith<$Res> {
  factory $CrawlerError_JsErrorCopyWith(CrawlerError_JsError value, $Res Function(CrawlerError_JsError) _then) = _$CrawlerError_JsErrorCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$CrawlerError_JsErrorCopyWithImpl<$Res>
    implements $CrawlerError_JsErrorCopyWith<$Res> {
  _$CrawlerError_JsErrorCopyWithImpl(this._self, this._then);

  final CrawlerError_JsError _self;
  final $Res Function(CrawlerError_JsError) _then;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(CrawlerError_JsError(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CrawlerError_InvalidInput extends CrawlerError {
  const CrawlerError_InvalidInput(this.field0): super._();
  

 final  String field0;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerError_InvalidInputCopyWith<CrawlerError_InvalidInput> get copyWith => _$CrawlerError_InvalidInputCopyWithImpl<CrawlerError_InvalidInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerError_InvalidInput&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'CrawlerError.invalidInput(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $CrawlerError_InvalidInputCopyWith<$Res> implements $CrawlerErrorCopyWith<$Res> {
  factory $CrawlerError_InvalidInputCopyWith(CrawlerError_InvalidInput value, $Res Function(CrawlerError_InvalidInput) _then) = _$CrawlerError_InvalidInputCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$CrawlerError_InvalidInputCopyWithImpl<$Res>
    implements $CrawlerError_InvalidInputCopyWith<$Res> {
  _$CrawlerError_InvalidInputCopyWithImpl(this._self, this._then);

  final CrawlerError_InvalidInput _self;
  final $Res Function(CrawlerError_InvalidInput) _then;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(CrawlerError_InvalidInput(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CrawlerError_NoMatch extends CrawlerError {
  const CrawlerError_NoMatch(this.field0): super._();
  

 final  String field0;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerError_NoMatchCopyWith<CrawlerError_NoMatch> get copyWith => _$CrawlerError_NoMatchCopyWithImpl<CrawlerError_NoMatch>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerError_NoMatch&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'CrawlerError.noMatch(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $CrawlerError_NoMatchCopyWith<$Res> implements $CrawlerErrorCopyWith<$Res> {
  factory $CrawlerError_NoMatchCopyWith(CrawlerError_NoMatch value, $Res Function(CrawlerError_NoMatch) _then) = _$CrawlerError_NoMatchCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$CrawlerError_NoMatchCopyWithImpl<$Res>
    implements $CrawlerError_NoMatchCopyWith<$Res> {
  _$CrawlerError_NoMatchCopyWithImpl(this._self, this._then);

  final CrawlerError_NoMatch _self;
  final $Res Function(CrawlerError_NoMatch) _then;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(CrawlerError_NoMatch(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CrawlerError_AuthRequired extends CrawlerError {
  const CrawlerError_AuthRequired(this.field0): super._();
  

 final  String field0;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerError_AuthRequiredCopyWith<CrawlerError_AuthRequired> get copyWith => _$CrawlerError_AuthRequiredCopyWithImpl<CrawlerError_AuthRequired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerError_AuthRequired&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'CrawlerError.authRequired(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $CrawlerError_AuthRequiredCopyWith<$Res> implements $CrawlerErrorCopyWith<$Res> {
  factory $CrawlerError_AuthRequiredCopyWith(CrawlerError_AuthRequired value, $Res Function(CrawlerError_AuthRequired) _then) = _$CrawlerError_AuthRequiredCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$CrawlerError_AuthRequiredCopyWithImpl<$Res>
    implements $CrawlerError_AuthRequiredCopyWith<$Res> {
  _$CrawlerError_AuthRequiredCopyWithImpl(this._self, this._then);

  final CrawlerError_AuthRequired _self;
  final $Res Function(CrawlerError_AuthRequired) _then;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(CrawlerError_AuthRequired(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CrawlerError_MissingPhaseConfig extends CrawlerError {
  const CrawlerError_MissingPhaseConfig({required this.phase}): super._();
  

 final  String phase;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerError_MissingPhaseConfigCopyWith<CrawlerError_MissingPhaseConfig> get copyWith => _$CrawlerError_MissingPhaseConfigCopyWithImpl<CrawlerError_MissingPhaseConfig>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerError_MissingPhaseConfig&&(identical(other.phase, phase) || other.phase == phase));
}


@override
int get hashCode => Object.hash(runtimeType,phase);

@override
String toString() {
  return 'CrawlerError.missingPhaseConfig(phase: $phase)';
}


}

/// @nodoc
abstract mixin class $CrawlerError_MissingPhaseConfigCopyWith<$Res> implements $CrawlerErrorCopyWith<$Res> {
  factory $CrawlerError_MissingPhaseConfigCopyWith(CrawlerError_MissingPhaseConfig value, $Res Function(CrawlerError_MissingPhaseConfig) _then) = _$CrawlerError_MissingPhaseConfigCopyWithImpl;
@useResult
$Res call({
 String phase
});




}
/// @nodoc
class _$CrawlerError_MissingPhaseConfigCopyWithImpl<$Res>
    implements $CrawlerError_MissingPhaseConfigCopyWith<$Res> {
  _$CrawlerError_MissingPhaseConfigCopyWithImpl(this._self, this._then);

  final CrawlerError_MissingPhaseConfig _self;
  final $Res Function(CrawlerError_MissingPhaseConfig) _then;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phase = null,}) {
  return _then(CrawlerError_MissingPhaseConfig(
phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CrawlerError_UrlTemplateError extends CrawlerError {
  const CrawlerError_UrlTemplateError({required this.reason}): super._();
  

 final  String reason;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerError_UrlTemplateErrorCopyWith<CrawlerError_UrlTemplateError> get copyWith => _$CrawlerError_UrlTemplateErrorCopyWithImpl<CrawlerError_UrlTemplateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerError_UrlTemplateError&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'CrawlerError.urlTemplateError(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $CrawlerError_UrlTemplateErrorCopyWith<$Res> implements $CrawlerErrorCopyWith<$Res> {
  factory $CrawlerError_UrlTemplateErrorCopyWith(CrawlerError_UrlTemplateError value, $Res Function(CrawlerError_UrlTemplateError) _then) = _$CrawlerError_UrlTemplateErrorCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$CrawlerError_UrlTemplateErrorCopyWithImpl<$Res>
    implements $CrawlerError_UrlTemplateErrorCopyWith<$Res> {
  _$CrawlerError_UrlTemplateErrorCopyWithImpl(this._self, this._then);

  final CrawlerError_UrlTemplateError _self;
  final $Res Function(CrawlerError_UrlTemplateError) _then;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(CrawlerError_UrlTemplateError(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CrawlerError_UnsupportedContentType extends CrawlerError {
  const CrawlerError_UnsupportedContentType({required this.contentType}): super._();
  

 final  String contentType;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerError_UnsupportedContentTypeCopyWith<CrawlerError_UnsupportedContentType> get copyWith => _$CrawlerError_UnsupportedContentTypeCopyWithImpl<CrawlerError_UnsupportedContentType>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerError_UnsupportedContentType&&(identical(other.contentType, contentType) || other.contentType == contentType));
}


@override
int get hashCode => Object.hash(runtimeType,contentType);

@override
String toString() {
  return 'CrawlerError.unsupportedContentType(contentType: $contentType)';
}


}

/// @nodoc
abstract mixin class $CrawlerError_UnsupportedContentTypeCopyWith<$Res> implements $CrawlerErrorCopyWith<$Res> {
  factory $CrawlerError_UnsupportedContentTypeCopyWith(CrawlerError_UnsupportedContentType value, $Res Function(CrawlerError_UnsupportedContentType) _then) = _$CrawlerError_UnsupportedContentTypeCopyWithImpl;
@useResult
$Res call({
 String contentType
});




}
/// @nodoc
class _$CrawlerError_UnsupportedContentTypeCopyWithImpl<$Res>
    implements $CrawlerError_UnsupportedContentTypeCopyWith<$Res> {
  _$CrawlerError_UnsupportedContentTypeCopyWithImpl(this._self, this._then);

  final CrawlerError_UnsupportedContentType _self;
  final $Res Function(CrawlerError_UnsupportedContentType) _then;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contentType = null,}) {
  return _then(CrawlerError_UnsupportedContentType(
contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CrawlerError_DataParseError extends CrawlerError {
  const CrawlerError_DataParseError({required this.reason}): super._();
  

 final  String reason;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerError_DataParseErrorCopyWith<CrawlerError_DataParseError> get copyWith => _$CrawlerError_DataParseErrorCopyWithImpl<CrawlerError_DataParseError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerError_DataParseError&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'CrawlerError.dataParseError(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $CrawlerError_DataParseErrorCopyWith<$Res> implements $CrawlerErrorCopyWith<$Res> {
  factory $CrawlerError_DataParseErrorCopyWith(CrawlerError_DataParseError value, $Res Function(CrawlerError_DataParseError) _then) = _$CrawlerError_DataParseErrorCopyWithImpl;
@useResult
$Res call({
 String reason
});




}
/// @nodoc
class _$CrawlerError_DataParseErrorCopyWithImpl<$Res>
    implements $CrawlerError_DataParseErrorCopyWith<$Res> {
  _$CrawlerError_DataParseErrorCopyWithImpl(this._self, this._then);

  final CrawlerError_DataParseError _self;
  final $Res Function(CrawlerError_DataParseError) _then;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(CrawlerError_DataParseError(
reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CrawlerError_MissingRequiredContext extends CrawlerError {
  const CrawlerError_MissingRequiredContext({required this.field}): super._();
  

 final  String field;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerError_MissingRequiredContextCopyWith<CrawlerError_MissingRequiredContext> get copyWith => _$CrawlerError_MissingRequiredContextCopyWithImpl<CrawlerError_MissingRequiredContext>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerError_MissingRequiredContext&&(identical(other.field, field) || other.field == field));
}


@override
int get hashCode => Object.hash(runtimeType,field);

@override
String toString() {
  return 'CrawlerError.missingRequiredContext(field: $field)';
}


}

/// @nodoc
abstract mixin class $CrawlerError_MissingRequiredContextCopyWith<$Res> implements $CrawlerErrorCopyWith<$Res> {
  factory $CrawlerError_MissingRequiredContextCopyWith(CrawlerError_MissingRequiredContext value, $Res Function(CrawlerError_MissingRequiredContext) _then) = _$CrawlerError_MissingRequiredContextCopyWithImpl;
@useResult
$Res call({
 String field
});




}
/// @nodoc
class _$CrawlerError_MissingRequiredContextCopyWithImpl<$Res>
    implements $CrawlerError_MissingRequiredContextCopyWith<$Res> {
  _$CrawlerError_MissingRequiredContextCopyWithImpl(this._self, this._then);

  final CrawlerError_MissingRequiredContext _self;
  final $Res Function(CrawlerError_MissingRequiredContext) _then;

/// Create a copy of CrawlerError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field = null,}) {
  return _then(CrawlerError_MissingRequiredContext(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ParseError {

 String get field0;
/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseErrorCopyWith<ParseError> get copyWith => _$ParseErrorCopyWithImpl<ParseError>(this as ParseError, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseError&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ParseError(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ParseErrorCopyWith<$Res>  {
  factory $ParseErrorCopyWith(ParseError value, $Res Function(ParseError) _then) = _$ParseErrorCopyWithImpl;
@useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$ParseErrorCopyWithImpl<$Res>
    implements $ParseErrorCopyWith<$Res> {
  _$ParseErrorCopyWithImpl(this._self, this._then);

  final ParseError _self;
  final $Res Function(ParseError) _then;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field0 = null,}) {
  return _then(_self.copyWith(
field0: null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ParseError].
extension ParseErrorPatterns on ParseError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ParseError_HtmlParse value)?  htmlParse,TResult Function( ParseError_XmlParse value)?  xmlParse,TResult Function( ParseError_JsonParse value)?  jsonParse,TResult Function( ParseError_XPathSyntax value)?  xPathSyntax,TResult Function( ParseError_CssSyntax value)?  cssSyntax,TResult Function( ParseError_JsonPathSyntax value)?  jsonPathSyntax,TResult Function( ParseError_RegexSyntax value)?  regexSyntax,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ParseError_HtmlParse() when htmlParse != null:
return htmlParse(_that);case ParseError_XmlParse() when xmlParse != null:
return xmlParse(_that);case ParseError_JsonParse() when jsonParse != null:
return jsonParse(_that);case ParseError_XPathSyntax() when xPathSyntax != null:
return xPathSyntax(_that);case ParseError_CssSyntax() when cssSyntax != null:
return cssSyntax(_that);case ParseError_JsonPathSyntax() when jsonPathSyntax != null:
return jsonPathSyntax(_that);case ParseError_RegexSyntax() when regexSyntax != null:
return regexSyntax(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ParseError_HtmlParse value)  htmlParse,required TResult Function( ParseError_XmlParse value)  xmlParse,required TResult Function( ParseError_JsonParse value)  jsonParse,required TResult Function( ParseError_XPathSyntax value)  xPathSyntax,required TResult Function( ParseError_CssSyntax value)  cssSyntax,required TResult Function( ParseError_JsonPathSyntax value)  jsonPathSyntax,required TResult Function( ParseError_RegexSyntax value)  regexSyntax,}){
final _that = this;
switch (_that) {
case ParseError_HtmlParse():
return htmlParse(_that);case ParseError_XmlParse():
return xmlParse(_that);case ParseError_JsonParse():
return jsonParse(_that);case ParseError_XPathSyntax():
return xPathSyntax(_that);case ParseError_CssSyntax():
return cssSyntax(_that);case ParseError_JsonPathSyntax():
return jsonPathSyntax(_that);case ParseError_RegexSyntax():
return regexSyntax(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ParseError_HtmlParse value)?  htmlParse,TResult? Function( ParseError_XmlParse value)?  xmlParse,TResult? Function( ParseError_JsonParse value)?  jsonParse,TResult? Function( ParseError_XPathSyntax value)?  xPathSyntax,TResult? Function( ParseError_CssSyntax value)?  cssSyntax,TResult? Function( ParseError_JsonPathSyntax value)?  jsonPathSyntax,TResult? Function( ParseError_RegexSyntax value)?  regexSyntax,}){
final _that = this;
switch (_that) {
case ParseError_HtmlParse() when htmlParse != null:
return htmlParse(_that);case ParseError_XmlParse() when xmlParse != null:
return xmlParse(_that);case ParseError_JsonParse() when jsonParse != null:
return jsonParse(_that);case ParseError_XPathSyntax() when xPathSyntax != null:
return xPathSyntax(_that);case ParseError_CssSyntax() when cssSyntax != null:
return cssSyntax(_that);case ParseError_JsonPathSyntax() when jsonPathSyntax != null:
return jsonPathSyntax(_that);case ParseError_RegexSyntax() when regexSyntax != null:
return regexSyntax(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String field0)?  htmlParse,TResult Function( String field0)?  xmlParse,TResult Function( String field0)?  jsonParse,TResult Function( String field0)?  xPathSyntax,TResult Function( String field0)?  cssSyntax,TResult Function( String field0)?  jsonPathSyntax,TResult Function( String field0)?  regexSyntax,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ParseError_HtmlParse() when htmlParse != null:
return htmlParse(_that.field0);case ParseError_XmlParse() when xmlParse != null:
return xmlParse(_that.field0);case ParseError_JsonParse() when jsonParse != null:
return jsonParse(_that.field0);case ParseError_XPathSyntax() when xPathSyntax != null:
return xPathSyntax(_that.field0);case ParseError_CssSyntax() when cssSyntax != null:
return cssSyntax(_that.field0);case ParseError_JsonPathSyntax() when jsonPathSyntax != null:
return jsonPathSyntax(_that.field0);case ParseError_RegexSyntax() when regexSyntax != null:
return regexSyntax(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String field0)  htmlParse,required TResult Function( String field0)  xmlParse,required TResult Function( String field0)  jsonParse,required TResult Function( String field0)  xPathSyntax,required TResult Function( String field0)  cssSyntax,required TResult Function( String field0)  jsonPathSyntax,required TResult Function( String field0)  regexSyntax,}) {final _that = this;
switch (_that) {
case ParseError_HtmlParse():
return htmlParse(_that.field0);case ParseError_XmlParse():
return xmlParse(_that.field0);case ParseError_JsonParse():
return jsonParse(_that.field0);case ParseError_XPathSyntax():
return xPathSyntax(_that.field0);case ParseError_CssSyntax():
return cssSyntax(_that.field0);case ParseError_JsonPathSyntax():
return jsonPathSyntax(_that.field0);case ParseError_RegexSyntax():
return regexSyntax(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String field0)?  htmlParse,TResult? Function( String field0)?  xmlParse,TResult? Function( String field0)?  jsonParse,TResult? Function( String field0)?  xPathSyntax,TResult? Function( String field0)?  cssSyntax,TResult? Function( String field0)?  jsonPathSyntax,TResult? Function( String field0)?  regexSyntax,}) {final _that = this;
switch (_that) {
case ParseError_HtmlParse() when htmlParse != null:
return htmlParse(_that.field0);case ParseError_XmlParse() when xmlParse != null:
return xmlParse(_that.field0);case ParseError_JsonParse() when jsonParse != null:
return jsonParse(_that.field0);case ParseError_XPathSyntax() when xPathSyntax != null:
return xPathSyntax(_that.field0);case ParseError_CssSyntax() when cssSyntax != null:
return cssSyntax(_that.field0);case ParseError_JsonPathSyntax() when jsonPathSyntax != null:
return jsonPathSyntax(_that.field0);case ParseError_RegexSyntax() when regexSyntax != null:
return regexSyntax(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class ParseError_HtmlParse extends ParseError {
  const ParseError_HtmlParse(this.field0): super._();
  

@override final  String field0;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseError_HtmlParseCopyWith<ParseError_HtmlParse> get copyWith => _$ParseError_HtmlParseCopyWithImpl<ParseError_HtmlParse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseError_HtmlParse&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ParseError.htmlParse(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ParseError_HtmlParseCopyWith<$Res> implements $ParseErrorCopyWith<$Res> {
  factory $ParseError_HtmlParseCopyWith(ParseError_HtmlParse value, $Res Function(ParseError_HtmlParse) _then) = _$ParseError_HtmlParseCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$ParseError_HtmlParseCopyWithImpl<$Res>
    implements $ParseError_HtmlParseCopyWith<$Res> {
  _$ParseError_HtmlParseCopyWithImpl(this._self, this._then);

  final ParseError_HtmlParse _self;
  final $Res Function(ParseError_HtmlParse) _then;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ParseError_HtmlParse(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ParseError_XmlParse extends ParseError {
  const ParseError_XmlParse(this.field0): super._();
  

@override final  String field0;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseError_XmlParseCopyWith<ParseError_XmlParse> get copyWith => _$ParseError_XmlParseCopyWithImpl<ParseError_XmlParse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseError_XmlParse&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ParseError.xmlParse(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ParseError_XmlParseCopyWith<$Res> implements $ParseErrorCopyWith<$Res> {
  factory $ParseError_XmlParseCopyWith(ParseError_XmlParse value, $Res Function(ParseError_XmlParse) _then) = _$ParseError_XmlParseCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$ParseError_XmlParseCopyWithImpl<$Res>
    implements $ParseError_XmlParseCopyWith<$Res> {
  _$ParseError_XmlParseCopyWithImpl(this._self, this._then);

  final ParseError_XmlParse _self;
  final $Res Function(ParseError_XmlParse) _then;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ParseError_XmlParse(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ParseError_JsonParse extends ParseError {
  const ParseError_JsonParse(this.field0): super._();
  

@override final  String field0;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseError_JsonParseCopyWith<ParseError_JsonParse> get copyWith => _$ParseError_JsonParseCopyWithImpl<ParseError_JsonParse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseError_JsonParse&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ParseError.jsonParse(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ParseError_JsonParseCopyWith<$Res> implements $ParseErrorCopyWith<$Res> {
  factory $ParseError_JsonParseCopyWith(ParseError_JsonParse value, $Res Function(ParseError_JsonParse) _then) = _$ParseError_JsonParseCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$ParseError_JsonParseCopyWithImpl<$Res>
    implements $ParseError_JsonParseCopyWith<$Res> {
  _$ParseError_JsonParseCopyWithImpl(this._self, this._then);

  final ParseError_JsonParse _self;
  final $Res Function(ParseError_JsonParse) _then;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ParseError_JsonParse(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ParseError_XPathSyntax extends ParseError {
  const ParseError_XPathSyntax(this.field0): super._();
  

@override final  String field0;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseError_XPathSyntaxCopyWith<ParseError_XPathSyntax> get copyWith => _$ParseError_XPathSyntaxCopyWithImpl<ParseError_XPathSyntax>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseError_XPathSyntax&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ParseError.xPathSyntax(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ParseError_XPathSyntaxCopyWith<$Res> implements $ParseErrorCopyWith<$Res> {
  factory $ParseError_XPathSyntaxCopyWith(ParseError_XPathSyntax value, $Res Function(ParseError_XPathSyntax) _then) = _$ParseError_XPathSyntaxCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$ParseError_XPathSyntaxCopyWithImpl<$Res>
    implements $ParseError_XPathSyntaxCopyWith<$Res> {
  _$ParseError_XPathSyntaxCopyWithImpl(this._self, this._then);

  final ParseError_XPathSyntax _self;
  final $Res Function(ParseError_XPathSyntax) _then;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ParseError_XPathSyntax(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ParseError_CssSyntax extends ParseError {
  const ParseError_CssSyntax(this.field0): super._();
  

@override final  String field0;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseError_CssSyntaxCopyWith<ParseError_CssSyntax> get copyWith => _$ParseError_CssSyntaxCopyWithImpl<ParseError_CssSyntax>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseError_CssSyntax&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ParseError.cssSyntax(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ParseError_CssSyntaxCopyWith<$Res> implements $ParseErrorCopyWith<$Res> {
  factory $ParseError_CssSyntaxCopyWith(ParseError_CssSyntax value, $Res Function(ParseError_CssSyntax) _then) = _$ParseError_CssSyntaxCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$ParseError_CssSyntaxCopyWithImpl<$Res>
    implements $ParseError_CssSyntaxCopyWith<$Res> {
  _$ParseError_CssSyntaxCopyWithImpl(this._self, this._then);

  final ParseError_CssSyntax _self;
  final $Res Function(ParseError_CssSyntax) _then;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ParseError_CssSyntax(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ParseError_JsonPathSyntax extends ParseError {
  const ParseError_JsonPathSyntax(this.field0): super._();
  

@override final  String field0;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseError_JsonPathSyntaxCopyWith<ParseError_JsonPathSyntax> get copyWith => _$ParseError_JsonPathSyntaxCopyWithImpl<ParseError_JsonPathSyntax>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseError_JsonPathSyntax&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ParseError.jsonPathSyntax(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ParseError_JsonPathSyntaxCopyWith<$Res> implements $ParseErrorCopyWith<$Res> {
  factory $ParseError_JsonPathSyntaxCopyWith(ParseError_JsonPathSyntax value, $Res Function(ParseError_JsonPathSyntax) _then) = _$ParseError_JsonPathSyntaxCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$ParseError_JsonPathSyntaxCopyWithImpl<$Res>
    implements $ParseError_JsonPathSyntaxCopyWith<$Res> {
  _$ParseError_JsonPathSyntaxCopyWithImpl(this._self, this._then);

  final ParseError_JsonPathSyntax _self;
  final $Res Function(ParseError_JsonPathSyntax) _then;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ParseError_JsonPathSyntax(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ParseError_RegexSyntax extends ParseError {
  const ParseError_RegexSyntax(this.field0): super._();
  

@override final  String field0;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ParseError_RegexSyntaxCopyWith<ParseError_RegexSyntax> get copyWith => _$ParseError_RegexSyntaxCopyWithImpl<ParseError_RegexSyntax>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ParseError_RegexSyntax&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'ParseError.regexSyntax(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $ParseError_RegexSyntaxCopyWith<$Res> implements $ParseErrorCopyWith<$Res> {
  factory $ParseError_RegexSyntaxCopyWith(ParseError_RegexSyntax value, $Res Function(ParseError_RegexSyntax) _then) = _$ParseError_RegexSyntaxCopyWithImpl;
@override @useResult
$Res call({
 String field0
});




}
/// @nodoc
class _$ParseError_RegexSyntaxCopyWithImpl<$Res>
    implements $ParseError_RegexSyntaxCopyWith<$Res> {
  _$ParseError_RegexSyntaxCopyWithImpl(this._self, this._then);

  final ParseError_RegexSyntax _self;
  final $Res Function(ParseError_RegexSyntax) _then;

/// Create a copy of ParseError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(ParseError_RegexSyntax(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
