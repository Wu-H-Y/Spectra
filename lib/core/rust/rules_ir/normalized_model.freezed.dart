// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'normalized_model.dart';

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

  /// Serializes this ChapterItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterItem&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
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
@JsonSerializable()

class _ChapterItem implements ChapterItem {
  const _ChapterItem({required this.title, this.url});
  factory _ChapterItem.fromJson(Map<String, dynamic> json) => _$ChapterItemFromJson(json);

@override final  String title;
@override final  String? url;

/// Create a copy of ChapterItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterItemCopyWith<_ChapterItem> get copyWith => __$ChapterItemCopyWithImpl<_ChapterItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChapterItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterItem&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
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
mixin _$ContentModel {

 String? get contentTextHtml; String? get contentTextPlain; List<MediaAsset> get mediaAssets;
/// Create a copy of ContentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentModelCopyWith<ContentModel> get copyWith => _$ContentModelCopyWithImpl<ContentModel>(this as ContentModel, _$identity);

  /// Serializes this ContentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentModel&&(identical(other.contentTextHtml, contentTextHtml) || other.contentTextHtml == contentTextHtml)&&(identical(other.contentTextPlain, contentTextPlain) || other.contentTextPlain == contentTextPlain)&&const DeepCollectionEquality().equals(other.mediaAssets, mediaAssets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentTextHtml,contentTextPlain,const DeepCollectionEquality().hash(mediaAssets));

@override
String toString() {
  return 'ContentModel(contentTextHtml: $contentTextHtml, contentTextPlain: $contentTextPlain, mediaAssets: $mediaAssets)';
}


}

/// @nodoc
abstract mixin class $ContentModelCopyWith<$Res>  {
  factory $ContentModelCopyWith(ContentModel value, $Res Function(ContentModel) _then) = _$ContentModelCopyWithImpl;
@useResult
$Res call({
 String? contentTextHtml, String? contentTextPlain, List<MediaAsset> mediaAssets
});




}
/// @nodoc
class _$ContentModelCopyWithImpl<$Res>
    implements $ContentModelCopyWith<$Res> {
  _$ContentModelCopyWithImpl(this._self, this._then);

  final ContentModel _self;
  final $Res Function(ContentModel) _then;

/// Create a copy of ContentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contentTextHtml = freezed,Object? contentTextPlain = freezed,Object? mediaAssets = null,}) {
  return _then(_self.copyWith(
contentTextHtml: freezed == contentTextHtml ? _self.contentTextHtml : contentTextHtml // ignore: cast_nullable_to_non_nullable
as String?,contentTextPlain: freezed == contentTextPlain ? _self.contentTextPlain : contentTextPlain // ignore: cast_nullable_to_non_nullable
as String?,mediaAssets: null == mediaAssets ? _self.mediaAssets : mediaAssets // ignore: cast_nullable_to_non_nullable
as List<MediaAsset>,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentModel].
extension ContentModelPatterns on ContentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentModel value)  $default,){
final _that = this;
switch (_that) {
case _ContentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentModel value)?  $default,){
final _that = this;
switch (_that) {
case _ContentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? contentTextHtml,  String? contentTextPlain,  List<MediaAsset> mediaAssets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentModel() when $default != null:
return $default(_that.contentTextHtml,_that.contentTextPlain,_that.mediaAssets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? contentTextHtml,  String? contentTextPlain,  List<MediaAsset> mediaAssets)  $default,) {final _that = this;
switch (_that) {
case _ContentModel():
return $default(_that.contentTextHtml,_that.contentTextPlain,_that.mediaAssets);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? contentTextHtml,  String? contentTextPlain,  List<MediaAsset> mediaAssets)?  $default,) {final _that = this;
switch (_that) {
case _ContentModel() when $default != null:
return $default(_that.contentTextHtml,_that.contentTextPlain,_that.mediaAssets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentModel implements ContentModel {
  const _ContentModel({this.contentTextHtml, this.contentTextPlain, final  List<MediaAsset> mediaAssets = const <MediaAsset>[]}): _mediaAssets = mediaAssets;
  factory _ContentModel.fromJson(Map<String, dynamic> json) => _$ContentModelFromJson(json);

@override final  String? contentTextHtml;
@override final  String? contentTextPlain;
 final  List<MediaAsset> _mediaAssets;
@override@JsonKey() List<MediaAsset> get mediaAssets {
  if (_mediaAssets is EqualUnmodifiableListView) return _mediaAssets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mediaAssets);
}


/// Create a copy of ContentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentModelCopyWith<_ContentModel> get copyWith => __$ContentModelCopyWithImpl<_ContentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentModel&&(identical(other.contentTextHtml, contentTextHtml) || other.contentTextHtml == contentTextHtml)&&(identical(other.contentTextPlain, contentTextPlain) || other.contentTextPlain == contentTextPlain)&&const DeepCollectionEquality().equals(other._mediaAssets, _mediaAssets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contentTextHtml,contentTextPlain,const DeepCollectionEquality().hash(_mediaAssets));

@override
String toString() {
  return 'ContentModel(contentTextHtml: $contentTextHtml, contentTextPlain: $contentTextPlain, mediaAssets: $mediaAssets)';
}


}

/// @nodoc
abstract mixin class _$ContentModelCopyWith<$Res> implements $ContentModelCopyWith<$Res> {
  factory _$ContentModelCopyWith(_ContentModel value, $Res Function(_ContentModel) _then) = __$ContentModelCopyWithImpl;
@override @useResult
$Res call({
 String? contentTextHtml, String? contentTextPlain, List<MediaAsset> mediaAssets
});




}
/// @nodoc
class __$ContentModelCopyWithImpl<$Res>
    implements _$ContentModelCopyWith<$Res> {
  __$ContentModelCopyWithImpl(this._self, this._then);

  final _ContentModel _self;
  final $Res Function(_ContentModel) _then;

/// Create a copy of ContentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contentTextHtml = freezed,Object? contentTextPlain = freezed,Object? mediaAssets = null,}) {
  return _then(_ContentModel(
contentTextHtml: freezed == contentTextHtml ? _self.contentTextHtml : contentTextHtml // ignore: cast_nullable_to_non_nullable
as String?,contentTextPlain: freezed == contentTextPlain ? _self.contentTextPlain : contentTextPlain // ignore: cast_nullable_to_non_nullable
as String?,mediaAssets: null == mediaAssets ? _self._mediaAssets : mediaAssets // ignore: cast_nullable_to_non_nullable
as List<MediaAsset>,
  ));
}


}


/// @nodoc
mixin _$DetailModel {

 String get title; String? get cover; String? get author; String? get description; List<String> get tags;
/// Create a copy of DetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailModelCopyWith<DetailModel> get copyWith => _$DetailModelCopyWithImpl<DetailModel>(this as DetailModel, _$identity);

  /// Serializes this DetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailModel&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.author, author) || other.author == author)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,cover,author,description,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'DetailModel(title: $title, cover: $cover, author: $author, description: $description, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $DetailModelCopyWith<$Res>  {
  factory $DetailModelCopyWith(DetailModel value, $Res Function(DetailModel) _then) = _$DetailModelCopyWithImpl;
@useResult
$Res call({
 String title, String? cover, String? author, String? description, List<String> tags
});




}
/// @nodoc
class _$DetailModelCopyWithImpl<$Res>
    implements $DetailModelCopyWith<$Res> {
  _$DetailModelCopyWithImpl(this._self, this._then);

  final DetailModel _self;
  final $Res Function(DetailModel) _then;

/// Create a copy of DetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? cover = freezed,Object? author = freezed,Object? description = freezed,Object? tags = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DetailModel].
extension DetailModelPatterns on DetailModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetailModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DetailModel value)  $default,){
final _that = this;
switch (_that) {
case _DetailModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _DetailModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? cover,  String? author,  String? description,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetailModel() when $default != null:
return $default(_that.title,_that.cover,_that.author,_that.description,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? cover,  String? author,  String? description,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _DetailModel():
return $default(_that.title,_that.cover,_that.author,_that.description,_that.tags);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? cover,  String? author,  String? description,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _DetailModel() when $default != null:
return $default(_that.title,_that.cover,_that.author,_that.description,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DetailModel implements DetailModel {
  const _DetailModel({required this.title, this.cover, this.author, this.description, final  List<String> tags = const <String>[]}): _tags = tags;
  factory _DetailModel.fromJson(Map<String, dynamic> json) => _$DetailModelFromJson(json);

@override final  String title;
@override final  String? cover;
@override final  String? author;
@override final  String? description;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of DetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailModelCopyWith<_DetailModel> get copyWith => __$DetailModelCopyWithImpl<_DetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailModel&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.author, author) || other.author == author)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,cover,author,description,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'DetailModel(title: $title, cover: $cover, author: $author, description: $description, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$DetailModelCopyWith<$Res> implements $DetailModelCopyWith<$Res> {
  factory _$DetailModelCopyWith(_DetailModel value, $Res Function(_DetailModel) _then) = __$DetailModelCopyWithImpl;
@override @useResult
$Res call({
 String title, String? cover, String? author, String? description, List<String> tags
});




}
/// @nodoc
class __$DetailModelCopyWithImpl<$Res>
    implements _$DetailModelCopyWith<$Res> {
  __$DetailModelCopyWithImpl(this._self, this._then);

  final _DetailModel _self;
  final $Res Function(_DetailModel) _then;

/// Create a copy of DetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? cover = freezed,Object? author = freezed,Object? description = freezed,Object? tags = null,}) {
  return _then(_DetailModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$MediaAsset {

 MediaType get mediaType; String get url; String? get title; String? get cover;
/// Create a copy of MediaAsset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaAssetCopyWith<MediaAsset> get copyWith => _$MediaAssetCopyWithImpl<MediaAsset>(this as MediaAsset, _$identity);

  /// Serializes this MediaAsset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaAsset&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mediaType,url,title,cover);

@override
String toString() {
  return 'MediaAsset(mediaType: $mediaType, url: $url, title: $title, cover: $cover)';
}


}

/// @nodoc
abstract mixin class $MediaAssetCopyWith<$Res>  {
  factory $MediaAssetCopyWith(MediaAsset value, $Res Function(MediaAsset) _then) = _$MediaAssetCopyWithImpl;
@useResult
$Res call({
 MediaType mediaType, String url, String? title, String? cover
});




}
/// @nodoc
class _$MediaAssetCopyWithImpl<$Res>
    implements $MediaAssetCopyWith<$Res> {
  _$MediaAssetCopyWithImpl(this._self, this._then);

  final MediaAsset _self;
  final $Res Function(MediaAsset) _then;

/// Create a copy of MediaAsset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mediaType = null,Object? url = null,Object? title = freezed,Object? cover = freezed,}) {
  return _then(_self.copyWith(
mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as MediaType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaAsset].
extension MediaAssetPatterns on MediaAsset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaAsset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaAsset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaAsset value)  $default,){
final _that = this;
switch (_that) {
case _MediaAsset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaAsset value)?  $default,){
final _that = this;
switch (_that) {
case _MediaAsset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MediaType mediaType,  String url,  String? title,  String? cover)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaAsset() when $default != null:
return $default(_that.mediaType,_that.url,_that.title,_that.cover);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MediaType mediaType,  String url,  String? title,  String? cover)  $default,) {final _that = this;
switch (_that) {
case _MediaAsset():
return $default(_that.mediaType,_that.url,_that.title,_that.cover);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MediaType mediaType,  String url,  String? title,  String? cover)?  $default,) {final _that = this;
switch (_that) {
case _MediaAsset() when $default != null:
return $default(_that.mediaType,_that.url,_that.title,_that.cover);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaAsset implements MediaAsset {
  const _MediaAsset({this.mediaType = MediaType.video, required this.url, this.title, this.cover});
  factory _MediaAsset.fromJson(Map<String, dynamic> json) => _$MediaAssetFromJson(json);

@override@JsonKey() final  MediaType mediaType;
@override final  String url;
@override final  String? title;
@override final  String? cover;

/// Create a copy of MediaAsset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaAssetCopyWith<_MediaAsset> get copyWith => __$MediaAssetCopyWithImpl<_MediaAsset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaAssetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaAsset&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.url, url) || other.url == url)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mediaType,url,title,cover);

@override
String toString() {
  return 'MediaAsset(mediaType: $mediaType, url: $url, title: $title, cover: $cover)';
}


}

/// @nodoc
abstract mixin class _$MediaAssetCopyWith<$Res> implements $MediaAssetCopyWith<$Res> {
  factory _$MediaAssetCopyWith(_MediaAsset value, $Res Function(_MediaAsset) _then) = __$MediaAssetCopyWithImpl;
@override @useResult
$Res call({
 MediaType mediaType, String url, String? title, String? cover
});




}
/// @nodoc
class __$MediaAssetCopyWithImpl<$Res>
    implements _$MediaAssetCopyWith<$Res> {
  __$MediaAssetCopyWithImpl(this._self, this._then);

  final _MediaAsset _self;
  final $Res Function(_MediaAsset) _then;

/// Create a copy of MediaAsset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mediaType = null,Object? url = null,Object? title = freezed,Object? cover = freezed,}) {
  return _then(_MediaAsset(
mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as MediaType,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MediaExtension {

 MediaSpec? get video; MediaSpec? get music; MediaSpec? get novel; MediaSpec? get comic; MediaSpec? get image;
/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaExtensionCopyWith<MediaExtension> get copyWith => _$MediaExtensionCopyWithImpl<MediaExtension>(this as MediaExtension, _$identity);

  /// Serializes this MediaExtension to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaExtension&&(identical(other.video, video) || other.video == video)&&(identical(other.music, music) || other.music == music)&&(identical(other.novel, novel) || other.novel == novel)&&(identical(other.comic, comic) || other.comic == comic)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,video,music,novel,comic,image);

@override
String toString() {
  return 'MediaExtension(video: $video, music: $music, novel: $novel, comic: $comic, image: $image)';
}


}

/// @nodoc
abstract mixin class $MediaExtensionCopyWith<$Res>  {
  factory $MediaExtensionCopyWith(MediaExtension value, $Res Function(MediaExtension) _then) = _$MediaExtensionCopyWithImpl;
@useResult
$Res call({
 MediaSpec? video, MediaSpec? music, MediaSpec? novel, MediaSpec? comic, MediaSpec? image
});


$MediaSpecCopyWith<$Res>? get video;$MediaSpecCopyWith<$Res>? get music;$MediaSpecCopyWith<$Res>? get novel;$MediaSpecCopyWith<$Res>? get comic;$MediaSpecCopyWith<$Res>? get image;

}
/// @nodoc
class _$MediaExtensionCopyWithImpl<$Res>
    implements $MediaExtensionCopyWith<$Res> {
  _$MediaExtensionCopyWithImpl(this._self, this._then);

  final MediaExtension _self;
  final $Res Function(MediaExtension) _then;

/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? video = freezed,Object? music = freezed,Object? novel = freezed,Object? comic = freezed,Object? image = freezed,}) {
  return _then(_self.copyWith(
video: freezed == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as MediaSpec?,music: freezed == music ? _self.music : music // ignore: cast_nullable_to_non_nullable
as MediaSpec?,novel: freezed == novel ? _self.novel : novel // ignore: cast_nullable_to_non_nullable
as MediaSpec?,comic: freezed == comic ? _self.comic : comic // ignore: cast_nullable_to_non_nullable
as MediaSpec?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as MediaSpec?,
  ));
}
/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaSpecCopyWith<$Res>? get video {
    if (_self.video == null) {
    return null;
  }

  return $MediaSpecCopyWith<$Res>(_self.video!, (value) {
    return _then(_self.copyWith(video: value));
  });
}/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaSpecCopyWith<$Res>? get music {
    if (_self.music == null) {
    return null;
  }

  return $MediaSpecCopyWith<$Res>(_self.music!, (value) {
    return _then(_self.copyWith(music: value));
  });
}/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaSpecCopyWith<$Res>? get novel {
    if (_self.novel == null) {
    return null;
  }

  return $MediaSpecCopyWith<$Res>(_self.novel!, (value) {
    return _then(_self.copyWith(novel: value));
  });
}/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaSpecCopyWith<$Res>? get comic {
    if (_self.comic == null) {
    return null;
  }

  return $MediaSpecCopyWith<$Res>(_self.comic!, (value) {
    return _then(_self.copyWith(comic: value));
  });
}/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaSpecCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $MediaSpecCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}


/// Adds pattern-matching-related methods to [MediaExtension].
extension MediaExtensionPatterns on MediaExtension {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaExtension value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaExtension() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaExtension value)  $default,){
final _that = this;
switch (_that) {
case _MediaExtension():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaExtension value)?  $default,){
final _that = this;
switch (_that) {
case _MediaExtension() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MediaSpec? video,  MediaSpec? music,  MediaSpec? novel,  MediaSpec? comic,  MediaSpec? image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaExtension() when $default != null:
return $default(_that.video,_that.music,_that.novel,_that.comic,_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MediaSpec? video,  MediaSpec? music,  MediaSpec? novel,  MediaSpec? comic,  MediaSpec? image)  $default,) {final _that = this;
switch (_that) {
case _MediaExtension():
return $default(_that.video,_that.music,_that.novel,_that.comic,_that.image);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MediaSpec? video,  MediaSpec? music,  MediaSpec? novel,  MediaSpec? comic,  MediaSpec? image)?  $default,) {final _that = this;
switch (_that) {
case _MediaExtension() when $default != null:
return $default(_that.video,_that.music,_that.novel,_that.comic,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaExtension implements MediaExtension {
  const _MediaExtension({this.video, this.music, this.novel, this.comic, this.image});
  factory _MediaExtension.fromJson(Map<String, dynamic> json) => _$MediaExtensionFromJson(json);

@override final  MediaSpec? video;
@override final  MediaSpec? music;
@override final  MediaSpec? novel;
@override final  MediaSpec? comic;
@override final  MediaSpec? image;

/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaExtensionCopyWith<_MediaExtension> get copyWith => __$MediaExtensionCopyWithImpl<_MediaExtension>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaExtensionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaExtension&&(identical(other.video, video) || other.video == video)&&(identical(other.music, music) || other.music == music)&&(identical(other.novel, novel) || other.novel == novel)&&(identical(other.comic, comic) || other.comic == comic)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,video,music,novel,comic,image);

@override
String toString() {
  return 'MediaExtension(video: $video, music: $music, novel: $novel, comic: $comic, image: $image)';
}


}

/// @nodoc
abstract mixin class _$MediaExtensionCopyWith<$Res> implements $MediaExtensionCopyWith<$Res> {
  factory _$MediaExtensionCopyWith(_MediaExtension value, $Res Function(_MediaExtension) _then) = __$MediaExtensionCopyWithImpl;
@override @useResult
$Res call({
 MediaSpec? video, MediaSpec? music, MediaSpec? novel, MediaSpec? comic, MediaSpec? image
});


@override $MediaSpecCopyWith<$Res>? get video;@override $MediaSpecCopyWith<$Res>? get music;@override $MediaSpecCopyWith<$Res>? get novel;@override $MediaSpecCopyWith<$Res>? get comic;@override $MediaSpecCopyWith<$Res>? get image;

}
/// @nodoc
class __$MediaExtensionCopyWithImpl<$Res>
    implements _$MediaExtensionCopyWith<$Res> {
  __$MediaExtensionCopyWithImpl(this._self, this._then);

  final _MediaExtension _self;
  final $Res Function(_MediaExtension) _then;

/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? video = freezed,Object? music = freezed,Object? novel = freezed,Object? comic = freezed,Object? image = freezed,}) {
  return _then(_MediaExtension(
video: freezed == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as MediaSpec?,music: freezed == music ? _self.music : music // ignore: cast_nullable_to_non_nullable
as MediaSpec?,novel: freezed == novel ? _self.novel : novel // ignore: cast_nullable_to_non_nullable
as MediaSpec?,comic: freezed == comic ? _self.comic : comic // ignore: cast_nullable_to_non_nullable
as MediaSpec?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as MediaSpec?,
  ));
}

/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaSpecCopyWith<$Res>? get video {
    if (_self.video == null) {
    return null;
  }

  return $MediaSpecCopyWith<$Res>(_self.video!, (value) {
    return _then(_self.copyWith(video: value));
  });
}/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaSpecCopyWith<$Res>? get music {
    if (_self.music == null) {
    return null;
  }

  return $MediaSpecCopyWith<$Res>(_self.music!, (value) {
    return _then(_self.copyWith(music: value));
  });
}/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaSpecCopyWith<$Res>? get novel {
    if (_self.novel == null) {
    return null;
  }

  return $MediaSpecCopyWith<$Res>(_self.novel!, (value) {
    return _then(_self.copyWith(novel: value));
  });
}/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaSpecCopyWith<$Res>? get comic {
    if (_self.comic == null) {
    return null;
  }

  return $MediaSpecCopyWith<$Res>(_self.comic!, (value) {
    return _then(_self.copyWith(comic: value));
  });
}/// Create a copy of MediaExtension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaSpecCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $MediaSpecCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}


/// @nodoc
mixin _$MediaSpec {

 Map<String, String> get extra;
/// Create a copy of MediaSpec
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MediaSpecCopyWith<MediaSpec> get copyWith => _$MediaSpecCopyWithImpl<MediaSpec>(this as MediaSpec, _$identity);

  /// Serializes this MediaSpec to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MediaSpec&&const DeepCollectionEquality().equals(other.extra, extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(extra));

@override
String toString() {
  return 'MediaSpec(extra: $extra)';
}


}

/// @nodoc
abstract mixin class $MediaSpecCopyWith<$Res>  {
  factory $MediaSpecCopyWith(MediaSpec value, $Res Function(MediaSpec) _then) = _$MediaSpecCopyWithImpl;
@useResult
$Res call({
 Map<String, String> extra
});




}
/// @nodoc
class _$MediaSpecCopyWithImpl<$Res>
    implements $MediaSpecCopyWith<$Res> {
  _$MediaSpecCopyWithImpl(this._self, this._then);

  final MediaSpec _self;
  final $Res Function(MediaSpec) _then;

/// Create a copy of MediaSpec
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? extra = null,}) {
  return _then(_self.copyWith(
extra: null == extra ? _self.extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [MediaSpec].
extension MediaSpecPatterns on MediaSpec {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MediaSpec value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MediaSpec() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MediaSpec value)  $default,){
final _that = this;
switch (_that) {
case _MediaSpec():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MediaSpec value)?  $default,){
final _that = this;
switch (_that) {
case _MediaSpec() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, String> extra)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MediaSpec() when $default != null:
return $default(_that.extra);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, String> extra)  $default,) {final _that = this;
switch (_that) {
case _MediaSpec():
return $default(_that.extra);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, String> extra)?  $default,) {final _that = this;
switch (_that) {
case _MediaSpec() when $default != null:
return $default(_that.extra);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MediaSpec implements MediaSpec {
  const _MediaSpec({final  Map<String, String> extra = const <String, String>{}}): _extra = extra;
  factory _MediaSpec.fromJson(Map<String, dynamic> json) => _$MediaSpecFromJson(json);

 final  Map<String, String> _extra;
@override@JsonKey() Map<String, String> get extra {
  if (_extra is EqualUnmodifiableMapView) return _extra;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_extra);
}


/// Create a copy of MediaSpec
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MediaSpecCopyWith<_MediaSpec> get copyWith => __$MediaSpecCopyWithImpl<_MediaSpec>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MediaSpecToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MediaSpec&&const DeepCollectionEquality().equals(other._extra, _extra));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_extra));

@override
String toString() {
  return 'MediaSpec(extra: $extra)';
}


}

/// @nodoc
abstract mixin class _$MediaSpecCopyWith<$Res> implements $MediaSpecCopyWith<$Res> {
  factory _$MediaSpecCopyWith(_MediaSpec value, $Res Function(_MediaSpec) _then) = __$MediaSpecCopyWithImpl;
@override @useResult
$Res call({
 Map<String, String> extra
});




}
/// @nodoc
class __$MediaSpecCopyWithImpl<$Res>
    implements _$MediaSpecCopyWith<$Res> {
  __$MediaSpecCopyWithImpl(this._self, this._then);

  final _MediaSpec _self;
  final $Res Function(_MediaSpec) _then;

/// Create a copy of MediaSpec
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? extra = null,}) {
  return _then(_MediaSpec(
extra: null == extra ? _self._extra : extra // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}


/// @nodoc
mixin _$NormalizedModel {

 SearchModel? get search; DetailModel? get detail; TocModel? get toc; ContentModel? get content; MediaExtension? get media;
/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NormalizedModelCopyWith<NormalizedModel> get copyWith => _$NormalizedModelCopyWithImpl<NormalizedModel>(this as NormalizedModel, _$identity);

  /// Serializes this NormalizedModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NormalizedModel&&(identical(other.search, search) || other.search == search)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.toc, toc) || other.toc == toc)&&(identical(other.content, content) || other.content == content)&&(identical(other.media, media) || other.media == media));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,search,detail,toc,content,media);

@override
String toString() {
  return 'NormalizedModel(search: $search, detail: $detail, toc: $toc, content: $content, media: $media)';
}


}

/// @nodoc
abstract mixin class $NormalizedModelCopyWith<$Res>  {
  factory $NormalizedModelCopyWith(NormalizedModel value, $Res Function(NormalizedModel) _then) = _$NormalizedModelCopyWithImpl;
@useResult
$Res call({
 SearchModel? search, DetailModel? detail, TocModel? toc, ContentModel? content, MediaExtension? media
});


$SearchModelCopyWith<$Res>? get search;$DetailModelCopyWith<$Res>? get detail;$TocModelCopyWith<$Res>? get toc;$ContentModelCopyWith<$Res>? get content;$MediaExtensionCopyWith<$Res>? get media;

}
/// @nodoc
class _$NormalizedModelCopyWithImpl<$Res>
    implements $NormalizedModelCopyWith<$Res> {
  _$NormalizedModelCopyWithImpl(this._self, this._then);

  final NormalizedModel _self;
  final $Res Function(NormalizedModel) _then;

/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? search = freezed,Object? detail = freezed,Object? toc = freezed,Object? content = freezed,Object? media = freezed,}) {
  return _then(_self.copyWith(
search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as SearchModel?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as DetailModel?,toc: freezed == toc ? _self.toc : toc // ignore: cast_nullable_to_non_nullable
as TocModel?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as ContentModel?,media: freezed == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as MediaExtension?,
  ));
}
/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchModelCopyWith<$Res>? get search {
    if (_self.search == null) {
    return null;
  }

  return $SearchModelCopyWith<$Res>(_self.search!, (value) {
    return _then(_self.copyWith(search: value));
  });
}/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetailModelCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $DetailModelCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TocModelCopyWith<$Res>? get toc {
    if (_self.toc == null) {
    return null;
  }

  return $TocModelCopyWith<$Res>(_self.toc!, (value) {
    return _then(_self.copyWith(toc: value));
  });
}/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentModelCopyWith<$Res>? get content {
    if (_self.content == null) {
    return null;
  }

  return $ContentModelCopyWith<$Res>(_self.content!, (value) {
    return _then(_self.copyWith(content: value));
  });
}/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaExtensionCopyWith<$Res>? get media {
    if (_self.media == null) {
    return null;
  }

  return $MediaExtensionCopyWith<$Res>(_self.media!, (value) {
    return _then(_self.copyWith(media: value));
  });
}
}


/// Adds pattern-matching-related methods to [NormalizedModel].
extension NormalizedModelPatterns on NormalizedModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NormalizedModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NormalizedModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NormalizedModel value)  $default,){
final _that = this;
switch (_that) {
case _NormalizedModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NormalizedModel value)?  $default,){
final _that = this;
switch (_that) {
case _NormalizedModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SearchModel? search,  DetailModel? detail,  TocModel? toc,  ContentModel? content,  MediaExtension? media)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NormalizedModel() when $default != null:
return $default(_that.search,_that.detail,_that.toc,_that.content,_that.media);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SearchModel? search,  DetailModel? detail,  TocModel? toc,  ContentModel? content,  MediaExtension? media)  $default,) {final _that = this;
switch (_that) {
case _NormalizedModel():
return $default(_that.search,_that.detail,_that.toc,_that.content,_that.media);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SearchModel? search,  DetailModel? detail,  TocModel? toc,  ContentModel? content,  MediaExtension? media)?  $default,) {final _that = this;
switch (_that) {
case _NormalizedModel() when $default != null:
return $default(_that.search,_that.detail,_that.toc,_that.content,_that.media);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NormalizedModel implements NormalizedModel {
  const _NormalizedModel({this.search, this.detail, this.toc, this.content, this.media});
  factory _NormalizedModel.fromJson(Map<String, dynamic> json) => _$NormalizedModelFromJson(json);

@override final  SearchModel? search;
@override final  DetailModel? detail;
@override final  TocModel? toc;
@override final  ContentModel? content;
@override final  MediaExtension? media;

/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NormalizedModelCopyWith<_NormalizedModel> get copyWith => __$NormalizedModelCopyWithImpl<_NormalizedModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NormalizedModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NormalizedModel&&(identical(other.search, search) || other.search == search)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.toc, toc) || other.toc == toc)&&(identical(other.content, content) || other.content == content)&&(identical(other.media, media) || other.media == media));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,search,detail,toc,content,media);

@override
String toString() {
  return 'NormalizedModel(search: $search, detail: $detail, toc: $toc, content: $content, media: $media)';
}


}

/// @nodoc
abstract mixin class _$NormalizedModelCopyWith<$Res> implements $NormalizedModelCopyWith<$Res> {
  factory _$NormalizedModelCopyWith(_NormalizedModel value, $Res Function(_NormalizedModel) _then) = __$NormalizedModelCopyWithImpl;
@override @useResult
$Res call({
 SearchModel? search, DetailModel? detail, TocModel? toc, ContentModel? content, MediaExtension? media
});


@override $SearchModelCopyWith<$Res>? get search;@override $DetailModelCopyWith<$Res>? get detail;@override $TocModelCopyWith<$Res>? get toc;@override $ContentModelCopyWith<$Res>? get content;@override $MediaExtensionCopyWith<$Res>? get media;

}
/// @nodoc
class __$NormalizedModelCopyWithImpl<$Res>
    implements _$NormalizedModelCopyWith<$Res> {
  __$NormalizedModelCopyWithImpl(this._self, this._then);

  final _NormalizedModel _self;
  final $Res Function(_NormalizedModel) _then;

/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? search = freezed,Object? detail = freezed,Object? toc = freezed,Object? content = freezed,Object? media = freezed,}) {
  return _then(_NormalizedModel(
search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as SearchModel?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as DetailModel?,toc: freezed == toc ? _self.toc : toc // ignore: cast_nullable_to_non_nullable
as TocModel?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as ContentModel?,media: freezed == media ? _self.media : media // ignore: cast_nullable_to_non_nullable
as MediaExtension?,
  ));
}

/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchModelCopyWith<$Res>? get search {
    if (_self.search == null) {
    return null;
  }

  return $SearchModelCopyWith<$Res>(_self.search!, (value) {
    return _then(_self.copyWith(search: value));
  });
}/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetailModelCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $DetailModelCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TocModelCopyWith<$Res>? get toc {
    if (_self.toc == null) {
    return null;
  }

  return $TocModelCopyWith<$Res>(_self.toc!, (value) {
    return _then(_self.copyWith(toc: value));
  });
}/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentModelCopyWith<$Res>? get content {
    if (_self.content == null) {
    return null;
  }

  return $ContentModelCopyWith<$Res>(_self.content!, (value) {
    return _then(_self.copyWith(content: value));
  });
}/// Create a copy of NormalizedModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MediaExtensionCopyWith<$Res>? get media {
    if (_self.media == null) {
    return null;
  }

  return $MediaExtensionCopyWith<$Res>(_self.media!, (value) {
    return _then(_self.copyWith(media: value));
  });
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

  /// Serializes this SearchItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchItem&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
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
@JsonSerializable()

class _SearchItem implements SearchItem {
  const _SearchItem({required this.title, required this.url, this.cover, this.author});
  factory _SearchItem.fromJson(Map<String, dynamic> json) => _$SearchItemFromJson(json);

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
Map<String, dynamic> toJson() {
  return _$SearchItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchItem&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.author, author) || other.author == author));
}

@JsonKey(includeFromJson: false, includeToJson: false)
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
mixin _$SearchModel {

 List<SearchItem> get items;
/// Create a copy of SearchModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchModelCopyWith<SearchModel> get copyWith => _$SearchModelCopyWithImpl<SearchModel>(this as SearchModel, _$identity);

  /// Serializes this SearchModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchModel&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'SearchModel(items: $items)';
}


}

/// @nodoc
abstract mixin class $SearchModelCopyWith<$Res>  {
  factory $SearchModelCopyWith(SearchModel value, $Res Function(SearchModel) _then) = _$SearchModelCopyWithImpl;
@useResult
$Res call({
 List<SearchItem> items
});




}
/// @nodoc
class _$SearchModelCopyWithImpl<$Res>
    implements $SearchModelCopyWith<$Res> {
  _$SearchModelCopyWithImpl(this._self, this._then);

  final SearchModel _self;
  final $Res Function(SearchModel) _then;

/// Create a copy of SearchModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<SearchItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchModel].
extension SearchModelPatterns on SearchModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchModel value)  $default,){
final _that = this;
switch (_that) {
case _SearchModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchModel value)?  $default,){
final _that = this;
switch (_that) {
case _SearchModel() when $default != null:
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
case _SearchModel() when $default != null:
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
case _SearchModel():
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
case _SearchModel() when $default != null:
return $default(_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchModel implements SearchModel {
  const _SearchModel({final  List<SearchItem> items = const <SearchItem>[]}): _items = items;
  factory _SearchModel.fromJson(Map<String, dynamic> json) => _$SearchModelFromJson(json);

 final  List<SearchItem> _items;
@override@JsonKey() List<SearchItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of SearchModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchModelCopyWith<_SearchModel> get copyWith => __$SearchModelCopyWithImpl<_SearchModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchModel&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'SearchModel(items: $items)';
}


}

/// @nodoc
abstract mixin class _$SearchModelCopyWith<$Res> implements $SearchModelCopyWith<$Res> {
  factory _$SearchModelCopyWith(_SearchModel value, $Res Function(_SearchModel) _then) = __$SearchModelCopyWithImpl;
@override @useResult
$Res call({
 List<SearchItem> items
});




}
/// @nodoc
class __$SearchModelCopyWithImpl<$Res>
    implements _$SearchModelCopyWith<$Res> {
  __$SearchModelCopyWithImpl(this._self, this._then);

  final _SearchModel _self;
  final $Res Function(_SearchModel) _then;

/// Create a copy of SearchModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,}) {
  return _then(_SearchModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<SearchItem>,
  ));
}


}


/// @nodoc
mixin _$TocModel {

 List<ChapterItem> get chapters;
/// Create a copy of TocModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TocModelCopyWith<TocModel> get copyWith => _$TocModelCopyWithImpl<TocModel>(this as TocModel, _$identity);

  /// Serializes this TocModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TocModel&&const DeepCollectionEquality().equals(other.chapters, chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(chapters));

@override
String toString() {
  return 'TocModel(chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class $TocModelCopyWith<$Res>  {
  factory $TocModelCopyWith(TocModel value, $Res Function(TocModel) _then) = _$TocModelCopyWithImpl;
@useResult
$Res call({
 List<ChapterItem> chapters
});




}
/// @nodoc
class _$TocModelCopyWithImpl<$Res>
    implements $TocModelCopyWith<$Res> {
  _$TocModelCopyWithImpl(this._self, this._then);

  final TocModel _self;
  final $Res Function(TocModel) _then;

/// Create a copy of TocModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chapters = null,}) {
  return _then(_self.copyWith(
chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [TocModel].
extension TocModelPatterns on TocModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TocModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TocModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TocModel value)  $default,){
final _that = this;
switch (_that) {
case _TocModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TocModel value)?  $default,){
final _that = this;
switch (_that) {
case _TocModel() when $default != null:
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
case _TocModel() when $default != null:
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
case _TocModel():
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
case _TocModel() when $default != null:
return $default(_that.chapters);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TocModel implements TocModel {
  const _TocModel({final  List<ChapterItem> chapters = const <ChapterItem>[]}): _chapters = chapters;
  factory _TocModel.fromJson(Map<String, dynamic> json) => _$TocModelFromJson(json);

 final  List<ChapterItem> _chapters;
@override@JsonKey() List<ChapterItem> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}


/// Create a copy of TocModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TocModelCopyWith<_TocModel> get copyWith => __$TocModelCopyWithImpl<_TocModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TocModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TocModel&&const DeepCollectionEquality().equals(other._chapters, _chapters));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_chapters));

@override
String toString() {
  return 'TocModel(chapters: $chapters)';
}


}

/// @nodoc
abstract mixin class _$TocModelCopyWith<$Res> implements $TocModelCopyWith<$Res> {
  factory _$TocModelCopyWith(_TocModel value, $Res Function(_TocModel) _then) = __$TocModelCopyWithImpl;
@override @useResult
$Res call({
 List<ChapterItem> chapters
});




}
/// @nodoc
class __$TocModelCopyWithImpl<$Res>
    implements _$TocModelCopyWith<$Res> {
  __$TocModelCopyWithImpl(this._self, this._then);

  final _TocModel _self;
  final $Res Function(_TocModel) _then;

/// Create a copy of TocModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chapters = null,}) {
  return _then(_TocModel(
chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ChapterItem>,
  ));
}


}

// dart format on
