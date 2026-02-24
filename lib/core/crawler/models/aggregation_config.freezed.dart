// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'aggregation_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AggregationConfig {

/// 匹配配置。
 MatchingConfig get matching;/// 是否启用聚合。
 bool get enabled;/// 源权重 (0-100，用于自动优选)。
 int get weight;
/// Create a copy of AggregationConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AggregationConfigCopyWith<AggregationConfig> get copyWith => _$AggregationConfigCopyWithImpl<AggregationConfig>(this as AggregationConfig, _$identity);

  /// Serializes this AggregationConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AggregationConfig&&(identical(other.matching, matching) || other.matching == matching)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.weight, weight) || other.weight == weight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matching,enabled,weight);

@override
String toString() {
  return 'AggregationConfig(matching: $matching, enabled: $enabled, weight: $weight)';
}


}

/// @nodoc
abstract mixin class $AggregationConfigCopyWith<$Res>  {
  factory $AggregationConfigCopyWith(AggregationConfig value, $Res Function(AggregationConfig) _then) = _$AggregationConfigCopyWithImpl;
@useResult
$Res call({
 MatchingConfig matching, bool enabled, int weight
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
@pragma('vm:prefer-inline') @override $Res call({Object? matching = null,Object? enabled = null,Object? weight = null,}) {
  return _then(_self.copyWith(
matching: null == matching ? _self.matching : matching // ignore: cast_nullable_to_non_nullable
as MatchingConfig,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MatchingConfig matching,  bool enabled,  int weight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AggregationConfig() when $default != null:
return $default(_that.matching,_that.enabled,_that.weight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MatchingConfig matching,  bool enabled,  int weight)  $default,) {final _that = this;
switch (_that) {
case _AggregationConfig():
return $default(_that.matching,_that.enabled,_that.weight);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MatchingConfig matching,  bool enabled,  int weight)?  $default,) {final _that = this;
switch (_that) {
case _AggregationConfig() when $default != null:
return $default(_that.matching,_that.enabled,_that.weight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AggregationConfig implements AggregationConfig {
  const _AggregationConfig({required this.matching, this.enabled = true, this.weight = 50});
  factory _AggregationConfig.fromJson(Map<String, dynamic> json) => _$AggregationConfigFromJson(json);

/// 匹配配置。
@override final  MatchingConfig matching;
/// 是否启用聚合。
@override@JsonKey() final  bool enabled;
/// 源权重 (0-100，用于自动优选)。
@override@JsonKey() final  int weight;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AggregationConfig&&(identical(other.matching, matching) || other.matching == matching)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.weight, weight) || other.weight == weight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matching,enabled,weight);

@override
String toString() {
  return 'AggregationConfig(matching: $matching, enabled: $enabled, weight: $weight)';
}


}

/// @nodoc
abstract mixin class _$AggregationConfigCopyWith<$Res> implements $AggregationConfigCopyWith<$Res> {
  factory _$AggregationConfigCopyWith(_AggregationConfig value, $Res Function(_AggregationConfig) _then) = __$AggregationConfigCopyWithImpl;
@override @useResult
$Res call({
 MatchingConfig matching, bool enabled, int weight
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
@override @pragma('vm:prefer-inline') $Res call({Object? matching = null,Object? enabled = null,Object? weight = null,}) {
  return _then(_AggregationConfig(
matching: null == matching ? _self.matching : matching // ignore: cast_nullable_to_non_nullable
as MatchingConfig,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,
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
mixin _$MatchingConfig {

/// 匹配策略。
 MatchingStrategy get strategy;/// 匹配维度列表。
 List<MatchingDimension> get dimensions;/// 综合阈值 (0.0-1.0)。
 double get combinedThreshold;
/// Create a copy of MatchingConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchingConfigCopyWith<MatchingConfig> get copyWith => _$MatchingConfigCopyWithImpl<MatchingConfig>(this as MatchingConfig, _$identity);

  /// Serializes this MatchingConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchingConfig&&(identical(other.strategy, strategy) || other.strategy == strategy)&&const DeepCollectionEquality().equals(other.dimensions, dimensions)&&(identical(other.combinedThreshold, combinedThreshold) || other.combinedThreshold == combinedThreshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strategy,const DeepCollectionEquality().hash(dimensions),combinedThreshold);

@override
String toString() {
  return 'MatchingConfig(strategy: $strategy, dimensions: $dimensions, combinedThreshold: $combinedThreshold)';
}


}

/// @nodoc
abstract mixin class $MatchingConfigCopyWith<$Res>  {
  factory $MatchingConfigCopyWith(MatchingConfig value, $Res Function(MatchingConfig) _then) = _$MatchingConfigCopyWithImpl;
@useResult
$Res call({
 MatchingStrategy strategy, List<MatchingDimension> dimensions, double combinedThreshold
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
@pragma('vm:prefer-inline') @override $Res call({Object? strategy = null,Object? dimensions = null,Object? combinedThreshold = null,}) {
  return _then(_self.copyWith(
strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as MatchingStrategy,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as List<MatchingDimension>,combinedThreshold: null == combinedThreshold ? _self.combinedThreshold : combinedThreshold // ignore: cast_nullable_to_non_nullable
as double,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MatchingStrategy strategy,  List<MatchingDimension> dimensions,  double combinedThreshold)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchingConfig() when $default != null:
return $default(_that.strategy,_that.dimensions,_that.combinedThreshold);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MatchingStrategy strategy,  List<MatchingDimension> dimensions,  double combinedThreshold)  $default,) {final _that = this;
switch (_that) {
case _MatchingConfig():
return $default(_that.strategy,_that.dimensions,_that.combinedThreshold);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MatchingStrategy strategy,  List<MatchingDimension> dimensions,  double combinedThreshold)?  $default,) {final _that = this;
switch (_that) {
case _MatchingConfig() when $default != null:
return $default(_that.strategy,_that.dimensions,_that.combinedThreshold);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchingConfig implements MatchingConfig {
  const _MatchingConfig({this.strategy = MatchingStrategy.fuzzy, final  List<MatchingDimension> dimensions = _defaultDimensions, this.combinedThreshold = 0.85}): _dimensions = dimensions;
  factory _MatchingConfig.fromJson(Map<String, dynamic> json) => _$MatchingConfigFromJson(json);

/// 匹配策略。
@override@JsonKey() final  MatchingStrategy strategy;
/// 匹配维度列表。
 final  List<MatchingDimension> _dimensions;
/// 匹配维度列表。
@override@JsonKey() List<MatchingDimension> get dimensions {
  if (_dimensions is EqualUnmodifiableListView) return _dimensions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dimensions);
}

/// 综合阈值 (0.0-1.0)。
@override@JsonKey() final  double combinedThreshold;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchingConfig&&(identical(other.strategy, strategy) || other.strategy == strategy)&&const DeepCollectionEquality().equals(other._dimensions, _dimensions)&&(identical(other.combinedThreshold, combinedThreshold) || other.combinedThreshold == combinedThreshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,strategy,const DeepCollectionEquality().hash(_dimensions),combinedThreshold);

@override
String toString() {
  return 'MatchingConfig(strategy: $strategy, dimensions: $dimensions, combinedThreshold: $combinedThreshold)';
}


}

/// @nodoc
abstract mixin class _$MatchingConfigCopyWith<$Res> implements $MatchingConfigCopyWith<$Res> {
  factory _$MatchingConfigCopyWith(_MatchingConfig value, $Res Function(_MatchingConfig) _then) = __$MatchingConfigCopyWithImpl;
@override @useResult
$Res call({
 MatchingStrategy strategy, List<MatchingDimension> dimensions, double combinedThreshold
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
@override @pragma('vm:prefer-inline') $Res call({Object? strategy = null,Object? dimensions = null,Object? combinedThreshold = null,}) {
  return _then(_MatchingConfig(
strategy: null == strategy ? _self.strategy : strategy // ignore: cast_nullable_to_non_nullable
as MatchingStrategy,dimensions: null == dimensions ? _self._dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as List<MatchingDimension>,combinedThreshold: null == combinedThreshold ? _self.combinedThreshold : combinedThreshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$MatchingDimension {

/// 字段名。
 String get field;/// 匹配类型。
 MatchType get matchType;/// 权重 (0-1)。
 double get weight;/// 相似度阈值 (fuzzy 类型)。
 double get threshold;/// 标准化配置。
 NormalizationConfig? get normalize;
/// Create a copy of MatchingDimension
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchingDimensionCopyWith<MatchingDimension> get copyWith => _$MatchingDimensionCopyWithImpl<MatchingDimension>(this as MatchingDimension, _$identity);

  /// Serializes this MatchingDimension to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchingDimension&&(identical(other.field, field) || other.field == field)&&(identical(other.matchType, matchType) || other.matchType == matchType)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.normalize, normalize) || other.normalize == normalize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,matchType,weight,threshold,normalize);

@override
String toString() {
  return 'MatchingDimension(field: $field, matchType: $matchType, weight: $weight, threshold: $threshold, normalize: $normalize)';
}


}

/// @nodoc
abstract mixin class $MatchingDimensionCopyWith<$Res>  {
  factory $MatchingDimensionCopyWith(MatchingDimension value, $Res Function(MatchingDimension) _then) = _$MatchingDimensionCopyWithImpl;
@useResult
$Res call({
 String field, MatchType matchType, double weight, double threshold, NormalizationConfig? normalize
});


$NormalizationConfigCopyWith<$Res>? get normalize;

}
/// @nodoc
class _$MatchingDimensionCopyWithImpl<$Res>
    implements $MatchingDimensionCopyWith<$Res> {
  _$MatchingDimensionCopyWithImpl(this._self, this._then);

  final MatchingDimension _self;
  final $Res Function(MatchingDimension) _then;

/// Create a copy of MatchingDimension
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field = null,Object? matchType = null,Object? weight = null,Object? threshold = null,Object? normalize = freezed,}) {
  return _then(_self.copyWith(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,matchType: null == matchType ? _self.matchType : matchType // ignore: cast_nullable_to_non_nullable
as MatchType,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as double,normalize: freezed == normalize ? _self.normalize : normalize // ignore: cast_nullable_to_non_nullable
as NormalizationConfig?,
  ));
}
/// Create a copy of MatchingDimension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NormalizationConfigCopyWith<$Res>? get normalize {
    if (_self.normalize == null) {
    return null;
  }

  return $NormalizationConfigCopyWith<$Res>(_self.normalize!, (value) {
    return _then(_self.copyWith(normalize: value));
  });
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String field,  MatchType matchType,  double weight,  double threshold,  NormalizationConfig? normalize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchingDimension() when $default != null:
return $default(_that.field,_that.matchType,_that.weight,_that.threshold,_that.normalize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String field,  MatchType matchType,  double weight,  double threshold,  NormalizationConfig? normalize)  $default,) {final _that = this;
switch (_that) {
case _MatchingDimension():
return $default(_that.field,_that.matchType,_that.weight,_that.threshold,_that.normalize);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String field,  MatchType matchType,  double weight,  double threshold,  NormalizationConfig? normalize)?  $default,) {final _that = this;
switch (_that) {
case _MatchingDimension() when $default != null:
return $default(_that.field,_that.matchType,_that.weight,_that.threshold,_that.normalize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchingDimension implements MatchingDimension {
  const _MatchingDimension({required this.field, this.matchType = MatchType.fuzzy, this.weight = 1.0, this.threshold = 0.96, this.normalize});
  factory _MatchingDimension.fromJson(Map<String, dynamic> json) => _$MatchingDimensionFromJson(json);

/// 字段名。
@override final  String field;
/// 匹配类型。
@override@JsonKey() final  MatchType matchType;
/// 权重 (0-1)。
@override@JsonKey() final  double weight;
/// 相似度阈值 (fuzzy 类型)。
@override@JsonKey() final  double threshold;
/// 标准化配置。
@override final  NormalizationConfig? normalize;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchingDimension&&(identical(other.field, field) || other.field == field)&&(identical(other.matchType, matchType) || other.matchType == matchType)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.threshold, threshold) || other.threshold == threshold)&&(identical(other.normalize, normalize) || other.normalize == normalize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,matchType,weight,threshold,normalize);

@override
String toString() {
  return 'MatchingDimension(field: $field, matchType: $matchType, weight: $weight, threshold: $threshold, normalize: $normalize)';
}


}

/// @nodoc
abstract mixin class _$MatchingDimensionCopyWith<$Res> implements $MatchingDimensionCopyWith<$Res> {
  factory _$MatchingDimensionCopyWith(_MatchingDimension value, $Res Function(_MatchingDimension) _then) = __$MatchingDimensionCopyWithImpl;
@override @useResult
$Res call({
 String field, MatchType matchType, double weight, double threshold, NormalizationConfig? normalize
});


@override $NormalizationConfigCopyWith<$Res>? get normalize;

}
/// @nodoc
class __$MatchingDimensionCopyWithImpl<$Res>
    implements _$MatchingDimensionCopyWith<$Res> {
  __$MatchingDimensionCopyWithImpl(this._self, this._then);

  final _MatchingDimension _self;
  final $Res Function(_MatchingDimension) _then;

/// Create a copy of MatchingDimension
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field = null,Object? matchType = null,Object? weight = null,Object? threshold = null,Object? normalize = freezed,}) {
  return _then(_MatchingDimension(
field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,matchType: null == matchType ? _self.matchType : matchType // ignore: cast_nullable_to_non_nullable
as MatchType,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as double,normalize: freezed == normalize ? _self.normalize : normalize // ignore: cast_nullable_to_non_nullable
as NormalizationConfig?,
  ));
}

/// Create a copy of MatchingDimension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NormalizationConfigCopyWith<$Res>? get normalize {
    if (_self.normalize == null) {
    return null;
  }

  return $NormalizationConfigCopyWith<$Res>(_self.normalize!, (value) {
    return _then(_self.copyWith(normalize: value));
  });
}
}


/// @nodoc
mixin _$NormalizationConfig {

/// 转小写。
 bool get lowercase;/// 去除标点。
 bool get trimPunctuation;/// 去除空白。
 bool get trimWhitespace;/// 繁体转简体。
 bool get traditionalToSimplified;/// 全角转半角。
 bool get fullWidthToHalfWidth;/// 去除元数据模式 (如 "(2024)", "【推荐】")。
 bool get removeMetadata;/// 自定义替换规则。
 List<ReplacementRule>? get replacements;
/// Create a copy of NormalizationConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NormalizationConfigCopyWith<NormalizationConfig> get copyWith => _$NormalizationConfigCopyWithImpl<NormalizationConfig>(this as NormalizationConfig, _$identity);

  /// Serializes this NormalizationConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NormalizationConfig&&(identical(other.lowercase, lowercase) || other.lowercase == lowercase)&&(identical(other.trimPunctuation, trimPunctuation) || other.trimPunctuation == trimPunctuation)&&(identical(other.trimWhitespace, trimWhitespace) || other.trimWhitespace == trimWhitespace)&&(identical(other.traditionalToSimplified, traditionalToSimplified) || other.traditionalToSimplified == traditionalToSimplified)&&(identical(other.fullWidthToHalfWidth, fullWidthToHalfWidth) || other.fullWidthToHalfWidth == fullWidthToHalfWidth)&&(identical(other.removeMetadata, removeMetadata) || other.removeMetadata == removeMetadata)&&const DeepCollectionEquality().equals(other.replacements, replacements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lowercase,trimPunctuation,trimWhitespace,traditionalToSimplified,fullWidthToHalfWidth,removeMetadata,const DeepCollectionEquality().hash(replacements));

@override
String toString() {
  return 'NormalizationConfig(lowercase: $lowercase, trimPunctuation: $trimPunctuation, trimWhitespace: $trimWhitespace, traditionalToSimplified: $traditionalToSimplified, fullWidthToHalfWidth: $fullWidthToHalfWidth, removeMetadata: $removeMetadata, replacements: $replacements)';
}


}

/// @nodoc
abstract mixin class $NormalizationConfigCopyWith<$Res>  {
  factory $NormalizationConfigCopyWith(NormalizationConfig value, $Res Function(NormalizationConfig) _then) = _$NormalizationConfigCopyWithImpl;
@useResult
$Res call({
 bool lowercase, bool trimPunctuation, bool trimWhitespace, bool traditionalToSimplified, bool fullWidthToHalfWidth, bool removeMetadata, List<ReplacementRule>? replacements
});




}
/// @nodoc
class _$NormalizationConfigCopyWithImpl<$Res>
    implements $NormalizationConfigCopyWith<$Res> {
  _$NormalizationConfigCopyWithImpl(this._self, this._then);

  final NormalizationConfig _self;
  final $Res Function(NormalizationConfig) _then;

/// Create a copy of NormalizationConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lowercase = null,Object? trimPunctuation = null,Object? trimWhitespace = null,Object? traditionalToSimplified = null,Object? fullWidthToHalfWidth = null,Object? removeMetadata = null,Object? replacements = freezed,}) {
  return _then(_self.copyWith(
lowercase: null == lowercase ? _self.lowercase : lowercase // ignore: cast_nullable_to_non_nullable
as bool,trimPunctuation: null == trimPunctuation ? _self.trimPunctuation : trimPunctuation // ignore: cast_nullable_to_non_nullable
as bool,trimWhitespace: null == trimWhitespace ? _self.trimWhitespace : trimWhitespace // ignore: cast_nullable_to_non_nullable
as bool,traditionalToSimplified: null == traditionalToSimplified ? _self.traditionalToSimplified : traditionalToSimplified // ignore: cast_nullable_to_non_nullable
as bool,fullWidthToHalfWidth: null == fullWidthToHalfWidth ? _self.fullWidthToHalfWidth : fullWidthToHalfWidth // ignore: cast_nullable_to_non_nullable
as bool,removeMetadata: null == removeMetadata ? _self.removeMetadata : removeMetadata // ignore: cast_nullable_to_non_nullable
as bool,replacements: freezed == replacements ? _self.replacements : replacements // ignore: cast_nullable_to_non_nullable
as List<ReplacementRule>?,
  ));
}

}


/// Adds pattern-matching-related methods to [NormalizationConfig].
extension NormalizationConfigPatterns on NormalizationConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NormalizationConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NormalizationConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NormalizationConfig value)  $default,){
final _that = this;
switch (_that) {
case _NormalizationConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NormalizationConfig value)?  $default,){
final _that = this;
switch (_that) {
case _NormalizationConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool lowercase,  bool trimPunctuation,  bool trimWhitespace,  bool traditionalToSimplified,  bool fullWidthToHalfWidth,  bool removeMetadata,  List<ReplacementRule>? replacements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NormalizationConfig() when $default != null:
return $default(_that.lowercase,_that.trimPunctuation,_that.trimWhitespace,_that.traditionalToSimplified,_that.fullWidthToHalfWidth,_that.removeMetadata,_that.replacements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool lowercase,  bool trimPunctuation,  bool trimWhitespace,  bool traditionalToSimplified,  bool fullWidthToHalfWidth,  bool removeMetadata,  List<ReplacementRule>? replacements)  $default,) {final _that = this;
switch (_that) {
case _NormalizationConfig():
return $default(_that.lowercase,_that.trimPunctuation,_that.trimWhitespace,_that.traditionalToSimplified,_that.fullWidthToHalfWidth,_that.removeMetadata,_that.replacements);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool lowercase,  bool trimPunctuation,  bool trimWhitespace,  bool traditionalToSimplified,  bool fullWidthToHalfWidth,  bool removeMetadata,  List<ReplacementRule>? replacements)?  $default,) {final _that = this;
switch (_that) {
case _NormalizationConfig() when $default != null:
return $default(_that.lowercase,_that.trimPunctuation,_that.trimWhitespace,_that.traditionalToSimplified,_that.fullWidthToHalfWidth,_that.removeMetadata,_that.replacements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NormalizationConfig implements NormalizationConfig {
  const _NormalizationConfig({this.lowercase = true, this.trimPunctuation = true, this.trimWhitespace = true, this.traditionalToSimplified = true, this.fullWidthToHalfWidth = true, this.removeMetadata = true, final  List<ReplacementRule>? replacements}): _replacements = replacements;
  factory _NormalizationConfig.fromJson(Map<String, dynamic> json) => _$NormalizationConfigFromJson(json);

/// 转小写。
@override@JsonKey() final  bool lowercase;
/// 去除标点。
@override@JsonKey() final  bool trimPunctuation;
/// 去除空白。
@override@JsonKey() final  bool trimWhitespace;
/// 繁体转简体。
@override@JsonKey() final  bool traditionalToSimplified;
/// 全角转半角。
@override@JsonKey() final  bool fullWidthToHalfWidth;
/// 去除元数据模式 (如 "(2024)", "【推荐】")。
@override@JsonKey() final  bool removeMetadata;
/// 自定义替换规则。
 final  List<ReplacementRule>? _replacements;
/// 自定义替换规则。
@override List<ReplacementRule>? get replacements {
  final value = _replacements;
  if (value == null) return null;
  if (_replacements is EqualUnmodifiableListView) return _replacements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of NormalizationConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NormalizationConfigCopyWith<_NormalizationConfig> get copyWith => __$NormalizationConfigCopyWithImpl<_NormalizationConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NormalizationConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NormalizationConfig&&(identical(other.lowercase, lowercase) || other.lowercase == lowercase)&&(identical(other.trimPunctuation, trimPunctuation) || other.trimPunctuation == trimPunctuation)&&(identical(other.trimWhitespace, trimWhitespace) || other.trimWhitespace == trimWhitespace)&&(identical(other.traditionalToSimplified, traditionalToSimplified) || other.traditionalToSimplified == traditionalToSimplified)&&(identical(other.fullWidthToHalfWidth, fullWidthToHalfWidth) || other.fullWidthToHalfWidth == fullWidthToHalfWidth)&&(identical(other.removeMetadata, removeMetadata) || other.removeMetadata == removeMetadata)&&const DeepCollectionEquality().equals(other._replacements, _replacements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lowercase,trimPunctuation,trimWhitespace,traditionalToSimplified,fullWidthToHalfWidth,removeMetadata,const DeepCollectionEquality().hash(_replacements));

@override
String toString() {
  return 'NormalizationConfig(lowercase: $lowercase, trimPunctuation: $trimPunctuation, trimWhitespace: $trimWhitespace, traditionalToSimplified: $traditionalToSimplified, fullWidthToHalfWidth: $fullWidthToHalfWidth, removeMetadata: $removeMetadata, replacements: $replacements)';
}


}

/// @nodoc
abstract mixin class _$NormalizationConfigCopyWith<$Res> implements $NormalizationConfigCopyWith<$Res> {
  factory _$NormalizationConfigCopyWith(_NormalizationConfig value, $Res Function(_NormalizationConfig) _then) = __$NormalizationConfigCopyWithImpl;
@override @useResult
$Res call({
 bool lowercase, bool trimPunctuation, bool trimWhitespace, bool traditionalToSimplified, bool fullWidthToHalfWidth, bool removeMetadata, List<ReplacementRule>? replacements
});




}
/// @nodoc
class __$NormalizationConfigCopyWithImpl<$Res>
    implements _$NormalizationConfigCopyWith<$Res> {
  __$NormalizationConfigCopyWithImpl(this._self, this._then);

  final _NormalizationConfig _self;
  final $Res Function(_NormalizationConfig) _then;

/// Create a copy of NormalizationConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lowercase = null,Object? trimPunctuation = null,Object? trimWhitespace = null,Object? traditionalToSimplified = null,Object? fullWidthToHalfWidth = null,Object? removeMetadata = null,Object? replacements = freezed,}) {
  return _then(_NormalizationConfig(
lowercase: null == lowercase ? _self.lowercase : lowercase // ignore: cast_nullable_to_non_nullable
as bool,trimPunctuation: null == trimPunctuation ? _self.trimPunctuation : trimPunctuation // ignore: cast_nullable_to_non_nullable
as bool,trimWhitespace: null == trimWhitespace ? _self.trimWhitespace : trimWhitespace // ignore: cast_nullable_to_non_nullable
as bool,traditionalToSimplified: null == traditionalToSimplified ? _self.traditionalToSimplified : traditionalToSimplified // ignore: cast_nullable_to_non_nullable
as bool,fullWidthToHalfWidth: null == fullWidthToHalfWidth ? _self.fullWidthToHalfWidth : fullWidthToHalfWidth // ignore: cast_nullable_to_non_nullable
as bool,removeMetadata: null == removeMetadata ? _self.removeMetadata : removeMetadata // ignore: cast_nullable_to_non_nullable
as bool,replacements: freezed == replacements ? _self._replacements : replacements // ignore: cast_nullable_to_non_nullable
as List<ReplacementRule>?,
  ));
}


}


/// @nodoc
mixin _$ReplacementRule {

/// 正则模式。
 String get pattern;/// 替换字符串。
 String get replacement;
/// Create a copy of ReplacementRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplacementRuleCopyWith<ReplacementRule> get copyWith => _$ReplacementRuleCopyWithImpl<ReplacementRule>(this as ReplacementRule, _$identity);

  /// Serializes this ReplacementRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplacementRule&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.replacement, replacement) || other.replacement == replacement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pattern,replacement);

@override
String toString() {
  return 'ReplacementRule(pattern: $pattern, replacement: $replacement)';
}


}

/// @nodoc
abstract mixin class $ReplacementRuleCopyWith<$Res>  {
  factory $ReplacementRuleCopyWith(ReplacementRule value, $Res Function(ReplacementRule) _then) = _$ReplacementRuleCopyWithImpl;
@useResult
$Res call({
 String pattern, String replacement
});




}
/// @nodoc
class _$ReplacementRuleCopyWithImpl<$Res>
    implements $ReplacementRuleCopyWith<$Res> {
  _$ReplacementRuleCopyWithImpl(this._self, this._then);

  final ReplacementRule _self;
  final $Res Function(ReplacementRule) _then;

/// Create a copy of ReplacementRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pattern = null,Object? replacement = null,}) {
  return _then(_self.copyWith(
pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,replacement: null == replacement ? _self.replacement : replacement // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReplacementRule].
extension ReplacementRulePatterns on ReplacementRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReplacementRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReplacementRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReplacementRule value)  $default,){
final _that = this;
switch (_that) {
case _ReplacementRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReplacementRule value)?  $default,){
final _that = this;
switch (_that) {
case _ReplacementRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String pattern,  String replacement)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReplacementRule() when $default != null:
return $default(_that.pattern,_that.replacement);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String pattern,  String replacement)  $default,) {final _that = this;
switch (_that) {
case _ReplacementRule():
return $default(_that.pattern,_that.replacement);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String pattern,  String replacement)?  $default,) {final _that = this;
switch (_that) {
case _ReplacementRule() when $default != null:
return $default(_that.pattern,_that.replacement);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReplacementRule implements ReplacementRule {
  const _ReplacementRule({required this.pattern, this.replacement = ''});
  factory _ReplacementRule.fromJson(Map<String, dynamic> json) => _$ReplacementRuleFromJson(json);

/// 正则模式。
@override final  String pattern;
/// 替换字符串。
@override@JsonKey() final  String replacement;

/// Create a copy of ReplacementRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplacementRuleCopyWith<_ReplacementRule> get copyWith => __$ReplacementRuleCopyWithImpl<_ReplacementRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReplacementRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplacementRule&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.replacement, replacement) || other.replacement == replacement));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pattern,replacement);

@override
String toString() {
  return 'ReplacementRule(pattern: $pattern, replacement: $replacement)';
}


}

/// @nodoc
abstract mixin class _$ReplacementRuleCopyWith<$Res> implements $ReplacementRuleCopyWith<$Res> {
  factory _$ReplacementRuleCopyWith(_ReplacementRule value, $Res Function(_ReplacementRule) _then) = __$ReplacementRuleCopyWithImpl;
@override @useResult
$Res call({
 String pattern, String replacement
});




}
/// @nodoc
class __$ReplacementRuleCopyWithImpl<$Res>
    implements _$ReplacementRuleCopyWith<$Res> {
  __$ReplacementRuleCopyWithImpl(this._self, this._then);

  final _ReplacementRule _self;
  final $Res Function(_ReplacementRule) _then;

/// Create a copy of ReplacementRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pattern = null,Object? replacement = null,}) {
  return _then(_ReplacementRule(
pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,replacement: null == replacement ? _self.replacement : replacement // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
