// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extract_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListExtract {

/// Selector for list item containers.
 Selector get container;/// Field mappings for each list item.
 List<FieldMapping> get items;/// Pagination configuration.
 PaginationConfig? get pagination;/// URL for list page (optional, uses rule pattern if not specified).
 String? get url;
/// Create a copy of ListExtract
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListExtractCopyWith<ListExtract> get copyWith => _$ListExtractCopyWithImpl<ListExtract>(this as ListExtract, _$identity);

  /// Serializes this ListExtract to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListExtract&&(identical(other.container, container) || other.container == container)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,container,const DeepCollectionEquality().hash(items),pagination,url);

@override
String toString() {
  return 'ListExtract(container: $container, items: $items, pagination: $pagination, url: $url)';
}


}

/// @nodoc
abstract mixin class $ListExtractCopyWith<$Res>  {
  factory $ListExtractCopyWith(ListExtract value, $Res Function(ListExtract) _then) = _$ListExtractCopyWithImpl;
@useResult
$Res call({
 Selector container, List<FieldMapping> items, PaginationConfig? pagination, String? url
});


$SelectorCopyWith<$Res> get container;$PaginationConfigCopyWith<$Res>? get pagination;

}
/// @nodoc
class _$ListExtractCopyWithImpl<$Res>
    implements $ListExtractCopyWith<$Res> {
  _$ListExtractCopyWithImpl(this._self, this._then);

  final ListExtract _self;
  final $Res Function(ListExtract) _then;

/// Create a copy of ListExtract
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? container = null,Object? items = null,Object? pagination = freezed,Object? url = freezed,}) {
  return _then(_self.copyWith(
container: null == container ? _self.container : container // ignore: cast_nullable_to_non_nullable
as Selector,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<FieldMapping>,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationConfig?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ListExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res> get container {
  
  return $SelectorCopyWith<$Res>(_self.container, (value) {
    return _then(_self.copyWith(container: value));
  });
}/// Create a copy of ListExtract
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


/// Adds pattern-matching-related methods to [ListExtract].
extension ListExtractPatterns on ListExtract {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListExtract value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListExtract() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListExtract value)  $default,){
final _that = this;
switch (_that) {
case _ListExtract():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListExtract value)?  $default,){
final _that = this;
switch (_that) {
case _ListExtract() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Selector container,  List<FieldMapping> items,  PaginationConfig? pagination,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListExtract() when $default != null:
return $default(_that.container,_that.items,_that.pagination,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Selector container,  List<FieldMapping> items,  PaginationConfig? pagination,  String? url)  $default,) {final _that = this;
switch (_that) {
case _ListExtract():
return $default(_that.container,_that.items,_that.pagination,_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Selector container,  List<FieldMapping> items,  PaginationConfig? pagination,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _ListExtract() when $default != null:
return $default(_that.container,_that.items,_that.pagination,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListExtract implements ListExtract {
  const _ListExtract({required this.container, required final  List<FieldMapping> items, this.pagination, this.url}): _items = items;
  factory _ListExtract.fromJson(Map<String, dynamic> json) => _$ListExtractFromJson(json);

/// Selector for list item containers.
@override final  Selector container;
/// Field mappings for each list item.
 final  List<FieldMapping> _items;
/// Field mappings for each list item.
@override List<FieldMapping> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// Pagination configuration.
@override final  PaginationConfig? pagination;
/// URL for list page (optional, uses rule pattern if not specified).
@override final  String? url;

/// Create a copy of ListExtract
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListExtractCopyWith<_ListExtract> get copyWith => __$ListExtractCopyWithImpl<_ListExtract>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListExtractToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListExtract&&(identical(other.container, container) || other.container == container)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.pagination, pagination) || other.pagination == pagination)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,container,const DeepCollectionEquality().hash(_items),pagination,url);

@override
String toString() {
  return 'ListExtract(container: $container, items: $items, pagination: $pagination, url: $url)';
}


}

/// @nodoc
abstract mixin class _$ListExtractCopyWith<$Res> implements $ListExtractCopyWith<$Res> {
  factory _$ListExtractCopyWith(_ListExtract value, $Res Function(_ListExtract) _then) = __$ListExtractCopyWithImpl;
@override @useResult
$Res call({
 Selector container, List<FieldMapping> items, PaginationConfig? pagination, String? url
});


@override $SelectorCopyWith<$Res> get container;@override $PaginationConfigCopyWith<$Res>? get pagination;

}
/// @nodoc
class __$ListExtractCopyWithImpl<$Res>
    implements _$ListExtractCopyWith<$Res> {
  __$ListExtractCopyWithImpl(this._self, this._then);

  final _ListExtract _self;
  final $Res Function(_ListExtract) _then;

/// Create a copy of ListExtract
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? container = null,Object? items = null,Object? pagination = freezed,Object? url = freezed,}) {
  return _then(_ListExtract(
container: null == container ? _self.container : container // ignore: cast_nullable_to_non_nullable
as Selector,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<FieldMapping>,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as PaginationConfig?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ListExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res> get container {
  
  return $SelectorCopyWith<$Res>(_self.container, (value) {
    return _then(_self.copyWith(container: value));
  });
}/// Create a copy of ListExtract
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


/// @nodoc
mixin _$DetailExtract {

/// Selector to get detail URL from list item.
 Selector? get urlFromList;/// Field mappings for detail page.
 List<FieldMapping> get items;/// Chapter/episode extraction (for comics, novels, videos).
 ChapterExtract? get chapters;
/// Create a copy of DetailExtract
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailExtractCopyWith<DetailExtract> get copyWith => _$DetailExtractCopyWithImpl<DetailExtract>(this as DetailExtract, _$identity);

  /// Serializes this DetailExtract to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailExtract&&(identical(other.urlFromList, urlFromList) || other.urlFromList == urlFromList)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.chapters, chapters) || other.chapters == chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,urlFromList,const DeepCollectionEquality().hash(items),chapters);

@override
String toString() {
  return 'DetailExtract(urlFromList: $urlFromList, items: $items, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class $DetailExtractCopyWith<$Res>  {
  factory $DetailExtractCopyWith(DetailExtract value, $Res Function(DetailExtract) _then) = _$DetailExtractCopyWithImpl;
@useResult
$Res call({
 Selector? urlFromList, List<FieldMapping> items, ChapterExtract? chapters
});


$SelectorCopyWith<$Res>? get urlFromList;$ChapterExtractCopyWith<$Res>? get chapters;

}
/// @nodoc
class _$DetailExtractCopyWithImpl<$Res>
    implements $DetailExtractCopyWith<$Res> {
  _$DetailExtractCopyWithImpl(this._self, this._then);

  final DetailExtract _self;
  final $Res Function(DetailExtract) _then;

/// Create a copy of DetailExtract
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? urlFromList = freezed,Object? items = null,Object? chapters = freezed,}) {
  return _then(_self.copyWith(
urlFromList: freezed == urlFromList ? _self.urlFromList : urlFromList // ignore: cast_nullable_to_non_nullable
as Selector?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<FieldMapping>,chapters: freezed == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as ChapterExtract?,
  ));
}
/// Create a copy of DetailExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get urlFromList {
    if (_self.urlFromList == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.urlFromList!, (value) {
    return _then(_self.copyWith(urlFromList: value));
  });
}/// Create a copy of DetailExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChapterExtractCopyWith<$Res>? get chapters {
    if (_self.chapters == null) {
    return null;
  }

  return $ChapterExtractCopyWith<$Res>(_self.chapters!, (value) {
    return _then(_self.copyWith(chapters: value));
  });
}
}


/// Adds pattern-matching-related methods to [DetailExtract].
extension DetailExtractPatterns on DetailExtract {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DetailExtract value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetailExtract() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DetailExtract value)  $default,){
final _that = this;
switch (_that) {
case _DetailExtract():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DetailExtract value)?  $default,){
final _that = this;
switch (_that) {
case _DetailExtract() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Selector? urlFromList,  List<FieldMapping> items,  ChapterExtract? chapters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetailExtract() when $default != null:
return $default(_that.urlFromList,_that.items,_that.chapters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Selector? urlFromList,  List<FieldMapping> items,  ChapterExtract? chapters)  $default,) {final _that = this;
switch (_that) {
case _DetailExtract():
return $default(_that.urlFromList,_that.items,_that.chapters);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Selector? urlFromList,  List<FieldMapping> items,  ChapterExtract? chapters)?  $default,) {final _that = this;
switch (_that) {
case _DetailExtract() when $default != null:
return $default(_that.urlFromList,_that.items,_that.chapters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DetailExtract implements DetailExtract {
  const _DetailExtract({this.urlFromList, required final  List<FieldMapping> items, this.chapters}): _items = items;
  factory _DetailExtract.fromJson(Map<String, dynamic> json) => _$DetailExtractFromJson(json);

/// Selector to get detail URL from list item.
@override final  Selector? urlFromList;
/// Field mappings for detail page.
 final  List<FieldMapping> _items;
/// Field mappings for detail page.
@override List<FieldMapping> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// Chapter/episode extraction (for comics, novels, videos).
@override final  ChapterExtract? chapters;

/// Create a copy of DetailExtract
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailExtractCopyWith<_DetailExtract> get copyWith => __$DetailExtractCopyWithImpl<_DetailExtract>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DetailExtractToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailExtract&&(identical(other.urlFromList, urlFromList) || other.urlFromList == urlFromList)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.chapters, chapters) || other.chapters == chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,urlFromList,const DeepCollectionEquality().hash(_items),chapters);

@override
String toString() {
  return 'DetailExtract(urlFromList: $urlFromList, items: $items, chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class _$DetailExtractCopyWith<$Res> implements $DetailExtractCopyWith<$Res> {
  factory _$DetailExtractCopyWith(_DetailExtract value, $Res Function(_DetailExtract) _then) = __$DetailExtractCopyWithImpl;
@override @useResult
$Res call({
 Selector? urlFromList, List<FieldMapping> items, ChapterExtract? chapters
});


@override $SelectorCopyWith<$Res>? get urlFromList;@override $ChapterExtractCopyWith<$Res>? get chapters;

}
/// @nodoc
class __$DetailExtractCopyWithImpl<$Res>
    implements _$DetailExtractCopyWith<$Res> {
  __$DetailExtractCopyWithImpl(this._self, this._then);

  final _DetailExtract _self;
  final $Res Function(_DetailExtract) _then;

/// Create a copy of DetailExtract
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? urlFromList = freezed,Object? items = null,Object? chapters = freezed,}) {
  return _then(_DetailExtract(
urlFromList: freezed == urlFromList ? _self.urlFromList : urlFromList // ignore: cast_nullable_to_non_nullable
as Selector?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<FieldMapping>,chapters: freezed == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as ChapterExtract?,
  ));
}

/// Create a copy of DetailExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get urlFromList {
    if (_self.urlFromList == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.urlFromList!, (value) {
    return _then(_self.copyWith(urlFromList: value));
  });
}/// Create a copy of DetailExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChapterExtractCopyWith<$Res>? get chapters {
    if (_self.chapters == null) {
    return null;
  }

  return $ChapterExtractCopyWith<$Res>(_self.chapters!, (value) {
    return _then(_self.copyWith(chapters: value));
  });
}
}


/// @nodoc
mixin _$ChapterExtract {

/// Selector for chapter list container.
 Selector get container;/// Field mappings for each chapter.
 List<FieldMapping> get items;/// Whether chapters are in reverse order (newest first).
 bool get reverseOrder;
/// Create a copy of ChapterExtract
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterExtractCopyWith<ChapterExtract> get copyWith => _$ChapterExtractCopyWithImpl<ChapterExtract>(this as ChapterExtract, _$identity);

  /// Serializes this ChapterExtract to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterExtract&&(identical(other.container, container) || other.container == container)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.reverseOrder, reverseOrder) || other.reverseOrder == reverseOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,container,const DeepCollectionEquality().hash(items),reverseOrder);

@override
String toString() {
  return 'ChapterExtract(container: $container, items: $items, reverseOrder: $reverseOrder)';
}


}

/// @nodoc
abstract mixin class $ChapterExtractCopyWith<$Res>  {
  factory $ChapterExtractCopyWith(ChapterExtract value, $Res Function(ChapterExtract) _then) = _$ChapterExtractCopyWithImpl;
@useResult
$Res call({
 Selector container, List<FieldMapping> items, bool reverseOrder
});


$SelectorCopyWith<$Res> get container;

}
/// @nodoc
class _$ChapterExtractCopyWithImpl<$Res>
    implements $ChapterExtractCopyWith<$Res> {
  _$ChapterExtractCopyWithImpl(this._self, this._then);

  final ChapterExtract _self;
  final $Res Function(ChapterExtract) _then;

/// Create a copy of ChapterExtract
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? container = null,Object? items = null,Object? reverseOrder = null,}) {
  return _then(_self.copyWith(
container: null == container ? _self.container : container // ignore: cast_nullable_to_non_nullable
as Selector,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<FieldMapping>,reverseOrder: null == reverseOrder ? _self.reverseOrder : reverseOrder // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ChapterExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res> get container {
  
  return $SelectorCopyWith<$Res>(_self.container, (value) {
    return _then(_self.copyWith(container: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChapterExtract].
extension ChapterExtractPatterns on ChapterExtract {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterExtract value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterExtract() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterExtract value)  $default,){
final _that = this;
switch (_that) {
case _ChapterExtract():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterExtract value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterExtract() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Selector container,  List<FieldMapping> items,  bool reverseOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterExtract() when $default != null:
return $default(_that.container,_that.items,_that.reverseOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Selector container,  List<FieldMapping> items,  bool reverseOrder)  $default,) {final _that = this;
switch (_that) {
case _ChapterExtract():
return $default(_that.container,_that.items,_that.reverseOrder);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Selector container,  List<FieldMapping> items,  bool reverseOrder)?  $default,) {final _that = this;
switch (_that) {
case _ChapterExtract() when $default != null:
return $default(_that.container,_that.items,_that.reverseOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChapterExtract implements ChapterExtract {
  const _ChapterExtract({required this.container, required final  List<FieldMapping> items, this.reverseOrder = false}): _items = items;
  factory _ChapterExtract.fromJson(Map<String, dynamic> json) => _$ChapterExtractFromJson(json);

/// Selector for chapter list container.
@override final  Selector container;
/// Field mappings for each chapter.
 final  List<FieldMapping> _items;
/// Field mappings for each chapter.
@override List<FieldMapping> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// Whether chapters are in reverse order (newest first).
@override@JsonKey() final  bool reverseOrder;

/// Create a copy of ChapterExtract
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterExtractCopyWith<_ChapterExtract> get copyWith => __$ChapterExtractCopyWithImpl<_ChapterExtract>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterExtractToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterExtract&&(identical(other.container, container) || other.container == container)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.reverseOrder, reverseOrder) || other.reverseOrder == reverseOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,container,const DeepCollectionEquality().hash(_items),reverseOrder);

@override
String toString() {
  return 'ChapterExtract(container: $container, items: $items, reverseOrder: $reverseOrder)';
}


}

/// @nodoc
abstract mixin class _$ChapterExtractCopyWith<$Res> implements $ChapterExtractCopyWith<$Res> {
  factory _$ChapterExtractCopyWith(_ChapterExtract value, $Res Function(_ChapterExtract) _then) = __$ChapterExtractCopyWithImpl;
@override @useResult
$Res call({
 Selector container, List<FieldMapping> items, bool reverseOrder
});


@override $SelectorCopyWith<$Res> get container;

}
/// @nodoc
class __$ChapterExtractCopyWithImpl<$Res>
    implements _$ChapterExtractCopyWith<$Res> {
  __$ChapterExtractCopyWithImpl(this._self, this._then);

  final _ChapterExtract _self;
  final $Res Function(_ChapterExtract) _then;

/// Create a copy of ChapterExtract
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? container = null,Object? items = null,Object? reverseOrder = null,}) {
  return _then(_ChapterExtract(
container: null == container ? _self.container : container // ignore: cast_nullable_to_non_nullable
as Selector,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<FieldMapping>,reverseOrder: null == reverseOrder ? _self.reverseOrder : reverseOrder // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ChapterExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res> get container {
  
  return $SelectorCopyWith<$Res>(_self.container, (value) {
    return _then(_self.copyWith(container: value));
  });
}
}


/// @nodoc
mixin _$ContentExtract {

/// Video extraction config.
 VideoExtract? get video;/// Comic extraction config.
 ComicExtract? get comic;/// Novel extraction config.
 NovelExtract? get novel;/// Music extraction config.
 MusicExtract? get music;
/// Create a copy of ContentExtract
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentExtractCopyWith<ContentExtract> get copyWith => _$ContentExtractCopyWithImpl<ContentExtract>(this as ContentExtract, _$identity);

  /// Serializes this ContentExtract to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentExtract&&(identical(other.video, video) || other.video == video)&&(identical(other.comic, comic) || other.comic == comic)&&(identical(other.novel, novel) || other.novel == novel)&&(identical(other.music, music) || other.music == music));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,video,comic,novel,music);

@override
String toString() {
  return 'ContentExtract(video: $video, comic: $comic, novel: $novel, music: $music)';
}


}

/// @nodoc
abstract mixin class $ContentExtractCopyWith<$Res>  {
  factory $ContentExtractCopyWith(ContentExtract value, $Res Function(ContentExtract) _then) = _$ContentExtractCopyWithImpl;
@useResult
$Res call({
 VideoExtract? video, ComicExtract? comic, NovelExtract? novel, MusicExtract? music
});


$VideoExtractCopyWith<$Res>? get video;$ComicExtractCopyWith<$Res>? get comic;$NovelExtractCopyWith<$Res>? get novel;$MusicExtractCopyWith<$Res>? get music;

}
/// @nodoc
class _$ContentExtractCopyWithImpl<$Res>
    implements $ContentExtractCopyWith<$Res> {
  _$ContentExtractCopyWithImpl(this._self, this._then);

  final ContentExtract _self;
  final $Res Function(ContentExtract) _then;

/// Create a copy of ContentExtract
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? video = freezed,Object? comic = freezed,Object? novel = freezed,Object? music = freezed,}) {
  return _then(_self.copyWith(
video: freezed == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as VideoExtract?,comic: freezed == comic ? _self.comic : comic // ignore: cast_nullable_to_non_nullable
as ComicExtract?,novel: freezed == novel ? _self.novel : novel // ignore: cast_nullable_to_non_nullable
as NovelExtract?,music: freezed == music ? _self.music : music // ignore: cast_nullable_to_non_nullable
as MusicExtract?,
  ));
}
/// Create a copy of ContentExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoExtractCopyWith<$Res>? get video {
    if (_self.video == null) {
    return null;
  }

  return $VideoExtractCopyWith<$Res>(_self.video!, (value) {
    return _then(_self.copyWith(video: value));
  });
}/// Create a copy of ContentExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComicExtractCopyWith<$Res>? get comic {
    if (_self.comic == null) {
    return null;
  }

  return $ComicExtractCopyWith<$Res>(_self.comic!, (value) {
    return _then(_self.copyWith(comic: value));
  });
}/// Create a copy of ContentExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NovelExtractCopyWith<$Res>? get novel {
    if (_self.novel == null) {
    return null;
  }

  return $NovelExtractCopyWith<$Res>(_self.novel!, (value) {
    return _then(_self.copyWith(novel: value));
  });
}/// Create a copy of ContentExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MusicExtractCopyWith<$Res>? get music {
    if (_self.music == null) {
    return null;
  }

  return $MusicExtractCopyWith<$Res>(_self.music!, (value) {
    return _then(_self.copyWith(music: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContentExtract].
extension ContentExtractPatterns on ContentExtract {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentExtract value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentExtract() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentExtract value)  $default,){
final _that = this;
switch (_that) {
case _ContentExtract():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentExtract value)?  $default,){
final _that = this;
switch (_that) {
case _ContentExtract() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( VideoExtract? video,  ComicExtract? comic,  NovelExtract? novel,  MusicExtract? music)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentExtract() when $default != null:
return $default(_that.video,_that.comic,_that.novel,_that.music);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( VideoExtract? video,  ComicExtract? comic,  NovelExtract? novel,  MusicExtract? music)  $default,) {final _that = this;
switch (_that) {
case _ContentExtract():
return $default(_that.video,_that.comic,_that.novel,_that.music);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( VideoExtract? video,  ComicExtract? comic,  NovelExtract? novel,  MusicExtract? music)?  $default,) {final _that = this;
switch (_that) {
case _ContentExtract() when $default != null:
return $default(_that.video,_that.comic,_that.novel,_that.music);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentExtract implements ContentExtract {
  const _ContentExtract({this.video, this.comic, this.novel, this.music});
  factory _ContentExtract.fromJson(Map<String, dynamic> json) => _$ContentExtractFromJson(json);

/// Video extraction config.
@override final  VideoExtract? video;
/// Comic extraction config.
@override final  ComicExtract? comic;
/// Novel extraction config.
@override final  NovelExtract? novel;
/// Music extraction config.
@override final  MusicExtract? music;

/// Create a copy of ContentExtract
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentExtractCopyWith<_ContentExtract> get copyWith => __$ContentExtractCopyWithImpl<_ContentExtract>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentExtractToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentExtract&&(identical(other.video, video) || other.video == video)&&(identical(other.comic, comic) || other.comic == comic)&&(identical(other.novel, novel) || other.novel == novel)&&(identical(other.music, music) || other.music == music));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,video,comic,novel,music);

@override
String toString() {
  return 'ContentExtract(video: $video, comic: $comic, novel: $novel, music: $music)';
}


}

/// @nodoc
abstract mixin class _$ContentExtractCopyWith<$Res> implements $ContentExtractCopyWith<$Res> {
  factory _$ContentExtractCopyWith(_ContentExtract value, $Res Function(_ContentExtract) _then) = __$ContentExtractCopyWithImpl;
@override @useResult
$Res call({
 VideoExtract? video, ComicExtract? comic, NovelExtract? novel, MusicExtract? music
});


@override $VideoExtractCopyWith<$Res>? get video;@override $ComicExtractCopyWith<$Res>? get comic;@override $NovelExtractCopyWith<$Res>? get novel;@override $MusicExtractCopyWith<$Res>? get music;

}
/// @nodoc
class __$ContentExtractCopyWithImpl<$Res>
    implements _$ContentExtractCopyWith<$Res> {
  __$ContentExtractCopyWithImpl(this._self, this._then);

  final _ContentExtract _self;
  final $Res Function(_ContentExtract) _then;

/// Create a copy of ContentExtract
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? video = freezed,Object? comic = freezed,Object? novel = freezed,Object? music = freezed,}) {
  return _then(_ContentExtract(
video: freezed == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as VideoExtract?,comic: freezed == comic ? _self.comic : comic // ignore: cast_nullable_to_non_nullable
as ComicExtract?,novel: freezed == novel ? _self.novel : novel // ignore: cast_nullable_to_non_nullable
as NovelExtract?,music: freezed == music ? _self.music : music // ignore: cast_nullable_to_non_nullable
as MusicExtract?,
  ));
}

/// Create a copy of ContentExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$VideoExtractCopyWith<$Res>? get video {
    if (_self.video == null) {
    return null;
  }

  return $VideoExtractCopyWith<$Res>(_self.video!, (value) {
    return _then(_self.copyWith(video: value));
  });
}/// Create a copy of ContentExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComicExtractCopyWith<$Res>? get comic {
    if (_self.comic == null) {
    return null;
  }

  return $ComicExtractCopyWith<$Res>(_self.comic!, (value) {
    return _then(_self.copyWith(comic: value));
  });
}/// Create a copy of ContentExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NovelExtractCopyWith<$Res>? get novel {
    if (_self.novel == null) {
    return null;
  }

  return $NovelExtractCopyWith<$Res>(_self.novel!, (value) {
    return _then(_self.copyWith(novel: value));
  });
}/// Create a copy of ContentExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MusicExtractCopyWith<$Res>? get music {
    if (_self.music == null) {
    return null;
  }

  return $MusicExtractCopyWith<$Res>(_self.music!, (value) {
    return _then(_self.copyWith(music: value));
  });
}
}


/// @nodoc
mixin _$VideoExtract {

/// Selector for video URL.
 Selector? get playUrl;/// Selector for quality options.
 Selector? get qualities;/// JavaScript to extract video info.
 String? get jsExtract;
/// Create a copy of VideoExtract
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoExtractCopyWith<VideoExtract> get copyWith => _$VideoExtractCopyWithImpl<VideoExtract>(this as VideoExtract, _$identity);

  /// Serializes this VideoExtract to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoExtract&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl)&&(identical(other.qualities, qualities) || other.qualities == qualities)&&(identical(other.jsExtract, jsExtract) || other.jsExtract == jsExtract));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playUrl,qualities,jsExtract);

@override
String toString() {
  return 'VideoExtract(playUrl: $playUrl, qualities: $qualities, jsExtract: $jsExtract)';
}


}

/// @nodoc
abstract mixin class $VideoExtractCopyWith<$Res>  {
  factory $VideoExtractCopyWith(VideoExtract value, $Res Function(VideoExtract) _then) = _$VideoExtractCopyWithImpl;
@useResult
$Res call({
 Selector? playUrl, Selector? qualities, String? jsExtract
});


$SelectorCopyWith<$Res>? get playUrl;$SelectorCopyWith<$Res>? get qualities;

}
/// @nodoc
class _$VideoExtractCopyWithImpl<$Res>
    implements $VideoExtractCopyWith<$Res> {
  _$VideoExtractCopyWithImpl(this._self, this._then);

  final VideoExtract _self;
  final $Res Function(VideoExtract) _then;

/// Create a copy of VideoExtract
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playUrl = freezed,Object? qualities = freezed,Object? jsExtract = freezed,}) {
  return _then(_self.copyWith(
playUrl: freezed == playUrl ? _self.playUrl : playUrl // ignore: cast_nullable_to_non_nullable
as Selector?,qualities: freezed == qualities ? _self.qualities : qualities // ignore: cast_nullable_to_non_nullable
as Selector?,jsExtract: freezed == jsExtract ? _self.jsExtract : jsExtract // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of VideoExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get playUrl {
    if (_self.playUrl == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.playUrl!, (value) {
    return _then(_self.copyWith(playUrl: value));
  });
}/// Create a copy of VideoExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get qualities {
    if (_self.qualities == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.qualities!, (value) {
    return _then(_self.copyWith(qualities: value));
  });
}
}


/// Adds pattern-matching-related methods to [VideoExtract].
extension VideoExtractPatterns on VideoExtract {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoExtract value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoExtract() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoExtract value)  $default,){
final _that = this;
switch (_that) {
case _VideoExtract():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoExtract value)?  $default,){
final _that = this;
switch (_that) {
case _VideoExtract() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Selector? playUrl,  Selector? qualities,  String? jsExtract)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoExtract() when $default != null:
return $default(_that.playUrl,_that.qualities,_that.jsExtract);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Selector? playUrl,  Selector? qualities,  String? jsExtract)  $default,) {final _that = this;
switch (_that) {
case _VideoExtract():
return $default(_that.playUrl,_that.qualities,_that.jsExtract);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Selector? playUrl,  Selector? qualities,  String? jsExtract)?  $default,) {final _that = this;
switch (_that) {
case _VideoExtract() when $default != null:
return $default(_that.playUrl,_that.qualities,_that.jsExtract);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoExtract implements VideoExtract {
  const _VideoExtract({this.playUrl, this.qualities, this.jsExtract});
  factory _VideoExtract.fromJson(Map<String, dynamic> json) => _$VideoExtractFromJson(json);

/// Selector for video URL.
@override final  Selector? playUrl;
/// Selector for quality options.
@override final  Selector? qualities;
/// JavaScript to extract video info.
@override final  String? jsExtract;

/// Create a copy of VideoExtract
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoExtractCopyWith<_VideoExtract> get copyWith => __$VideoExtractCopyWithImpl<_VideoExtract>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoExtractToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoExtract&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl)&&(identical(other.qualities, qualities) || other.qualities == qualities)&&(identical(other.jsExtract, jsExtract) || other.jsExtract == jsExtract));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playUrl,qualities,jsExtract);

@override
String toString() {
  return 'VideoExtract(playUrl: $playUrl, qualities: $qualities, jsExtract: $jsExtract)';
}


}

/// @nodoc
abstract mixin class _$VideoExtractCopyWith<$Res> implements $VideoExtractCopyWith<$Res> {
  factory _$VideoExtractCopyWith(_VideoExtract value, $Res Function(_VideoExtract) _then) = __$VideoExtractCopyWithImpl;
@override @useResult
$Res call({
 Selector? playUrl, Selector? qualities, String? jsExtract
});


@override $SelectorCopyWith<$Res>? get playUrl;@override $SelectorCopyWith<$Res>? get qualities;

}
/// @nodoc
class __$VideoExtractCopyWithImpl<$Res>
    implements _$VideoExtractCopyWith<$Res> {
  __$VideoExtractCopyWithImpl(this._self, this._then);

  final _VideoExtract _self;
  final $Res Function(_VideoExtract) _then;

/// Create a copy of VideoExtract
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playUrl = freezed,Object? qualities = freezed,Object? jsExtract = freezed,}) {
  return _then(_VideoExtract(
playUrl: freezed == playUrl ? _self.playUrl : playUrl // ignore: cast_nullable_to_non_nullable
as Selector?,qualities: freezed == qualities ? _self.qualities : qualities // ignore: cast_nullable_to_non_nullable
as Selector?,jsExtract: freezed == jsExtract ? _self.jsExtract : jsExtract // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of VideoExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get playUrl {
    if (_self.playUrl == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.playUrl!, (value) {
    return _then(_self.copyWith(playUrl: value));
  });
}/// Create a copy of VideoExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get qualities {
    if (_self.qualities == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.qualities!, (value) {
    return _then(_self.copyWith(qualities: value));
  });
}
}


/// @nodoc
mixin _$ComicExtract {

/// Selector for image URLs.
 Selector get images;/// JavaScript to extract images.
 String? get jsExtract;
/// Create a copy of ComicExtract
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComicExtractCopyWith<ComicExtract> get copyWith => _$ComicExtractCopyWithImpl<ComicExtract>(this as ComicExtract, _$identity);

  /// Serializes this ComicExtract to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComicExtract&&(identical(other.images, images) || other.images == images)&&(identical(other.jsExtract, jsExtract) || other.jsExtract == jsExtract));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,images,jsExtract);

@override
String toString() {
  return 'ComicExtract(images: $images, jsExtract: $jsExtract)';
}


}

/// @nodoc
abstract mixin class $ComicExtractCopyWith<$Res>  {
  factory $ComicExtractCopyWith(ComicExtract value, $Res Function(ComicExtract) _then) = _$ComicExtractCopyWithImpl;
@useResult
$Res call({
 Selector images, String? jsExtract
});


$SelectorCopyWith<$Res> get images;

}
/// @nodoc
class _$ComicExtractCopyWithImpl<$Res>
    implements $ComicExtractCopyWith<$Res> {
  _$ComicExtractCopyWithImpl(this._self, this._then);

  final ComicExtract _self;
  final $Res Function(ComicExtract) _then;

/// Create a copy of ComicExtract
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? images = null,Object? jsExtract = freezed,}) {
  return _then(_self.copyWith(
images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as Selector,jsExtract: freezed == jsExtract ? _self.jsExtract : jsExtract // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ComicExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res> get images {
  
  return $SelectorCopyWith<$Res>(_self.images, (value) {
    return _then(_self.copyWith(images: value));
  });
}
}


/// Adds pattern-matching-related methods to [ComicExtract].
extension ComicExtractPatterns on ComicExtract {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComicExtract value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComicExtract() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComicExtract value)  $default,){
final _that = this;
switch (_that) {
case _ComicExtract():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComicExtract value)?  $default,){
final _that = this;
switch (_that) {
case _ComicExtract() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Selector images,  String? jsExtract)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComicExtract() when $default != null:
return $default(_that.images,_that.jsExtract);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Selector images,  String? jsExtract)  $default,) {final _that = this;
switch (_that) {
case _ComicExtract():
return $default(_that.images,_that.jsExtract);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Selector images,  String? jsExtract)?  $default,) {final _that = this;
switch (_that) {
case _ComicExtract() when $default != null:
return $default(_that.images,_that.jsExtract);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComicExtract implements ComicExtract {
  const _ComicExtract({required this.images, this.jsExtract});
  factory _ComicExtract.fromJson(Map<String, dynamic> json) => _$ComicExtractFromJson(json);

/// Selector for image URLs.
@override final  Selector images;
/// JavaScript to extract images.
@override final  String? jsExtract;

/// Create a copy of ComicExtract
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComicExtractCopyWith<_ComicExtract> get copyWith => __$ComicExtractCopyWithImpl<_ComicExtract>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComicExtractToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComicExtract&&(identical(other.images, images) || other.images == images)&&(identical(other.jsExtract, jsExtract) || other.jsExtract == jsExtract));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,images,jsExtract);

@override
String toString() {
  return 'ComicExtract(images: $images, jsExtract: $jsExtract)';
}


}

/// @nodoc
abstract mixin class _$ComicExtractCopyWith<$Res> implements $ComicExtractCopyWith<$Res> {
  factory _$ComicExtractCopyWith(_ComicExtract value, $Res Function(_ComicExtract) _then) = __$ComicExtractCopyWithImpl;
@override @useResult
$Res call({
 Selector images, String? jsExtract
});


@override $SelectorCopyWith<$Res> get images;

}
/// @nodoc
class __$ComicExtractCopyWithImpl<$Res>
    implements _$ComicExtractCopyWith<$Res> {
  __$ComicExtractCopyWithImpl(this._self, this._then);

  final _ComicExtract _self;
  final $Res Function(_ComicExtract) _then;

/// Create a copy of ComicExtract
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? images = null,Object? jsExtract = freezed,}) {
  return _then(_ComicExtract(
images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as Selector,jsExtract: freezed == jsExtract ? _self.jsExtract : jsExtract // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ComicExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res> get images {
  
  return $SelectorCopyWith<$Res>(_self.images, (value) {
    return _then(_self.copyWith(images: value));
  });
}
}


/// @nodoc
mixin _$NovelExtract {

/// Selector for chapter content.
 Selector get content;/// JavaScript to extract content.
 String? get jsExtract;
/// Create a copy of NovelExtract
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NovelExtractCopyWith<NovelExtract> get copyWith => _$NovelExtractCopyWithImpl<NovelExtract>(this as NovelExtract, _$identity);

  /// Serializes this NovelExtract to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NovelExtract&&(identical(other.content, content) || other.content == content)&&(identical(other.jsExtract, jsExtract) || other.jsExtract == jsExtract));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,jsExtract);

@override
String toString() {
  return 'NovelExtract(content: $content, jsExtract: $jsExtract)';
}


}

/// @nodoc
abstract mixin class $NovelExtractCopyWith<$Res>  {
  factory $NovelExtractCopyWith(NovelExtract value, $Res Function(NovelExtract) _then) = _$NovelExtractCopyWithImpl;
@useResult
$Res call({
 Selector content, String? jsExtract
});


$SelectorCopyWith<$Res> get content;

}
/// @nodoc
class _$NovelExtractCopyWithImpl<$Res>
    implements $NovelExtractCopyWith<$Res> {
  _$NovelExtractCopyWithImpl(this._self, this._then);

  final NovelExtract _self;
  final $Res Function(NovelExtract) _then;

/// Create a copy of NovelExtract
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? jsExtract = freezed,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Selector,jsExtract: freezed == jsExtract ? _self.jsExtract : jsExtract // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of NovelExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res> get content {
  
  return $SelectorCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// Adds pattern-matching-related methods to [NovelExtract].
extension NovelExtractPatterns on NovelExtract {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NovelExtract value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NovelExtract() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NovelExtract value)  $default,){
final _that = this;
switch (_that) {
case _NovelExtract():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NovelExtract value)?  $default,){
final _that = this;
switch (_that) {
case _NovelExtract() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Selector content,  String? jsExtract)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NovelExtract() when $default != null:
return $default(_that.content,_that.jsExtract);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Selector content,  String? jsExtract)  $default,) {final _that = this;
switch (_that) {
case _NovelExtract():
return $default(_that.content,_that.jsExtract);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Selector content,  String? jsExtract)?  $default,) {final _that = this;
switch (_that) {
case _NovelExtract() when $default != null:
return $default(_that.content,_that.jsExtract);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NovelExtract implements NovelExtract {
  const _NovelExtract({required this.content, this.jsExtract});
  factory _NovelExtract.fromJson(Map<String, dynamic> json) => _$NovelExtractFromJson(json);

/// Selector for chapter content.
@override final  Selector content;
/// JavaScript to extract content.
@override final  String? jsExtract;

/// Create a copy of NovelExtract
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NovelExtractCopyWith<_NovelExtract> get copyWith => __$NovelExtractCopyWithImpl<_NovelExtract>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NovelExtractToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NovelExtract&&(identical(other.content, content) || other.content == content)&&(identical(other.jsExtract, jsExtract) || other.jsExtract == jsExtract));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,jsExtract);

@override
String toString() {
  return 'NovelExtract(content: $content, jsExtract: $jsExtract)';
}


}

/// @nodoc
abstract mixin class _$NovelExtractCopyWith<$Res> implements $NovelExtractCopyWith<$Res> {
  factory _$NovelExtractCopyWith(_NovelExtract value, $Res Function(_NovelExtract) _then) = __$NovelExtractCopyWithImpl;
@override @useResult
$Res call({
 Selector content, String? jsExtract
});


@override $SelectorCopyWith<$Res> get content;

}
/// @nodoc
class __$NovelExtractCopyWithImpl<$Res>
    implements _$NovelExtractCopyWith<$Res> {
  __$NovelExtractCopyWithImpl(this._self, this._then);

  final _NovelExtract _self;
  final $Res Function(_NovelExtract) _then;

/// Create a copy of NovelExtract
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? jsExtract = freezed,}) {
  return _then(_NovelExtract(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as Selector,jsExtract: freezed == jsExtract ? _self.jsExtract : jsExtract // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of NovelExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res> get content {
  
  return $SelectorCopyWith<$Res>(_self.content, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// @nodoc
mixin _$MusicExtract {

/// Selector for audio URL.
 Selector? get audioUrl;/// Selector for lyrics.
 Selector? get lyrics;/// JavaScript to extract audio info.
 String? get jsExtract;
/// Create a copy of MusicExtract
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MusicExtractCopyWith<MusicExtract> get copyWith => _$MusicExtractCopyWithImpl<MusicExtract>(this as MusicExtract, _$identity);

  /// Serializes this MusicExtract to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MusicExtract&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.lyrics, lyrics) || other.lyrics == lyrics)&&(identical(other.jsExtract, jsExtract) || other.jsExtract == jsExtract));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,audioUrl,lyrics,jsExtract);

@override
String toString() {
  return 'MusicExtract(audioUrl: $audioUrl, lyrics: $lyrics, jsExtract: $jsExtract)';
}


}

/// @nodoc
abstract mixin class $MusicExtractCopyWith<$Res>  {
  factory $MusicExtractCopyWith(MusicExtract value, $Res Function(MusicExtract) _then) = _$MusicExtractCopyWithImpl;
@useResult
$Res call({
 Selector? audioUrl, Selector? lyrics, String? jsExtract
});


$SelectorCopyWith<$Res>? get audioUrl;$SelectorCopyWith<$Res>? get lyrics;

}
/// @nodoc
class _$MusicExtractCopyWithImpl<$Res>
    implements $MusicExtractCopyWith<$Res> {
  _$MusicExtractCopyWithImpl(this._self, this._then);

  final MusicExtract _self;
  final $Res Function(MusicExtract) _then;

/// Create a copy of MusicExtract
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? audioUrl = freezed,Object? lyrics = freezed,Object? jsExtract = freezed,}) {
  return _then(_self.copyWith(
audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as Selector?,lyrics: freezed == lyrics ? _self.lyrics : lyrics // ignore: cast_nullable_to_non_nullable
as Selector?,jsExtract: freezed == jsExtract ? _self.jsExtract : jsExtract // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MusicExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get audioUrl {
    if (_self.audioUrl == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.audioUrl!, (value) {
    return _then(_self.copyWith(audioUrl: value));
  });
}/// Create a copy of MusicExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get lyrics {
    if (_self.lyrics == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.lyrics!, (value) {
    return _then(_self.copyWith(lyrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [MusicExtract].
extension MusicExtractPatterns on MusicExtract {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MusicExtract value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MusicExtract() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MusicExtract value)  $default,){
final _that = this;
switch (_that) {
case _MusicExtract():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MusicExtract value)?  $default,){
final _that = this;
switch (_that) {
case _MusicExtract() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Selector? audioUrl,  Selector? lyrics,  String? jsExtract)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MusicExtract() when $default != null:
return $default(_that.audioUrl,_that.lyrics,_that.jsExtract);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Selector? audioUrl,  Selector? lyrics,  String? jsExtract)  $default,) {final _that = this;
switch (_that) {
case _MusicExtract():
return $default(_that.audioUrl,_that.lyrics,_that.jsExtract);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Selector? audioUrl,  Selector? lyrics,  String? jsExtract)?  $default,) {final _that = this;
switch (_that) {
case _MusicExtract() when $default != null:
return $default(_that.audioUrl,_that.lyrics,_that.jsExtract);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MusicExtract implements MusicExtract {
  const _MusicExtract({this.audioUrl, this.lyrics, this.jsExtract});
  factory _MusicExtract.fromJson(Map<String, dynamic> json) => _$MusicExtractFromJson(json);

/// Selector for audio URL.
@override final  Selector? audioUrl;
/// Selector for lyrics.
@override final  Selector? lyrics;
/// JavaScript to extract audio info.
@override final  String? jsExtract;

/// Create a copy of MusicExtract
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MusicExtractCopyWith<_MusicExtract> get copyWith => __$MusicExtractCopyWithImpl<_MusicExtract>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MusicExtractToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MusicExtract&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.lyrics, lyrics) || other.lyrics == lyrics)&&(identical(other.jsExtract, jsExtract) || other.jsExtract == jsExtract));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,audioUrl,lyrics,jsExtract);

@override
String toString() {
  return 'MusicExtract(audioUrl: $audioUrl, lyrics: $lyrics, jsExtract: $jsExtract)';
}


}

/// @nodoc
abstract mixin class _$MusicExtractCopyWith<$Res> implements $MusicExtractCopyWith<$Res> {
  factory _$MusicExtractCopyWith(_MusicExtract value, $Res Function(_MusicExtract) _then) = __$MusicExtractCopyWithImpl;
@override @useResult
$Res call({
 Selector? audioUrl, Selector? lyrics, String? jsExtract
});


@override $SelectorCopyWith<$Res>? get audioUrl;@override $SelectorCopyWith<$Res>? get lyrics;

}
/// @nodoc
class __$MusicExtractCopyWithImpl<$Res>
    implements _$MusicExtractCopyWith<$Res> {
  __$MusicExtractCopyWithImpl(this._self, this._then);

  final _MusicExtract _self;
  final $Res Function(_MusicExtract) _then;

/// Create a copy of MusicExtract
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? audioUrl = freezed,Object? lyrics = freezed,Object? jsExtract = freezed,}) {
  return _then(_MusicExtract(
audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as Selector?,lyrics: freezed == lyrics ? _self.lyrics : lyrics // ignore: cast_nullable_to_non_nullable
as Selector?,jsExtract: freezed == jsExtract ? _self.jsExtract : jsExtract // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MusicExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get audioUrl {
    if (_self.audioUrl == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.audioUrl!, (value) {
    return _then(_self.copyWith(audioUrl: value));
  });
}/// Create a copy of MusicExtract
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectorCopyWith<$Res>? get lyrics {
    if (_self.lyrics == null) {
    return null;
  }

  return $SelectorCopyWith<$Res>(_self.lyrics!, (value) {
    return _then(_self.copyWith(lyrics: value));
  });
}
}


/// @nodoc
mixin _$ExtractConfig {

/// List page extraction.
 ListExtract? get list;/// Detail page extraction.
 DetailExtract? get detail;/// Content extraction.
 ContentExtract? get content;
/// Create a copy of ExtractConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtractConfigCopyWith<ExtractConfig> get copyWith => _$ExtractConfigCopyWithImpl<ExtractConfig>(this as ExtractConfig, _$identity);

  /// Serializes this ExtractConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtractConfig&&(identical(other.list, list) || other.list == list)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,list,detail,content);

@override
String toString() {
  return 'ExtractConfig(list: $list, detail: $detail, content: $content)';
}


}

/// @nodoc
abstract mixin class $ExtractConfigCopyWith<$Res>  {
  factory $ExtractConfigCopyWith(ExtractConfig value, $Res Function(ExtractConfig) _then) = _$ExtractConfigCopyWithImpl;
@useResult
$Res call({
 ListExtract? list, DetailExtract? detail, ContentExtract? content
});


$ListExtractCopyWith<$Res>? get list;$DetailExtractCopyWith<$Res>? get detail;$ContentExtractCopyWith<$Res>? get content;

}
/// @nodoc
class _$ExtractConfigCopyWithImpl<$Res>
    implements $ExtractConfigCopyWith<$Res> {
  _$ExtractConfigCopyWithImpl(this._self, this._then);

  final ExtractConfig _self;
  final $Res Function(ExtractConfig) _then;

/// Create a copy of ExtractConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = freezed,Object? detail = freezed,Object? content = freezed,}) {
  return _then(_self.copyWith(
list: freezed == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as ListExtract?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as DetailExtract?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as ContentExtract?,
  ));
}
/// Create a copy of ExtractConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListExtractCopyWith<$Res>? get list {
    if (_self.list == null) {
    return null;
  }

  return $ListExtractCopyWith<$Res>(_self.list!, (value) {
    return _then(_self.copyWith(list: value));
  });
}/// Create a copy of ExtractConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetailExtractCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $DetailExtractCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}/// Create a copy of ExtractConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentExtractCopyWith<$Res>? get content {
    if (_self.content == null) {
    return null;
  }

  return $ContentExtractCopyWith<$Res>(_self.content!, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExtractConfig].
extension ExtractConfigPatterns on ExtractConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExtractConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExtractConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExtractConfig value)  $default,){
final _that = this;
switch (_that) {
case _ExtractConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExtractConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ExtractConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ListExtract? list,  DetailExtract? detail,  ContentExtract? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExtractConfig() when $default != null:
return $default(_that.list,_that.detail,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ListExtract? list,  DetailExtract? detail,  ContentExtract? content)  $default,) {final _that = this;
switch (_that) {
case _ExtractConfig():
return $default(_that.list,_that.detail,_that.content);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ListExtract? list,  DetailExtract? detail,  ContentExtract? content)?  $default,) {final _that = this;
switch (_that) {
case _ExtractConfig() when $default != null:
return $default(_that.list,_that.detail,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExtractConfig implements ExtractConfig {
  const _ExtractConfig({this.list, this.detail, this.content});
  factory _ExtractConfig.fromJson(Map<String, dynamic> json) => _$ExtractConfigFromJson(json);

/// List page extraction.
@override final  ListExtract? list;
/// Detail page extraction.
@override final  DetailExtract? detail;
/// Content extraction.
@override final  ContentExtract? content;

/// Create a copy of ExtractConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtractConfigCopyWith<_ExtractConfig> get copyWith => __$ExtractConfigCopyWithImpl<_ExtractConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExtractConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtractConfig&&(identical(other.list, list) || other.list == list)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,list,detail,content);

@override
String toString() {
  return 'ExtractConfig(list: $list, detail: $detail, content: $content)';
}


}

/// @nodoc
abstract mixin class _$ExtractConfigCopyWith<$Res> implements $ExtractConfigCopyWith<$Res> {
  factory _$ExtractConfigCopyWith(_ExtractConfig value, $Res Function(_ExtractConfig) _then) = __$ExtractConfigCopyWithImpl;
@override @useResult
$Res call({
 ListExtract? list, DetailExtract? detail, ContentExtract? content
});


@override $ListExtractCopyWith<$Res>? get list;@override $DetailExtractCopyWith<$Res>? get detail;@override $ContentExtractCopyWith<$Res>? get content;

}
/// @nodoc
class __$ExtractConfigCopyWithImpl<$Res>
    implements _$ExtractConfigCopyWith<$Res> {
  __$ExtractConfigCopyWithImpl(this._self, this._then);

  final _ExtractConfig _self;
  final $Res Function(_ExtractConfig) _then;

/// Create a copy of ExtractConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = freezed,Object? detail = freezed,Object? content = freezed,}) {
  return _then(_ExtractConfig(
list: freezed == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as ListExtract?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as DetailExtract?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as ContentExtract?,
  ));
}

/// Create a copy of ExtractConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ListExtractCopyWith<$Res>? get list {
    if (_self.list == null) {
    return null;
  }

  return $ListExtractCopyWith<$Res>(_self.list!, (value) {
    return _then(_self.copyWith(list: value));
  });
}/// Create a copy of ExtractConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetailExtractCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $DetailExtractCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}/// Create a copy of ExtractConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentExtractCopyWith<$Res>? get content {
    if (_self.content == null) {
    return null;
  }

  return $ContentExtractCopyWith<$Res>(_self.content!, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}

// dart format on
