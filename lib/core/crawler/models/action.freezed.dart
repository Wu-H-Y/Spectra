// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CrawlerAction {

/// Action type.
 ActionType get type;/// Action parameters (varies by type).
/// - wait: {selector?: string, timeout?: int}
/// - click: {selector: string}
/// - scroll: {direction: "up"|"down", distance?: int}
/// - fill: {selector: string, value: string}
/// - script: {code: string}
/// - condition: {check: string, then: List<Action>, else?: List<Action>}
/// - loop: {count: int, actions: List<Action>, delay?: int}
 Map<String, dynamic> get params;
/// Create a copy of CrawlerAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerActionCopyWith<CrawlerAction> get copyWith => _$CrawlerActionCopyWithImpl<CrawlerAction>(this as CrawlerAction, _$identity);

  /// Serializes this CrawlerAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerAction&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.params, params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(params));

@override
String toString() {
  return 'CrawlerAction(type: $type, params: $params)';
}


}

/// @nodoc
abstract mixin class $CrawlerActionCopyWith<$Res>  {
  factory $CrawlerActionCopyWith(CrawlerAction value, $Res Function(CrawlerAction) _then) = _$CrawlerActionCopyWithImpl;
@useResult
$Res call({
 ActionType type, Map<String, dynamic> params
});




}
/// @nodoc
class _$CrawlerActionCopyWithImpl<$Res>
    implements $CrawlerActionCopyWith<$Res> {
  _$CrawlerActionCopyWithImpl(this._self, this._then);

  final CrawlerAction _self;
  final $Res Function(CrawlerAction) _then;

/// Create a copy of CrawlerAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? params = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ActionType,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [CrawlerAction].
extension CrawlerActionPatterns on CrawlerAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrawlerAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrawlerAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrawlerAction value)  $default,){
final _that = this;
switch (_that) {
case _CrawlerAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrawlerAction value)?  $default,){
final _that = this;
switch (_that) {
case _CrawlerAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ActionType type,  Map<String, dynamic> params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrawlerAction() when $default != null:
return $default(_that.type,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ActionType type,  Map<String, dynamic> params)  $default,) {final _that = this;
switch (_that) {
case _CrawlerAction():
return $default(_that.type,_that.params);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ActionType type,  Map<String, dynamic> params)?  $default,) {final _that = this;
switch (_that) {
case _CrawlerAction() when $default != null:
return $default(_that.type,_that.params);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CrawlerAction implements CrawlerAction {
  const _CrawlerAction({required this.type, required final  Map<String, dynamic> params}): _params = params;
  factory _CrawlerAction.fromJson(Map<String, dynamic> json) => _$CrawlerActionFromJson(json);

/// Action type.
@override final  ActionType type;
/// Action parameters (varies by type).
/// - wait: {selector?: string, timeout?: int}
/// - click: {selector: string}
/// - scroll: {direction: "up"|"down", distance?: int}
/// - fill: {selector: string, value: string}
/// - script: {code: string}
/// - condition: {check: string, then: List<Action>, else?: List<Action>}
/// - loop: {count: int, actions: List<Action>, delay?: int}
 final  Map<String, dynamic> _params;
/// Action parameters (varies by type).
/// - wait: {selector?: string, timeout?: int}
/// - click: {selector: string}
/// - scroll: {direction: "up"|"down", distance?: int}
/// - fill: {selector: string, value: string}
/// - script: {code: string}
/// - condition: {check: string, then: List<Action>, else?: List<Action>}
/// - loop: {count: int, actions: List<Action>, delay?: int}
@override Map<String, dynamic> get params {
  if (_params is EqualUnmodifiableMapView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_params);
}


/// Create a copy of CrawlerAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrawlerActionCopyWith<_CrawlerAction> get copyWith => __$CrawlerActionCopyWithImpl<_CrawlerAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CrawlerActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrawlerAction&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._params, _params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_params));

@override
String toString() {
  return 'CrawlerAction(type: $type, params: $params)';
}


}

/// @nodoc
abstract mixin class _$CrawlerActionCopyWith<$Res> implements $CrawlerActionCopyWith<$Res> {
  factory _$CrawlerActionCopyWith(_CrawlerAction value, $Res Function(_CrawlerAction) _then) = __$CrawlerActionCopyWithImpl;
@override @useResult
$Res call({
 ActionType type, Map<String, dynamic> params
});




}
/// @nodoc
class __$CrawlerActionCopyWithImpl<$Res>
    implements _$CrawlerActionCopyWith<$Res> {
  __$CrawlerActionCopyWithImpl(this._self, this._then);

  final _CrawlerAction _self;
  final $Res Function(_CrawlerAction) _then;

/// Create a copy of CrawlerAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? params = null,}) {
  return _then(_CrawlerAction(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ActionType,params: null == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$WaitAction {

/// Selector to wait for (optional - if null, waits for time).
 String? get selector;/// Timeout in milliseconds.
 int get timeout;
/// Create a copy of WaitAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WaitActionCopyWith<WaitAction> get copyWith => _$WaitActionCopyWithImpl<WaitAction>(this as WaitAction, _$identity);

  /// Serializes this WaitAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WaitAction&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.timeout, timeout) || other.timeout == timeout));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selector,timeout);

@override
String toString() {
  return 'WaitAction(selector: $selector, timeout: $timeout)';
}


}

/// @nodoc
abstract mixin class $WaitActionCopyWith<$Res>  {
  factory $WaitActionCopyWith(WaitAction value, $Res Function(WaitAction) _then) = _$WaitActionCopyWithImpl;
@useResult
$Res call({
 String? selector, int timeout
});




}
/// @nodoc
class _$WaitActionCopyWithImpl<$Res>
    implements $WaitActionCopyWith<$Res> {
  _$WaitActionCopyWithImpl(this._self, this._then);

  final WaitAction _self;
  final $Res Function(WaitAction) _then;

/// Create a copy of WaitAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selector = freezed,Object? timeout = null,}) {
  return _then(_self.copyWith(
selector: freezed == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String?,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WaitAction].
extension WaitActionPatterns on WaitAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WaitAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WaitAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WaitAction value)  $default,){
final _that = this;
switch (_that) {
case _WaitAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WaitAction value)?  $default,){
final _that = this;
switch (_that) {
case _WaitAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? selector,  int timeout)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WaitAction() when $default != null:
return $default(_that.selector,_that.timeout);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? selector,  int timeout)  $default,) {final _that = this;
switch (_that) {
case _WaitAction():
return $default(_that.selector,_that.timeout);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? selector,  int timeout)?  $default,) {final _that = this;
switch (_that) {
case _WaitAction() when $default != null:
return $default(_that.selector,_that.timeout);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WaitAction implements WaitAction {
  const _WaitAction({this.selector, this.timeout = 5000});
  factory _WaitAction.fromJson(Map<String, dynamic> json) => _$WaitActionFromJson(json);

/// Selector to wait for (optional - if null, waits for time).
@override final  String? selector;
/// Timeout in milliseconds.
@override@JsonKey() final  int timeout;

/// Create a copy of WaitAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WaitActionCopyWith<_WaitAction> get copyWith => __$WaitActionCopyWithImpl<_WaitAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WaitActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WaitAction&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.timeout, timeout) || other.timeout == timeout));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selector,timeout);

@override
String toString() {
  return 'WaitAction(selector: $selector, timeout: $timeout)';
}


}

/// @nodoc
abstract mixin class _$WaitActionCopyWith<$Res> implements $WaitActionCopyWith<$Res> {
  factory _$WaitActionCopyWith(_WaitAction value, $Res Function(_WaitAction) _then) = __$WaitActionCopyWithImpl;
@override @useResult
$Res call({
 String? selector, int timeout
});




}
/// @nodoc
class __$WaitActionCopyWithImpl<$Res>
    implements _$WaitActionCopyWith<$Res> {
  __$WaitActionCopyWithImpl(this._self, this._then);

  final _WaitAction _self;
  final $Res Function(_WaitAction) _then;

/// Create a copy of WaitAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selector = freezed,Object? timeout = null,}) {
  return _then(_WaitAction(
selector: freezed == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String?,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ClickAction {

/// Selector for element to click.
 String get selector;/// Whether to scroll element into view first.
 bool get scrollIntoView;
/// Create a copy of ClickAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClickActionCopyWith<ClickAction> get copyWith => _$ClickActionCopyWithImpl<ClickAction>(this as ClickAction, _$identity);

  /// Serializes this ClickAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClickAction&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.scrollIntoView, scrollIntoView) || other.scrollIntoView == scrollIntoView));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selector,scrollIntoView);

@override
String toString() {
  return 'ClickAction(selector: $selector, scrollIntoView: $scrollIntoView)';
}


}

/// @nodoc
abstract mixin class $ClickActionCopyWith<$Res>  {
  factory $ClickActionCopyWith(ClickAction value, $Res Function(ClickAction) _then) = _$ClickActionCopyWithImpl;
@useResult
$Res call({
 String selector, bool scrollIntoView
});




}
/// @nodoc
class _$ClickActionCopyWithImpl<$Res>
    implements $ClickActionCopyWith<$Res> {
  _$ClickActionCopyWithImpl(this._self, this._then);

  final ClickAction _self;
  final $Res Function(ClickAction) _then;

/// Create a copy of ClickAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selector = null,Object? scrollIntoView = null,}) {
  return _then(_self.copyWith(
selector: null == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String,scrollIntoView: null == scrollIntoView ? _self.scrollIntoView : scrollIntoView // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ClickAction].
extension ClickActionPatterns on ClickAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClickAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClickAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClickAction value)  $default,){
final _that = this;
switch (_that) {
case _ClickAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClickAction value)?  $default,){
final _that = this;
switch (_that) {
case _ClickAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String selector,  bool scrollIntoView)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClickAction() when $default != null:
return $default(_that.selector,_that.scrollIntoView);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String selector,  bool scrollIntoView)  $default,) {final _that = this;
switch (_that) {
case _ClickAction():
return $default(_that.selector,_that.scrollIntoView);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String selector,  bool scrollIntoView)?  $default,) {final _that = this;
switch (_that) {
case _ClickAction() when $default != null:
return $default(_that.selector,_that.scrollIntoView);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClickAction implements ClickAction {
  const _ClickAction({required this.selector, this.scrollIntoView = true});
  factory _ClickAction.fromJson(Map<String, dynamic> json) => _$ClickActionFromJson(json);

/// Selector for element to click.
@override final  String selector;
/// Whether to scroll element into view first.
@override@JsonKey() final  bool scrollIntoView;

/// Create a copy of ClickAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClickActionCopyWith<_ClickAction> get copyWith => __$ClickActionCopyWithImpl<_ClickAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClickActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClickAction&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.scrollIntoView, scrollIntoView) || other.scrollIntoView == scrollIntoView));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selector,scrollIntoView);

@override
String toString() {
  return 'ClickAction(selector: $selector, scrollIntoView: $scrollIntoView)';
}


}

/// @nodoc
abstract mixin class _$ClickActionCopyWith<$Res> implements $ClickActionCopyWith<$Res> {
  factory _$ClickActionCopyWith(_ClickAction value, $Res Function(_ClickAction) _then) = __$ClickActionCopyWithImpl;
@override @useResult
$Res call({
 String selector, bool scrollIntoView
});




}
/// @nodoc
class __$ClickActionCopyWithImpl<$Res>
    implements _$ClickActionCopyWith<$Res> {
  __$ClickActionCopyWithImpl(this._self, this._then);

  final _ClickAction _self;
  final $Res Function(_ClickAction) _then;

/// Create a copy of ClickAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selector = null,Object? scrollIntoView = null,}) {
  return _then(_ClickAction(
selector: null == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String,scrollIntoView: null == scrollIntoView ? _self.scrollIntoView : scrollIntoView // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ScrollAction {

/// Scroll direction.
 ScrollDirection get direction;/// Scroll distance in pixels (0 = scroll to end).
 int get distance;/// Scroll smoothly.
 bool get smooth;
/// Create a copy of ScrollAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScrollActionCopyWith<ScrollAction> get copyWith => _$ScrollActionCopyWithImpl<ScrollAction>(this as ScrollAction, _$identity);

  /// Serializes this ScrollAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScrollAction&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.smooth, smooth) || other.smooth == smooth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,direction,distance,smooth);

@override
String toString() {
  return 'ScrollAction(direction: $direction, distance: $distance, smooth: $smooth)';
}


}

/// @nodoc
abstract mixin class $ScrollActionCopyWith<$Res>  {
  factory $ScrollActionCopyWith(ScrollAction value, $Res Function(ScrollAction) _then) = _$ScrollActionCopyWithImpl;
@useResult
$Res call({
 ScrollDirection direction, int distance, bool smooth
});




}
/// @nodoc
class _$ScrollActionCopyWithImpl<$Res>
    implements $ScrollActionCopyWith<$Res> {
  _$ScrollActionCopyWithImpl(this._self, this._then);

  final ScrollAction _self;
  final $Res Function(ScrollAction) _then;

/// Create a copy of ScrollAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? direction = null,Object? distance = null,Object? smooth = null,}) {
  return _then(_self.copyWith(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as ScrollDirection,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as int,smooth: null == smooth ? _self.smooth : smooth // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ScrollAction].
extension ScrollActionPatterns on ScrollAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScrollAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScrollAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScrollAction value)  $default,){
final _that = this;
switch (_that) {
case _ScrollAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScrollAction value)?  $default,){
final _that = this;
switch (_that) {
case _ScrollAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ScrollDirection direction,  int distance,  bool smooth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScrollAction() when $default != null:
return $default(_that.direction,_that.distance,_that.smooth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ScrollDirection direction,  int distance,  bool smooth)  $default,) {final _that = this;
switch (_that) {
case _ScrollAction():
return $default(_that.direction,_that.distance,_that.smooth);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ScrollDirection direction,  int distance,  bool smooth)?  $default,) {final _that = this;
switch (_that) {
case _ScrollAction() when $default != null:
return $default(_that.direction,_that.distance,_that.smooth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScrollAction implements ScrollAction {
  const _ScrollAction({this.direction = ScrollDirection.down, this.distance = 0, this.smooth = true});
  factory _ScrollAction.fromJson(Map<String, dynamic> json) => _$ScrollActionFromJson(json);

/// Scroll direction.
@override@JsonKey() final  ScrollDirection direction;
/// Scroll distance in pixels (0 = scroll to end).
@override@JsonKey() final  int distance;
/// Scroll smoothly.
@override@JsonKey() final  bool smooth;

/// Create a copy of ScrollAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScrollActionCopyWith<_ScrollAction> get copyWith => __$ScrollActionCopyWithImpl<_ScrollAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScrollActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScrollAction&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.smooth, smooth) || other.smooth == smooth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,direction,distance,smooth);

@override
String toString() {
  return 'ScrollAction(direction: $direction, distance: $distance, smooth: $smooth)';
}


}

/// @nodoc
abstract mixin class _$ScrollActionCopyWith<$Res> implements $ScrollActionCopyWith<$Res> {
  factory _$ScrollActionCopyWith(_ScrollAction value, $Res Function(_ScrollAction) _then) = __$ScrollActionCopyWithImpl;
@override @useResult
$Res call({
 ScrollDirection direction, int distance, bool smooth
});




}
/// @nodoc
class __$ScrollActionCopyWithImpl<$Res>
    implements _$ScrollActionCopyWith<$Res> {
  __$ScrollActionCopyWithImpl(this._self, this._then);

  final _ScrollAction _self;
  final $Res Function(_ScrollAction) _then;

/// Create a copy of ScrollAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? direction = null,Object? distance = null,Object? smooth = null,}) {
  return _then(_ScrollAction(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as ScrollDirection,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as int,smooth: null == smooth ? _self.smooth : smooth // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$FillAction {

/// Selector for form field.
 String get selector;/// Value to fill.
 String get value;/// Whether to simulate typing (with delays).
 bool get simulateTyping;
/// Create a copy of FillAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FillActionCopyWith<FillAction> get copyWith => _$FillActionCopyWithImpl<FillAction>(this as FillAction, _$identity);

  /// Serializes this FillAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FillAction&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.value, value) || other.value == value)&&(identical(other.simulateTyping, simulateTyping) || other.simulateTyping == simulateTyping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selector,value,simulateTyping);

@override
String toString() {
  return 'FillAction(selector: $selector, value: $value, simulateTyping: $simulateTyping)';
}


}

/// @nodoc
abstract mixin class $FillActionCopyWith<$Res>  {
  factory $FillActionCopyWith(FillAction value, $Res Function(FillAction) _then) = _$FillActionCopyWithImpl;
@useResult
$Res call({
 String selector, String value, bool simulateTyping
});




}
/// @nodoc
class _$FillActionCopyWithImpl<$Res>
    implements $FillActionCopyWith<$Res> {
  _$FillActionCopyWithImpl(this._self, this._then);

  final FillAction _self;
  final $Res Function(FillAction) _then;

/// Create a copy of FillAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selector = null,Object? value = null,Object? simulateTyping = null,}) {
  return _then(_self.copyWith(
selector: null == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,simulateTyping: null == simulateTyping ? _self.simulateTyping : simulateTyping // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FillAction].
extension FillActionPatterns on FillAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FillAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FillAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FillAction value)  $default,){
final _that = this;
switch (_that) {
case _FillAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FillAction value)?  $default,){
final _that = this;
switch (_that) {
case _FillAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String selector,  String value,  bool simulateTyping)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FillAction() when $default != null:
return $default(_that.selector,_that.value,_that.simulateTyping);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String selector,  String value,  bool simulateTyping)  $default,) {final _that = this;
switch (_that) {
case _FillAction():
return $default(_that.selector,_that.value,_that.simulateTyping);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String selector,  String value,  bool simulateTyping)?  $default,) {final _that = this;
switch (_that) {
case _FillAction() when $default != null:
return $default(_that.selector,_that.value,_that.simulateTyping);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FillAction implements FillAction {
  const _FillAction({required this.selector, required this.value, this.simulateTyping = false});
  factory _FillAction.fromJson(Map<String, dynamic> json) => _$FillActionFromJson(json);

/// Selector for form field.
@override final  String selector;
/// Value to fill.
@override final  String value;
/// Whether to simulate typing (with delays).
@override@JsonKey() final  bool simulateTyping;

/// Create a copy of FillAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FillActionCopyWith<_FillAction> get copyWith => __$FillActionCopyWithImpl<_FillAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FillActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FillAction&&(identical(other.selector, selector) || other.selector == selector)&&(identical(other.value, value) || other.value == value)&&(identical(other.simulateTyping, simulateTyping) || other.simulateTyping == simulateTyping));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,selector,value,simulateTyping);

@override
String toString() {
  return 'FillAction(selector: $selector, value: $value, simulateTyping: $simulateTyping)';
}


}

/// @nodoc
abstract mixin class _$FillActionCopyWith<$Res> implements $FillActionCopyWith<$Res> {
  factory _$FillActionCopyWith(_FillAction value, $Res Function(_FillAction) _then) = __$FillActionCopyWithImpl;
@override @useResult
$Res call({
 String selector, String value, bool simulateTyping
});




}
/// @nodoc
class __$FillActionCopyWithImpl<$Res>
    implements _$FillActionCopyWith<$Res> {
  __$FillActionCopyWithImpl(this._self, this._then);

  final _FillAction _self;
  final $Res Function(_FillAction) _then;

/// Create a copy of FillAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selector = null,Object? value = null,Object? simulateTyping = null,}) {
  return _then(_FillAction(
selector: null == selector ? _self.selector : selector // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,simulateTyping: null == simulateTyping ? _self.simulateTyping : simulateTyping // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ScriptAction {

/// JavaScript code to execute.
 String get code;/// Whether to wait for script to complete.
 bool get awaitCompletion;
/// Create a copy of ScriptAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScriptActionCopyWith<ScriptAction> get copyWith => _$ScriptActionCopyWithImpl<ScriptAction>(this as ScriptAction, _$identity);

  /// Serializes this ScriptAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScriptAction&&(identical(other.code, code) || other.code == code)&&(identical(other.awaitCompletion, awaitCompletion) || other.awaitCompletion == awaitCompletion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,awaitCompletion);

@override
String toString() {
  return 'ScriptAction(code: $code, awaitCompletion: $awaitCompletion)';
}


}

/// @nodoc
abstract mixin class $ScriptActionCopyWith<$Res>  {
  factory $ScriptActionCopyWith(ScriptAction value, $Res Function(ScriptAction) _then) = _$ScriptActionCopyWithImpl;
@useResult
$Res call({
 String code, bool awaitCompletion
});




}
/// @nodoc
class _$ScriptActionCopyWithImpl<$Res>
    implements $ScriptActionCopyWith<$Res> {
  _$ScriptActionCopyWithImpl(this._self, this._then);

  final ScriptAction _self;
  final $Res Function(ScriptAction) _then;

/// Create a copy of ScriptAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? awaitCompletion = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,awaitCompletion: null == awaitCompletion ? _self.awaitCompletion : awaitCompletion // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ScriptAction].
extension ScriptActionPatterns on ScriptAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScriptAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScriptAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScriptAction value)  $default,){
final _that = this;
switch (_that) {
case _ScriptAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScriptAction value)?  $default,){
final _that = this;
switch (_that) {
case _ScriptAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  bool awaitCompletion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScriptAction() when $default != null:
return $default(_that.code,_that.awaitCompletion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  bool awaitCompletion)  $default,) {final _that = this;
switch (_that) {
case _ScriptAction():
return $default(_that.code,_that.awaitCompletion);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  bool awaitCompletion)?  $default,) {final _that = this;
switch (_that) {
case _ScriptAction() when $default != null:
return $default(_that.code,_that.awaitCompletion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScriptAction implements ScriptAction {
  const _ScriptAction({required this.code, this.awaitCompletion = true});
  factory _ScriptAction.fromJson(Map<String, dynamic> json) => _$ScriptActionFromJson(json);

/// JavaScript code to execute.
@override final  String code;
/// Whether to wait for script to complete.
@override@JsonKey() final  bool awaitCompletion;

/// Create a copy of ScriptAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScriptActionCopyWith<_ScriptAction> get copyWith => __$ScriptActionCopyWithImpl<_ScriptAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScriptActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScriptAction&&(identical(other.code, code) || other.code == code)&&(identical(other.awaitCompletion, awaitCompletion) || other.awaitCompletion == awaitCompletion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,awaitCompletion);

@override
String toString() {
  return 'ScriptAction(code: $code, awaitCompletion: $awaitCompletion)';
}


}

/// @nodoc
abstract mixin class _$ScriptActionCopyWith<$Res> implements $ScriptActionCopyWith<$Res> {
  factory _$ScriptActionCopyWith(_ScriptAction value, $Res Function(_ScriptAction) _then) = __$ScriptActionCopyWithImpl;
@override @useResult
$Res call({
 String code, bool awaitCompletion
});




}
/// @nodoc
class __$ScriptActionCopyWithImpl<$Res>
    implements _$ScriptActionCopyWith<$Res> {
  __$ScriptActionCopyWithImpl(this._self, this._then);

  final _ScriptAction _self;
  final $Res Function(_ScriptAction) _then;

/// Create a copy of ScriptAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? awaitCompletion = null,}) {
  return _then(_ScriptAction(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,awaitCompletion: null == awaitCompletion ? _self.awaitCompletion : awaitCompletion // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ConditionAction {

/// Condition to check (JavaScript expression or selector).
 String get check;/// Actions to execute if condition is true.
 List<CrawlerAction> get thenActions;/// Actions to execute if condition is false.
 List<CrawlerAction>? get elseActions;
/// Create a copy of ConditionAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConditionActionCopyWith<ConditionAction> get copyWith => _$ConditionActionCopyWithImpl<ConditionAction>(this as ConditionAction, _$identity);

  /// Serializes this ConditionAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConditionAction&&(identical(other.check, check) || other.check == check)&&const DeepCollectionEquality().equals(other.thenActions, thenActions)&&const DeepCollectionEquality().equals(other.elseActions, elseActions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,check,const DeepCollectionEquality().hash(thenActions),const DeepCollectionEquality().hash(elseActions));

@override
String toString() {
  return 'ConditionAction(check: $check, thenActions: $thenActions, elseActions: $elseActions)';
}


}

/// @nodoc
abstract mixin class $ConditionActionCopyWith<$Res>  {
  factory $ConditionActionCopyWith(ConditionAction value, $Res Function(ConditionAction) _then) = _$ConditionActionCopyWithImpl;
@useResult
$Res call({
 String check, List<CrawlerAction> thenActions, List<CrawlerAction>? elseActions
});




}
/// @nodoc
class _$ConditionActionCopyWithImpl<$Res>
    implements $ConditionActionCopyWith<$Res> {
  _$ConditionActionCopyWithImpl(this._self, this._then);

  final ConditionAction _self;
  final $Res Function(ConditionAction) _then;

/// Create a copy of ConditionAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? check = null,Object? thenActions = null,Object? elseActions = freezed,}) {
  return _then(_self.copyWith(
check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as String,thenActions: null == thenActions ? _self.thenActions : thenActions // ignore: cast_nullable_to_non_nullable
as List<CrawlerAction>,elseActions: freezed == elseActions ? _self.elseActions : elseActions // ignore: cast_nullable_to_non_nullable
as List<CrawlerAction>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConditionAction].
extension ConditionActionPatterns on ConditionAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConditionAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConditionAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConditionAction value)  $default,){
final _that = this;
switch (_that) {
case _ConditionAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConditionAction value)?  $default,){
final _that = this;
switch (_that) {
case _ConditionAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String check,  List<CrawlerAction> thenActions,  List<CrawlerAction>? elseActions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConditionAction() when $default != null:
return $default(_that.check,_that.thenActions,_that.elseActions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String check,  List<CrawlerAction> thenActions,  List<CrawlerAction>? elseActions)  $default,) {final _that = this;
switch (_that) {
case _ConditionAction():
return $default(_that.check,_that.thenActions,_that.elseActions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String check,  List<CrawlerAction> thenActions,  List<CrawlerAction>? elseActions)?  $default,) {final _that = this;
switch (_that) {
case _ConditionAction() when $default != null:
return $default(_that.check,_that.thenActions,_that.elseActions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConditionAction implements ConditionAction {
  const _ConditionAction({required this.check, required final  List<CrawlerAction> thenActions, final  List<CrawlerAction>? elseActions}): _thenActions = thenActions,_elseActions = elseActions;
  factory _ConditionAction.fromJson(Map<String, dynamic> json) => _$ConditionActionFromJson(json);

/// Condition to check (JavaScript expression or selector).
@override final  String check;
/// Actions to execute if condition is true.
 final  List<CrawlerAction> _thenActions;
/// Actions to execute if condition is true.
@override List<CrawlerAction> get thenActions {
  if (_thenActions is EqualUnmodifiableListView) return _thenActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_thenActions);
}

/// Actions to execute if condition is false.
 final  List<CrawlerAction>? _elseActions;
/// Actions to execute if condition is false.
@override List<CrawlerAction>? get elseActions {
  final value = _elseActions;
  if (value == null) return null;
  if (_elseActions is EqualUnmodifiableListView) return _elseActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ConditionAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConditionActionCopyWith<_ConditionAction> get copyWith => __$ConditionActionCopyWithImpl<_ConditionAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConditionActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConditionAction&&(identical(other.check, check) || other.check == check)&&const DeepCollectionEquality().equals(other._thenActions, _thenActions)&&const DeepCollectionEquality().equals(other._elseActions, _elseActions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,check,const DeepCollectionEquality().hash(_thenActions),const DeepCollectionEquality().hash(_elseActions));

@override
String toString() {
  return 'ConditionAction(check: $check, thenActions: $thenActions, elseActions: $elseActions)';
}


}

/// @nodoc
abstract mixin class _$ConditionActionCopyWith<$Res> implements $ConditionActionCopyWith<$Res> {
  factory _$ConditionActionCopyWith(_ConditionAction value, $Res Function(_ConditionAction) _then) = __$ConditionActionCopyWithImpl;
@override @useResult
$Res call({
 String check, List<CrawlerAction> thenActions, List<CrawlerAction>? elseActions
});




}
/// @nodoc
class __$ConditionActionCopyWithImpl<$Res>
    implements _$ConditionActionCopyWith<$Res> {
  __$ConditionActionCopyWithImpl(this._self, this._then);

  final _ConditionAction _self;
  final $Res Function(_ConditionAction) _then;

/// Create a copy of ConditionAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? check = null,Object? thenActions = null,Object? elseActions = freezed,}) {
  return _then(_ConditionAction(
check: null == check ? _self.check : check // ignore: cast_nullable_to_non_nullable
as String,thenActions: null == thenActions ? _self._thenActions : thenActions // ignore: cast_nullable_to_non_nullable
as List<CrawlerAction>,elseActions: freezed == elseActions ? _self._elseActions : elseActions // ignore: cast_nullable_to_non_nullable
as List<CrawlerAction>?,
  ));
}


}


/// @nodoc
mixin _$LoopAction {

/// Number of iterations.
 int get count;/// Actions to execute in each iteration.
 List<CrawlerAction> get actions;/// Delay between iterations in milliseconds.
 int get delayMs;
/// Create a copy of LoopAction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoopActionCopyWith<LoopAction> get copyWith => _$LoopActionCopyWithImpl<LoopAction>(this as LoopAction, _$identity);

  /// Serializes this LoopAction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoopAction&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.actions, actions)&&(identical(other.delayMs, delayMs) || other.delayMs == delayMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(actions),delayMs);

@override
String toString() {
  return 'LoopAction(count: $count, actions: $actions, delayMs: $delayMs)';
}


}

/// @nodoc
abstract mixin class $LoopActionCopyWith<$Res>  {
  factory $LoopActionCopyWith(LoopAction value, $Res Function(LoopAction) _then) = _$LoopActionCopyWithImpl;
@useResult
$Res call({
 int count, List<CrawlerAction> actions, int delayMs
});




}
/// @nodoc
class _$LoopActionCopyWithImpl<$Res>
    implements $LoopActionCopyWith<$Res> {
  _$LoopActionCopyWithImpl(this._self, this._then);

  final LoopAction _self;
  final $Res Function(LoopAction) _then;

/// Create a copy of LoopAction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? actions = null,Object? delayMs = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,actions: null == actions ? _self.actions : actions // ignore: cast_nullable_to_non_nullable
as List<CrawlerAction>,delayMs: null == delayMs ? _self.delayMs : delayMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LoopAction].
extension LoopActionPatterns on LoopAction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoopAction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoopAction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoopAction value)  $default,){
final _that = this;
switch (_that) {
case _LoopAction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoopAction value)?  $default,){
final _that = this;
switch (_that) {
case _LoopAction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  List<CrawlerAction> actions,  int delayMs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoopAction() when $default != null:
return $default(_that.count,_that.actions,_that.delayMs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  List<CrawlerAction> actions,  int delayMs)  $default,) {final _that = this;
switch (_that) {
case _LoopAction():
return $default(_that.count,_that.actions,_that.delayMs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  List<CrawlerAction> actions,  int delayMs)?  $default,) {final _that = this;
switch (_that) {
case _LoopAction() when $default != null:
return $default(_that.count,_that.actions,_that.delayMs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoopAction implements LoopAction {
  const _LoopAction({required this.count, required final  List<CrawlerAction> actions, this.delayMs = 1000}): _actions = actions;
  factory _LoopAction.fromJson(Map<String, dynamic> json) => _$LoopActionFromJson(json);

/// Number of iterations.
@override final  int count;
/// Actions to execute in each iteration.
 final  List<CrawlerAction> _actions;
/// Actions to execute in each iteration.
@override List<CrawlerAction> get actions {
  if (_actions is EqualUnmodifiableListView) return _actions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_actions);
}

/// Delay between iterations in milliseconds.
@override@JsonKey() final  int delayMs;

/// Create a copy of LoopAction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoopActionCopyWith<_LoopAction> get copyWith => __$LoopActionCopyWithImpl<_LoopAction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoopActionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoopAction&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._actions, _actions)&&(identical(other.delayMs, delayMs) || other.delayMs == delayMs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(_actions),delayMs);

@override
String toString() {
  return 'LoopAction(count: $count, actions: $actions, delayMs: $delayMs)';
}


}

/// @nodoc
abstract mixin class _$LoopActionCopyWith<$Res> implements $LoopActionCopyWith<$Res> {
  factory _$LoopActionCopyWith(_LoopAction value, $Res Function(_LoopAction) _then) = __$LoopActionCopyWithImpl;
@override @useResult
$Res call({
 int count, List<CrawlerAction> actions, int delayMs
});




}
/// @nodoc
class __$LoopActionCopyWithImpl<$Res>
    implements _$LoopActionCopyWith<$Res> {
  __$LoopActionCopyWithImpl(this._self, this._then);

  final _LoopAction _self;
  final $Res Function(_LoopAction) _then;

/// Create a copy of LoopAction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? actions = null,Object? delayMs = null,}) {
  return _then(_LoopAction(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,actions: null == actions ? _self._actions : actions // ignore: cast_nullable_to_non_nullable
as List<CrawlerAction>,delayMs: null == delayMs ? _self.delayMs : delayMs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
