// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rule_graph.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RuleGraph {

 List<Map<String, dynamic>> get nodes; List<Map<String, dynamic>> get edges; Map<String, dynamic> get phaseEntrypoints;
/// Create a copy of RuleGraph
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RuleGraphCopyWith<RuleGraph> get copyWith => _$RuleGraphCopyWithImpl<RuleGraph>(this as RuleGraph, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuleGraph&&const DeepCollectionEquality().equals(other.nodes, nodes)&&const DeepCollectionEquality().equals(other.edges, edges)&&const DeepCollectionEquality().equals(other.phaseEntrypoints, phaseEntrypoints));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(nodes),const DeepCollectionEquality().hash(edges),const DeepCollectionEquality().hash(phaseEntrypoints));

@override
String toString() {
  return 'RuleGraph(nodes: $nodes, edges: $edges, phaseEntrypoints: $phaseEntrypoints)';
}


}

/// @nodoc
abstract mixin class $RuleGraphCopyWith<$Res>  {
  factory $RuleGraphCopyWith(RuleGraph value, $Res Function(RuleGraph) _then) = _$RuleGraphCopyWithImpl;
@useResult
$Res call({
 List<Map<String, dynamic>> nodes, List<Map<String, dynamic>> edges, Map<String, dynamic> phaseEntrypoints
});




}
/// @nodoc
class _$RuleGraphCopyWithImpl<$Res>
    implements $RuleGraphCopyWith<$Res> {
  _$RuleGraphCopyWithImpl(this._self, this._then);

  final RuleGraph _self;
  final $Res Function(RuleGraph) _then;

/// Create a copy of RuleGraph
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nodes = null,Object? edges = null,Object? phaseEntrypoints = null,}) {
  return _then(_self.copyWith(
nodes: null == nodes ? _self.nodes : nodes // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,edges: null == edges ? _self.edges : edges // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,phaseEntrypoints: null == phaseEntrypoints ? _self.phaseEntrypoints : phaseEntrypoints // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [RuleGraph].
extension RuleGraphPatterns on RuleGraph {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RuleGraph value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RuleGraph() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RuleGraph value)  $default,){
final _that = this;
switch (_that) {
case _RuleGraph():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RuleGraph value)?  $default,){
final _that = this;
switch (_that) {
case _RuleGraph() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Map<String, dynamic>> nodes,  List<Map<String, dynamic>> edges,  Map<String, dynamic> phaseEntrypoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RuleGraph() when $default != null:
return $default(_that.nodes,_that.edges,_that.phaseEntrypoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Map<String, dynamic>> nodes,  List<Map<String, dynamic>> edges,  Map<String, dynamic> phaseEntrypoints)  $default,) {final _that = this;
switch (_that) {
case _RuleGraph():
return $default(_that.nodes,_that.edges,_that.phaseEntrypoints);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Map<String, dynamic>> nodes,  List<Map<String, dynamic>> edges,  Map<String, dynamic> phaseEntrypoints)?  $default,) {final _that = this;
switch (_that) {
case _RuleGraph() when $default != null:
return $default(_that.nodes,_that.edges,_that.phaseEntrypoints);case _:
  return null;

}
}

}

/// @nodoc


class _RuleGraph extends RuleGraph {
  const _RuleGraph({required final  List<Map<String, dynamic>> nodes, required final  List<Map<String, dynamic>> edges, required final  Map<String, dynamic> phaseEntrypoints}): _nodes = nodes,_edges = edges,_phaseEntrypoints = phaseEntrypoints,super._();
  

 final  List<Map<String, dynamic>> _nodes;
@override List<Map<String, dynamic>> get nodes {
  if (_nodes is EqualUnmodifiableListView) return _nodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nodes);
}

 final  List<Map<String, dynamic>> _edges;
@override List<Map<String, dynamic>> get edges {
  if (_edges is EqualUnmodifiableListView) return _edges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_edges);
}

 final  Map<String, dynamic> _phaseEntrypoints;
@override Map<String, dynamic> get phaseEntrypoints {
  if (_phaseEntrypoints is EqualUnmodifiableMapView) return _phaseEntrypoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_phaseEntrypoints);
}


/// Create a copy of RuleGraph
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RuleGraphCopyWith<_RuleGraph> get copyWith => __$RuleGraphCopyWithImpl<_RuleGraph>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuleGraph&&const DeepCollectionEquality().equals(other._nodes, _nodes)&&const DeepCollectionEquality().equals(other._edges, _edges)&&const DeepCollectionEquality().equals(other._phaseEntrypoints, _phaseEntrypoints));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_nodes),const DeepCollectionEquality().hash(_edges),const DeepCollectionEquality().hash(_phaseEntrypoints));

@override
String toString() {
  return 'RuleGraph(nodes: $nodes, edges: $edges, phaseEntrypoints: $phaseEntrypoints)';
}


}

/// @nodoc
abstract mixin class _$RuleGraphCopyWith<$Res> implements $RuleGraphCopyWith<$Res> {
  factory _$RuleGraphCopyWith(_RuleGraph value, $Res Function(_RuleGraph) _then) = __$RuleGraphCopyWithImpl;
@override @useResult
$Res call({
 List<Map<String, dynamic>> nodes, List<Map<String, dynamic>> edges, Map<String, dynamic> phaseEntrypoints
});




}
/// @nodoc
class __$RuleGraphCopyWithImpl<$Res>
    implements _$RuleGraphCopyWith<$Res> {
  __$RuleGraphCopyWithImpl(this._self, this._then);

  final _RuleGraph _self;
  final $Res Function(_RuleGraph) _then;

/// Create a copy of RuleGraph
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nodes = null,Object? edges = null,Object? phaseEntrypoints = null,}) {
  return _then(_RuleGraph(
nodes: null == nodes ? _self._nodes : nodes // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,edges: null == edges ? _self._edges : edges // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,phaseEntrypoints: null == phaseEntrypoints ? _self._phaseEntrypoints : phaseEntrypoints // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
