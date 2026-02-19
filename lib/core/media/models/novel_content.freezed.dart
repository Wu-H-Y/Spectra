// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'novel_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NovelChapter {

/// Chapter ID.
 String get id;/// Chapter title.
 String get title;/// Chapter URL (if separate page).
 String? get url;/// Chapter text content.
 String? get content;/// Word count for this chapter.
 int? get wordCount;/// Chapter index/number.
 int get index;
/// Create a copy of NovelChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NovelChapterCopyWith<NovelChapter> get copyWith => _$NovelChapterCopyWithImpl<NovelChapter>(this as NovelChapter, _$identity);

  /// Serializes this NovelChapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NovelChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.content, content) || other.content == content)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.index, index) || other.index == index));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,url,content,wordCount,index);

@override
String toString() {
  return 'NovelChapter(id: $id, title: $title, url: $url, content: $content, wordCount: $wordCount, index: $index)';
}


}

/// @nodoc
abstract mixin class $NovelChapterCopyWith<$Res>  {
  factory $NovelChapterCopyWith(NovelChapter value, $Res Function(NovelChapter) _then) = _$NovelChapterCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? url, String? content, int? wordCount, int index
});




}
/// @nodoc
class _$NovelChapterCopyWithImpl<$Res>
    implements $NovelChapterCopyWith<$Res> {
  _$NovelChapterCopyWithImpl(this._self, this._then);

  final NovelChapter _self;
  final $Res Function(NovelChapter) _then;

/// Create a copy of NovelChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? url = freezed,Object? content = freezed,Object? wordCount = freezed,Object? index = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,wordCount: freezed == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int?,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NovelChapter].
extension NovelChapterPatterns on NovelChapter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NovelChapter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NovelChapter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NovelChapter value)  $default,){
final _that = this;
switch (_that) {
case _NovelChapter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NovelChapter value)?  $default,){
final _that = this;
switch (_that) {
case _NovelChapter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? url,  String? content,  int? wordCount,  int index)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NovelChapter() when $default != null:
return $default(_that.id,_that.title,_that.url,_that.content,_that.wordCount,_that.index);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? url,  String? content,  int? wordCount,  int index)  $default,) {final _that = this;
switch (_that) {
case _NovelChapter():
return $default(_that.id,_that.title,_that.url,_that.content,_that.wordCount,_that.index);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? url,  String? content,  int? wordCount,  int index)?  $default,) {final _that = this;
switch (_that) {
case _NovelChapter() when $default != null:
return $default(_that.id,_that.title,_that.url,_that.content,_that.wordCount,_that.index);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NovelChapter implements NovelChapter {
  const _NovelChapter({required this.id, required this.title, this.url, this.content, this.wordCount, required this.index});
  factory _NovelChapter.fromJson(Map<String, dynamic> json) => _$NovelChapterFromJson(json);

/// Chapter ID.
@override final  String id;
/// Chapter title.
@override final  String title;
/// Chapter URL (if separate page).
@override final  String? url;
/// Chapter text content.
@override final  String? content;
/// Word count for this chapter.
@override final  int? wordCount;
/// Chapter index/number.
@override final  int index;

/// Create a copy of NovelChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NovelChapterCopyWith<_NovelChapter> get copyWith => __$NovelChapterCopyWithImpl<_NovelChapter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NovelChapterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NovelChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.content, content) || other.content == content)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.index, index) || other.index == index));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,url,content,wordCount,index);

@override
String toString() {
  return 'NovelChapter(id: $id, title: $title, url: $url, content: $content, wordCount: $wordCount, index: $index)';
}


}

/// @nodoc
abstract mixin class _$NovelChapterCopyWith<$Res> implements $NovelChapterCopyWith<$Res> {
  factory _$NovelChapterCopyWith(_NovelChapter value, $Res Function(_NovelChapter) _then) = __$NovelChapterCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? url, String? content, int? wordCount, int index
});




}
/// @nodoc
class __$NovelChapterCopyWithImpl<$Res>
    implements _$NovelChapterCopyWith<$Res> {
  __$NovelChapterCopyWithImpl(this._self, this._then);

  final _NovelChapter _self;
  final $Res Function(_NovelChapter) _then;

/// Create a copy of NovelChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? url = freezed,Object? content = freezed,Object? wordCount = freezed,Object? index = null,}) {
  return _then(_NovelChapter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,wordCount: freezed == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int?,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$NovelContent {

/// Unique identifier.
 String get id;/// Novel title.
 String get title;/// Cover image URL.
 String? get cover;/// Description/summary.
 String? get description;/// Author information.
 Author? get author;/// Tags.
 List<String>? get tags;/// Category.
 String? get category;/// Statistics.
 ContentStats? get stats;/// Publish date.
 DateTime? get createdAt;/// Update date.
 DateTime? get updatedAt;/// Source information.
 ContentSource get source;/// Chapter list.
 List<NovelChapter> get chapters;/// Novel status.
 NovelStatus? get status;/// Total word count.
 int? get wordCount;/// Latest chapter info.
 NovelChapter? get lastChapter;/// Total chapter count.
 int? get chapterCount;
/// Create a copy of NovelContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NovelContentCopyWith<NovelContent> get copyWith => _$NovelContentCopyWithImpl<NovelContent>(this as NovelContent, _$identity);

  /// Serializes this NovelContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NovelContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other.chapters, chapters)&&(identical(other.status, status) || other.status == status)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.lastChapter, lastChapter) || other.lastChapter == lastChapter)&&(identical(other.chapterCount, chapterCount) || other.chapterCount == chapterCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,cover,description,author,const DeepCollectionEquality().hash(tags),category,stats,createdAt,updatedAt,source,const DeepCollectionEquality().hash(chapters),status,wordCount,lastChapter,chapterCount);

@override
String toString() {
  return 'NovelContent(id: $id, title: $title, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, source: $source, chapters: $chapters, status: $status, wordCount: $wordCount, lastChapter: $lastChapter, chapterCount: $chapterCount)';
}


}

/// @nodoc
abstract mixin class $NovelContentCopyWith<$Res>  {
  factory $NovelContentCopyWith(NovelContent value, $Res Function(NovelContent) _then) = _$NovelContentCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, ContentSource source, List<NovelChapter> chapters, NovelStatus? status, int? wordCount, NovelChapter? lastChapter, int? chapterCount
});


$AuthorCopyWith<$Res>? get author;$ContentStatsCopyWith<$Res>? get stats;$ContentSourceCopyWith<$Res> get source;$NovelChapterCopyWith<$Res>? get lastChapter;

}
/// @nodoc
class _$NovelContentCopyWithImpl<$Res>
    implements $NovelContentCopyWith<$Res> {
  _$NovelContentCopyWithImpl(this._self, this._then);

  final NovelContent _self;
  final $Res Function(NovelContent) _then;

/// Create a copy of NovelContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? source = null,Object? chapters = null,Object? status = freezed,Object? wordCount = freezed,Object? lastChapter = freezed,Object? chapterCount = freezed,}) {
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
as List<NovelChapter>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NovelStatus?,wordCount: freezed == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int?,lastChapter: freezed == lastChapter ? _self.lastChapter : lastChapter // ignore: cast_nullable_to_non_nullable
as NovelChapter?,chapterCount: freezed == chapterCount ? _self.chapterCount : chapterCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of NovelContent
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
}/// Create a copy of NovelContent
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
}/// Create a copy of NovelContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of NovelContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NovelChapterCopyWith<$Res>? get lastChapter {
    if (_self.lastChapter == null) {
    return null;
  }

  return $NovelChapterCopyWith<$Res>(_self.lastChapter!, (value) {
    return _then(_self.copyWith(lastChapter: value));
  });
}
}


/// Adds pattern-matching-related methods to [NovelContent].
extension NovelContentPatterns on NovelContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NovelContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NovelContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NovelContent value)  $default,){
final _that = this;
switch (_that) {
case _NovelContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NovelContent value)?  $default,){
final _that = this;
switch (_that) {
case _NovelContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source,  List<NovelChapter> chapters,  NovelStatus? status,  int? wordCount,  NovelChapter? lastChapter,  int? chapterCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NovelContent() when $default != null:
return $default(_that.id,_that.title,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source,_that.chapters,_that.status,_that.wordCount,_that.lastChapter,_that.chapterCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source,  List<NovelChapter> chapters,  NovelStatus? status,  int? wordCount,  NovelChapter? lastChapter,  int? chapterCount)  $default,) {final _that = this;
switch (_that) {
case _NovelContent():
return $default(_that.id,_that.title,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source,_that.chapters,_that.status,_that.wordCount,_that.lastChapter,_that.chapterCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source,  List<NovelChapter> chapters,  NovelStatus? status,  int? wordCount,  NovelChapter? lastChapter,  int? chapterCount)?  $default,) {final _that = this;
switch (_that) {
case _NovelContent() when $default != null:
return $default(_that.id,_that.title,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source,_that.chapters,_that.status,_that.wordCount,_that.lastChapter,_that.chapterCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NovelContent implements NovelContent {
  const _NovelContent({required this.id, required this.title, this.cover, this.description, this.author, final  List<String>? tags, this.category, this.stats, this.createdAt, this.updatedAt, required this.source, required final  List<NovelChapter> chapters, this.status, this.wordCount, this.lastChapter, this.chapterCount}): _tags = tags,_chapters = chapters;
  factory _NovelContent.fromJson(Map<String, dynamic> json) => _$NovelContentFromJson(json);

/// Unique identifier.
@override final  String id;
/// Novel title.
@override final  String title;
/// Cover image URL.
@override final  String? cover;
/// Description/summary.
@override final  String? description;
/// Author information.
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
 final  List<NovelChapter> _chapters;
/// Chapter list.
@override List<NovelChapter> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}

/// Novel status.
@override final  NovelStatus? status;
/// Total word count.
@override final  int? wordCount;
/// Latest chapter info.
@override final  NovelChapter? lastChapter;
/// Total chapter count.
@override final  int? chapterCount;

/// Create a copy of NovelContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NovelContentCopyWith<_NovelContent> get copyWith => __$NovelContentCopyWithImpl<_NovelContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NovelContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NovelContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other._chapters, _chapters)&&(identical(other.status, status) || other.status == status)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.lastChapter, lastChapter) || other.lastChapter == lastChapter)&&(identical(other.chapterCount, chapterCount) || other.chapterCount == chapterCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,cover,description,author,const DeepCollectionEquality().hash(_tags),category,stats,createdAt,updatedAt,source,const DeepCollectionEquality().hash(_chapters),status,wordCount,lastChapter,chapterCount);

@override
String toString() {
  return 'NovelContent(id: $id, title: $title, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, source: $source, chapters: $chapters, status: $status, wordCount: $wordCount, lastChapter: $lastChapter, chapterCount: $chapterCount)';
}


}

/// @nodoc
abstract mixin class _$NovelContentCopyWith<$Res> implements $NovelContentCopyWith<$Res> {
  factory _$NovelContentCopyWith(_NovelContent value, $Res Function(_NovelContent) _then) = __$NovelContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, ContentSource source, List<NovelChapter> chapters, NovelStatus? status, int? wordCount, NovelChapter? lastChapter, int? chapterCount
});


@override $AuthorCopyWith<$Res>? get author;@override $ContentStatsCopyWith<$Res>? get stats;@override $ContentSourceCopyWith<$Res> get source;@override $NovelChapterCopyWith<$Res>? get lastChapter;

}
/// @nodoc
class __$NovelContentCopyWithImpl<$Res>
    implements _$NovelContentCopyWith<$Res> {
  __$NovelContentCopyWithImpl(this._self, this._then);

  final _NovelContent _self;
  final $Res Function(_NovelContent) _then;

/// Create a copy of NovelContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? source = null,Object? chapters = null,Object? status = freezed,Object? wordCount = freezed,Object? lastChapter = freezed,Object? chapterCount = freezed,}) {
  return _then(_NovelContent(
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
as List<NovelChapter>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NovelStatus?,wordCount: freezed == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int?,lastChapter: freezed == lastChapter ? _self.lastChapter : lastChapter // ignore: cast_nullable_to_non_nullable
as NovelChapter?,chapterCount: freezed == chapterCount ? _self.chapterCount : chapterCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of NovelContent
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
}/// Create a copy of NovelContent
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
}/// Create a copy of NovelContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of NovelContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NovelChapterCopyWith<$Res>? get lastChapter {
    if (_self.lastChapter == null) {
    return null;
  }

  return $NovelChapterCopyWith<$Res>(_self.lastChapter!, (value) {
    return _then(_self.copyWith(lastChapter: value));
  });
}
}

// dart format on
