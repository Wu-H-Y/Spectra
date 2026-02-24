// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExploreMenu {

/// 菜单名称。
 String get name;/// 菜单标识 (用于 {{category}} 变量)。
 String get key;/// 菜单选项。
 List<ExploreOption> get options;
/// Create a copy of ExploreMenu
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreMenuCopyWith<ExploreMenu> get copyWith => _$ExploreMenuCopyWithImpl<ExploreMenu>(this as ExploreMenu, _$identity);

  /// Serializes this ExploreMenu to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreMenu&&(identical(other.name, name) || other.name == name)&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,key,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'ExploreMenu(name: $name, key: $key, options: $options)';
}


}

/// @nodoc
abstract mixin class $ExploreMenuCopyWith<$Res>  {
  factory $ExploreMenuCopyWith(ExploreMenu value, $Res Function(ExploreMenu) _then) = _$ExploreMenuCopyWithImpl;
@useResult
$Res call({
 String name, String key, List<ExploreOption> options
});




}
/// @nodoc
class _$ExploreMenuCopyWithImpl<$Res>
    implements $ExploreMenuCopyWith<$Res> {
  _$ExploreMenuCopyWithImpl(this._self, this._then);

  final ExploreMenu _self;
  final $Res Function(ExploreMenu) _then;

/// Create a copy of ExploreMenu
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? key = null,Object? options = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<ExploreOption>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExploreMenu].
extension ExploreMenuPatterns on ExploreMenu {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreMenu value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreMenu() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreMenu value)  $default,){
final _that = this;
switch (_that) {
case _ExploreMenu():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreMenu value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreMenu() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String key,  List<ExploreOption> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreMenu() when $default != null:
return $default(_that.name,_that.key,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String key,  List<ExploreOption> options)  $default,) {final _that = this;
switch (_that) {
case _ExploreMenu():
return $default(_that.name,_that.key,_that.options);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String key,  List<ExploreOption> options)?  $default,) {final _that = this;
switch (_that) {
case _ExploreMenu() when $default != null:
return $default(_that.name,_that.key,_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExploreMenu implements ExploreMenu {
  const _ExploreMenu({required this.name, required this.key, required final  List<ExploreOption> options}): _options = options;
  factory _ExploreMenu.fromJson(Map<String, dynamic> json) => _$ExploreMenuFromJson(json);

/// 菜单名称。
@override final  String name;
/// 菜单标识 (用于 {{category}} 变量)。
@override final  String key;
/// 菜单选项。
 final  List<ExploreOption> _options;
/// 菜单选项。
@override List<ExploreOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of ExploreMenu
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreMenuCopyWith<_ExploreMenu> get copyWith => __$ExploreMenuCopyWithImpl<_ExploreMenu>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreMenuToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreMenu&&(identical(other.name, name) || other.name == name)&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,key,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'ExploreMenu(name: $name, key: $key, options: $options)';
}


}

/// @nodoc
abstract mixin class _$ExploreMenuCopyWith<$Res> implements $ExploreMenuCopyWith<$Res> {
  factory _$ExploreMenuCopyWith(_ExploreMenu value, $Res Function(_ExploreMenu) _then) = __$ExploreMenuCopyWithImpl;
@override @useResult
$Res call({
 String name, String key, List<ExploreOption> options
});




}
/// @nodoc
class __$ExploreMenuCopyWithImpl<$Res>
    implements _$ExploreMenuCopyWith<$Res> {
  __$ExploreMenuCopyWithImpl(this._self, this._then);

  final _ExploreMenu _self;
  final $Res Function(_ExploreMenu) _then;

/// Create a copy of ExploreMenu
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? key = null,Object? options = null,}) {
  return _then(_ExploreMenu(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<ExploreOption>,
  ));
}


}


/// @nodoc
mixin _$ExploreOption {

/// 选项名称。
 String get name;/// 选项值 (用于 URL 模板)。
 String get value;
/// Create a copy of ExploreOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreOptionCopyWith<ExploreOption> get copyWith => _$ExploreOptionCopyWithImpl<ExploreOption>(this as ExploreOption, _$identity);

  /// Serializes this ExploreOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreOption&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,value);

@override
String toString() {
  return 'ExploreOption(name: $name, value: $value)';
}


}

/// @nodoc
abstract mixin class $ExploreOptionCopyWith<$Res>  {
  factory $ExploreOptionCopyWith(ExploreOption value, $Res Function(ExploreOption) _then) = _$ExploreOptionCopyWithImpl;
@useResult
$Res call({
 String name, String value
});




}
/// @nodoc
class _$ExploreOptionCopyWithImpl<$Res>
    implements $ExploreOptionCopyWith<$Res> {
  _$ExploreOptionCopyWithImpl(this._self, this._then);

  final ExploreOption _self;
  final $Res Function(ExploreOption) _then;

/// Create a copy of ExploreOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? value = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ExploreOption].
extension ExploreOptionPatterns on ExploreOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreOption value)  $default,){
final _that = this;
switch (_that) {
case _ExploreOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreOption value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreOption() when $default != null:
return $default(_that.name,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String value)  $default,) {final _that = this;
switch (_that) {
case _ExploreOption():
return $default(_that.name,_that.value);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String value)?  $default,) {final _that = this;
switch (_that) {
case _ExploreOption() when $default != null:
return $default(_that.name,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExploreOption implements ExploreOption {
  const _ExploreOption({required this.name, required this.value});
  factory _ExploreOption.fromJson(Map<String, dynamic> json) => _$ExploreOptionFromJson(json);

/// 选项名称。
@override final  String name;
/// 选项值 (用于 URL 模板)。
@override final  String value;

/// Create a copy of ExploreOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreOptionCopyWith<_ExploreOption> get copyWith => __$ExploreOptionCopyWithImpl<_ExploreOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreOption&&(identical(other.name, name) || other.name == name)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,value);

@override
String toString() {
  return 'ExploreOption(name: $name, value: $value)';
}


}

/// @nodoc
abstract mixin class _$ExploreOptionCopyWith<$Res> implements $ExploreOptionCopyWith<$Res> {
  factory _$ExploreOptionCopyWith(_ExploreOption value, $Res Function(_ExploreOption) _then) = __$ExploreOptionCopyWithImpl;
@override @useResult
$Res call({
 String name, String value
});




}
/// @nodoc
class __$ExploreOptionCopyWithImpl<$Res>
    implements _$ExploreOptionCopyWith<$Res> {
  __$ExploreOptionCopyWithImpl(this._self, this._then);

  final _ExploreOption _self;
  final $Res Function(_ExploreOption) _then;

/// Create a copy of ExploreOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? value = null,}) {
  return _then(_ExploreOption(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ExploreConfig {

/// 请求 URL 模板 (支持 {{category}}, {{page}} 变量)。
 String get url;/// 列表项提取 Pipeline。
 Map<String, Pipeline> get list;/// 分类/筛选菜单。
 List<ExploreMenu>? get menus;/// 分页配置。
 PaginationConfig? get pagination;
/// Create a copy of ExploreConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreConfigCopyWith<ExploreConfig> get copyWith => _$ExploreConfigCopyWithImpl<ExploreConfig>(this as ExploreConfig, _$identity);

  /// Serializes this ExploreConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreConfig&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.list, list)&&const DeepCollectionEquality().equals(other.menus, menus)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,const DeepCollectionEquality().hash(list),const DeepCollectionEquality().hash(menus),pagination);

@override
String toString() {
  return 'ExploreConfig(url: $url, list: $list, menus: $menus, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $ExploreConfigCopyWith<$Res>  {
  factory $ExploreConfigCopyWith(ExploreConfig value, $Res Function(ExploreConfig) _then) = _$ExploreConfigCopyWithImpl;
@useResult
$Res call({
 String url, Map<String, Pipeline> list, List<ExploreMenu>? menus, PaginationConfig? pagination
});


$PaginationConfigCopyWith<$Res>? get pagination;

}
/// @nodoc
class _$ExploreConfigCopyWithImpl<$Res>
    implements $ExploreConfigCopyWith<$Res> {
  _$ExploreConfigCopyWithImpl(this._self, this._then);

  final ExploreConfig _self;
  final $Res Function(ExploreConfig) _then;

/// Create a copy of ExploreConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? list = null,Object? menus = freezed,Object? pagination = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as Map<String, Pipeline>,menus: freezed == menus ? _self.menus : menus // ignore: cast_nullable_to_non_nullable
as List<ExploreMenu>?,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationConfig?,
  ));
}
/// Create a copy of ExploreConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationConfigCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
    return null;
  }

  return $PaginationConfigCopyWith<$Res>(_self.pagination!, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExploreConfig].
extension ExploreConfigPatterns on ExploreConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreConfig value)  $default,){
final _that = this;
switch (_that) {
case _ExploreConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  Map<String, Pipeline> list,  List<ExploreMenu>? menus,  PaginationConfig? pagination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreConfig() when $default != null:
return $default(_that.url,_that.list,_that.menus,_that.pagination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  Map<String, Pipeline> list,  List<ExploreMenu>? menus,  PaginationConfig? pagination)  $default,) {final _that = this;
switch (_that) {
case _ExploreConfig():
return $default(_that.url,_that.list,_that.menus,_that.pagination);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  Map<String, Pipeline> list,  List<ExploreMenu>? menus,  PaginationConfig? pagination)?  $default,) {final _that = this;
switch (_that) {
case _ExploreConfig() when $default != null:
return $default(_that.url,_that.list,_that.menus,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExploreConfig implements ExploreConfig {
  const _ExploreConfig({required this.url, required final  Map<String, Pipeline> list, final  List<ExploreMenu>? menus, this.pagination}): _list = list,_menus = menus;
  factory _ExploreConfig.fromJson(Map<String, dynamic> json) => _$ExploreConfigFromJson(json);

/// 请求 URL 模板 (支持 {{category}}, {{page}} 变量)。
@override final  String url;
/// 列表项提取 Pipeline。
 final  Map<String, Pipeline> _list;
/// 列表项提取 Pipeline。
@override Map<String, Pipeline> get list {
  if (_list is EqualUnmodifiableMapView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_list);
}

/// 分类/筛选菜单。
 final  List<ExploreMenu>? _menus;
/// 分类/筛选菜单。
@override List<ExploreMenu>? get menus {
  final value = _menus;
  if (value == null) return null;
  if (_menus is EqualUnmodifiableListView) return _menus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// 分页配置。
@override final  PaginationConfig? pagination;

/// Create a copy of ExploreConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreConfigCopyWith<_ExploreConfig> get copyWith => __$ExploreConfigCopyWithImpl<_ExploreConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreConfig&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._list, _list)&&const DeepCollectionEquality().equals(other._menus, _menus)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,const DeepCollectionEquality().hash(_list),const DeepCollectionEquality().hash(_menus),pagination);

@override
String toString() {
  return 'ExploreConfig(url: $url, list: $list, menus: $menus, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$ExploreConfigCopyWith<$Res> implements $ExploreConfigCopyWith<$Res> {
  factory _$ExploreConfigCopyWith(_ExploreConfig value, $Res Function(_ExploreConfig) _then) = __$ExploreConfigCopyWithImpl;
@override @useResult
$Res call({
 String url, Map<String, Pipeline> list, List<ExploreMenu>? menus, PaginationConfig? pagination
});


@override $PaginationConfigCopyWith<$Res>? get pagination;

}
/// @nodoc
class __$ExploreConfigCopyWithImpl<$Res>
    implements _$ExploreConfigCopyWith<$Res> {
  __$ExploreConfigCopyWithImpl(this._self, this._then);

  final _ExploreConfig _self;
  final $Res Function(_ExploreConfig) _then;

/// Create a copy of ExploreConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? list = null,Object? menus = freezed,Object? pagination = freezed,}) {
  return _then(_ExploreConfig(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as Map<String, Pipeline>,menus: freezed == menus ? _self._menus : menus // ignore: cast_nullable_to_non_nullable
as List<ExploreMenu>?,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationConfig?,
  ));
}

/// Create a copy of ExploreConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationConfigCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
    return null;
  }

  return $PaginationConfigCopyWith<$Res>(_self.pagination!, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}

// dart format on
