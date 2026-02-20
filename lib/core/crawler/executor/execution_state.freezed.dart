// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'execution_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExecutionState {

/// 唯一执行 ID。
 String get id;/// 正在执行的规则 ID。
 String get ruleId;/// 当前状态。
 ExecutionStatus get status;/// 当前正在处理的 URL。
 String? get currentUrl;/// 当前页码。
 int get currentPage;/// 总页数（0 = 未知/无限制）。
 int get totalPages;/// 目前已提取的项目数。
 int get extractedCount;/// 提取失败的项目数。
 int get failedCount;/// 遇到的错误列表。
 List<String> get errors;/// 警告列表。
 List<String> get warnings;/// 开始时间。
 DateTime? get startTime;/// 结束时间。
 DateTime? get endTime;/// 当前提取阶段。
 ExecutionPhase get phase;/// 额外的元数据。
 Map<String, dynamic> get metadata;
/// Create a copy of ExecutionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExecutionStateCopyWith<ExecutionState> get copyWith => _$ExecutionStateCopyWithImpl<ExecutionState>(this as ExecutionState, _$identity);

  /// Serializes this ExecutionState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExecutionState&&(identical(other.id, id) || other.id == id)&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentUrl, currentUrl) || other.currentUrl == currentUrl)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.extractedCount, extractedCount) || other.extractedCount == extractedCount)&&(identical(other.failedCount, failedCount) || other.failedCount == failedCount)&&const DeepCollectionEquality().equals(other.errors, errors)&&const DeepCollectionEquality().equals(other.warnings, warnings)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.phase, phase) || other.phase == phase)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ruleId,status,currentUrl,currentPage,totalPages,extractedCount,failedCount,const DeepCollectionEquality().hash(errors),const DeepCollectionEquality().hash(warnings),startTime,endTime,phase,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'ExecutionState(id: $id, ruleId: $ruleId, status: $status, currentUrl: $currentUrl, currentPage: $currentPage, totalPages: $totalPages, extractedCount: $extractedCount, failedCount: $failedCount, errors: $errors, warnings: $warnings, startTime: $startTime, endTime: $endTime, phase: $phase, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ExecutionStateCopyWith<$Res>  {
  factory $ExecutionStateCopyWith(ExecutionState value, $Res Function(ExecutionState) _then) = _$ExecutionStateCopyWithImpl;
@useResult
$Res call({
 String id, String ruleId, ExecutionStatus status, String? currentUrl, int currentPage, int totalPages, int extractedCount, int failedCount, List<String> errors, List<String> warnings, DateTime? startTime, DateTime? endTime, ExecutionPhase phase, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$ExecutionStateCopyWithImpl<$Res>
    implements $ExecutionStateCopyWith<$Res> {
  _$ExecutionStateCopyWithImpl(this._self, this._then);

  final ExecutionState _self;
  final $Res Function(ExecutionState) _then;

/// Create a copy of ExecutionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ruleId = null,Object? status = null,Object? currentUrl = freezed,Object? currentPage = null,Object? totalPages = null,Object? extractedCount = null,Object? failedCount = null,Object? errors = null,Object? warnings = null,Object? startTime = freezed,Object? endTime = freezed,Object? phase = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExecutionStatus,currentUrl: freezed == currentUrl ? _self.currentUrl : currentUrl // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,extractedCount: null == extractedCount ? _self.extractedCount : extractedCount // ignore: cast_nullable_to_non_nullable
as int,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,warnings: null == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as ExecutionPhase,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExecutionState].
extension ExecutionStatePatterns on ExecutionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExecutionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExecutionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExecutionState value)  $default,){
final _that = this;
switch (_that) {
case _ExecutionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExecutionState value)?  $default,){
final _that = this;
switch (_that) {
case _ExecutionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ruleId,  ExecutionStatus status,  String? currentUrl,  int currentPage,  int totalPages,  int extractedCount,  int failedCount,  List<String> errors,  List<String> warnings,  DateTime? startTime,  DateTime? endTime,  ExecutionPhase phase,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExecutionState() when $default != null:
return $default(_that.id,_that.ruleId,_that.status,_that.currentUrl,_that.currentPage,_that.totalPages,_that.extractedCount,_that.failedCount,_that.errors,_that.warnings,_that.startTime,_that.endTime,_that.phase,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ruleId,  ExecutionStatus status,  String? currentUrl,  int currentPage,  int totalPages,  int extractedCount,  int failedCount,  List<String> errors,  List<String> warnings,  DateTime? startTime,  DateTime? endTime,  ExecutionPhase phase,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _ExecutionState():
return $default(_that.id,_that.ruleId,_that.status,_that.currentUrl,_that.currentPage,_that.totalPages,_that.extractedCount,_that.failedCount,_that.errors,_that.warnings,_that.startTime,_that.endTime,_that.phase,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ruleId,  ExecutionStatus status,  String? currentUrl,  int currentPage,  int totalPages,  int extractedCount,  int failedCount,  List<String> errors,  List<String> warnings,  DateTime? startTime,  DateTime? endTime,  ExecutionPhase phase,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _ExecutionState() when $default != null:
return $default(_that.id,_that.ruleId,_that.status,_that.currentUrl,_that.currentPage,_that.totalPages,_that.extractedCount,_that.failedCount,_that.errors,_that.warnings,_that.startTime,_that.endTime,_that.phase,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExecutionState implements ExecutionState {
  const _ExecutionState({required this.id, required this.ruleId, this.status = ExecutionStatus.idle, this.currentUrl, this.currentPage = 1, this.totalPages = 0, this.extractedCount = 0, this.failedCount = 0, final  List<String> errors = const [], final  List<String> warnings = const [], this.startTime, this.endTime, this.phase = ExecutionPhase.initializing, final  Map<String, dynamic> metadata = const {}}): _errors = errors,_warnings = warnings,_metadata = metadata;
  factory _ExecutionState.fromJson(Map<String, dynamic> json) => _$ExecutionStateFromJson(json);

/// 唯一执行 ID。
@override final  String id;
/// 正在执行的规则 ID。
@override final  String ruleId;
/// 当前状态。
@override@JsonKey() final  ExecutionStatus status;
/// 当前正在处理的 URL。
@override final  String? currentUrl;
/// 当前页码。
@override@JsonKey() final  int currentPage;
/// 总页数（0 = 未知/无限制）。
@override@JsonKey() final  int totalPages;
/// 目前已提取的项目数。
@override@JsonKey() final  int extractedCount;
/// 提取失败的项目数。
@override@JsonKey() final  int failedCount;
/// 遇到的错误列表。
 final  List<String> _errors;
/// 遇到的错误列表。
@override@JsonKey() List<String> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}

/// 警告列表。
 final  List<String> _warnings;
/// 警告列表。
@override@JsonKey() List<String> get warnings {
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_warnings);
}

/// 开始时间。
@override final  DateTime? startTime;
/// 结束时间。
@override final  DateTime? endTime;
/// 当前提取阶段。
@override@JsonKey() final  ExecutionPhase phase;
/// 额外的元数据。
 final  Map<String, dynamic> _metadata;
/// 额外的元数据。
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of ExecutionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExecutionStateCopyWith<_ExecutionState> get copyWith => __$ExecutionStateCopyWithImpl<_ExecutionState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExecutionStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExecutionState&&(identical(other.id, id) || other.id == id)&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.status, status) || other.status == status)&&(identical(other.currentUrl, currentUrl) || other.currentUrl == currentUrl)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.extractedCount, extractedCount) || other.extractedCount == extractedCount)&&(identical(other.failedCount, failedCount) || other.failedCount == failedCount)&&const DeepCollectionEquality().equals(other._errors, _errors)&&const DeepCollectionEquality().equals(other._warnings, _warnings)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.phase, phase) || other.phase == phase)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ruleId,status,currentUrl,currentPage,totalPages,extractedCount,failedCount,const DeepCollectionEquality().hash(_errors),const DeepCollectionEquality().hash(_warnings),startTime,endTime,phase,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'ExecutionState(id: $id, ruleId: $ruleId, status: $status, currentUrl: $currentUrl, currentPage: $currentPage, totalPages: $totalPages, extractedCount: $extractedCount, failedCount: $failedCount, errors: $errors, warnings: $warnings, startTime: $startTime, endTime: $endTime, phase: $phase, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ExecutionStateCopyWith<$Res> implements $ExecutionStateCopyWith<$Res> {
  factory _$ExecutionStateCopyWith(_ExecutionState value, $Res Function(_ExecutionState) _then) = __$ExecutionStateCopyWithImpl;
@override @useResult
$Res call({
 String id, String ruleId, ExecutionStatus status, String? currentUrl, int currentPage, int totalPages, int extractedCount, int failedCount, List<String> errors, List<String> warnings, DateTime? startTime, DateTime? endTime, ExecutionPhase phase, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$ExecutionStateCopyWithImpl<$Res>
    implements _$ExecutionStateCopyWith<$Res> {
  __$ExecutionStateCopyWithImpl(this._self, this._then);

  final _ExecutionState _self;
  final $Res Function(_ExecutionState) _then;

/// Create a copy of ExecutionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ruleId = null,Object? status = null,Object? currentUrl = freezed,Object? currentPage = null,Object? totalPages = null,Object? extractedCount = null,Object? failedCount = null,Object? errors = null,Object? warnings = null,Object? startTime = freezed,Object? endTime = freezed,Object? phase = null,Object? metadata = null,}) {
  return _then(_ExecutionState(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExecutionStatus,currentUrl: freezed == currentUrl ? _self.currentUrl : currentUrl // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,extractedCount: null == extractedCount ? _self.extractedCount : extractedCount // ignore: cast_nullable_to_non_nullable
as int,failedCount: null == failedCount ? _self.failedCount : failedCount // ignore: cast_nullable_to_non_nullable
as int,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,warnings: null == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,phase: null == phase ? _self.phase : phase // ignore: cast_nullable_to_non_nullable
as ExecutionPhase,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
