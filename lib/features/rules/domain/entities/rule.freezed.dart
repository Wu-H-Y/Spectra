// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Rule {

 String get id; String get name; String get irVersion; RuleMetadata get metadata; RuleGraph get graph; Map<String, dynamic> get normalizedOutputs; Map<String, dynamic> get capabilities; Map<String, dynamic>? get rateLimit; bool get isEnabled; DateTime? get createdAt; DateTime? get updatedAt; Map<String, dynamic> get rawEnvelope;
/// Create a copy of Rule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuleCopyWith<Rule> get copyWith => _$RuleCopyWithImpl<Rule>(this as Rule, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Rule&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.irVersion, irVersion) || other.irVersion == irVersion)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.graph, graph) || other.graph == graph)&&const DeepCollectionEquality().equals(other.normalizedOutputs, normalizedOutputs)&&const DeepCollectionEquality().equals(other.capabilities, capabilities)&&const DeepCollectionEquality().equals(other.rateLimit, rateLimit)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.rawEnvelope, rawEnvelope));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,irVersion,metadata,graph,const DeepCollectionEquality().hash(normalizedOutputs),const DeepCollectionEquality().hash(capabilities),const DeepCollectionEquality().hash(rateLimit),isEnabled,createdAt,updatedAt,const DeepCollectionEquality().hash(rawEnvelope));

@override
String toString() {
  return 'Rule(id: $id, name: $name, irVersion: $irVersion, metadata: $metadata, graph: $graph, normalizedOutputs: $normalizedOutputs, capabilities: $capabilities, rateLimit: $rateLimit, isEnabled: $isEnabled, createdAt: $createdAt, updatedAt: $updatedAt, rawEnvelope: $rawEnvelope)';
}


}

/// @nodoc
abstract mixin class $RuleCopyWith<$Res>  {
  factory $RuleCopyWith(Rule value, $Res Function(Rule) _then) = _$RuleCopyWithImpl;
@useResult
$Res call({
 String id, String name, String irVersion, RuleMetadata metadata, RuleGraph graph, Map<String, dynamic> normalizedOutputs, Map<String, dynamic> capabilities, Map<String, dynamic>? rateLimit, bool isEnabled, DateTime? createdAt, DateTime? updatedAt, Map<String, dynamic> rawEnvelope
});


$RuleMetadataCopyWith<$Res> get metadata;$RuleGraphCopyWith<$Res> get graph;

}
/// @nodoc
class _$RuleCopyWithImpl<$Res>
    implements $RuleCopyWith<$Res> {
  _$RuleCopyWithImpl(this._self, this._then);

  final Rule _self;
  final $Res Function(Rule) _then;

/// Create a copy of Rule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? irVersion = null,Object? metadata = null,Object? graph = null,Object? normalizedOutputs = null,Object? capabilities = null,Object? rateLimit = freezed,Object? isEnabled = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? rawEnvelope = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,irVersion: null == irVersion ? _self.irVersion : irVersion // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as RuleMetadata,graph: null == graph ? _self.graph : graph // ignore: cast_nullable_to_non_nullable
as RuleGraph,normalizedOutputs: null == normalizedOutputs ? _self.normalizedOutputs : normalizedOutputs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,capabilities: null == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,rateLimit: freezed == rateLimit ? _self.rateLimit : rateLimit // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rawEnvelope: null == rawEnvelope ? _self.rawEnvelope : rawEnvelope // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}
/// Create a copy of Rule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RuleMetadataCopyWith<$Res> get metadata {
  
  return $RuleMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}/// Create a copy of Rule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RuleGraphCopyWith<$Res> get graph {
  
  return $RuleGraphCopyWith<$Res>(_self.graph, (value) {
    return _then(_self.copyWith(graph: value));
  });
}
}


/// Adds pattern-matching-related methods to [Rule].
extension RulePatterns on Rule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Rule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Rule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Rule value)  $default,){
final _that = this;
switch (_that) {
case _Rule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Rule value)?  $default,){
final _that = this;
switch (_that) {
case _Rule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String irVersion,  RuleMetadata metadata,  RuleGraph graph,  Map<String, dynamic> normalizedOutputs,  Map<String, dynamic> capabilities,  Map<String, dynamic>? rateLimit,  bool isEnabled,  DateTime? createdAt,  DateTime? updatedAt,  Map<String, dynamic> rawEnvelope)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Rule() when $default != null:
return $default(_that.id,_that.name,_that.irVersion,_that.metadata,_that.graph,_that.normalizedOutputs,_that.capabilities,_that.rateLimit,_that.isEnabled,_that.createdAt,_that.updatedAt,_that.rawEnvelope);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String irVersion,  RuleMetadata metadata,  RuleGraph graph,  Map<String, dynamic> normalizedOutputs,  Map<String, dynamic> capabilities,  Map<String, dynamic>? rateLimit,  bool isEnabled,  DateTime? createdAt,  DateTime? updatedAt,  Map<String, dynamic> rawEnvelope)  $default,) {final _that = this;
switch (_that) {
case _Rule():
return $default(_that.id,_that.name,_that.irVersion,_that.metadata,_that.graph,_that.normalizedOutputs,_that.capabilities,_that.rateLimit,_that.isEnabled,_that.createdAt,_that.updatedAt,_that.rawEnvelope);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String irVersion,  RuleMetadata metadata,  RuleGraph graph,  Map<String, dynamic> normalizedOutputs,  Map<String, dynamic> capabilities,  Map<String, dynamic>? rateLimit,  bool isEnabled,  DateTime? createdAt,  DateTime? updatedAt,  Map<String, dynamic> rawEnvelope)?  $default,) {final _that = this;
switch (_that) {
case _Rule() when $default != null:
return $default(_that.id,_that.name,_that.irVersion,_that.metadata,_that.graph,_that.normalizedOutputs,_that.capabilities,_that.rateLimit,_that.isEnabled,_that.createdAt,_that.updatedAt,_that.rawEnvelope);case _:
  return null;

}
}

}

/// @nodoc


class _Rule extends Rule {
  const _Rule({required this.id, required this.name, required this.irVersion, required this.metadata, required this.graph, required final  Map<String, dynamic> normalizedOutputs, required final  Map<String, dynamic> capabilities, final  Map<String, dynamic>? rateLimit, this.isEnabled = true, this.createdAt, this.updatedAt, required final  Map<String, dynamic> rawEnvelope}): _normalizedOutputs = normalizedOutputs,_capabilities = capabilities,_rateLimit = rateLimit,_rawEnvelope = rawEnvelope,super._();
  

@override final  String id;
@override final  String name;
@override final  String irVersion;
@override final  RuleMetadata metadata;
@override final  RuleGraph graph;
 final  Map<String, dynamic> _normalizedOutputs;
@override Map<String, dynamic> get normalizedOutputs {
  if (_normalizedOutputs is EqualUnmodifiableMapView) return _normalizedOutputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_normalizedOutputs);
}

 final  Map<String, dynamic> _capabilities;
@override Map<String, dynamic> get capabilities {
  if (_capabilities is EqualUnmodifiableMapView) return _capabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_capabilities);
}

 final  Map<String, dynamic>? _rateLimit;
@override Map<String, dynamic>? get rateLimit {
  final value = _rateLimit;
  if (value == null) return null;
  if (_rateLimit is EqualUnmodifiableMapView) return _rateLimit;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey() final  bool isEnabled;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
 final  Map<String, dynamic> _rawEnvelope;
@override Map<String, dynamic> get rawEnvelope {
  if (_rawEnvelope is EqualUnmodifiableMapView) return _rawEnvelope;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rawEnvelope);
}


/// Create a copy of Rule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RuleCopyWith<_Rule> get copyWith => __$RuleCopyWithImpl<_Rule>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Rule&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.irVersion, irVersion) || other.irVersion == irVersion)&&(identical(other.metadata, metadata) || other.metadata == metadata)&&(identical(other.graph, graph) || other.graph == graph)&&const DeepCollectionEquality().equals(other._normalizedOutputs, _normalizedOutputs)&&const DeepCollectionEquality().equals(other._capabilities, _capabilities)&&const DeepCollectionEquality().equals(other._rateLimit, _rateLimit)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._rawEnvelope, _rawEnvelope));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,irVersion,metadata,graph,const DeepCollectionEquality().hash(_normalizedOutputs),const DeepCollectionEquality().hash(_capabilities),const DeepCollectionEquality().hash(_rateLimit),isEnabled,createdAt,updatedAt,const DeepCollectionEquality().hash(_rawEnvelope));

@override
String toString() {
  return 'Rule(id: $id, name: $name, irVersion: $irVersion, metadata: $metadata, graph: $graph, normalizedOutputs: $normalizedOutputs, capabilities: $capabilities, rateLimit: $rateLimit, isEnabled: $isEnabled, createdAt: $createdAt, updatedAt: $updatedAt, rawEnvelope: $rawEnvelope)';
}


}

/// @nodoc
abstract mixin class _$RuleCopyWith<$Res> implements $RuleCopyWith<$Res> {
  factory _$RuleCopyWith(_Rule value, $Res Function(_Rule) _then) = __$RuleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String irVersion, RuleMetadata metadata, RuleGraph graph, Map<String, dynamic> normalizedOutputs, Map<String, dynamic> capabilities, Map<String, dynamic>? rateLimit, bool isEnabled, DateTime? createdAt, DateTime? updatedAt, Map<String, dynamic> rawEnvelope
});


@override $RuleMetadataCopyWith<$Res> get metadata;@override $RuleGraphCopyWith<$Res> get graph;

}
/// @nodoc
class __$RuleCopyWithImpl<$Res>
    implements _$RuleCopyWith<$Res> {
  __$RuleCopyWithImpl(this._self, this._then);

  final _Rule _self;
  final $Res Function(_Rule) _then;

/// Create a copy of Rule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? irVersion = null,Object? metadata = null,Object? graph = null,Object? normalizedOutputs = null,Object? capabilities = null,Object? rateLimit = freezed,Object? isEnabled = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? rawEnvelope = null,}) {
  return _then(_Rule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,irVersion: null == irVersion ? _self.irVersion : irVersion // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as RuleMetadata,graph: null == graph ? _self.graph : graph // ignore: cast_nullable_to_non_nullable
as RuleGraph,normalizedOutputs: null == normalizedOutputs ? _self._normalizedOutputs : normalizedOutputs // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,capabilities: null == capabilities ? _self._capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,rateLimit: freezed == rateLimit ? _self._rateLimit : rateLimit // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rawEnvelope: null == rawEnvelope ? _self._rawEnvelope : rawEnvelope // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

/// Create a copy of Rule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RuleMetadataCopyWith<$Res> get metadata {
  
  return $RuleMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}/// Create a copy of Rule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RuleGraphCopyWith<$Res> get graph {
  
  return $RuleGraphCopyWith<$Res>(_self.graph, (value) {
    return _then(_self.copyWith(graph: value));
  });
}
}

// dart format on
