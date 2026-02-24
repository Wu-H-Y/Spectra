// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pipeline_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PipelineNode {

/// 节点类型。
 PipelineNodeType get type;/// 操作符名称 (不带 @ 前缀)。
 String get operator;/// 操作参数 (如 @css:.title 中的 ".title")。
 String? get argument;/// 节点描述 (用于可视化编辑器)。
 String? get description;
/// Create a copy of PipelineNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PipelineNodeCopyWith<PipelineNode> get copyWith => _$PipelineNodeCopyWithImpl<PipelineNode>(this as PipelineNode, _$identity);

  /// Serializes this PipelineNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PipelineNode&&(identical(other.type, type) || other.type == type)&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.argument, argument) || other.argument == argument)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operator,argument,description);

@override
String toString() {
  return 'PipelineNode(type: $type, operator: $operator, argument: $argument, description: $description)';
}


}

/// @nodoc
abstract mixin class $PipelineNodeCopyWith<$Res>  {
  factory $PipelineNodeCopyWith(PipelineNode value, $Res Function(PipelineNode) _then) = _$PipelineNodeCopyWithImpl;
@useResult
$Res call({
 PipelineNodeType type, String operator, String? argument, String? description
});




}
/// @nodoc
class _$PipelineNodeCopyWithImpl<$Res>
    implements $PipelineNodeCopyWith<$Res> {
  _$PipelineNodeCopyWithImpl(this._self, this._then);

  final PipelineNode _self;
  final $Res Function(PipelineNode) _then;

/// Create a copy of PipelineNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? operator = null,Object? argument = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PipelineNodeType,operator: null == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as String,argument: freezed == argument ? _self.argument : argument // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PipelineNode].
extension PipelineNodePatterns on PipelineNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PipelineNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PipelineNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PipelineNode value)  $default,){
final _that = this;
switch (_that) {
case _PipelineNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PipelineNode value)?  $default,){
final _that = this;
switch (_that) {
case _PipelineNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PipelineNodeType type,  String operator,  String? argument,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PipelineNode() when $default != null:
return $default(_that.type,_that.operator,_that.argument,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PipelineNodeType type,  String operator,  String? argument,  String? description)  $default,) {final _that = this;
switch (_that) {
case _PipelineNode():
return $default(_that.type,_that.operator,_that.argument,_that.description);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PipelineNodeType type,  String operator,  String? argument,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _PipelineNode() when $default != null:
return $default(_that.type,_that.operator,_that.argument,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PipelineNode implements PipelineNode {
  const _PipelineNode({required this.type, required this.operator, this.argument, this.description});
  factory _PipelineNode.fromJson(Map<String, dynamic> json) => _$PipelineNodeFromJson(json);

/// 节点类型。
@override final  PipelineNodeType type;
/// 操作符名称 (不带 @ 前缀)。
@override final  String operator;
/// 操作参数 (如 @css:.title 中的 ".title")。
@override final  String? argument;
/// 节点描述 (用于可视化编辑器)。
@override final  String? description;

/// Create a copy of PipelineNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PipelineNodeCopyWith<_PipelineNode> get copyWith => __$PipelineNodeCopyWithImpl<_PipelineNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PipelineNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PipelineNode&&(identical(other.type, type) || other.type == type)&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.argument, argument) || other.argument == argument)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,operator,argument,description);

@override
String toString() {
  return 'PipelineNode(type: $type, operator: $operator, argument: $argument, description: $description)';
}


}

/// @nodoc
abstract mixin class _$PipelineNodeCopyWith<$Res> implements $PipelineNodeCopyWith<$Res> {
  factory _$PipelineNodeCopyWith(_PipelineNode value, $Res Function(_PipelineNode) _then) = __$PipelineNodeCopyWithImpl;
@override @useResult
$Res call({
 PipelineNodeType type, String operator, String? argument, String? description
});




}
/// @nodoc
class __$PipelineNodeCopyWithImpl<$Res>
    implements _$PipelineNodeCopyWith<$Res> {
  __$PipelineNodeCopyWithImpl(this._self, this._then);

  final _PipelineNode _self;
  final $Res Function(_PipelineNode) _then;

/// Create a copy of PipelineNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? operator = null,Object? argument = freezed,Object? description = freezed,}) {
  return _then(_PipelineNode(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PipelineNodeType,operator: null == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as String,argument: freezed == argument ? _self.argument : argument // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Pipeline {

/// 节点列表。
 List<PipelineNode> get nodes;/// 输出字段名。
 String? get outputField;
/// Create a copy of Pipeline
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PipelineCopyWith<Pipeline> get copyWith => _$PipelineCopyWithImpl<Pipeline>(this as Pipeline, _$identity);

  /// Serializes this Pipeline to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Pipeline&&const DeepCollectionEquality().equals(other.nodes, nodes)&&(identical(other.outputField, outputField) || other.outputField == outputField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(nodes),outputField);

@override
String toString() {
  return 'Pipeline(nodes: $nodes, outputField: $outputField)';
}


}

/// @nodoc
abstract mixin class $PipelineCopyWith<$Res>  {
  factory $PipelineCopyWith(Pipeline value, $Res Function(Pipeline) _then) = _$PipelineCopyWithImpl;
@useResult
$Res call({
 List<PipelineNode> nodes, String? outputField
});




}
/// @nodoc
class _$PipelineCopyWithImpl<$Res>
    implements $PipelineCopyWith<$Res> {
  _$PipelineCopyWithImpl(this._self, this._then);

  final Pipeline _self;
  final $Res Function(Pipeline) _then;

/// Create a copy of Pipeline
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nodes = null,Object? outputField = freezed,}) {
  return _then(_self.copyWith(
nodes: null == nodes ? _self.nodes : nodes // ignore: cast_nullable_to_non_nullable
as List<PipelineNode>,outputField: freezed == outputField ? _self.outputField : outputField // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Pipeline].
extension PipelinePatterns on Pipeline {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Pipeline value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Pipeline() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Pipeline value)  $default,){
final _that = this;
switch (_that) {
case _Pipeline():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Pipeline value)?  $default,){
final _that = this;
switch (_that) {
case _Pipeline() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PipelineNode> nodes,  String? outputField)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Pipeline() when $default != null:
return $default(_that.nodes,_that.outputField);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PipelineNode> nodes,  String? outputField)  $default,) {final _that = this;
switch (_that) {
case _Pipeline():
return $default(_that.nodes,_that.outputField);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PipelineNode> nodes,  String? outputField)?  $default,) {final _that = this;
switch (_that) {
case _Pipeline() when $default != null:
return $default(_that.nodes,_that.outputField);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Pipeline implements Pipeline {
  const _Pipeline({required final  List<PipelineNode> nodes, this.outputField}): _nodes = nodes;
  factory _Pipeline.fromJson(Map<String, dynamic> json) => _$PipelineFromJson(json);

/// 节点列表。
 final  List<PipelineNode> _nodes;
/// 节点列表。
@override List<PipelineNode> get nodes {
  if (_nodes is EqualUnmodifiableListView) return _nodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nodes);
}

/// 输出字段名。
@override final  String? outputField;

/// Create a copy of Pipeline
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PipelineCopyWith<_Pipeline> get copyWith => __$PipelineCopyWithImpl<_Pipeline>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PipelineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pipeline&&const DeepCollectionEquality().equals(other._nodes, _nodes)&&(identical(other.outputField, outputField) || other.outputField == outputField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_nodes),outputField);

@override
String toString() {
  return 'Pipeline(nodes: $nodes, outputField: $outputField)';
}


}

/// @nodoc
abstract mixin class _$PipelineCopyWith<$Res> implements $PipelineCopyWith<$Res> {
  factory _$PipelineCopyWith(_Pipeline value, $Res Function(_Pipeline) _then) = __$PipelineCopyWithImpl;
@override @useResult
$Res call({
 List<PipelineNode> nodes, String? outputField
});




}
/// @nodoc
class __$PipelineCopyWithImpl<$Res>
    implements _$PipelineCopyWith<$Res> {
  __$PipelineCopyWithImpl(this._self, this._then);

  final _Pipeline _self;
  final $Res Function(_Pipeline) _then;

/// Create a copy of Pipeline
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nodes = null,Object? outputField = freezed,}) {
  return _then(_Pipeline(
nodes: null == nodes ? _self._nodes : nodes // ignore: cast_nullable_to_non_nullable
as List<PipelineNode>,outputField: freezed == outputField ? _self.outputField : outputField // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
