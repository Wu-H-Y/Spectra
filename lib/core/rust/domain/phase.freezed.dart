// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChapterItem {

 String get title; String? get url;
/// Create a copy of ChapterItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterItemCopyWith<ChapterItem> get copyWith => _$ChapterItemCopyWithImpl<ChapterItem>(this as ChapterItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterItem&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,title,url);

@override
String toString() {
  return 'ChapterItem(title: $title, url: $url)';
}


}

/// @nodoc
abstract mixin class $ChapterItemCopyWith<$Res>  {
  factory $ChapterItemCopyWith(ChapterItem value, $Res Function(ChapterItem) _then) = _$ChapterItemCopyWithImpl;
@useResult
$Res call({
 String title, String? url
});




}
/// @nodoc
class _$ChapterItemCopyWithImpl<$Res>
    implements $ChapterItemCopyWith<$Res> {
  _$ChapterItemCopyWithImpl(this._self, this._then);

  final ChapterItem _self;
  final $Res Function(ChapterItem) _then;

/// Create a copy of ChapterItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? url = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChapterItem].
extension ChapterItemPatterns on ChapterItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterItem value)  $default,){
final _that = this;
switch (_that) {
case _ChapterItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterItem value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterItem() when $default != null:
return $default(_that.title,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? url)  $default,) {final _that = this;
switch (_that) {
case _ChapterItem():
return $default(_that.title,_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _ChapterItem() when $default != null:
return $default(_that.title,_that.url);case _:
  return null;

}
}

}

/// @nodoc


class _ChapterItem implements ChapterItem {
  const _ChapterItem({required this.title, this.url});
  

@override final  String title;
@override final  String? url;

/// Create a copy of ChapterItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterItemCopyWith<_ChapterItem> get copyWith => __$ChapterItemCopyWithImpl<_ChapterItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterItem&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url));
}


@override
int get hashCode => Object.hash(runtimeType,title,url);

@override
String toString() {
  return 'ChapterItem(title: $title, url: $url)';
}


}

/// @nodoc
abstract mixin class _$ChapterItemCopyWith<$Res> implements $ChapterItemCopyWith<$Res> {
  factory _$ChapterItemCopyWith(_ChapterItem value, $Res Function(_ChapterItem) _then) = __$ChapterItemCopyWithImpl;
@override @useResult
$Res call({
 String title, String? url
});




}
/// @nodoc
class __$ChapterItemCopyWithImpl<$Res>
    implements _$ChapterItemCopyWith<$Res> {
  __$ChapterItemCopyWithImpl(this._self, this._then);

  final _ChapterItem _self;
  final $Res Function(_ChapterItem) _then;

/// Create a copy of ChapterItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? url = freezed,}) {
  return _then(_ChapterItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ContentData {

 String get content; List<String> get media;
/// Create a copy of ContentData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentDataCopyWith<ContentData> get copyWith => _$ContentDataCopyWithImpl<ContentData>(this as ContentData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentData&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.media, media));
}


@override
int get hashCode => Object.hash(runtimeType,content,const DeepCollectionEquality().hash(media));

@override
String toString() {
  return 'ContentData(content: $content, media: $media)';
}


}

/// @nodoc
abstract mixin class $ContentDataCopyWith<$Res>  {
  factory $ContentDataCopyWith(ContentData value, $Res Function(ContentData) _then) = _$ContentDataCopyWithImpl;
@useResult
$Res call({
 String content, List<String> media
});




}
/// @nodoc
class _$ContentDataCopyWithImpl<$Res>
    implements $ContentDataCopyWith<$Res> {
  _$ContentDataCopyWithImpl(this._self, this._then);

  final ContentData _self;
  final $Res Function(ContentData) _then;

/// Create a copy of ContentData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? media = null,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,media: null == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentData].
extension ContentDataPatterns on ContentData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentData value)  $default,){
final _that = this;
switch (_that) {
case _ContentData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentData value)?  $default,){
final _that = this;
switch (_that) {
case _ContentData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content,  List<String> media)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentData() when $default != null:
return $default(_that.content,_that.media);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content,  List<String> media)  $default,) {final _that = this;
switch (_that) {
case _ContentData():
return $default(_that.content,_that.media);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content,  List<String> media)?  $default,) {final _that = this;
switch (_that) {
case _ContentData() when $default != null:
return $default(_that.content,_that.media);case _:
  return null;

}
}

}

/// @nodoc


class _ContentData implements ContentData {
  const _ContentData({required this.content, required final  List<String> media}): _media = media;
  

@override final  String content;
 final  List<String> _media;
@override List<String> get media {
  if (_media is EqualUnmodifiableListView) return _media;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_media);
}


/// Create a copy of ContentData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentDataCopyWith<_ContentData> get copyWith => __$ContentDataCopyWithImpl<_ContentData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentData&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._media, _media));
}


@override
int get hashCode => Object.hash(runtimeType,content,const DeepCollectionEquality().hash(_media));

@override
String toString() {
  return 'ContentData(content: $content, media: $media)';
}


}

/// @nodoc
abstract mixin class _$ContentDataCopyWith<$Res> implements $ContentDataCopyWith<$Res> {
  factory _$ContentDataCopyWith(_ContentData value, $Res Function(_ContentData) _then) = __$ContentDataCopyWithImpl;
@override @useResult
$Res call({
 String content, List<String> media
});




}
/// @nodoc
class __$ContentDataCopyWithImpl<$Res>
    implements _$ContentDataCopyWith<$Res> {
  __$ContentDataCopyWithImpl(this._self, this._then);

  final _ContentData _self;
  final $Res Function(_ContentData) _then;

/// Create a copy of ContentData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? media = null,}) {
  return _then(_ContentData(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,media: null == media ? _self._media : media // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$DetailData {

 Map<String, String> get fields;
/// Create a copy of DetailData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailDataCopyWith<DetailData> get copyWith => _$DetailDataCopyWithImpl<DetailData>(this as DetailData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailData&&const DeepCollectionEquality().equals(other.fields, fields));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(fields));

@override
String toString() {
  return 'DetailData(fields: $fields)';
}


}

/// @nodoc
abstract mixin class $DetailDataCopyWith<$Res>  {
  factory $DetailDataCopyWith(DetailData value, $Res Function(DetailData) _then) = _$DetailDataCopyWithImpl;
@useResult
$Res call({
 Map<String, String> fields
});




}
/// @nodoc
class _$DetailDataCopyWithImpl<$Res>
    implements $DetailDataCopyWith<$Res> {
  _$DetailDataCopyWithImpl(this._self, this._then);

  final DetailData _self;
  final $Res Function(DetailData) _then;

/// Create a copy of DetailData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fields = null,}) {
  return _then(_self.copyWith(
fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DetailData].
extension DetailDataPatterns on DetailData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DetailData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetailData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DetailData value)  $default,){
final _that = this;
switch (_that) {
case _DetailData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DetailData value)?  $default,){
final _that = this;
switch (_that) {
case _DetailData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, String> fields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetailData() when $default != null:
return $default(_that.fields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, String> fields)  $default,) {final _that = this;
switch (_that) {
case _DetailData():
return $default(_that.fields);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, String> fields)?  $default,) {final _that = this;
switch (_that) {
case _DetailData() when $default != null:
return $default(_that.fields);case _:
  return null;

}
}

}

/// @nodoc


class _DetailData implements DetailData {
  const _DetailData({required final  Map<String, String> fields}): _fields = fields;
  

 final  Map<String, String> _fields;
@override Map<String, String> get fields {
  if (_fields is EqualUnmodifiableMapView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fields);
}


/// Create a copy of DetailData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailDataCopyWith<_DetailData> get copyWith => __$DetailDataCopyWithImpl<_DetailData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailData&&const DeepCollectionEquality().equals(other._fields, _fields));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_fields));

@override
String toString() {
  return 'DetailData(fields: $fields)';
}


}

/// @nodoc
abstract mixin class _$DetailDataCopyWith<$Res> implements $DetailDataCopyWith<$Res> {
  factory _$DetailDataCopyWith(_DetailData value, $Res Function(_DetailData) _then) = __$DetailDataCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String> fields
});




}
/// @nodoc
class __$DetailDataCopyWithImpl<$Res>
    implements _$DetailDataCopyWith<$Res> {
  __$DetailDataCopyWithImpl(this._self, this._then);

  final _DetailData _self;
  final $Res Function(_DetailData) _then;

/// Create a copy of DetailData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fields = null,}) {
  return _then(_DetailData(
fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

/// @nodoc
mixin _$ExploreData {

 List<String> get items;
/// Create a copy of ExploreData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreDataCopyWith<ExploreData> get copyWith => _$ExploreDataCopyWithImpl<ExploreData>(this as ExploreData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreData&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'ExploreData(items: $items)';
}


}

/// @nodoc
abstract mixin class $ExploreDataCopyWith<$Res>  {
  factory $ExploreDataCopyWith(ExploreData value, $Res Function(ExploreData) _then) = _$ExploreDataCopyWithImpl;
@useResult
$Res call({
 List<String> items
});




}
/// @nodoc
class _$ExploreDataCopyWithImpl<$Res>
    implements $ExploreDataCopyWith<$Res> {
  _$ExploreDataCopyWithImpl(this._self, this._then);

  final ExploreData _self;
  final $Res Function(ExploreData) _then;

/// Create a copy of ExploreData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ExploreData].
extension ExploreDataPatterns on ExploreData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreData value)  $default,){
final _that = this;
switch (_that) {
case _ExploreData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreData value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreData() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> items)  $default,) {final _that = this;
switch (_that) {
case _ExploreData():
return $default(_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> items)?  $default,) {final _that = this;
switch (_that) {
case _ExploreData() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _ExploreData implements ExploreData {
  const _ExploreData({required final  List<String> items}): _items = items;
  

 final  List<String> _items;
@override List<String> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ExploreData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreDataCopyWith<_ExploreData> get copyWith => __$ExploreDataCopyWithImpl<_ExploreData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreData&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'ExploreData(items: $items)';
}


}

/// @nodoc
abstract mixin class _$ExploreDataCopyWith<$Res> implements $ExploreDataCopyWith<$Res> {
  factory _$ExploreDataCopyWith(_ExploreData value, $Res Function(_ExploreData) _then) = __$ExploreDataCopyWithImpl;
@override @useResult
$Res call({
 List<String> items
});




}
/// @nodoc
class __$ExploreDataCopyWithImpl<$Res>
    implements _$ExploreDataCopyWith<$Res> {
  __$ExploreDataCopyWithImpl(this._self, this._then);

  final _ExploreData _self;
  final $Res Function(_ExploreData) _then;

/// Create a copy of ExploreData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_ExploreData(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$PhaseContext {

 String? get url; String? get keyword; int? get page; Map<String, String>? get vars;
/// Create a copy of PhaseContext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhaseContextCopyWith<PhaseContext> get copyWith => _$PhaseContextCopyWithImpl<PhaseContext>(this as PhaseContext, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhaseContext&&(identical(other.url, url) || other.url == url)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other.vars, vars));
}


@override
int get hashCode => Object.hash(runtimeType,url,keyword,page,const DeepCollectionEquality().hash(vars));

@override
String toString() {
  return 'PhaseContext(url: $url, keyword: $keyword, page: $page, vars: $vars)';
}


}

/// @nodoc
abstract mixin class $PhaseContextCopyWith<$Res>  {
  factory $PhaseContextCopyWith(PhaseContext value, $Res Function(PhaseContext) _then) = _$PhaseContextCopyWithImpl;
@useResult
$Res call({
 String? url, String? keyword, int? page, Map<String, String>? vars
});




}
/// @nodoc
class _$PhaseContextCopyWithImpl<$Res>
    implements $PhaseContextCopyWith<$Res> {
  _$PhaseContextCopyWithImpl(this._self, this._then);

  final PhaseContext _self;
  final $Res Function(PhaseContext) _then;

/// Create a copy of PhaseContext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? keyword = freezed,Object? page = freezed,Object? vars = freezed,}) {
  return _then(_self.copyWith(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,vars: freezed == vars ? _self.vars : vars // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PhaseContext].
extension PhaseContextPatterns on PhaseContext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhaseContext value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhaseContext() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhaseContext value)  $default,){
final _that = this;
switch (_that) {
case _PhaseContext():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhaseContext value)?  $default,){
final _that = this;
switch (_that) {
case _PhaseContext() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? url,  String? keyword,  int? page,  Map<String, String>? vars)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhaseContext() when $default != null:
return $default(_that.url,_that.keyword,_that.page,_that.vars);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? url,  String? keyword,  int? page,  Map<String, String>? vars)  $default,) {final _that = this;
switch (_that) {
case _PhaseContext():
return $default(_that.url,_that.keyword,_that.page,_that.vars);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? url,  String? keyword,  int? page,  Map<String, String>? vars)?  $default,) {final _that = this;
switch (_that) {
case _PhaseContext() when $default != null:
return $default(_that.url,_that.keyword,_that.page,_that.vars);case _:
  return null;

}
}

}

/// @nodoc


class _PhaseContext implements PhaseContext {
  const _PhaseContext({this.url, this.keyword, this.page, final  Map<String, String>? vars}): _vars = vars;
  

@override final  String? url;
@override final  String? keyword;
@override final  int? page;
 final  Map<String, String>? _vars;
@override Map<String, String>? get vars {
  final value = _vars;
  if (value == null) return null;
  if (_vars is EqualUnmodifiableMapView) return _vars;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PhaseContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhaseContextCopyWith<_PhaseContext> get copyWith => __$PhaseContextCopyWithImpl<_PhaseContext>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhaseContext&&(identical(other.url, url) || other.url == url)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other._vars, _vars));
}


@override
int get hashCode => Object.hash(runtimeType,url,keyword,page,const DeepCollectionEquality().hash(_vars));

@override
String toString() {
  return 'PhaseContext(url: $url, keyword: $keyword, page: $page, vars: $vars)';
}


}

/// @nodoc
abstract mixin class _$PhaseContextCopyWith<$Res> implements $PhaseContextCopyWith<$Res> {
  factory _$PhaseContextCopyWith(_PhaseContext value, $Res Function(_PhaseContext) _then) = __$PhaseContextCopyWithImpl;
@override @useResult
$Res call({
 String? url, String? keyword, int? page, Map<String, String>? vars
});




}
/// @nodoc
class __$PhaseContextCopyWithImpl<$Res>
    implements _$PhaseContextCopyWith<$Res> {
  __$PhaseContextCopyWithImpl(this._self, this._then);

  final _PhaseContext _self;
  final $Res Function(_PhaseContext) _then;

/// Create a copy of PhaseContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? keyword = freezed,Object? page = freezed,Object? vars = freezed,}) {
  return _then(_PhaseContext(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,page: freezed == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int?,vars: freezed == vars ? _self._vars : vars // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

/// @nodoc
mixin _$PhaseData {

 Object get field0;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhaseData&&const DeepCollectionEquality().equals(other.field0, field0));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(field0));

@override
String toString() {
  return 'PhaseData(field0: $field0)';
}


}

/// @nodoc
class $PhaseDataCopyWith<$Res>  {
$PhaseDataCopyWith(PhaseData _, $Res Function(PhaseData) __);
}


/// Adds pattern-matching-related methods to [PhaseData].
extension PhaseDataPatterns on PhaseData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PhaseData_Explore value)?  explore,TResult Function( PhaseData_Search value)?  search,TResult Function( PhaseData_Detail value)?  detail,TResult Function( PhaseData_Toc value)?  toc,TResult Function( PhaseData_Content value)?  content,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PhaseData_Explore() when explore != null:
return explore(_that);case PhaseData_Search() when search != null:
return search(_that);case PhaseData_Detail() when detail != null:
return detail(_that);case PhaseData_Toc() when toc != null:
return toc(_that);case PhaseData_Content() when content != null:
return content(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PhaseData_Explore value)  explore,required TResult Function( PhaseData_Search value)  search,required TResult Function( PhaseData_Detail value)  detail,required TResult Function( PhaseData_Toc value)  toc,required TResult Function( PhaseData_Content value)  content,}){
final _that = this;
switch (_that) {
case PhaseData_Explore():
return explore(_that);case PhaseData_Search():
return search(_that);case PhaseData_Detail():
return detail(_that);case PhaseData_Toc():
return toc(_that);case PhaseData_Content():
return content(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PhaseData_Explore value)?  explore,TResult? Function( PhaseData_Search value)?  search,TResult? Function( PhaseData_Detail value)?  detail,TResult? Function( PhaseData_Toc value)?  toc,TResult? Function( PhaseData_Content value)?  content,}){
final _that = this;
switch (_that) {
case PhaseData_Explore() when explore != null:
return explore(_that);case PhaseData_Search() when search != null:
return search(_that);case PhaseData_Detail() when detail != null:
return detail(_that);case PhaseData_Toc() when toc != null:
return toc(_that);case PhaseData_Content() when content != null:
return content(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ExploreData field0)?  explore,TResult Function( SearchData field0)?  search,TResult Function( DetailData field0)?  detail,TResult Function( TocData field0)?  toc,TResult Function( ContentData field0)?  content,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PhaseData_Explore() when explore != null:
return explore(_that.field0);case PhaseData_Search() when search != null:
return search(_that.field0);case PhaseData_Detail() when detail != null:
return detail(_that.field0);case PhaseData_Toc() when toc != null:
return toc(_that.field0);case PhaseData_Content() when content != null:
return content(_that.field0);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ExploreData field0)  explore,required TResult Function( SearchData field0)  search,required TResult Function( DetailData field0)  detail,required TResult Function( TocData field0)  toc,required TResult Function( ContentData field0)  content,}) {final _that = this;
switch (_that) {
case PhaseData_Explore():
return explore(_that.field0);case PhaseData_Search():
return search(_that.field0);case PhaseData_Detail():
return detail(_that.field0);case PhaseData_Toc():
return toc(_that.field0);case PhaseData_Content():
return content(_that.field0);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ExploreData field0)?  explore,TResult? Function( SearchData field0)?  search,TResult? Function( DetailData field0)?  detail,TResult? Function( TocData field0)?  toc,TResult? Function( ContentData field0)?  content,}) {final _that = this;
switch (_that) {
case PhaseData_Explore() when explore != null:
return explore(_that.field0);case PhaseData_Search() when search != null:
return search(_that.field0);case PhaseData_Detail() when detail != null:
return detail(_that.field0);case PhaseData_Toc() when toc != null:
return toc(_that.field0);case PhaseData_Content() when content != null:
return content(_that.field0);case _:
  return null;

}
}

}

/// @nodoc


class PhaseData_Explore extends PhaseData {
  const PhaseData_Explore(this.field0): super._();
  

@override final  ExploreData field0;

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhaseData_ExploreCopyWith<PhaseData_Explore> get copyWith => _$PhaseData_ExploreCopyWithImpl<PhaseData_Explore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhaseData_Explore&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'PhaseData.explore(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $PhaseData_ExploreCopyWith<$Res> implements $PhaseDataCopyWith<$Res> {
  factory $PhaseData_ExploreCopyWith(PhaseData_Explore value, $Res Function(PhaseData_Explore) _then) = _$PhaseData_ExploreCopyWithImpl;
@useResult
$Res call({
 ExploreData field0
});


$ExploreDataCopyWith<$Res> get field0;

}
/// @nodoc
class _$PhaseData_ExploreCopyWithImpl<$Res>
    implements $PhaseData_ExploreCopyWith<$Res> {
  _$PhaseData_ExploreCopyWithImpl(this._self, this._then);

  final PhaseData_Explore _self;
  final $Res Function(PhaseData_Explore) _then;

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(PhaseData_Explore(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as ExploreData,
  ));
}

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExploreDataCopyWith<$Res> get field0 {
  
  return $ExploreDataCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

/// @nodoc


class PhaseData_Search extends PhaseData {
  const PhaseData_Search(this.field0): super._();
  

@override final  SearchData field0;

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhaseData_SearchCopyWith<PhaseData_Search> get copyWith => _$PhaseData_SearchCopyWithImpl<PhaseData_Search>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhaseData_Search&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'PhaseData.search(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $PhaseData_SearchCopyWith<$Res> implements $PhaseDataCopyWith<$Res> {
  factory $PhaseData_SearchCopyWith(PhaseData_Search value, $Res Function(PhaseData_Search) _then) = _$PhaseData_SearchCopyWithImpl;
@useResult
$Res call({
 SearchData field0
});


$SearchDataCopyWith<$Res> get field0;

}
/// @nodoc
class _$PhaseData_SearchCopyWithImpl<$Res>
    implements $PhaseData_SearchCopyWith<$Res> {
  _$PhaseData_SearchCopyWithImpl(this._self, this._then);

  final PhaseData_Search _self;
  final $Res Function(PhaseData_Search) _then;

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(PhaseData_Search(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as SearchData,
  ));
}

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchDataCopyWith<$Res> get field0 {
  
  return $SearchDataCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

/// @nodoc


class PhaseData_Detail extends PhaseData {
  const PhaseData_Detail(this.field0): super._();
  

@override final  DetailData field0;

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhaseData_DetailCopyWith<PhaseData_Detail> get copyWith => _$PhaseData_DetailCopyWithImpl<PhaseData_Detail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhaseData_Detail&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'PhaseData.detail(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $PhaseData_DetailCopyWith<$Res> implements $PhaseDataCopyWith<$Res> {
  factory $PhaseData_DetailCopyWith(PhaseData_Detail value, $Res Function(PhaseData_Detail) _then) = _$PhaseData_DetailCopyWithImpl;
@useResult
$Res call({
 DetailData field0
});


$DetailDataCopyWith<$Res> get field0;

}
/// @nodoc
class _$PhaseData_DetailCopyWithImpl<$Res>
    implements $PhaseData_DetailCopyWith<$Res> {
  _$PhaseData_DetailCopyWithImpl(this._self, this._then);

  final PhaseData_Detail _self;
  final $Res Function(PhaseData_Detail) _then;

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(PhaseData_Detail(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as DetailData,
  ));
}

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetailDataCopyWith<$Res> get field0 {
  
  return $DetailDataCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

/// @nodoc


class PhaseData_Toc extends PhaseData {
  const PhaseData_Toc(this.field0): super._();
  

@override final  TocData field0;

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhaseData_TocCopyWith<PhaseData_Toc> get copyWith => _$PhaseData_TocCopyWithImpl<PhaseData_Toc>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhaseData_Toc&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'PhaseData.toc(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $PhaseData_TocCopyWith<$Res> implements $PhaseDataCopyWith<$Res> {
  factory $PhaseData_TocCopyWith(PhaseData_Toc value, $Res Function(PhaseData_Toc) _then) = _$PhaseData_TocCopyWithImpl;
@useResult
$Res call({
 TocData field0
});


$TocDataCopyWith<$Res> get field0;

}
/// @nodoc
class _$PhaseData_TocCopyWithImpl<$Res>
    implements $PhaseData_TocCopyWith<$Res> {
  _$PhaseData_TocCopyWithImpl(this._self, this._then);

  final PhaseData_Toc _self;
  final $Res Function(PhaseData_Toc) _then;

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(PhaseData_Toc(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as TocData,
  ));
}

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TocDataCopyWith<$Res> get field0 {
  
  return $TocDataCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

/// @nodoc


class PhaseData_Content extends PhaseData {
  const PhaseData_Content(this.field0): super._();
  

@override final  ContentData field0;

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhaseData_ContentCopyWith<PhaseData_Content> get copyWith => _$PhaseData_ContentCopyWithImpl<PhaseData_Content>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhaseData_Content&&(identical(other.field0, field0) || other.field0 == field0));
}


@override
int get hashCode => Object.hash(runtimeType,field0);

@override
String toString() {
  return 'PhaseData.content(field0: $field0)';
}


}

/// @nodoc
abstract mixin class $PhaseData_ContentCopyWith<$Res> implements $PhaseDataCopyWith<$Res> {
  factory $PhaseData_ContentCopyWith(PhaseData_Content value, $Res Function(PhaseData_Content) _then) = _$PhaseData_ContentCopyWithImpl;
@useResult
$Res call({
 ContentData field0
});


$ContentDataCopyWith<$Res> get field0;

}
/// @nodoc
class _$PhaseData_ContentCopyWithImpl<$Res>
    implements $PhaseData_ContentCopyWith<$Res> {
  _$PhaseData_ContentCopyWithImpl(this._self, this._then);

  final PhaseData_Content _self;
  final $Res Function(PhaseData_Content) _then;

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? field0 = null,}) {
  return _then(PhaseData_Content(
null == field0 ? _self.field0 : field0 // ignore: cast_nullable_to_non_nullable
as ContentData,
  ));
}

/// Create a copy of PhaseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentDataCopyWith<$Res> get field0 {
  
  return $ContentDataCopyWith<$Res>(_self.field0, (value) {
    return _then(_self.copyWith(field0: value));
  });
}
}

/// @nodoc
mixin _$PhaseResult {

 bool get success; String? get finalUrl; ContentType get contentType; String? get rawBody; PhaseData? get data; CrawlerError? get error;
/// Create a copy of PhaseResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhaseResultCopyWith<PhaseResult> get copyWith => _$PhaseResultCopyWithImpl<PhaseResult>(this as PhaseResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhaseResult&&(identical(other.success, success) || other.success == success)&&(identical(other.finalUrl, finalUrl) || other.finalUrl == finalUrl)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.rawBody, rawBody) || other.rawBody == rawBody)&&(identical(other.data, data) || other.data == data)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,success,finalUrl,contentType,rawBody,data,error);

@override
String toString() {
  return 'PhaseResult(success: $success, finalUrl: $finalUrl, contentType: $contentType, rawBody: $rawBody, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class $PhaseResultCopyWith<$Res>  {
  factory $PhaseResultCopyWith(PhaseResult value, $Res Function(PhaseResult) _then) = _$PhaseResultCopyWithImpl;
@useResult
$Res call({
 bool success, String? finalUrl, ContentType contentType, String? rawBody, PhaseData? data, CrawlerError? error
});


$PhaseDataCopyWith<$Res>? get data;$CrawlerErrorCopyWith<$Res>? get error;

}
/// @nodoc
class _$PhaseResultCopyWithImpl<$Res>
    implements $PhaseResultCopyWith<$Res> {
  _$PhaseResultCopyWithImpl(this._self, this._then);

  final PhaseResult _self;
  final $Res Function(PhaseResult) _then;

/// Create a copy of PhaseResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? finalUrl = freezed,Object? contentType = null,Object? rawBody = freezed,Object? data = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,finalUrl: freezed == finalUrl ? _self.finalUrl : finalUrl // ignore: cast_nullable_to_non_nullable
as String?,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as ContentType,rawBody: freezed == rawBody ? _self.rawBody : rawBody // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PhaseData?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as CrawlerError?,
  ));
}
/// Create a copy of PhaseResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhaseDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $PhaseDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of PhaseResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CrawlerErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $CrawlerErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// Adds pattern-matching-related methods to [PhaseResult].
extension PhaseResultPatterns on PhaseResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhaseResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhaseResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhaseResult value)  $default,){
final _that = this;
switch (_that) {
case _PhaseResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhaseResult value)?  $default,){
final _that = this;
switch (_that) {
case _PhaseResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? finalUrl,  ContentType contentType,  String? rawBody,  PhaseData? data,  CrawlerError? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhaseResult() when $default != null:
return $default(_that.success,_that.finalUrl,_that.contentType,_that.rawBody,_that.data,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? finalUrl,  ContentType contentType,  String? rawBody,  PhaseData? data,  CrawlerError? error)  $default,) {final _that = this;
switch (_that) {
case _PhaseResult():
return $default(_that.success,_that.finalUrl,_that.contentType,_that.rawBody,_that.data,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? finalUrl,  ContentType contentType,  String? rawBody,  PhaseData? data,  CrawlerError? error)?  $default,) {final _that = this;
switch (_that) {
case _PhaseResult() when $default != null:
return $default(_that.success,_that.finalUrl,_that.contentType,_that.rawBody,_that.data,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _PhaseResult implements PhaseResult {
  const _PhaseResult({required this.success, this.finalUrl, required this.contentType, this.rawBody, this.data, this.error});
  

@override final  bool success;
@override final  String? finalUrl;
@override final  ContentType contentType;
@override final  String? rawBody;
@override final  PhaseData? data;
@override final  CrawlerError? error;

/// Create a copy of PhaseResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhaseResultCopyWith<_PhaseResult> get copyWith => __$PhaseResultCopyWithImpl<_PhaseResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhaseResult&&(identical(other.success, success) || other.success == success)&&(identical(other.finalUrl, finalUrl) || other.finalUrl == finalUrl)&&(identical(other.contentType, contentType) || other.contentType == contentType)&&(identical(other.rawBody, rawBody) || other.rawBody == rawBody)&&(identical(other.data, data) || other.data == data)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,success,finalUrl,contentType,rawBody,data,error);

@override
String toString() {
  return 'PhaseResult(success: $success, finalUrl: $finalUrl, contentType: $contentType, rawBody: $rawBody, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PhaseResultCopyWith<$Res> implements $PhaseResultCopyWith<$Res> {
  factory _$PhaseResultCopyWith(_PhaseResult value, $Res Function(_PhaseResult) _then) = __$PhaseResultCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? finalUrl, ContentType contentType, String? rawBody, PhaseData? data, CrawlerError? error
});


@override $PhaseDataCopyWith<$Res>? get data;@override $CrawlerErrorCopyWith<$Res>? get error;

}
/// @nodoc
class __$PhaseResultCopyWithImpl<$Res>
    implements _$PhaseResultCopyWith<$Res> {
  __$PhaseResultCopyWithImpl(this._self, this._then);

  final _PhaseResult _self;
  final $Res Function(_PhaseResult) _then;

/// Create a copy of PhaseResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? finalUrl = freezed,Object? contentType = null,Object? rawBody = freezed,Object? data = freezed,Object? error = freezed,}) {
  return _then(_PhaseResult(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,finalUrl: freezed == finalUrl ? _self.finalUrl : finalUrl // ignore: cast_nullable_to_non_nullable
as String?,contentType: null == contentType ? _self.contentType : contentType // ignore: cast_nullable_to_non_nullable
as ContentType,rawBody: freezed == rawBody ? _self.rawBody : rawBody // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PhaseData?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as CrawlerError?,
  ));
}

/// Create a copy of PhaseResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhaseDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $PhaseDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}/// Create a copy of PhaseResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CrawlerErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $CrawlerErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

/// @nodoc
mixin _$SearchData {

 List<SearchItem> get items;
/// Create a copy of SearchData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchDataCopyWith<SearchData> get copyWith => _$SearchDataCopyWithImpl<SearchData>(this as SearchData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchData&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'SearchData(items: $items)';
}


}

/// @nodoc
abstract mixin class $SearchDataCopyWith<$Res>  {
  factory $SearchDataCopyWith(SearchData value, $Res Function(SearchData) _then) = _$SearchDataCopyWithImpl;
@useResult
$Res call({
 List<SearchItem> items
});




}
/// @nodoc
class _$SearchDataCopyWithImpl<$Res>
    implements $SearchDataCopyWith<$Res> {
  _$SearchDataCopyWithImpl(this._self, this._then);

  final SearchData _self;
  final $Res Function(SearchData) _then;

/// Create a copy of SearchData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SearchItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchData].
extension SearchDataPatterns on SearchData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchData value)  $default,){
final _that = this;
switch (_that) {
case _SearchData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchData value)?  $default,){
final _that = this;
switch (_that) {
case _SearchData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SearchItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchData() when $default != null:
return $default(_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SearchItem> items)  $default,) {final _that = this;
switch (_that) {
case _SearchData():
return $default(_that.items);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SearchItem> items)?  $default,) {final _that = this;
switch (_that) {
case _SearchData() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _SearchData implements SearchData {
  const _SearchData({required final  List<SearchItem> items}): _items = items;
  

 final  List<SearchItem> _items;
@override List<SearchItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of SearchData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchDataCopyWith<_SearchData> get copyWith => __$SearchDataCopyWithImpl<_SearchData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchData&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'SearchData(items: $items)';
}


}

/// @nodoc
abstract mixin class _$SearchDataCopyWith<$Res> implements $SearchDataCopyWith<$Res> {
  factory _$SearchDataCopyWith(_SearchData value, $Res Function(_SearchData) _then) = __$SearchDataCopyWithImpl;
@override @useResult
$Res call({
 List<SearchItem> items
});




}
/// @nodoc
class __$SearchDataCopyWithImpl<$Res>
    implements _$SearchDataCopyWith<$Res> {
  __$SearchDataCopyWithImpl(this._self, this._then);

  final _SearchData _self;
  final $Res Function(_SearchData) _then;

/// Create a copy of SearchData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_SearchData(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SearchItem>,
  ));
}


}

/// @nodoc
mixin _$SearchItem {

 String get title; String get url; String? get cover; String? get author;
/// Create a copy of SearchItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchItemCopyWith<SearchItem> get copyWith => _$SearchItemCopyWithImpl<SearchItem>(this as SearchItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchItem&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.author, author) || other.author == author));
}


@override
int get hashCode => Object.hash(runtimeType,title,url,cover,author);

@override
String toString() {
  return 'SearchItem(title: $title, url: $url, cover: $cover, author: $author)';
}


}

/// @nodoc
abstract mixin class $SearchItemCopyWith<$Res>  {
  factory $SearchItemCopyWith(SearchItem value, $Res Function(SearchItem) _then) = _$SearchItemCopyWithImpl;
@useResult
$Res call({
 String title, String url, String? cover, String? author
});




}
/// @nodoc
class _$SearchItemCopyWithImpl<$Res>
    implements $SearchItemCopyWith<$Res> {
  _$SearchItemCopyWithImpl(this._self, this._then);

  final SearchItem _self;
  final $Res Function(SearchItem) _then;

/// Create a copy of SearchItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? url = null,Object? cover = freezed,Object? author = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchItem].
extension SearchItemPatterns on SearchItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchItem value)  $default,){
final _that = this;
switch (_that) {
case _SearchItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchItem value)?  $default,){
final _that = this;
switch (_that) {
case _SearchItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String url,  String? cover,  String? author)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchItem() when $default != null:
return $default(_that.title,_that.url,_that.cover,_that.author);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String url,  String? cover,  String? author)  $default,) {final _that = this;
switch (_that) {
case _SearchItem():
return $default(_that.title,_that.url,_that.cover,_that.author);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String url,  String? cover,  String? author)?  $default,) {final _that = this;
switch (_that) {
case _SearchItem() when $default != null:
return $default(_that.title,_that.url,_that.cover,_that.author);case _:
  return null;

}
}

}

/// @nodoc


class _SearchItem implements SearchItem {
  const _SearchItem({required this.title, required this.url, this.cover, this.author});
  

@override final  String title;
@override final  String url;
@override final  String? cover;
@override final  String? author;

/// Create a copy of SearchItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchItemCopyWith<_SearchItem> get copyWith => __$SearchItemCopyWithImpl<_SearchItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchItem&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.author, author) || other.author == author));
}


@override
int get hashCode => Object.hash(runtimeType,title,url,cover,author);

@override
String toString() {
  return 'SearchItem(title: $title, url: $url, cover: $cover, author: $author)';
}


}

/// @nodoc
abstract mixin class _$SearchItemCopyWith<$Res> implements $SearchItemCopyWith<$Res> {
  factory _$SearchItemCopyWith(_SearchItem value, $Res Function(_SearchItem) _then) = __$SearchItemCopyWithImpl;
@override @useResult
$Res call({
 String title, String url, String? cover, String? author
});




}
/// @nodoc
class __$SearchItemCopyWithImpl<$Res>
    implements _$SearchItemCopyWith<$Res> {
  __$SearchItemCopyWithImpl(this._self, this._then);

  final _SearchItem _self;
  final $Res Function(_SearchItem) _then;

/// Create a copy of SearchItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? url = null,Object? cover = freezed,Object? author = freezed,}) {
  return _then(_SearchItem(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TocData {

 List<ChapterItem> get chapters;
/// Create a copy of TocData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TocDataCopyWith<TocData> get copyWith => _$TocDataCopyWithImpl<TocData>(this as TocData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TocData&&const DeepCollectionEquality().equals(other.chapters, chapters));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(chapters));

@override
String toString() {
  return 'TocData(chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class $TocDataCopyWith<$Res>  {
  factory $TocDataCopyWith(TocData value, $Res Function(TocData) _then) = _$TocDataCopyWithImpl;
@useResult
$Res call({
 List<ChapterItem> chapters
});




}
/// @nodoc
class _$TocDataCopyWithImpl<$Res>
    implements $TocDataCopyWith<$Res> {
  _$TocDataCopyWithImpl(this._self, this._then);

  final TocData _self;
  final $Res Function(TocData) _then;

/// Create a copy of TocData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chapters = null,}) {
  return _then(_self.copyWith(
chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [TocData].
extension TocDataPatterns on TocData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TocData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TocData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TocData value)  $default,){
final _that = this;
switch (_that) {
case _TocData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TocData value)?  $default,){
final _that = this;
switch (_that) {
case _TocData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ChapterItem> chapters)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TocData() when $default != null:
return $default(_that.chapters);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ChapterItem> chapters)  $default,) {final _that = this;
switch (_that) {
case _TocData():
return $default(_that.chapters);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ChapterItem> chapters)?  $default,) {final _that = this;
switch (_that) {
case _TocData() when $default != null:
return $default(_that.chapters);case _:
  return null;

}
}

}

/// @nodoc


class _TocData implements TocData {
  const _TocData({required final  List<ChapterItem> chapters}): _chapters = chapters;
  

 final  List<ChapterItem> _chapters;
@override List<ChapterItem> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}


/// Create a copy of TocData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TocDataCopyWith<_TocData> get copyWith => __$TocDataCopyWithImpl<_TocData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TocData&&const DeepCollectionEquality().equals(other._chapters, _chapters));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_chapters));

@override
String toString() {
  return 'TocData(chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class _$TocDataCopyWith<$Res> implements $TocDataCopyWith<$Res> {
  factory _$TocDataCopyWith(_TocData value, $Res Function(_TocData) _then) = __$TocDataCopyWithImpl;
@override @useResult
$Res call({
 List<ChapterItem> chapters
});




}
/// @nodoc
class __$TocDataCopyWithImpl<$Res>
    implements _$TocDataCopyWith<$Res> {
  __$TocDataCopyWithImpl(this._self, this._then);

  final _TocData _self;
  final $Res Function(_TocData) _then;

/// Create a copy of TocData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chapters = null,}) {
  return _then(_TocData(
chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterItem>,
  ));
}


}

// dart format on
