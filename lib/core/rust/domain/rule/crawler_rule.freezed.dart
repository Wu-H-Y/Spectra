// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crawler_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AggregationConfig {

 bool get enabled; int get weight; MatchingConfig get matching;
/// Create a copy of AggregationConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AggregationConfigCopyWith<AggregationConfig> get copyWith => _$AggregationConfigCopyWithImpl<AggregationConfig>(this as AggregationConfig, _$identity);

  /// Serializes this AggregationConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AggregationConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.matching, matching) || other.matching == matching));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,weight,matching);

@override
String toString() {
  return 'AggregationConfig(enabled: $enabled, weight: $weight, matching: $matching)';
}


}

/// @nodoc
abstract mixin class $AggregationConfigCopyWith<$Res>  {
  factory $AggregationConfigCopyWith(AggregationConfig value, $Res Function(AggregationConfig) _then) = _$AggregationConfigCopyWithImpl;
@useResult
$Res call({
 bool enabled, int weight, MatchingConfig matching
});


$MatchingConfigCopyWith<$Res> get matching;

}
/// @nodoc
class _$AggregationConfigCopyWithImpl<$Res>
    implements $AggregationConfigCopyWith<$Res> {
  _$AggregationConfigCopyWithImpl(this._self, this._then);

  final AggregationConfig _self;
  final $Res Function(AggregationConfig) _then;

/// Create a copy of AggregationConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? weight = null,Object? matching = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,matching: null == matching ? _self.matching : matching // ignore: cast_nullable_to_non_nullable
as MatchingConfig,
  ));
}
/// Create a copy of AggregationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchingConfigCopyWith<$Res> get matching {
  
  return $MatchingConfigCopyWith<$Res>(_self.matching, (value) {
    return _then(_self.copyWith(matching: value));
  });
}
}


/// Adds pattern-matching-related methods to [AggregationConfig].
extension AggregationConfigPatterns on AggregationConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AggregationConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AggregationConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AggregationConfig value)  $default,){
final _that = this;
switch (_that) {
case _AggregationConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AggregationConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AggregationConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  int weight,  MatchingConfig matching)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AggregationConfig() when $default != null:
return $default(_that.enabled,_that.weight,_that.matching);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  int weight,  MatchingConfig matching)  $default,) {final _that = this;
switch (_that) {
case _AggregationConfig():
return $default(_that.enabled,_that.weight,_that.matching);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  int weight,  MatchingConfig matching)?  $default,) {final _that = this;
switch (_that) {
case _AggregationConfig() when $default != null:
return $default(_that.enabled,_that.weight,_that.matching);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AggregationConfig implements AggregationConfig {
  const _AggregationConfig({required this.enabled, required this.weight, required this.matching});
  factory _AggregationConfig.fromJson(Map<String, dynamic> json) => _$AggregationConfigFromJson(json);

@override final  bool enabled;
@override final  int weight;
@override final  MatchingConfig matching;

/// Create a copy of AggregationConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AggregationConfigCopyWith<_AggregationConfig> get copyWith => __$AggregationConfigCopyWithImpl<_AggregationConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AggregationConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AggregationConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.matching, matching) || other.matching == matching));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,weight,matching);

@override
String toString() {
  return 'AggregationConfig(enabled: $enabled, weight: $weight, matching: $matching)';
}


}

/// @nodoc
abstract mixin class _$AggregationConfigCopyWith<$Res> implements $AggregationConfigCopyWith<$Res> {
  factory _$AggregationConfigCopyWith(_AggregationConfig value, $Res Function(_AggregationConfig) _then) = __$AggregationConfigCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, int weight, MatchingConfig matching
});


@override $MatchingConfigCopyWith<$Res> get matching;

}
/// @nodoc
class __$AggregationConfigCopyWithImpl<$Res>
    implements _$AggregationConfigCopyWith<$Res> {
  __$AggregationConfigCopyWithImpl(this._self, this._then);

  final _AggregationConfig _self;
  final $Res Function(_AggregationConfig) _then;

/// Create a copy of AggregationConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? weight = null,Object? matching = null,}) {
  return _then(_AggregationConfig(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,matching: null == matching ? _self.matching : matching // ignore: cast_nullable_to_non_nullable
as MatchingConfig,
  ));
}

/// Create a copy of AggregationConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchingConfigCopyWith<$Res> get matching {
  
  return $MatchingConfigCopyWith<$Res>(_self.matching, (value) {
    return _then(_self.copyWith(matching: value));
  });
}
}


/// @nodoc
mixin _$CrawlerRule {

 String get id; String get name; String get description; String get author; String get version; NetworkConfig? get network; AggregationConfig? get aggregation; Lifecycle get lifecycle;
/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerRuleCopyWith<CrawlerRule> get copyWith => _$CrawlerRuleCopyWithImpl<CrawlerRule>(this as CrawlerRule, _$identity);

  /// Serializes this CrawlerRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerRule&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&(identical(other.version, version) || other.version == version)&&(identical(other.network, network) || other.network == network)&&(identical(other.aggregation, aggregation) || other.aggregation == aggregation)&&(identical(other.lifecycle, lifecycle) || other.lifecycle == lifecycle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,author,version,network,aggregation,lifecycle);

@override
String toString() {
  return 'CrawlerRule(id: $id, name: $name, description: $description, author: $author, version: $version, network: $network, aggregation: $aggregation, lifecycle: $lifecycle)';
}


}

/// @nodoc
abstract mixin class $CrawlerRuleCopyWith<$Res>  {
  factory $CrawlerRuleCopyWith(CrawlerRule value, $Res Function(CrawlerRule) _then) = _$CrawlerRuleCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String author, String version, NetworkConfig? network, AggregationConfig? aggregation, Lifecycle lifecycle
});


$NetworkConfigCopyWith<$Res>? get network;$AggregationConfigCopyWith<$Res>? get aggregation;$LifecycleCopyWith<$Res> get lifecycle;

}
/// @nodoc
class _$CrawlerRuleCopyWithImpl<$Res>
    implements $CrawlerRuleCopyWith<$Res> {
  _$CrawlerRuleCopyWithImpl(this._self, this._then);

  final CrawlerRule _self;
  final $Res Function(CrawlerRule) _then;

/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? author = null,Object? version = null,Object? network = freezed,Object? aggregation = freezed,Object? lifecycle = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as NetworkConfig?,aggregation: freezed == aggregation ? _self.aggregation : aggregation // ignore: cast_nullable_to_non_nullable
as AggregationConfig?,lifecycle: null == lifecycle ? _self.lifecycle : lifecycle // ignore: cast_nullable_to_non_nullable
as Lifecycle,
  ));
}
/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkConfigCopyWith<$Res>? get network {
    if (_self.network == null) {
    return null;
  }

  return $NetworkConfigCopyWith<$Res>(_self.network!, (value) {
    return _then(_self.copyWith(network: value));
  });
}/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AggregationConfigCopyWith<$Res>? get aggregation {
    if (_self.aggregation == null) {
    return null;
  }

  return $AggregationConfigCopyWith<$Res>(_self.aggregation!, (value) {
    return _then(_self.copyWith(aggregation: value));
  });
}/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LifecycleCopyWith<$Res> get lifecycle {
  
  return $LifecycleCopyWith<$Res>(_self.lifecycle, (value) {
    return _then(_self.copyWith(lifecycle: value));
  });
}
}


/// Adds pattern-matching-related methods to [CrawlerRule].
extension CrawlerRulePatterns on CrawlerRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrawlerRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrawlerRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrawlerRule value)  $default,){
final _that = this;
switch (_that) {
case _CrawlerRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrawlerRule value)?  $default,){
final _that = this;
switch (_that) {
case _CrawlerRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String author,  String version,  NetworkConfig? network,  AggregationConfig? aggregation,  Lifecycle lifecycle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrawlerRule() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.author,_that.version,_that.network,_that.aggregation,_that.lifecycle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String author,  String version,  NetworkConfig? network,  AggregationConfig? aggregation,  Lifecycle lifecycle)  $default,) {final _that = this;
switch (_that) {
case _CrawlerRule():
return $default(_that.id,_that.name,_that.description,_that.author,_that.version,_that.network,_that.aggregation,_that.lifecycle);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String author,  String version,  NetworkConfig? network,  AggregationConfig? aggregation,  Lifecycle lifecycle)?  $default,) {final _that = this;
switch (_that) {
case _CrawlerRule() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.author,_that.version,_that.network,_that.aggregation,_that.lifecycle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CrawlerRule implements CrawlerRule {
  const _CrawlerRule({required this.id, required this.name, required this.description, required this.author, required this.version, this.network, this.aggregation, required this.lifecycle});
  factory _CrawlerRule.fromJson(Map<String, dynamic> json) => _$CrawlerRuleFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String author;
@override final  String version;
@override final  NetworkConfig? network;
@override final  AggregationConfig? aggregation;
@override final  Lifecycle lifecycle;

/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrawlerRuleCopyWith<_CrawlerRule> get copyWith => __$CrawlerRuleCopyWithImpl<_CrawlerRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CrawlerRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrawlerRule&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&(identical(other.version, version) || other.version == version)&&(identical(other.network, network) || other.network == network)&&(identical(other.aggregation, aggregation) || other.aggregation == aggregation)&&(identical(other.lifecycle, lifecycle) || other.lifecycle == lifecycle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,author,version,network,aggregation,lifecycle);

@override
String toString() {
  return 'CrawlerRule(id: $id, name: $name, description: $description, author: $author, version: $version, network: $network, aggregation: $aggregation, lifecycle: $lifecycle)';
}


}

/// @nodoc
abstract mixin class _$CrawlerRuleCopyWith<$Res> implements $CrawlerRuleCopyWith<$Res> {
  factory _$CrawlerRuleCopyWith(_CrawlerRule value, $Res Function(_CrawlerRule) _then) = __$CrawlerRuleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String author, String version, NetworkConfig? network, AggregationConfig? aggregation, Lifecycle lifecycle
});


@override $NetworkConfigCopyWith<$Res>? get network;@override $AggregationConfigCopyWith<$Res>? get aggregation;@override $LifecycleCopyWith<$Res> get lifecycle;

}
/// @nodoc
class __$CrawlerRuleCopyWithImpl<$Res>
    implements _$CrawlerRuleCopyWith<$Res> {
  __$CrawlerRuleCopyWithImpl(this._self, this._then);

  final _CrawlerRule _self;
  final $Res Function(_CrawlerRule) _then;

/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? author = null,Object? version = null,Object? network = freezed,Object? aggregation = freezed,Object? lifecycle = null,}) {
  return _then(_CrawlerRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as NetworkConfig?,aggregation: freezed == aggregation ? _self.aggregation : aggregation // ignore: cast_nullable_to_non_nullable
as AggregationConfig?,lifecycle: null == lifecycle ? _self.lifecycle : lifecycle // ignore: cast_nullable_to_non_nullable
as Lifecycle,
  ));
}

/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkConfigCopyWith<$Res>? get network {
    if (_self.network == null) {
    return null;
  }

  return $NetworkConfigCopyWith<$Res>(_self.network!, (value) {
    return _then(_self.copyWith(network: value));
  });
}/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AggregationConfigCopyWith<$Res>? get aggregation {
    if (_self.aggregation == null) {
    return null;
  }

  return $AggregationConfigCopyWith<$Res>(_self.aggregation!, (value) {
    return _then(_self.copyWith(aggregation: value));
  });
}/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LifecycleCopyWith<$Res> get lifecycle {
  
  return $LifecycleCopyWith<$Res>(_self.lifecycle, (value) {
    return _then(_self.copyWith(lifecycle: value));
  });
}
}


/// @nodoc
mixin _$MatchingConfig {

 String get strategy; List<MatchingDimension> get dimensions;
/// Create a copy of MatchingConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchingConfigCopyWith<MatchingConfig> get copyWith => _$MatchingConfigCopyWithImpl<MatchingConfig>(this as MatchingConfig, _$identity);

  /// Serializes this MatchingConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchingConfig&&(identical(other.strategy, strategy) || other.strategy == strategy)&&const DeepCollectionEquality().equals(other.dimensions, dimensions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strategy,const DeepCollectionEquality().hash(dimensions));

@override
String toString() {
  return 'MatchingConfig(strategy: $strategy, dimensions: $dimensions)';
}


}

/// @nodoc
abstract mixin class $MatchingConfigCopyWith<$Res>  {
  factory $MatchingConfigCopyWith(MatchingConfig value, $Res Function(MatchingConfig) _then) = _$MatchingConfigCopyWithImpl;
@useResult
$Res call({
 String strategy, List<MatchingDimension> dimensions
});




}
/// @nodoc
class _$MatchingConfigCopyWithImpl<$Res>
    implements $MatchingConfigCopyWith<$Res> {
  _$MatchingConfigCopyWithImpl(this._self, this._then);

  final MatchingConfig _self;
  final $Res Function(MatchingConfig) _then;

/// Create a copy of MatchingConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? strategy = null,Object? dimensions = null,}) {
  return _then(_self.copyWith(
strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as String,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as List<MatchingDimension>,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchingConfig].
extension MatchingConfigPatterns on MatchingConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchingConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchingConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchingConfig value)  $default,){
final _that = this;
switch (_that) {
case _MatchingConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchingConfig value)?  $default,){
final _that = this;
switch (_that) {
case _MatchingConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String strategy,  List<MatchingDimension> dimensions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchingConfig() when $default != null:
return $default(_that.strategy,_that.dimensions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String strategy,  List<MatchingDimension> dimensions)  $default,) {final _that = this;
switch (_that) {
case _MatchingConfig():
return $default(_that.strategy,_that.dimensions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String strategy,  List<MatchingDimension> dimensions)?  $default,) {final _that = this;
switch (_that) {
case _MatchingConfig() when $default != null:
return $default(_that.strategy,_that.dimensions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchingConfig implements MatchingConfig {
  const _MatchingConfig({required this.strategy, required final  List<MatchingDimension> dimensions}): _dimensions = dimensions;
  factory _MatchingConfig.fromJson(Map<String, dynamic> json) => _$MatchingConfigFromJson(json);

@override final  String strategy;
 final  List<MatchingDimension> _dimensions;
@override List<MatchingDimension> get dimensions {
  if (_dimensions is EqualUnmodifiableListView) return _dimensions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dimensions);
}


/// Create a copy of MatchingConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchingConfigCopyWith<_MatchingConfig> get copyWith => __$MatchingConfigCopyWithImpl<_MatchingConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchingConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchingConfig&&(identical(other.strategy, strategy) || other.strategy == strategy)&&const DeepCollectionEquality().equals(other._dimensions, _dimensions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strategy,const DeepCollectionEquality().hash(_dimensions));

@override
String toString() {
  return 'MatchingConfig(strategy: $strategy, dimensions: $dimensions)';
}


}

/// @nodoc
abstract mixin class _$MatchingConfigCopyWith<$Res> implements $MatchingConfigCopyWith<$Res> {
  factory _$MatchingConfigCopyWith(_MatchingConfig value, $Res Function(_MatchingConfig) _then) = __$MatchingConfigCopyWithImpl;
@override @useResult
$Res call({
 String strategy, List<MatchingDimension> dimensions
});




}
/// @nodoc
class __$MatchingConfigCopyWithImpl<$Res>
    implements _$MatchingConfigCopyWith<$Res> {
  __$MatchingConfigCopyWithImpl(this._self, this._then);

  final _MatchingConfig _self;
  final $Res Function(_MatchingConfig) _then;

/// Create a copy of MatchingConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? strategy = null,Object? dimensions = null,}) {
  return _then(_MatchingConfig(
strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as String,dimensions: null == dimensions ? _self._dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as List<MatchingDimension>,
  ));
}


}


/// @nodoc
mixin _$MatchingDimension {

 String get field; String get matchType; double get threshold;
/// Create a copy of MatchingDimension
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchingDimensionCopyWith<MatchingDimension> get copyWith => _$MatchingDimensionCopyWithImpl<MatchingDimension>(this as MatchingDimension, _$identity);

  /// Serializes this MatchingDimension to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchingDimension&&(identical(other.field, field) || other.field == field)&&(identical(other.matchType, matchType) || other.matchType == matchType)&&(identical(other.threshold, threshold) || other.threshold == threshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,matchType,threshold);

@override
String toString() {
  return 'MatchingDimension(field: $field, matchType: $matchType, threshold: $threshold)';
}


}

/// @nodoc
abstract mixin class $MatchingDimensionCopyWith<$Res>  {
  factory $MatchingDimensionCopyWith(MatchingDimension value, $Res Function(MatchingDimension) _then) = _$MatchingDimensionCopyWithImpl;
@useResult
$Res call({
 String field, String matchType, double threshold
});




}
/// @nodoc
class _$MatchingDimensionCopyWithImpl<$Res>
    implements $MatchingDimensionCopyWith<$Res> {
  _$MatchingDimensionCopyWithImpl(this._self, this._then);

  final MatchingDimension _self;
  final $Res Function(MatchingDimension) _then;

/// Create a copy of MatchingDimension
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field = null,Object? matchType = null,Object? threshold = null,}) {
  return _then(_self.copyWith(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,matchType: null == matchType ? _self.matchType : matchType // ignore: cast_nullable_to_non_nullable
as String,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchingDimension].
extension MatchingDimensionPatterns on MatchingDimension {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchingDimension value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchingDimension() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchingDimension value)  $default,){
final _that = this;
switch (_that) {
case _MatchingDimension():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchingDimension value)?  $default,){
final _that = this;
switch (_that) {
case _MatchingDimension() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String field,  String matchType,  double threshold)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchingDimension() when $default != null:
return $default(_that.field,_that.matchType,_that.threshold);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String field,  String matchType,  double threshold)  $default,) {final _that = this;
switch (_that) {
case _MatchingDimension():
return $default(_that.field,_that.matchType,_that.threshold);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String field,  String matchType,  double threshold)?  $default,) {final _that = this;
switch (_that) {
case _MatchingDimension() when $default != null:
return $default(_that.field,_that.matchType,_that.threshold);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchingDimension implements MatchingDimension {
  const _MatchingDimension({required this.field, required this.matchType, required this.threshold});
  factory _MatchingDimension.fromJson(Map<String, dynamic> json) => _$MatchingDimensionFromJson(json);

@override final  String field;
@override final  String matchType;
@override final  double threshold;

/// Create a copy of MatchingDimension
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchingDimensionCopyWith<_MatchingDimension> get copyWith => __$MatchingDimensionCopyWithImpl<_MatchingDimension>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchingDimensionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchingDimension&&(identical(other.field, field) || other.field == field)&&(identical(other.matchType, matchType) || other.matchType == matchType)&&(identical(other.threshold, threshold) || other.threshold == threshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,matchType,threshold);

@override
String toString() {
  return 'MatchingDimension(field: $field, matchType: $matchType, threshold: $threshold)';
}


}

/// @nodoc
abstract mixin class _$MatchingDimensionCopyWith<$Res> implements $MatchingDimensionCopyWith<$Res> {
  factory _$MatchingDimensionCopyWith(_MatchingDimension value, $Res Function(_MatchingDimension) _then) = __$MatchingDimensionCopyWithImpl;
@override @useResult
$Res call({
 String field, String matchType, double threshold
});




}
/// @nodoc
class __$MatchingDimensionCopyWithImpl<$Res>
    implements _$MatchingDimensionCopyWith<$Res> {
  __$MatchingDimensionCopyWithImpl(this._self, this._then);

  final _MatchingDimension _self;
  final $Res Function(_MatchingDimension) _then;

/// Create a copy of MatchingDimension
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field = null,Object? matchType = null,Object? threshold = null,}) {
  return _then(_MatchingDimension(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,matchType: null == matchType ? _self.matchType : matchType // ignore: cast_nullable_to_non_nullable
as String,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
