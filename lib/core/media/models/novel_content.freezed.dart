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

/// 章节 ID。
 String get id;/// 章节标题。
 String get title;/// 章节索引/编号。
 int get index;/// 章节 URL（如果为单独页面）。
 String? get url;/// 章节文本内容。
 String? get content;/// 本章字数。
 int? get wordCount;
/// Create a copy of NovelChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NovelChapterCopyWith<NovelChapter> get copyWith => _$NovelChapterCopyWithImpl<NovelChapter>(this as NovelChapter, _$identity);

  /// Serializes this NovelChapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NovelChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.index, index) || other.index == index)&&(identical(other.url, url) || other.url == url)&&(identical(other.content, content) || other.content == content)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,index,url,content,wordCount);

@override
String toString() {
  return 'NovelChapter(id: $id, title: $title, index: $index, url: $url, content: $content, wordCount: $wordCount)';
}


}

/// @nodoc
abstract mixin class $NovelChapterCopyWith<$Res>  {
  factory $NovelChapterCopyWith(NovelChapter value, $Res Function(NovelChapter) _then) = _$NovelChapterCopyWithImpl;
@useResult
$Res call({
 String id, String title, int index, String? url, String? content, int? wordCount
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? index = null,Object? url = freezed,Object? content = freezed,Object? wordCount = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,wordCount: freezed == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int index,  String? url,  String? content,  int? wordCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NovelChapter() when $default != null:
return $default(_that.id,_that.title,_that.index,_that.url,_that.content,_that.wordCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int index,  String? url,  String? content,  int? wordCount)  $default,) {final _that = this;
switch (_that) {
case _NovelChapter():
return $default(_that.id,_that.title,_that.index,_that.url,_that.content,_that.wordCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int index,  String? url,  String? content,  int? wordCount)?  $default,) {final _that = this;
switch (_that) {
case _NovelChapter() when $default != null:
return $default(_that.id,_that.title,_that.index,_that.url,_that.content,_that.wordCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NovelChapter implements NovelChapter {
  const _NovelChapter({required this.id, required this.title, required this.index, this.url, this.content, this.wordCount});
  factory _NovelChapter.fromJson(Map<String, dynamic> json) => _$NovelChapterFromJson(json);

/// 章节 ID。
@override final  String id;
/// 章节标题。
@override final  String title;
/// 章节索引/编号。
@override final  int index;
/// 章节 URL（如果为单独页面）。
@override final  String? url;
/// 章节文本内容。
@override final  String? content;
/// 本章字数。
@override final  int? wordCount;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NovelChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.index, index) || other.index == index)&&(identical(other.url, url) || other.url == url)&&(identical(other.content, content) || other.content == content)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,index,url,content,wordCount);

@override
String toString() {
  return 'NovelChapter(id: $id, title: $title, index: $index, url: $url, content: $content, wordCount: $wordCount)';
}


}

/// @nodoc
abstract mixin class _$NovelChapterCopyWith<$Res> implements $NovelChapterCopyWith<$Res> {
  factory _$NovelChapterCopyWith(_NovelChapter value, $Res Function(_NovelChapter) _then) = __$NovelChapterCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int index, String? url, String? content, int? wordCount
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? index = null,Object? url = freezed,Object? content = freezed,Object? wordCount = freezed,}) {
  return _then(_NovelChapter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,wordCount: freezed == wordCount ? _self.wordCount : wordCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$NovelContent {

/// 唯一标识符。
 String get id;/// 小说标题。
 String get title;/// 来源信息。
 ContentSource get source;/// 章节列表。
 List<NovelChapter> get chapters;/// 封面图片 URL。
 String? get cover;/// 描述/摘要。
 String? get description;/// 作者信息。
 Author? get author;/// 标签。
 List<String>? get tags;/// 分类。
 String? get category;/// 统计信息。
 ContentStats? get stats;/// 发布日期。
 DateTime? get createdAt;/// 更新日期。
 DateTime? get updatedAt;/// 小说状态。
 NovelStatus? get status;/// 总字数。
 int? get wordCount;/// 最新章节信息。
 NovelChapter? get lastChapter;/// 总章节数。
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NovelContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other.chapters, chapters)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.lastChapter, lastChapter) || other.lastChapter == lastChapter)&&(identical(other.chapterCount, chapterCount) || other.chapterCount == chapterCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,source,const DeepCollectionEquality().hash(chapters),cover,description,author,const DeepCollectionEquality().hash(tags),category,stats,createdAt,updatedAt,status,wordCount,lastChapter,chapterCount);

@override
String toString() {
  return 'NovelContent(id: $id, title: $title, source: $source, chapters: $chapters, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, wordCount: $wordCount, lastChapter: $lastChapter, chapterCount: $chapterCount)';
}


}

/// @nodoc
abstract mixin class $NovelContentCopyWith<$Res>  {
  factory $NovelContentCopyWith(NovelContent value, $Res Function(NovelContent) _then) = _$NovelContentCopyWithImpl;
@useResult
$Res call({
 String id, String title, ContentSource source, List<NovelChapter> chapters, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, NovelStatus? status, int? wordCount, NovelChapter? lastChapter, int? chapterCount
});


$ContentSourceCopyWith<$Res> get source;$AuthorCopyWith<$Res>? get author;$ContentStatsCopyWith<$Res>? get stats;$NovelChapterCopyWith<$Res>? get lastChapter;

}
/// @nodoc
class _$NovelContentCopyWithImpl<$Res>
    implements $NovelContentCopyWith<$Res> {
  _$NovelContentCopyWithImpl(this._self, this._then);

  final NovelContent _self;
  final $Res Function(NovelContent) _then;

/// Create a copy of NovelContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? source = null,Object? chapters = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? status = freezed,Object? wordCount = freezed,Object? lastChapter = freezed,Object? chapterCount = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ContentSource,chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<NovelChapter>,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Author?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ContentStats?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
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
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of NovelContent
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  ContentSource source,  List<NovelChapter> chapters,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  NovelStatus? status,  int? wordCount,  NovelChapter? lastChapter,  int? chapterCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NovelContent() when $default != null:
return $default(_that.id,_that.title,_that.source,_that.chapters,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.status,_that.wordCount,_that.lastChapter,_that.chapterCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  ContentSource source,  List<NovelChapter> chapters,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  NovelStatus? status,  int? wordCount,  NovelChapter? lastChapter,  int? chapterCount)  $default,) {final _that = this;
switch (_that) {
case _NovelContent():
return $default(_that.id,_that.title,_that.source,_that.chapters,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.status,_that.wordCount,_that.lastChapter,_that.chapterCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  ContentSource source,  List<NovelChapter> chapters,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  NovelStatus? status,  int? wordCount,  NovelChapter? lastChapter,  int? chapterCount)?  $default,) {final _that = this;
switch (_that) {
case _NovelContent() when $default != null:
return $default(_that.id,_that.title,_that.source,_that.chapters,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.status,_that.wordCount,_that.lastChapter,_that.chapterCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NovelContent implements NovelContent {
  const _NovelContent({required this.id, required this.title, required this.source, required final  List<NovelChapter> chapters, this.cover, this.description, this.author, final  List<String>? tags, this.category, this.stats, this.createdAt, this.updatedAt, this.status, this.wordCount, this.lastChapter, this.chapterCount}): _chapters = chapters,_tags = tags;
  factory _NovelContent.fromJson(Map<String, dynamic> json) => _$NovelContentFromJson(json);

/// 唯一标识符。
@override final  String id;
/// 小说标题。
@override final  String title;
/// 来源信息。
@override final  ContentSource source;
/// 章节列表。
 final  List<NovelChapter> _chapters;
/// 章节列表。
@override List<NovelChapter> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}

/// 封面图片 URL。
@override final  String? cover;
/// 描述/摘要。
@override final  String? description;
/// 作者信息。
@override final  Author? author;
/// 标签。
 final  List<String>? _tags;
/// 标签。
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// 分类。
@override final  String? category;
/// 统计信息。
@override final  ContentStats? stats;
/// 发布日期。
@override final  DateTime? createdAt;
/// 更新日期。
@override final  DateTime? updatedAt;
/// 小说状态。
@override final  NovelStatus? status;
/// 总字数。
@override final  int? wordCount;
/// 最新章节信息。
@override final  NovelChapter? lastChapter;
/// 总章节数。
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NovelContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other._chapters, _chapters)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.wordCount, wordCount) || other.wordCount == wordCount)&&(identical(other.lastChapter, lastChapter) || other.lastChapter == lastChapter)&&(identical(other.chapterCount, chapterCount) || other.chapterCount == chapterCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,source,const DeepCollectionEquality().hash(_chapters),cover,description,author,const DeepCollectionEquality().hash(_tags),category,stats,createdAt,updatedAt,status,wordCount,lastChapter,chapterCount);

@override
String toString() {
  return 'NovelContent(id: $id, title: $title, source: $source, chapters: $chapters, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, wordCount: $wordCount, lastChapter: $lastChapter, chapterCount: $chapterCount)';
}


}

/// @nodoc
abstract mixin class _$NovelContentCopyWith<$Res> implements $NovelContentCopyWith<$Res> {
  factory _$NovelContentCopyWith(_NovelContent value, $Res Function(_NovelContent) _then) = __$NovelContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, ContentSource source, List<NovelChapter> chapters, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, NovelStatus? status, int? wordCount, NovelChapter? lastChapter, int? chapterCount
});


@override $ContentSourceCopyWith<$Res> get source;@override $AuthorCopyWith<$Res>? get author;@override $ContentStatsCopyWith<$Res>? get stats;@override $NovelChapterCopyWith<$Res>? get lastChapter;

}
/// @nodoc
class __$NovelContentCopyWithImpl<$Res>
    implements _$NovelContentCopyWith<$Res> {
  __$NovelContentCopyWithImpl(this._self, this._then);

  final _NovelContent _self;
  final $Res Function(_NovelContent) _then;

/// Create a copy of NovelContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? source = null,Object? chapters = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? status = freezed,Object? wordCount = freezed,Object? lastChapter = freezed,Object? chapterCount = freezed,}) {
  return _then(_NovelContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ContentSource,chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<NovelChapter>,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Author?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ContentStats?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
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
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of NovelContent
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
