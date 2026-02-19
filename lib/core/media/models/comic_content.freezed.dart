// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comic_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComicChapter {

/// Chapter ID.
 String get id;/// Chapter title.
 String get title;/// Chapter URL (if separate page).
 String? get url;/// List of image URLs in reading order.
 List<String> get images;/// Chapter index/number.
 int get index;
/// Create a copy of ComicChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComicChapterCopyWith<ComicChapter> get copyWith => _$ComicChapterCopyWithImpl<ComicChapter>(this as ComicChapter, _$identity);

  /// Serializes this ComicChapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComicChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.index, index) || other.index == index));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,url,const DeepCollectionEquality().hash(images),index);

@override
String toString() {
  return 'ComicChapter(id: $id, title: $title, url: $url, images: $images, index: $index)';
}


}

/// @nodoc
abstract mixin class $ComicChapterCopyWith<$Res>  {
  factory $ComicChapterCopyWith(ComicChapter value, $Res Function(ComicChapter) _then) = _$ComicChapterCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? url, List<String> images, int index
});




}
/// @nodoc
class _$ComicChapterCopyWithImpl<$Res>
    implements $ComicChapterCopyWith<$Res> {
  _$ComicChapterCopyWithImpl(this._self, this._then);

  final ComicChapter _self;
  final $Res Function(ComicChapter) _then;

/// Create a copy of ComicChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? url = freezed,Object? images = null,Object? index = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ComicChapter].
extension ComicChapterPatterns on ComicChapter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComicChapter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComicChapter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComicChapter value)  $default,){
final _that = this;
switch (_that) {
case _ComicChapter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComicChapter value)?  $default,){
final _that = this;
switch (_that) {
case _ComicChapter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? url,  List<String> images,  int index)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComicChapter() when $default != null:
return $default(_that.id,_that.title,_that.url,_that.images,_that.index);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? url,  List<String> images,  int index)  $default,) {final _that = this;
switch (_that) {
case _ComicChapter():
return $default(_that.id,_that.title,_that.url,_that.images,_that.index);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? url,  List<String> images,  int index)?  $default,) {final _that = this;
switch (_that) {
case _ComicChapter() when $default != null:
return $default(_that.id,_that.title,_that.url,_that.images,_that.index);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComicChapter implements ComicChapter {
  const _ComicChapter({required this.id, required this.title, this.url, required final  List<String> images, required this.index}): _images = images;
  factory _ComicChapter.fromJson(Map<String, dynamic> json) => _$ComicChapterFromJson(json);

/// Chapter ID.
@override final  String id;
/// Chapter title.
@override final  String title;
/// Chapter URL (if separate page).
@override final  String? url;
/// List of image URLs in reading order.
 final  List<String> _images;
/// List of image URLs in reading order.
@override List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

/// Chapter index/number.
@override final  int index;

/// Create a copy of ComicChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComicChapterCopyWith<_ComicChapter> get copyWith => __$ComicChapterCopyWithImpl<_ComicChapter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComicChapterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComicChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.index, index) || other.index == index));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,url,const DeepCollectionEquality().hash(_images),index);

@override
String toString() {
  return 'ComicChapter(id: $id, title: $title, url: $url, images: $images, index: $index)';
}


}

/// @nodoc
abstract mixin class _$ComicChapterCopyWith<$Res> implements $ComicChapterCopyWith<$Res> {
  factory _$ComicChapterCopyWith(_ComicChapter value, $Res Function(_ComicChapter) _then) = __$ComicChapterCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? url, List<String> images, int index
});




}
/// @nodoc
class __$ComicChapterCopyWithImpl<$Res>
    implements _$ComicChapterCopyWith<$Res> {
  __$ComicChapterCopyWithImpl(this._self, this._then);

  final _ComicChapter _self;
  final $Res Function(_ComicChapter) _then;

/// Create a copy of ComicChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? url = freezed,Object? images = null,Object? index = null,}) {
  return _then(_ComicChapter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ComicContent {

/// Unique identifier.
 String get id;/// Comic title.
 String get title;/// Cover image URL.
 String? get cover;/// Description/summary.
 String? get description;/// Author/artist information.
 Author? get author;/// Tags.
 List<String>? get tags;/// Category.
 String? get category;/// Statistics.
 ContentStats? get stats;/// Publish date.
 DateTime? get createdAt;/// Update date.
 DateTime? get updatedAt;/// Source information.
 ContentSource get source;/// Chapter list.
 List<ComicChapter> get chapters;/// Comic status.
 ComicStatus? get status;/// Latest chapter info.
 ComicChapter? get lastChapter;/// Reading direction.
 ReadDirection get readDirection;/// Age rating/restriction.
 String? get ageRating;/// Total chapter count.
 int? get chapterCount;/// Total image count across all chapters.
 int? get totalImages;
/// Create a copy of ComicContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComicContentCopyWith<ComicContent> get copyWith => _$ComicContentCopyWithImpl<ComicContent>(this as ComicContent, _$identity);

  /// Serializes this ComicContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComicContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other.chapters, chapters)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastChapter, lastChapter) || other.lastChapter == lastChapter)&&(identical(other.readDirection, readDirection) || other.readDirection == readDirection)&&(identical(other.ageRating, ageRating) || other.ageRating == ageRating)&&(identical(other.chapterCount, chapterCount) || other.chapterCount == chapterCount)&&(identical(other.totalImages, totalImages) || other.totalImages == totalImages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,cover,description,author,const DeepCollectionEquality().hash(tags),category,stats,createdAt,updatedAt,source,const DeepCollectionEquality().hash(chapters),status,lastChapter,readDirection,ageRating,chapterCount,totalImages);

@override
String toString() {
  return 'ComicContent(id: $id, title: $title, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, source: $source, chapters: $chapters, status: $status, lastChapter: $lastChapter, readDirection: $readDirection, ageRating: $ageRating, chapterCount: $chapterCount, totalImages: $totalImages)';
}


}

/// @nodoc
abstract mixin class $ComicContentCopyWith<$Res>  {
  factory $ComicContentCopyWith(ComicContent value, $Res Function(ComicContent) _then) = _$ComicContentCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, ContentSource source, List<ComicChapter> chapters, ComicStatus? status, ComicChapter? lastChapter, ReadDirection readDirection, String? ageRating, int? chapterCount, int? totalImages
});


$AuthorCopyWith<$Res>? get author;$ContentStatsCopyWith<$Res>? get stats;$ContentSourceCopyWith<$Res> get source;$ComicChapterCopyWith<$Res>? get lastChapter;

}
/// @nodoc
class _$ComicContentCopyWithImpl<$Res>
    implements $ComicContentCopyWith<$Res> {
  _$ComicContentCopyWithImpl(this._self, this._then);

  final ComicContent _self;
  final $Res Function(ComicContent) _then;

/// Create a copy of ComicContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? source = null,Object? chapters = null,Object? status = freezed,Object? lastChapter = freezed,Object? readDirection = null,Object? ageRating = freezed,Object? chapterCount = freezed,Object? totalImages = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Author?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ContentStats?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ContentSource,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ComicChapter>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ComicStatus?,lastChapter: freezed == lastChapter ? _self.lastChapter : lastChapter // ignore: cast_nullable_to_non_nullable
as ComicChapter?,readDirection: null == readDirection ? _self.readDirection : readDirection // ignore: cast_nullable_to_non_nullable
as ReadDirection,ageRating: freezed == ageRating ? _self.ageRating : ageRating // ignore: cast_nullable_to_non_nullable
as String?,chapterCount: freezed == chapterCount ? _self.chapterCount : chapterCount // ignore: cast_nullable_to_non_nullable
as int?,totalImages: freezed == totalImages ? _self.totalImages : totalImages // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of ComicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthorCopyWith<$Res>? get author {
    if (_self.author == null) {
    return null;
  }

  return $AuthorCopyWith<$Res>(_self.author!, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of ComicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $ContentStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of ComicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of ComicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComicChapterCopyWith<$Res>? get lastChapter {
    if (_self.lastChapter == null) {
    return null;
  }

  return $ComicChapterCopyWith<$Res>(_self.lastChapter!, (value) {
    return _then(_self.copyWith(lastChapter: value));
  });
}
}


/// Adds pattern-matching-related methods to [ComicContent].
extension ComicContentPatterns on ComicContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComicContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComicContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComicContent value)  $default,){
final _that = this;
switch (_that) {
case _ComicContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComicContent value)?  $default,){
final _that = this;
switch (_that) {
case _ComicContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source,  List<ComicChapter> chapters,  ComicStatus? status,  ComicChapter? lastChapter,  ReadDirection readDirection,  String? ageRating,  int? chapterCount,  int? totalImages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComicContent() when $default != null:
return $default(_that.id,_that.title,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source,_that.chapters,_that.status,_that.lastChapter,_that.readDirection,_that.ageRating,_that.chapterCount,_that.totalImages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source,  List<ComicChapter> chapters,  ComicStatus? status,  ComicChapter? lastChapter,  ReadDirection readDirection,  String? ageRating,  int? chapterCount,  int? totalImages)  $default,) {final _that = this;
switch (_that) {
case _ComicContent():
return $default(_that.id,_that.title,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source,_that.chapters,_that.status,_that.lastChapter,_that.readDirection,_that.ageRating,_that.chapterCount,_that.totalImages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source,  List<ComicChapter> chapters,  ComicStatus? status,  ComicChapter? lastChapter,  ReadDirection readDirection,  String? ageRating,  int? chapterCount,  int? totalImages)?  $default,) {final _that = this;
switch (_that) {
case _ComicContent() when $default != null:
return $default(_that.id,_that.title,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source,_that.chapters,_that.status,_that.lastChapter,_that.readDirection,_that.ageRating,_that.chapterCount,_that.totalImages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComicContent implements ComicContent {
  const _ComicContent({required this.id, required this.title, this.cover, this.description, this.author, final  List<String>? tags, this.category, this.stats, this.createdAt, this.updatedAt, required this.source, required final  List<ComicChapter> chapters, this.status, this.lastChapter, this.readDirection = ReadDirection.ltr, this.ageRating, this.chapterCount, this.totalImages}): _tags = tags,_chapters = chapters;
  factory _ComicContent.fromJson(Map<String, dynamic> json) => _$ComicContentFromJson(json);

/// Unique identifier.
@override final  String id;
/// Comic title.
@override final  String title;
/// Cover image URL.
@override final  String? cover;
/// Description/summary.
@override final  String? description;
/// Author/artist information.
@override final  Author? author;
/// Tags.
 final  List<String>? _tags;
/// Tags.
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Category.
@override final  String? category;
/// Statistics.
@override final  ContentStats? stats;
/// Publish date.
@override final  DateTime? createdAt;
/// Update date.
@override final  DateTime? updatedAt;
/// Source information.
@override final  ContentSource source;
/// Chapter list.
 final  List<ComicChapter> _chapters;
/// Chapter list.
@override List<ComicChapter> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}

/// Comic status.
@override final  ComicStatus? status;
/// Latest chapter info.
@override final  ComicChapter? lastChapter;
/// Reading direction.
@override@JsonKey() final  ReadDirection readDirection;
/// Age rating/restriction.
@override final  String? ageRating;
/// Total chapter count.
@override final  int? chapterCount;
/// Total image count across all chapters.
@override final  int? totalImages;

/// Create a copy of ComicContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComicContentCopyWith<_ComicContent> get copyWith => __$ComicContentCopyWithImpl<_ComicContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComicContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComicContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other._chapters, _chapters)&&(identical(other.status, status) || other.status == status)&&(identical(other.lastChapter, lastChapter) || other.lastChapter == lastChapter)&&(identical(other.readDirection, readDirection) || other.readDirection == readDirection)&&(identical(other.ageRating, ageRating) || other.ageRating == ageRating)&&(identical(other.chapterCount, chapterCount) || other.chapterCount == chapterCount)&&(identical(other.totalImages, totalImages) || other.totalImages == totalImages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,cover,description,author,const DeepCollectionEquality().hash(_tags),category,stats,createdAt,updatedAt,source,const DeepCollectionEquality().hash(_chapters),status,lastChapter,readDirection,ageRating,chapterCount,totalImages);

@override
String toString() {
  return 'ComicContent(id: $id, title: $title, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, source: $source, chapters: $chapters, status: $status, lastChapter: $lastChapter, readDirection: $readDirection, ageRating: $ageRating, chapterCount: $chapterCount, totalImages: $totalImages)';
}


}

/// @nodoc
abstract mixin class _$ComicContentCopyWith<$Res> implements $ComicContentCopyWith<$Res> {
  factory _$ComicContentCopyWith(_ComicContent value, $Res Function(_ComicContent) _then) = __$ComicContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, ContentSource source, List<ComicChapter> chapters, ComicStatus? status, ComicChapter? lastChapter, ReadDirection readDirection, String? ageRating, int? chapterCount, int? totalImages
});


@override $AuthorCopyWith<$Res>? get author;@override $ContentStatsCopyWith<$Res>? get stats;@override $ContentSourceCopyWith<$Res> get source;@override $ComicChapterCopyWith<$Res>? get lastChapter;

}
/// @nodoc
class __$ComicContentCopyWithImpl<$Res>
    implements _$ComicContentCopyWith<$Res> {
  __$ComicContentCopyWithImpl(this._self, this._then);

  final _ComicContent _self;
  final $Res Function(_ComicContent) _then;

/// Create a copy of ComicContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? source = null,Object? chapters = null,Object? status = freezed,Object? lastChapter = freezed,Object? readDirection = null,Object? ageRating = freezed,Object? chapterCount = freezed,Object? totalImages = freezed,}) {
  return _then(_ComicContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Author?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ContentStats?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ContentSource,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<ComicChapter>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ComicStatus?,lastChapter: freezed == lastChapter ? _self.lastChapter : lastChapter // ignore: cast_nullable_to_non_nullable
as ComicChapter?,readDirection: null == readDirection ? _self.readDirection : readDirection // ignore: cast_nullable_to_non_nullable
as ReadDirection,ageRating: freezed == ageRating ? _self.ageRating : ageRating // ignore: cast_nullable_to_non_nullable
as String?,chapterCount: freezed == chapterCount ? _self.chapterCount : chapterCount // ignore: cast_nullable_to_non_nullable
as int?,totalImages: freezed == totalImages ? _self.totalImages : totalImages // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of ComicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthorCopyWith<$Res>? get author {
    if (_self.author == null) {
    return null;
  }

  return $AuthorCopyWith<$Res>(_self.author!, (value) {
    return _then(_self.copyWith(author: value));
  });
}/// Create a copy of ComicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentStatsCopyWith<$Res>? get stats {
    if (_self.stats == null) {
    return null;
  }

  return $ContentStatsCopyWith<$Res>(_self.stats!, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of ComicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of ComicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComicChapterCopyWith<$Res>? get lastChapter {
    if (_self.lastChapter == null) {
    return null;
  }

  return $ComicChapterCopyWith<$Res>(_self.lastChapter!, (value) {
    return _then(_self.copyWith(lastChapter: value));
  });
}
}

// dart format on
