// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pipeline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
AggregationDef _$AggregationDefFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'first':
          return AggregationDef_First.fromJson(
            json
          );
                case 'last':
          return AggregationDef_Last.fromJson(
            json
          );
                case 'join':
          return AggregationDef_Join.fromJson(
            json
          );
                case 'array':
          return AggregationDef_Array.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'AggregationDef',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$AggregationDef {



  /// Serializes this AggregationDef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AggregationDef);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AggregationDef()';
}


}

/// @nodoc
class $AggregationDefCopyWith<$Res>  {
$AggregationDefCopyWith(AggregationDef _, $Res Function(AggregationDef) __);
}


/// Adds pattern-matching-related methods to [AggregationDef].
extension AggregationDefPatterns on AggregationDef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AggregationDef_First value)?  first,TResult Function( AggregationDef_Last value)?  last,TResult Function( AggregationDef_Join value)?  join,TResult Function( AggregationDef_Array value)?  array,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AggregationDef_First() when first != null:
return first(_that);case AggregationDef_Last() when last != null:
return last(_that);case AggregationDef_Join() when join != null:
return join(_that);case AggregationDef_Array() when array != null:
return array(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AggregationDef_First value)  first,required TResult Function( AggregationDef_Last value)  last,required TResult Function( AggregationDef_Join value)  join,required TResult Function( AggregationDef_Array value)  array,}){
final _that = this;
switch (_that) {
case AggregationDef_First():
return first(_that);case AggregationDef_Last():
return last(_that);case AggregationDef_Join():
return join(_that);case AggregationDef_Array():
return array(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AggregationDef_First value)?  first,TResult? Function( AggregationDef_Last value)?  last,TResult? Function( AggregationDef_Join value)?  join,TResult? Function( AggregationDef_Array value)?  array,}){
final _that = this;
switch (_that) {
case AggregationDef_First() when first != null:
return first(_that);case AggregationDef_Last() when last != null:
return last(_that);case AggregationDef_Join() when join != null:
return join(_that);case AggregationDef_Array() when array != null:
return array(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  first,TResult Function()?  last,TResult Function( String separator)?  join,TResult Function()?  array,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AggregationDef_First() when first != null:
return first();case AggregationDef_Last() when last != null:
return last();case AggregationDef_Join() when join != null:
return join(_that.separator);case AggregationDef_Array() when array != null:
return array();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  first,required TResult Function()  last,required TResult Function( String separator)  join,required TResult Function()  array,}) {final _that = this;
switch (_that) {
case AggregationDef_First():
return first();case AggregationDef_Last():
return last();case AggregationDef_Join():
return join(_that.separator);case AggregationDef_Array():
return array();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  first,TResult? Function()?  last,TResult? Function( String separator)?  join,TResult? Function()?  array,}) {final _that = this;
switch (_that) {
case AggregationDef_First() when first != null:
return first();case AggregationDef_Last() when last != null:
return last();case AggregationDef_Join() when join != null:
return join(_that.separator);case AggregationDef_Array() when array != null:
return array();case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class AggregationDef_First extends AggregationDef {
  const AggregationDef_First({final  String? $type}): $type = $type ?? 'first',super._();
  factory AggregationDef_First.fromJson(Map<String, dynamic> json) => _$AggregationDef_FirstFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AggregationDef_FirstToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AggregationDef_First);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AggregationDef.first()';
}


}




/// @nodoc
@JsonSerializable()

class AggregationDef_Last extends AggregationDef {
  const AggregationDef_Last({final  String? $type}): $type = $type ?? 'last',super._();
  factory AggregationDef_Last.fromJson(Map<String, dynamic> json) => _$AggregationDef_LastFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AggregationDef_LastToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AggregationDef_Last);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AggregationDef.last()';
}


}




/// @nodoc
@JsonSerializable()

class AggregationDef_Join extends AggregationDef {
  const AggregationDef_Join({required this.separator, final  String? $type}): $type = $type ?? 'join',super._();
  factory AggregationDef_Join.fromJson(Map<String, dynamic> json) => _$AggregationDef_JoinFromJson(json);

 final  String separator;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AggregationDef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AggregationDef_JoinCopyWith<AggregationDef_Join> get copyWith => _$AggregationDef_JoinCopyWithImpl<AggregationDef_Join>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AggregationDef_JoinToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AggregationDef_Join&&(identical(other.separator, separator) || other.separator == separator));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,separator);

@override
String toString() {
  return 'AggregationDef.join(separator: $separator)';
}


}

/// @nodoc
abstract mixin class $AggregationDef_JoinCopyWith<$Res> implements $AggregationDefCopyWith<$Res> {
  factory $AggregationDef_JoinCopyWith(AggregationDef_Join value, $Res Function(AggregationDef_Join) _then) = _$AggregationDef_JoinCopyWithImpl;
@useResult
$Res call({
 String separator
});




}
/// @nodoc
class _$AggregationDef_JoinCopyWithImpl<$Res>
    implements $AggregationDef_JoinCopyWith<$Res> {
  _$AggregationDef_JoinCopyWithImpl(this._self, this._then);

  final AggregationDef_Join _self;
  final $Res Function(AggregationDef_Join) _then;

/// Create a copy of AggregationDef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? separator = null,}) {
  return _then(AggregationDef_Join(
separator: null == separator ? _self.separator : separator // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AggregationDef_Array extends AggregationDef {
  const AggregationDef_Array({final  String? $type}): $type = $type ?? 'array',super._();
  factory AggregationDef_Array.fromJson(Map<String, dynamic> json) => _$AggregationDef_ArrayFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$AggregationDef_ArrayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AggregationDef_Array);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AggregationDef.array()';
}


}





/// @nodoc
mixin _$FlowEdge {

 String get id; String get source; String get target;
/// Create a copy of FlowEdge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlowEdgeCopyWith<FlowEdge> get copyWith => _$FlowEdgeCopyWithImpl<FlowEdge>(this as FlowEdge, _$identity);

  /// Serializes this FlowEdge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlowEdge&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,source,target);

@override
String toString() {
  return 'FlowEdge(id: $id, source: $source, target: $target)';
}


}

/// @nodoc
abstract mixin class $FlowEdgeCopyWith<$Res>  {
  factory $FlowEdgeCopyWith(FlowEdge value, $Res Function(FlowEdge) _then) = _$FlowEdgeCopyWithImpl;
@useResult
$Res call({
 String id, String source, String target
});




}
/// @nodoc
class _$FlowEdgeCopyWithImpl<$Res>
    implements $FlowEdgeCopyWith<$Res> {
  _$FlowEdgeCopyWithImpl(this._self, this._then);

  final FlowEdge _self;
  final $Res Function(FlowEdge) _then;

/// Create a copy of FlowEdge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? source = null,Object? target = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FlowEdge].
extension FlowEdgePatterns on FlowEdge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlowEdge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlowEdge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlowEdge value)  $default,){
final _that = this;
switch (_that) {
case _FlowEdge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlowEdge value)?  $default,){
final _that = this;
switch (_that) {
case _FlowEdge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String source,  String target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlowEdge() when $default != null:
return $default(_that.id,_that.source,_that.target);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String source,  String target)  $default,) {final _that = this;
switch (_that) {
case _FlowEdge():
return $default(_that.id,_that.source,_that.target);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String source,  String target)?  $default,) {final _that = this;
switch (_that) {
case _FlowEdge() when $default != null:
return $default(_that.id,_that.source,_that.target);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlowEdge implements FlowEdge {
  const _FlowEdge({required this.id, required this.source, required this.target});
  factory _FlowEdge.fromJson(Map<String, dynamic> json) => _$FlowEdgeFromJson(json);

@override final  String id;
@override final  String source;
@override final  String target;

/// Create a copy of FlowEdge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlowEdgeCopyWith<_FlowEdge> get copyWith => __$FlowEdgeCopyWithImpl<_FlowEdge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlowEdgeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlowEdge&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,source,target);

@override
String toString() {
  return 'FlowEdge(id: $id, source: $source, target: $target)';
}


}

/// @nodoc
abstract mixin class _$FlowEdgeCopyWith<$Res> implements $FlowEdgeCopyWith<$Res> {
  factory _$FlowEdgeCopyWith(_FlowEdge value, $Res Function(_FlowEdge) _then) = __$FlowEdgeCopyWithImpl;
@override @useResult
$Res call({
 String id, String source, String target
});




}
/// @nodoc
class __$FlowEdgeCopyWithImpl<$Res>
    implements _$FlowEdgeCopyWith<$Res> {
  __$FlowEdgeCopyWithImpl(this._self, this._then);

  final _FlowEdge _self;
  final $Res Function(_FlowEdge) _then;

/// Create a copy of FlowEdge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? source = null,Object? target = null,}) {
  return _then(_FlowEdge(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FlowNode {

 String get id; double get x; double get y; NodePayload get data;
/// Create a copy of FlowNode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlowNodeCopyWith<FlowNode> get copyWith => _$FlowNodeCopyWithImpl<FlowNode>(this as FlowNode, _$identity);

  /// Serializes this FlowNode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlowNode&&(identical(other.id, id) || other.id == id)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,x,y,data);

@override
String toString() {
  return 'FlowNode(id: $id, x: $x, y: $y, data: $data)';
}


}

/// @nodoc
abstract mixin class $FlowNodeCopyWith<$Res>  {
  factory $FlowNodeCopyWith(FlowNode value, $Res Function(FlowNode) _then) = _$FlowNodeCopyWithImpl;
@useResult
$Res call({
 String id, double x, double y, NodePayload data
});


$NodePayloadCopyWith<$Res> get data;

}
/// @nodoc
class _$FlowNodeCopyWithImpl<$Res>
    implements $FlowNodeCopyWith<$Res> {
  _$FlowNodeCopyWithImpl(this._self, this._then);

  final FlowNode _self;
  final $Res Function(FlowNode) _then;

/// Create a copy of FlowNode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? x = null,Object? y = null,Object? data = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as NodePayload,
  ));
}
/// Create a copy of FlowNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodePayloadCopyWith<$Res> get data {
  
  return $NodePayloadCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [FlowNode].
extension FlowNodePatterns on FlowNode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlowNode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlowNode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlowNode value)  $default,){
final _that = this;
switch (_that) {
case _FlowNode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlowNode value)?  $default,){
final _that = this;
switch (_that) {
case _FlowNode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  double x,  double y,  NodePayload data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlowNode() when $default != null:
return $default(_that.id,_that.x,_that.y,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  double x,  double y,  NodePayload data)  $default,) {final _that = this;
switch (_that) {
case _FlowNode():
return $default(_that.id,_that.x,_that.y,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  double x,  double y,  NodePayload data)?  $default,) {final _that = this;
switch (_that) {
case _FlowNode() when $default != null:
return $default(_that.id,_that.x,_that.y,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlowNode implements FlowNode {
  const _FlowNode({required this.id, required this.x, required this.y, required this.data});
  factory _FlowNode.fromJson(Map<String, dynamic> json) => _$FlowNodeFromJson(json);

@override final  String id;
@override final  double x;
@override final  double y;
@override final  NodePayload data;

/// Create a copy of FlowNode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlowNodeCopyWith<_FlowNode> get copyWith => __$FlowNodeCopyWithImpl<_FlowNode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlowNodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlowNode&&(identical(other.id, id) || other.id == id)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,x,y,data);

@override
String toString() {
  return 'FlowNode(id: $id, x: $x, y: $y, data: $data)';
}


}

/// @nodoc
abstract mixin class _$FlowNodeCopyWith<$Res> implements $FlowNodeCopyWith<$Res> {
  factory _$FlowNodeCopyWith(_FlowNode value, $Res Function(_FlowNode) _then) = __$FlowNodeCopyWithImpl;
@override @useResult
$Res call({
 String id, double x, double y, NodePayload data
});


@override $NodePayloadCopyWith<$Res> get data;

}
/// @nodoc
class __$FlowNodeCopyWithImpl<$Res>
    implements _$FlowNodeCopyWith<$Res> {
  __$FlowNodeCopyWithImpl(this._self, this._then);

  final _FlowNode _self;
  final $Res Function(_FlowNode) _then;

/// Create a copy of FlowNode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? x = null,Object? y = null,Object? data = null,}) {
  return _then(_FlowNode(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as NodePayload,
  ));
}

/// Create a copy of FlowNode
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NodePayloadCopyWith<$Res> get data {
  
  return $NodePayloadCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

NodePayload _$NodePayloadFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'selector':
          return NodePayload_Selector.fromJson(
            json
          );
                case 'transform':
          return NodePayload_Transform.fromJson(
            json
          );
                case 'aggregation':
          return NodePayload_Aggregation.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'NodePayload',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$NodePayload {

 Object get field0;

  /// Serializes this NodePayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodePayload&&const DeepCollectionEquality().equals(other.field0, field0));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'NodePayload(field0: $field0)';
}


}

/// @nodoc
class $NodePayloadCopyWith<$Res>  {
$NodePayloadCopyWith(NodePayload _, $Res Function(NodePayload) __);
}


/// Adds pattern-matching-related methods to [NodePayload].
extension NodePayloadPatterns on NodePayload {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NodePayload_Selector value)?  selector,TResult Function( NodePayload_Transform value)?  transform,TResult Function( NodePayload_Aggregation value)?  aggregation,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NodePayload_Selector() when selector != null:
return selector(_that);case NodePayload_Transform() when transform != null:
return transform(_that);case NodePayload_Aggregation() when aggregation != null:
return aggregation(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NodePayload_Selector value)  selector,required TResult Function( NodePayload_Transform value)  transform,required TResult Function( NodePayload_Aggregation value)  aggregation,}){
final _that = this;
switch (_that) {
case NodePayload_Selector():
return selector(_that);case NodePayload_Transform():
return transform(_that);case NodePayload_Aggregation():
return aggregation(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NodePayload_Selector value)?  selector,TResult? Function( NodePayload_Transform value)?  transform,TResult? Function( NodePayload_Aggregation value)?  aggregation,}){
final _that = this;
switch (_that) {
case NodePayload_Selector() when selector != null:
return selector(_that);case NodePayload_Transform() when transform != null:
return transform(_that);case NodePayload_Aggregation() when aggregation != null:
return aggregation(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SelectorDef field0)?  selector,TResult Function( TransformDef field0)?  transform,TResult Function( AggregationDef field0)?  aggregation,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NodePayload_Selector() when selector != null:
return selector(_that.field0);case NodePayload_Transform() when transform != null:
return transform(_that.field0);case NodePayload_Aggregation() when aggregation != null:
return aggregation(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SelectorDef field0)  selector,required TResult Function( TransformDef field0)  transform,required TResult Function( AggregationDef field0)  aggregation,}) {final _that = this;
switch (_that) {
case NodePayload_Selector():
return selector(_that.field0);case NodePayload_Transform():
return transform(_that.field0);case NodePayload_Aggregation():
return aggregation(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SelectorDef field0)?  selector,TResult? Function( TransformDef field0)?  transform,TResult? Function( AggregationDef field0)?  aggregation,}) {final _that = this;
switch (_that) {
case NodePayload_Selector() when selector != null:
return selector(_that.field0);case NodePayload_Transform() when transform != null:
return transform(_that.field0);case NodePayload_Aggregation() when aggregation != null:
return aggregation(_that.field0);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class NodePayload_Selector extends NodePayload {
  const NodePayload_Selector(this.field0, {final  String? $type}): $type = $type ?? 'selector',super._();
  factory NodePayload_Selector.fromJson(Map<String, dynamic> json) => _$NodePayload_SelectorFromJson(json);

@override final  SelectorDef field0;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of NodePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodePayload_SelectorCopyWith<NodePayload_Selector> get copyWith => _$NodePayload_SelectorCopyWithImpl<NodePayload_Selector>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodePayload_SelectorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodePayload_Selector&&(identical(other.field0, field0) || other.field0 == field0));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'NodePayload.selector(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $NodePayload_SelectorCopyWith<$Res> implements $NodePayloadCopyWith<$Res> {
  factory $NodePayload_SelectorCopyWith(NodePayload_Selector value, $Res Function(NodePayload_Selector) _then) = _$NodePayload_SelectorCopyWithImpl;
@useResult
$Res call({
 SelectorDef field0
});


$SelectorDefCopyWith<$Res> get field0;

}
/// @nodoc
class _$NodePayload_SelectorCopyWithImpl<$Res>
    implements $NodePayload_SelectorCopyWith<$Res> {
  _$NodePayload_SelectorCopyWithImpl(this._self, this._then);

  final NodePayload_Selector _self;
  final $Res Function(NodePayload_Selector) _then;

/// Create a copy of NodePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(NodePayload_Selector(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as SelectorDef,
  ));
}

/// Create a copy of NodePayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorDefCopyWith<$Res> get field0 {
  
  return $SelectorDefCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class NodePayload_Transform extends NodePayload {
  const NodePayload_Transform(this.field0, {final  String? $type}): $type = $type ?? 'transform',super._();
  factory NodePayload_Transform.fromJson(Map<String, dynamic> json) => _$NodePayload_TransformFromJson(json);

@override final  TransformDef field0;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of NodePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodePayload_TransformCopyWith<NodePayload_Transform> get copyWith => _$NodePayload_TransformCopyWithImpl<NodePayload_Transform>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodePayload_TransformToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodePayload_Transform&&(identical(other.field0, field0) || other.field0 == field0));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'NodePayload.transform(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $NodePayload_TransformCopyWith<$Res> implements $NodePayloadCopyWith<$Res> {
  factory $NodePayload_TransformCopyWith(NodePayload_Transform value, $Res Function(NodePayload_Transform) _then) = _$NodePayload_TransformCopyWithImpl;
@useResult
$Res call({
 TransformDef field0
});


$TransformDefCopyWith<$Res> get field0;

}
/// @nodoc
class _$NodePayload_TransformCopyWithImpl<$Res>
    implements $NodePayload_TransformCopyWith<$Res> {
  _$NodePayload_TransformCopyWithImpl(this._self, this._then);

  final NodePayload_Transform _self;
  final $Res Function(NodePayload_Transform) _then;

/// Create a copy of NodePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(NodePayload_Transform(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as TransformDef,
  ));
}

/// Create a copy of NodePayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TransformDefCopyWith<$Res> get field0 {
  
  return $TransformDefCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class NodePayload_Aggregation extends NodePayload {
  const NodePayload_Aggregation(this.field0, {final  String? $type}): $type = $type ?? 'aggregation',super._();
  factory NodePayload_Aggregation.fromJson(Map<String, dynamic> json) => _$NodePayload_AggregationFromJson(json);

@override final  AggregationDef field0;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of NodePayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NodePayload_AggregationCopyWith<NodePayload_Aggregation> get copyWith => _$NodePayload_AggregationCopyWithImpl<NodePayload_Aggregation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NodePayload_AggregationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NodePayload_Aggregation&&(identical(other.field0, field0) || other.field0 == field0));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'NodePayload.aggregation(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $NodePayload_AggregationCopyWith<$Res> implements $NodePayloadCopyWith<$Res> {
  factory $NodePayload_AggregationCopyWith(NodePayload_Aggregation value, $Res Function(NodePayload_Aggregation) _then) = _$NodePayload_AggregationCopyWithImpl;
@useResult
$Res call({
 AggregationDef field0
});


$AggregationDefCopyWith<$Res> get field0;

}
/// @nodoc
class _$NodePayload_AggregationCopyWithImpl<$Res>
    implements $NodePayload_AggregationCopyWith<$Res> {
  _$NodePayload_AggregationCopyWithImpl(this._self, this._then);

  final NodePayload_Aggregation _self;
  final $Res Function(NodePayload_Aggregation) _then;

/// Create a copy of NodePayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(NodePayload_Aggregation(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as AggregationDef,
  ));
}

/// Create a copy of NodePayload
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AggregationDefCopyWith<$Res> get field0 {
  
  return $AggregationDefCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}


/// @nodoc
mixin _$PipelineExecuteRequest {

 String get content; String? get baseUrl; String? get vars; List<PipelineOperation> get operations;
/// Create a copy of PipelineExecuteRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PipelineExecuteRequestCopyWith<PipelineExecuteRequest> get copyWith => _$PipelineExecuteRequestCopyWithImpl<PipelineExecuteRequest>(this as PipelineExecuteRequest, _$identity);

  /// Serializes this PipelineExecuteRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PipelineExecuteRequest&&(identical(other.content, content) || other.content == content)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.vars, vars) || other.vars == vars)&&const DeepCollectionEquality().equals(other.operations, operations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,baseUrl,vars,const DeepCollectionEquality().hash(operations));

@override
String toString() {
  return 'PipelineExecuteRequest(content: $content, baseUrl: $baseUrl, vars: $vars, operations: $operations)';
}


}

/// @nodoc
abstract mixin class $PipelineExecuteRequestCopyWith<$Res>  {
  factory $PipelineExecuteRequestCopyWith(PipelineExecuteRequest value, $Res Function(PipelineExecuteRequest) _then) = _$PipelineExecuteRequestCopyWithImpl;
@useResult
$Res call({
 String content, String? baseUrl, String? vars, List<PipelineOperation> operations
});




}
/// @nodoc
class _$PipelineExecuteRequestCopyWithImpl<$Res>
    implements $PipelineExecuteRequestCopyWith<$Res> {
  _$PipelineExecuteRequestCopyWithImpl(this._self, this._then);

  final PipelineExecuteRequest _self;
  final $Res Function(PipelineExecuteRequest) _then;

/// Create a copy of PipelineExecuteRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? baseUrl = freezed,Object? vars = freezed,Object? operations = null,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,baseUrl: freezed == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String?,vars: freezed == vars ? _self.vars : vars // ignore: cast_nullable_to_non_nullable
as String?,operations: null == operations ? _self.operations : operations // ignore: cast_nullable_to_non_nullable
as List<PipelineOperation>,
  ));
}

}


/// Adds pattern-matching-related methods to [PipelineExecuteRequest].
extension PipelineExecuteRequestPatterns on PipelineExecuteRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PipelineExecuteRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PipelineExecuteRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PipelineExecuteRequest value)  $default,){
final _that = this;
switch (_that) {
case _PipelineExecuteRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PipelineExecuteRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PipelineExecuteRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content,  String? baseUrl,  String? vars,  List<PipelineOperation> operations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PipelineExecuteRequest() when $default != null:
return $default(_that.content,_that.baseUrl,_that.vars,_that.operations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content,  String? baseUrl,  String? vars,  List<PipelineOperation> operations)  $default,) {final _that = this;
switch (_that) {
case _PipelineExecuteRequest():
return $default(_that.content,_that.baseUrl,_that.vars,_that.operations);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content,  String? baseUrl,  String? vars,  List<PipelineOperation> operations)?  $default,) {final _that = this;
switch (_that) {
case _PipelineExecuteRequest() when $default != null:
return $default(_that.content,_that.baseUrl,_that.vars,_that.operations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PipelineExecuteRequest implements PipelineExecuteRequest {
  const _PipelineExecuteRequest({required this.content, this.baseUrl, this.vars, required final  List<PipelineOperation> operations}): _operations = operations;
  factory _PipelineExecuteRequest.fromJson(Map<String, dynamic> json) => _$PipelineExecuteRequestFromJson(json);

@override final  String content;
@override final  String? baseUrl;
@override final  String? vars;
 final  List<PipelineOperation> _operations;
@override List<PipelineOperation> get operations {
  if (_operations is EqualUnmodifiableListView) return _operations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_operations);
}


/// Create a copy of PipelineExecuteRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PipelineExecuteRequestCopyWith<_PipelineExecuteRequest> get copyWith => __$PipelineExecuteRequestCopyWithImpl<_PipelineExecuteRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PipelineExecuteRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PipelineExecuteRequest&&(identical(other.content, content) || other.content == content)&&(identical(other.baseUrl, baseUrl) || other.baseUrl == baseUrl)&&(identical(other.vars, vars) || other.vars == vars)&&const DeepCollectionEquality().equals(other._operations, _operations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,baseUrl,vars,const DeepCollectionEquality().hash(_operations));

@override
String toString() {
  return 'PipelineExecuteRequest(content: $content, baseUrl: $baseUrl, vars: $vars, operations: $operations)';
}


}

/// @nodoc
abstract mixin class _$PipelineExecuteRequestCopyWith<$Res> implements $PipelineExecuteRequestCopyWith<$Res> {
  factory _$PipelineExecuteRequestCopyWith(_PipelineExecuteRequest value, $Res Function(_PipelineExecuteRequest) _then) = __$PipelineExecuteRequestCopyWithImpl;
@override @useResult
$Res call({
 String content, String? baseUrl, String? vars, List<PipelineOperation> operations
});




}
/// @nodoc
class __$PipelineExecuteRequestCopyWithImpl<$Res>
    implements _$PipelineExecuteRequestCopyWith<$Res> {
  __$PipelineExecuteRequestCopyWithImpl(this._self, this._then);

  final _PipelineExecuteRequest _self;
  final $Res Function(_PipelineExecuteRequest) _then;

/// Create a copy of PipelineExecuteRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? baseUrl = freezed,Object? vars = freezed,Object? operations = null,}) {
  return _then(_PipelineExecuteRequest(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,baseUrl: freezed == baseUrl ? _self.baseUrl : baseUrl // ignore: cast_nullable_to_non_nullable
as String?,vars: freezed == vars ? _self.vars : vars // ignore: cast_nullable_to_non_nullable
as String?,operations: null == operations ? _self._operations : operations // ignore: cast_nullable_to_non_nullable
as List<PipelineOperation>,
  ));
}


}


/// @nodoc
mixin _$PipelineExecuteResult {

 bool get success; List<String> get data; String? get error;
/// Create a copy of PipelineExecuteResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PipelineExecuteResultCopyWith<PipelineExecuteResult> get copyWith => _$PipelineExecuteResultCopyWithImpl<PipelineExecuteResult>(this as PipelineExecuteResult, _$identity);

  /// Serializes this PipelineExecuteResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PipelineExecuteResult&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(data),error);

@override
String toString() {
  return 'PipelineExecuteResult(success: $success, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class $PipelineExecuteResultCopyWith<$Res>  {
  factory $PipelineExecuteResultCopyWith(PipelineExecuteResult value, $Res Function(PipelineExecuteResult) _then) = _$PipelineExecuteResultCopyWithImpl;
@useResult
$Res call({
 bool success, List<String> data, String? error
});




}
/// @nodoc
class _$PipelineExecuteResultCopyWithImpl<$Res>
    implements $PipelineExecuteResultCopyWith<$Res> {
  _$PipelineExecuteResultCopyWithImpl(this._self, this._then);

  final PipelineExecuteResult _self;
  final $Res Function(PipelineExecuteResult) _then;

/// Create a copy of PipelineExecuteResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? data = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as List<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PipelineExecuteResult].
extension PipelineExecuteResultPatterns on PipelineExecuteResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PipelineExecuteResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PipelineExecuteResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PipelineExecuteResult value)  $default,){
final _that = this;
switch (_that) {
case _PipelineExecuteResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PipelineExecuteResult value)?  $default,){
final _that = this;
switch (_that) {
case _PipelineExecuteResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  List<String> data,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PipelineExecuteResult() when $default != null:
return $default(_that.success,_that.data,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  List<String> data,  String? error)  $default,) {final _that = this;
switch (_that) {
case _PipelineExecuteResult():
return $default(_that.success,_that.data,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  List<String> data,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _PipelineExecuteResult() when $default != null:
return $default(_that.success,_that.data,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PipelineExecuteResult implements PipelineExecuteResult {
  const _PipelineExecuteResult({required this.success, required final  List<String> data, this.error}): _data = data;
  factory _PipelineExecuteResult.fromJson(Map<String, dynamic> json) => _$PipelineExecuteResultFromJson(json);

@override final  bool success;
 final  List<String> _data;
@override List<String> get data {
  if (_data is EqualUnmodifiableListView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_data);
}

@override final  String? error;

/// Create a copy of PipelineExecuteResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PipelineExecuteResultCopyWith<_PipelineExecuteResult> get copyWith => __$PipelineExecuteResultCopyWithImpl<_PipelineExecuteResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PipelineExecuteResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PipelineExecuteResult&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(_data),error);

@override
String toString() {
  return 'PipelineExecuteResult(success: $success, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PipelineExecuteResultCopyWith<$Res> implements $PipelineExecuteResultCopyWith<$Res> {
  factory _$PipelineExecuteResultCopyWith(_PipelineExecuteResult value, $Res Function(_PipelineExecuteResult) _then) = __$PipelineExecuteResultCopyWithImpl;
@override @useResult
$Res call({
 bool success, List<String> data, String? error
});




}
/// @nodoc
class __$PipelineExecuteResultCopyWithImpl<$Res>
    implements _$PipelineExecuteResultCopyWith<$Res> {
  __$PipelineExecuteResultCopyWithImpl(this._self, this._then);

  final _PipelineExecuteResult _self;
  final $Res Function(_PipelineExecuteResult) _then;

/// Create a copy of PipelineExecuteResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? data = null,Object? error = freezed,}) {
  return _then(_PipelineExecuteResult(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as List<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PipelineGraph {

 List<FlowNode> get nodes; List<FlowEdge> get edges;
/// Create a copy of PipelineGraph
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PipelineGraphCopyWith<PipelineGraph> get copyWith => _$PipelineGraphCopyWithImpl<PipelineGraph>(this as PipelineGraph, _$identity);

  /// Serializes this PipelineGraph to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PipelineGraph&&const DeepCollectionEquality().equals(other.nodes, nodes)&&const DeepCollectionEquality().equals(other.edges, edges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(nodes),const DeepCollectionEquality().hash(edges));

@override
String toString() {
  return 'PipelineGraph(nodes: $nodes, edges: $edges)';
}


}

/// @nodoc
abstract mixin class $PipelineGraphCopyWith<$Res>  {
  factory $PipelineGraphCopyWith(PipelineGraph value, $Res Function(PipelineGraph) _then) = _$PipelineGraphCopyWithImpl;
@useResult
$Res call({
 List<FlowNode> nodes, List<FlowEdge> edges
});




}
/// @nodoc
class _$PipelineGraphCopyWithImpl<$Res>
    implements $PipelineGraphCopyWith<$Res> {
  _$PipelineGraphCopyWithImpl(this._self, this._then);

  final PipelineGraph _self;
  final $Res Function(PipelineGraph) _then;

/// Create a copy of PipelineGraph
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nodes = null,Object? edges = null,}) {
  return _then(_self.copyWith(
nodes: null == nodes ? _self.nodes : nodes // ignore: cast_nullable_to_non_nullable
as List<FlowNode>,edges: null == edges ? _self.edges : edges // ignore: cast_nullable_to_non_nullable
as List<FlowEdge>,
  ));
}

}


/// Adds pattern-matching-related methods to [PipelineGraph].
extension PipelineGraphPatterns on PipelineGraph {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PipelineGraph value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PipelineGraph() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PipelineGraph value)  $default,){
final _that = this;
switch (_that) {
case _PipelineGraph():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PipelineGraph value)?  $default,){
final _that = this;
switch (_that) {
case _PipelineGraph() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FlowNode> nodes,  List<FlowEdge> edges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PipelineGraph() when $default != null:
return $default(_that.nodes,_that.edges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FlowNode> nodes,  List<FlowEdge> edges)  $default,) {final _that = this;
switch (_that) {
case _PipelineGraph():
return $default(_that.nodes,_that.edges);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FlowNode> nodes,  List<FlowEdge> edges)?  $default,) {final _that = this;
switch (_that) {
case _PipelineGraph() when $default != null:
return $default(_that.nodes,_that.edges);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PipelineGraph implements PipelineGraph {
  const _PipelineGraph({required final  List<FlowNode> nodes, required final  List<FlowEdge> edges}): _nodes = nodes,_edges = edges;
  factory _PipelineGraph.fromJson(Map<String, dynamic> json) => _$PipelineGraphFromJson(json);

 final  List<FlowNode> _nodes;
@override List<FlowNode> get nodes {
  if (_nodes is EqualUnmodifiableListView) return _nodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nodes);
}

 final  List<FlowEdge> _edges;
@override List<FlowEdge> get edges {
  if (_edges is EqualUnmodifiableListView) return _edges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_edges);
}


/// Create a copy of PipelineGraph
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PipelineGraphCopyWith<_PipelineGraph> get copyWith => __$PipelineGraphCopyWithImpl<_PipelineGraph>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PipelineGraphToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PipelineGraph&&const DeepCollectionEquality().equals(other._nodes, _nodes)&&const DeepCollectionEquality().equals(other._edges, _edges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_nodes),const DeepCollectionEquality().hash(_edges));

@override
String toString() {
  return 'PipelineGraph(nodes: $nodes, edges: $edges)';
}


}

/// @nodoc
abstract mixin class _$PipelineGraphCopyWith<$Res> implements $PipelineGraphCopyWith<$Res> {
  factory _$PipelineGraphCopyWith(_PipelineGraph value, $Res Function(_PipelineGraph) _then) = __$PipelineGraphCopyWithImpl;
@override @useResult
$Res call({
 List<FlowNode> nodes, List<FlowEdge> edges
});




}
/// @nodoc
class __$PipelineGraphCopyWithImpl<$Res>
    implements _$PipelineGraphCopyWith<$Res> {
  __$PipelineGraphCopyWithImpl(this._self, this._then);

  final _PipelineGraph _self;
  final $Res Function(_PipelineGraph) _then;

/// Create a copy of PipelineGraph
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nodes = null,Object? edges = null,}) {
  return _then(_PipelineGraph(
nodes: null == nodes ? _self._nodes : nodes // ignore: cast_nullable_to_non_nullable
as List<FlowNode>,edges: null == edges ? _self._edges : edges // ignore: cast_nullable_to_non_nullable
as List<FlowEdge>,
  ));
}


}


/// @nodoc
mixin _$PipelineOperation {

 String get opType; String? get param; String? get param2;
/// Create a copy of PipelineOperation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PipelineOperationCopyWith<PipelineOperation> get copyWith => _$PipelineOperationCopyWithImpl<PipelineOperation>(this as PipelineOperation, _$identity);

  /// Serializes this PipelineOperation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PipelineOperation&&(identical(other.opType, opType) || other.opType == opType)&&(identical(other.param, param) || other.param == param)&&(identical(other.param2, param2) || other.param2 == param2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,opType,param,param2);

@override
String toString() {
  return 'PipelineOperation(opType: $opType, param: $param, param2: $param2)';
}


}

/// @nodoc
abstract mixin class $PipelineOperationCopyWith<$Res>  {
  factory $PipelineOperationCopyWith(PipelineOperation value, $Res Function(PipelineOperation) _then) = _$PipelineOperationCopyWithImpl;
@useResult
$Res call({
 String opType, String? param, String? param2
});




}
/// @nodoc
class _$PipelineOperationCopyWithImpl<$Res>
    implements $PipelineOperationCopyWith<$Res> {
  _$PipelineOperationCopyWithImpl(this._self, this._then);

  final PipelineOperation _self;
  final $Res Function(PipelineOperation) _then;

/// Create a copy of PipelineOperation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? opType = null,Object? param = freezed,Object? param2 = freezed,}) {
  return _then(_self.copyWith(
opType: null == opType ? _self.opType : opType // ignore: cast_nullable_to_non_nullable
as String,param: freezed == param ? _self.param : param // ignore: cast_nullable_to_non_nullable
as String?,param2: freezed == param2 ? _self.param2 : param2 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PipelineOperation].
extension PipelineOperationPatterns on PipelineOperation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PipelineOperation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PipelineOperation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PipelineOperation value)  $default,){
final _that = this;
switch (_that) {
case _PipelineOperation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PipelineOperation value)?  $default,){
final _that = this;
switch (_that) {
case _PipelineOperation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String opType,  String? param,  String? param2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PipelineOperation() when $default != null:
return $default(_that.opType,_that.param,_that.param2);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String opType,  String? param,  String? param2)  $default,) {final _that = this;
switch (_that) {
case _PipelineOperation():
return $default(_that.opType,_that.param,_that.param2);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String opType,  String? param,  String? param2)?  $default,) {final _that = this;
switch (_that) {
case _PipelineOperation() when $default != null:
return $default(_that.opType,_that.param,_that.param2);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PipelineOperation implements PipelineOperation {
  const _PipelineOperation({required this.opType, this.param, this.param2});
  factory _PipelineOperation.fromJson(Map<String, dynamic> json) => _$PipelineOperationFromJson(json);

@override final  String opType;
@override final  String? param;
@override final  String? param2;

/// Create a copy of PipelineOperation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PipelineOperationCopyWith<_PipelineOperation> get copyWith => __$PipelineOperationCopyWithImpl<_PipelineOperation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PipelineOperationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PipelineOperation&&(identical(other.opType, opType) || other.opType == opType)&&(identical(other.param, param) || other.param == param)&&(identical(other.param2, param2) || other.param2 == param2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,opType,param,param2);

@override
String toString() {
  return 'PipelineOperation(opType: $opType, param: $param, param2: $param2)';
}


}

/// @nodoc
abstract mixin class _$PipelineOperationCopyWith<$Res> implements $PipelineOperationCopyWith<$Res> {
  factory _$PipelineOperationCopyWith(_PipelineOperation value, $Res Function(_PipelineOperation) _then) = __$PipelineOperationCopyWithImpl;
@override @useResult
$Res call({
 String opType, String? param, String? param2
});




}
/// @nodoc
class __$PipelineOperationCopyWithImpl<$Res>
    implements _$PipelineOperationCopyWith<$Res> {
  __$PipelineOperationCopyWithImpl(this._self, this._then);

  final _PipelineOperation _self;
  final $Res Function(_PipelineOperation) _then;

/// Create a copy of PipelineOperation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? opType = null,Object? param = freezed,Object? param2 = freezed,}) {
  return _then(_PipelineOperation(
opType: null == opType ? _self.opType : opType // ignore: cast_nullable_to_non_nullable
as String,param: freezed == param ? _self.param : param // ignore: cast_nullable_to_non_nullable
as String?,param2: freezed == param2 ? _self.param2 : param2 // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

SelectorDef _$SelectorDefFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'css':
          return SelectorDef_Css.fromJson(
            json
          );
                case 'x_path':
          return SelectorDef_XPath.fromJson(
            json
          );
                case 'json_path':
          return SelectorDef_JsonPath.fromJson(
            json
          );
                case 'regex':
          return SelectorDef_Regex.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'SelectorDef',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$SelectorDef {



  /// Serializes this SelectorDef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectorDef);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SelectorDef()';
}


}

/// @nodoc
class $SelectorDefCopyWith<$Res>  {
$SelectorDefCopyWith(SelectorDef _, $Res Function(SelectorDef) __);
}


/// Adds pattern-matching-related methods to [SelectorDef].
extension SelectorDefPatterns on SelectorDef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SelectorDef_Css value)?  css,TResult Function( SelectorDef_XPath value)?  xPath,TResult Function( SelectorDef_JsonPath value)?  jsonPath,TResult Function( SelectorDef_Regex value)?  regex,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SelectorDef_Css() when css != null:
return css(_that);case SelectorDef_XPath() when xPath != null:
return xPath(_that);case SelectorDef_JsonPath() when jsonPath != null:
return jsonPath(_that);case SelectorDef_Regex() when regex != null:
return regex(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SelectorDef_Css value)  css,required TResult Function( SelectorDef_XPath value)  xPath,required TResult Function( SelectorDef_JsonPath value)  jsonPath,required TResult Function( SelectorDef_Regex value)  regex,}){
final _that = this;
switch (_that) {
case SelectorDef_Css():
return css(_that);case SelectorDef_XPath():
return xPath(_that);case SelectorDef_JsonPath():
return jsonPath(_that);case SelectorDef_Regex():
return regex(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SelectorDef_Css value)?  css,TResult? Function( SelectorDef_XPath value)?  xPath,TResult? Function( SelectorDef_JsonPath value)?  jsonPath,TResult? Function( SelectorDef_Regex value)?  regex,}){
final _that = this;
switch (_that) {
case SelectorDef_Css() when css != null:
return css(_that);case SelectorDef_XPath() when xPath != null:
return xPath(_that);case SelectorDef_JsonPath() when jsonPath != null:
return jsonPath(_that);case SelectorDef_Regex() when regex != null:
return regex(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String selector)?  css,TResult Function( String query)?  xPath,TResult Function( String path)?  jsonPath,TResult Function( String pattern)?  regex,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SelectorDef_Css() when css != null:
return css(_that.selector);case SelectorDef_XPath() when xPath != null:
return xPath(_that.query);case SelectorDef_JsonPath() when jsonPath != null:
return jsonPath(_that.path);case SelectorDef_Regex() when regex != null:
return regex(_that.pattern);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String selector)  css,required TResult Function( String query)  xPath,required TResult Function( String path)  jsonPath,required TResult Function( String pattern)  regex,}) {final _that = this;
switch (_that) {
case SelectorDef_Css():
return css(_that.selector);case SelectorDef_XPath():
return xPath(_that.query);case SelectorDef_JsonPath():
return jsonPath(_that.path);case SelectorDef_Regex():
return regex(_that.pattern);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String selector)?  css,TResult? Function( String query)?  xPath,TResult? Function( String path)?  jsonPath,TResult? Function( String pattern)?  regex,}) {final _that = this;
switch (_that) {
case SelectorDef_Css() when css != null:
return css(_that.selector);case SelectorDef_XPath() when xPath != null:
return xPath(_that.query);case SelectorDef_JsonPath() when jsonPath != null:
return jsonPath(_that.path);case SelectorDef_Regex() when regex != null:
return regex(_that.pattern);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class SelectorDef_Css extends SelectorDef {
  const SelectorDef_Css({required this.selector, final  String? $type}): $type = $type ?? 'css',super._();
  factory SelectorDef_Css.fromJson(Map<String, dynamic> json) => _$SelectorDef_CssFromJson(json);

 final  String selector;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SelectorDef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectorDef_CssCopyWith<SelectorDef_Css> get copyWith => _$SelectorDef_CssCopyWithImpl<SelectorDef_Css>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectorDef_CssToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectorDef_Css&&(identical(other.selector, selector) || other.selector == selector));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selector);

@override
String toString() {
  return 'SelectorDef.css(selector: $selector)';
}


}

/// @nodoc
abstract mixin class $SelectorDef_CssCopyWith<$Res> implements $SelectorDefCopyWith<$Res> {
  factory $SelectorDef_CssCopyWith(SelectorDef_Css value, $Res Function(SelectorDef_Css) _then) = _$SelectorDef_CssCopyWithImpl;
@useResult
$Res call({
 String selector
});




}
/// @nodoc
class _$SelectorDef_CssCopyWithImpl<$Res>
    implements $SelectorDef_CssCopyWith<$Res> {
  _$SelectorDef_CssCopyWithImpl(this._self, this._then);

  final SelectorDef_Css _self;
  final $Res Function(SelectorDef_Css) _then;

/// Create a copy of SelectorDef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? selector = null,}) {
  return _then(SelectorDef_Css(
selector: null == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SelectorDef_XPath extends SelectorDef {
  const SelectorDef_XPath({required this.query, final  String? $type}): $type = $type ?? 'x_path',super._();
  factory SelectorDef_XPath.fromJson(Map<String, dynamic> json) => _$SelectorDef_XPathFromJson(json);

 final  String query;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SelectorDef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectorDef_XPathCopyWith<SelectorDef_XPath> get copyWith => _$SelectorDef_XPathCopyWithImpl<SelectorDef_XPath>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectorDef_XPathToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectorDef_XPath&&(identical(other.query, query) || other.query == query));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'SelectorDef.xPath(query: $query)';
}


}

/// @nodoc
abstract mixin class $SelectorDef_XPathCopyWith<$Res> implements $SelectorDefCopyWith<$Res> {
  factory $SelectorDef_XPathCopyWith(SelectorDef_XPath value, $Res Function(SelectorDef_XPath) _then) = _$SelectorDef_XPathCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$SelectorDef_XPathCopyWithImpl<$Res>
    implements $SelectorDef_XPathCopyWith<$Res> {
  _$SelectorDef_XPathCopyWithImpl(this._self, this._then);

  final SelectorDef_XPath _self;
  final $Res Function(SelectorDef_XPath) _then;

/// Create a copy of SelectorDef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(SelectorDef_XPath(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SelectorDef_JsonPath extends SelectorDef {
  const SelectorDef_JsonPath({required this.path, final  String? $type}): $type = $type ?? 'json_path',super._();
  factory SelectorDef_JsonPath.fromJson(Map<String, dynamic> json) => _$SelectorDef_JsonPathFromJson(json);

 final  String path;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SelectorDef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectorDef_JsonPathCopyWith<SelectorDef_JsonPath> get copyWith => _$SelectorDef_JsonPathCopyWithImpl<SelectorDef_JsonPath>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectorDef_JsonPathToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectorDef_JsonPath&&(identical(other.path, path) || other.path == path));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,path);

@override
String toString() {
  return 'SelectorDef.jsonPath(path: $path)';
}


}

/// @nodoc
abstract mixin class $SelectorDef_JsonPathCopyWith<$Res> implements $SelectorDefCopyWith<$Res> {
  factory $SelectorDef_JsonPathCopyWith(SelectorDef_JsonPath value, $Res Function(SelectorDef_JsonPath) _then) = _$SelectorDef_JsonPathCopyWithImpl;
@useResult
$Res call({
 String path
});




}
/// @nodoc
class _$SelectorDef_JsonPathCopyWithImpl<$Res>
    implements $SelectorDef_JsonPathCopyWith<$Res> {
  _$SelectorDef_JsonPathCopyWithImpl(this._self, this._then);

  final SelectorDef_JsonPath _self;
  final $Res Function(SelectorDef_JsonPath) _then;

/// Create a copy of SelectorDef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? path = null,}) {
  return _then(SelectorDef_JsonPath(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SelectorDef_Regex extends SelectorDef {
  const SelectorDef_Regex({required this.pattern, final  String? $type}): $type = $type ?? 'regex',super._();
  factory SelectorDef_Regex.fromJson(Map<String, dynamic> json) => _$SelectorDef_RegexFromJson(json);

 final  String pattern;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of SelectorDef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectorDef_RegexCopyWith<SelectorDef_Regex> get copyWith => _$SelectorDef_RegexCopyWithImpl<SelectorDef_Regex>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SelectorDef_RegexToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectorDef_Regex&&(identical(other.pattern, pattern) || other.pattern == pattern));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pattern);

@override
String toString() {
  return 'SelectorDef.regex(pattern: $pattern)';
}


}

/// @nodoc
abstract mixin class $SelectorDef_RegexCopyWith<$Res> implements $SelectorDefCopyWith<$Res> {
  factory $SelectorDef_RegexCopyWith(SelectorDef_Regex value, $Res Function(SelectorDef_Regex) _then) = _$SelectorDef_RegexCopyWithImpl;
@useResult
$Res call({
 String pattern
});




}
/// @nodoc
class _$SelectorDef_RegexCopyWithImpl<$Res>
    implements $SelectorDef_RegexCopyWith<$Res> {
  _$SelectorDef_RegexCopyWithImpl(this._self, this._then);

  final SelectorDef_Regex _self;
  final $Res Function(SelectorDef_Regex) _then;

/// Create a copy of SelectorDef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pattern = null,}) {
  return _then(SelectorDef_Regex(
pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

TransformDef _$TransformDefFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'trim':
          return TransformDef_Trim.fromJson(
            json
          );
                case 'lower':
          return TransformDef_Lower.fromJson(
            json
          );
                case 'upper':
          return TransformDef_Upper.fromJson(
            json
          );
                case 'regex_replace':
          return TransformDef_RegexReplace.fromJson(
            json
          );
                case 'text':
          return TransformDef_Text.fromJson(
            json
          );
                case 'attr':
          return TransformDef_Attr.fromJson(
            json
          );
                case 'url':
          return TransformDef_Url.fromJson(
            json
          );
                case 'js':
          return TransformDef_Js.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'TransformDef',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$TransformDef {



  /// Serializes this TransformDef to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransformDef);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TransformDef()';
}


}

/// @nodoc
class $TransformDefCopyWith<$Res>  {
$TransformDefCopyWith(TransformDef _, $Res Function(TransformDef) __);
}


/// Adds pattern-matching-related methods to [TransformDef].
extension TransformDefPatterns on TransformDef {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TransformDef_Trim value)?  trim,TResult Function( TransformDef_Lower value)?  lower,TResult Function( TransformDef_Upper value)?  upper,TResult Function( TransformDef_RegexReplace value)?  regexReplace,TResult Function( TransformDef_Text value)?  text,TResult Function( TransformDef_Attr value)?  attr,TResult Function( TransformDef_Url value)?  url,TResult Function( TransformDef_Js value)?  js,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TransformDef_Trim() when trim != null:
return trim(_that);case TransformDef_Lower() when lower != null:
return lower(_that);case TransformDef_Upper() when upper != null:
return upper(_that);case TransformDef_RegexReplace() when regexReplace != null:
return regexReplace(_that);case TransformDef_Text() when text != null:
return text(_that);case TransformDef_Attr() when attr != null:
return attr(_that);case TransformDef_Url() when url != null:
return url(_that);case TransformDef_Js() when js != null:
return js(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TransformDef_Trim value)  trim,required TResult Function( TransformDef_Lower value)  lower,required TResult Function( TransformDef_Upper value)  upper,required TResult Function( TransformDef_RegexReplace value)  regexReplace,required TResult Function( TransformDef_Text value)  text,required TResult Function( TransformDef_Attr value)  attr,required TResult Function( TransformDef_Url value)  url,required TResult Function( TransformDef_Js value)  js,}){
final _that = this;
switch (_that) {
case TransformDef_Trim():
return trim(_that);case TransformDef_Lower():
return lower(_that);case TransformDef_Upper():
return upper(_that);case TransformDef_RegexReplace():
return regexReplace(_that);case TransformDef_Text():
return text(_that);case TransformDef_Attr():
return attr(_that);case TransformDef_Url():
return url(_that);case TransformDef_Js():
return js(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TransformDef_Trim value)?  trim,TResult? Function( TransformDef_Lower value)?  lower,TResult? Function( TransformDef_Upper value)?  upper,TResult? Function( TransformDef_RegexReplace value)?  regexReplace,TResult? Function( TransformDef_Text value)?  text,TResult? Function( TransformDef_Attr value)?  attr,TResult? Function( TransformDef_Url value)?  url,TResult? Function( TransformDef_Js value)?  js,}){
final _that = this;
switch (_that) {
case TransformDef_Trim() when trim != null:
return trim(_that);case TransformDef_Lower() when lower != null:
return lower(_that);case TransformDef_Upper() when upper != null:
return upper(_that);case TransformDef_RegexReplace() when regexReplace != null:
return regexReplace(_that);case TransformDef_Text() when text != null:
return text(_that);case TransformDef_Attr() when attr != null:
return attr(_that);case TransformDef_Url() when url != null:
return url(_that);case TransformDef_Js() when js != null:
return js(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  trim,TResult Function()?  lower,TResult Function()?  upper,TResult Function( String pattern,  String replace)?  regexReplace,TResult Function()?  text,TResult Function( String name)?  attr,TResult Function()?  url,TResult Function( String script)?  js,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TransformDef_Trim() when trim != null:
return trim();case TransformDef_Lower() when lower != null:
return lower();case TransformDef_Upper() when upper != null:
return upper();case TransformDef_RegexReplace() when regexReplace != null:
return regexReplace(_that.pattern,_that.replace);case TransformDef_Text() when text != null:
return text();case TransformDef_Attr() when attr != null:
return attr(_that.name);case TransformDef_Url() when url != null:
return url();case TransformDef_Js() when js != null:
return js(_that.script);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  trim,required TResult Function()  lower,required TResult Function()  upper,required TResult Function( String pattern,  String replace)  regexReplace,required TResult Function()  text,required TResult Function( String name)  attr,required TResult Function()  url,required TResult Function( String script)  js,}) {final _that = this;
switch (_that) {
case TransformDef_Trim():
return trim();case TransformDef_Lower():
return lower();case TransformDef_Upper():
return upper();case TransformDef_RegexReplace():
return regexReplace(_that.pattern,_that.replace);case TransformDef_Text():
return text();case TransformDef_Attr():
return attr(_that.name);case TransformDef_Url():
return url();case TransformDef_Js():
return js(_that.script);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  trim,TResult? Function()?  lower,TResult? Function()?  upper,TResult? Function( String pattern,  String replace)?  regexReplace,TResult? Function()?  text,TResult? Function( String name)?  attr,TResult? Function()?  url,TResult? Function( String script)?  js,}) {final _that = this;
switch (_that) {
case TransformDef_Trim() when trim != null:
return trim();case TransformDef_Lower() when lower != null:
return lower();case TransformDef_Upper() when upper != null:
return upper();case TransformDef_RegexReplace() when regexReplace != null:
return regexReplace(_that.pattern,_that.replace);case TransformDef_Text() when text != null:
return text();case TransformDef_Attr() when attr != null:
return attr(_that.name);case TransformDef_Url() when url != null:
return url();case TransformDef_Js() when js != null:
return js(_that.script);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class TransformDef_Trim extends TransformDef {
  const TransformDef_Trim({final  String? $type}): $type = $type ?? 'trim',super._();
  factory TransformDef_Trim.fromJson(Map<String, dynamic> json) => _$TransformDef_TrimFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$TransformDef_TrimToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransformDef_Trim);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TransformDef.trim()';
}


}




/// @nodoc
@JsonSerializable()

class TransformDef_Lower extends TransformDef {
  const TransformDef_Lower({final  String? $type}): $type = $type ?? 'lower',super._();
  factory TransformDef_Lower.fromJson(Map<String, dynamic> json) => _$TransformDef_LowerFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$TransformDef_LowerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransformDef_Lower);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TransformDef.lower()';
}


}




/// @nodoc
@JsonSerializable()

class TransformDef_Upper extends TransformDef {
  const TransformDef_Upper({final  String? $type}): $type = $type ?? 'upper',super._();
  factory TransformDef_Upper.fromJson(Map<String, dynamic> json) => _$TransformDef_UpperFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$TransformDef_UpperToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransformDef_Upper);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TransformDef.upper()';
}


}




/// @nodoc
@JsonSerializable()

class TransformDef_RegexReplace extends TransformDef {
  const TransformDef_RegexReplace({required this.pattern, required this.replace, final  String? $type}): $type = $type ?? 'regex_replace',super._();
  factory TransformDef_RegexReplace.fromJson(Map<String, dynamic> json) => _$TransformDef_RegexReplaceFromJson(json);

 final  String pattern;
 final  String replace;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TransformDef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransformDef_RegexReplaceCopyWith<TransformDef_RegexReplace> get copyWith => _$TransformDef_RegexReplaceCopyWithImpl<TransformDef_RegexReplace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransformDef_RegexReplaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransformDef_RegexReplace&&(identical(other.pattern, pattern) || other.pattern == pattern)&&(identical(other.replace, replace) || other.replace == replace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pattern,replace);

@override
String toString() {
  return 'TransformDef.regexReplace(pattern: $pattern, replace: $replace)';
}


}

/// @nodoc
abstract mixin class $TransformDef_RegexReplaceCopyWith<$Res> implements $TransformDefCopyWith<$Res> {
  factory $TransformDef_RegexReplaceCopyWith(TransformDef_RegexReplace value, $Res Function(TransformDef_RegexReplace) _then) = _$TransformDef_RegexReplaceCopyWithImpl;
@useResult
$Res call({
 String pattern, String replace
});




}
/// @nodoc
class _$TransformDef_RegexReplaceCopyWithImpl<$Res>
    implements $TransformDef_RegexReplaceCopyWith<$Res> {
  _$TransformDef_RegexReplaceCopyWithImpl(this._self, this._then);

  final TransformDef_RegexReplace _self;
  final $Res Function(TransformDef_RegexReplace) _then;

/// Create a copy of TransformDef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? pattern = null,Object? replace = null,}) {
  return _then(TransformDef_RegexReplace(
pattern: null == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String,replace: null == replace ? _self.replace : replace // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TransformDef_Text extends TransformDef {
  const TransformDef_Text({final  String? $type}): $type = $type ?? 'text',super._();
  factory TransformDef_Text.fromJson(Map<String, dynamic> json) => _$TransformDef_TextFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$TransformDef_TextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransformDef_Text);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TransformDef.text()';
}


}




/// @nodoc
@JsonSerializable()

class TransformDef_Attr extends TransformDef {
  const TransformDef_Attr({required this.name, final  String? $type}): $type = $type ?? 'attr',super._();
  factory TransformDef_Attr.fromJson(Map<String, dynamic> json) => _$TransformDef_AttrFromJson(json);

 final  String name;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TransformDef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransformDef_AttrCopyWith<TransformDef_Attr> get copyWith => _$TransformDef_AttrCopyWithImpl<TransformDef_Attr>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransformDef_AttrToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransformDef_Attr&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'TransformDef.attr(name: $name)';
}


}

/// @nodoc
abstract mixin class $TransformDef_AttrCopyWith<$Res> implements $TransformDefCopyWith<$Res> {
  factory $TransformDef_AttrCopyWith(TransformDef_Attr value, $Res Function(TransformDef_Attr) _then) = _$TransformDef_AttrCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$TransformDef_AttrCopyWithImpl<$Res>
    implements $TransformDef_AttrCopyWith<$Res> {
  _$TransformDef_AttrCopyWithImpl(this._self, this._then);

  final TransformDef_Attr _self;
  final $Res Function(TransformDef_Attr) _then;

/// Create a copy of TransformDef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(TransformDef_Attr(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class TransformDef_Url extends TransformDef {
  const TransformDef_Url({final  String? $type}): $type = $type ?? 'url',super._();
  factory TransformDef_Url.fromJson(Map<String, dynamic> json) => _$TransformDef_UrlFromJson(json);



@JsonKey(name: 'runtimeType')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$TransformDef_UrlToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransformDef_Url);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TransformDef.url()';
}


}




/// @nodoc
@JsonSerializable()

class TransformDef_Js extends TransformDef {
  const TransformDef_Js({required this.script, final  String? $type}): $type = $type ?? 'js',super._();
  factory TransformDef_Js.fromJson(Map<String, dynamic> json) => _$TransformDef_JsFromJson(json);

 final  String script;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of TransformDef
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransformDef_JsCopyWith<TransformDef_Js> get copyWith => _$TransformDef_JsCopyWithImpl<TransformDef_Js>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransformDef_JsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransformDef_Js&&(identical(other.script, script) || other.script == script));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,script);

@override
String toString() {
  return 'TransformDef.js(script: $script)';
}


}

/// @nodoc
abstract mixin class $TransformDef_JsCopyWith<$Res> implements $TransformDefCopyWith<$Res> {
  factory $TransformDef_JsCopyWith(TransformDef_Js value, $Res Function(TransformDef_Js) _then) = _$TransformDef_JsCopyWithImpl;
@useResult
$Res call({
 String script
});




}
/// @nodoc
class _$TransformDef_JsCopyWithImpl<$Res>
    implements $TransformDef_JsCopyWith<$Res> {
  _$TransformDef_JsCopyWithImpl(this._self, this._then);

  final TransformDef_Js _self;
  final $Res Function(TransformDef_Js) _then;

/// Create a copy of TransformDef
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? script = null,}) {
  return _then(TransformDef_Js(
script: null == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
