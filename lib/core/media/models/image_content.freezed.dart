// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageInfo {

/// 图片 URL。
 String get url;/// 缩略图/预览 URL。
 String? get thumbnail;/// 图片宽度（像素）。
 int? get width;/// 图片高度（像素）。
 int? get height;/// 文件大小（字节）。
 int? get fileSize;/// 图片格式（如 "jpg"、"png"、"webp"）。
 String? get format;/// 替代文本/说明。
 String? get caption;
/// Create a copy of ImageInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageInfoCopyWith<ImageInfo> get copyWith => _$ImageInfoCopyWithImpl<ImageInfo>(this as ImageInfo, _$identity);

  /// Serializes this ImageInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageInfo&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.format, format) || other.format == format)&&(identical(other.caption, caption) || other.caption == caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,thumbnail,width,height,fileSize,format,caption);

@override
String toString() {
  return 'ImageInfo(url: $url, thumbnail: $thumbnail, width: $width, height: $height, fileSize: $fileSize, format: $format, caption: $caption)';
}


}

/// @nodoc
abstract mixin class $ImageInfoCopyWith<$Res>  {
  factory $ImageInfoCopyWith(ImageInfo value, $Res Function(ImageInfo) _then) = _$ImageInfoCopyWithImpl;
@useResult
$Res call({
 String url, String? thumbnail, int? width, int? height, int? fileSize, String? format, String? caption
});




}
/// @nodoc
class _$ImageInfoCopyWithImpl<$Res>
    implements $ImageInfoCopyWith<$Res> {
  _$ImageInfoCopyWithImpl(this._self, this._then);

  final ImageInfo _self;
  final $Res Function(ImageInfo) _then;

/// Create a copy of ImageInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? thumbnail = freezed,Object? width = freezed,Object? height = freezed,Object? fileSize = freezed,Object? format = freezed,Object? caption = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,thumbnail: freezed == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageInfo].
extension ImageInfoPatterns on ImageInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageInfo value)  $default,){
final _that = this;
switch (_that) {
case _ImageInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ImageInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String? thumbnail,  int? width,  int? height,  int? fileSize,  String? format,  String? caption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageInfo() when $default != null:
return $default(_that.url,_that.thumbnail,_that.width,_that.height,_that.fileSize,_that.format,_that.caption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String? thumbnail,  int? width,  int? height,  int? fileSize,  String? format,  String? caption)  $default,) {final _that = this;
switch (_that) {
case _ImageInfo():
return $default(_that.url,_that.thumbnail,_that.width,_that.height,_that.fileSize,_that.format,_that.caption);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String? thumbnail,  int? width,  int? height,  int? fileSize,  String? format,  String? caption)?  $default,) {final _that = this;
switch (_that) {
case _ImageInfo() when $default != null:
return $default(_that.url,_that.thumbnail,_that.width,_that.height,_that.fileSize,_that.format,_that.caption);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageInfo implements ImageInfo {
  const _ImageInfo({required this.url, this.thumbnail, this.width, this.height, this.fileSize, this.format, this.caption});
  factory _ImageInfo.fromJson(Map<String, dynamic> json) => _$ImageInfoFromJson(json);

/// 图片 URL。
@override final  String url;
/// 缩略图/预览 URL。
@override final  String? thumbnail;
/// 图片宽度（像素）。
@override final  int? width;
/// 图片高度（像素）。
@override final  int? height;
/// 文件大小（字节）。
@override final  int? fileSize;
/// 图片格式（如 "jpg"、"png"、"webp"）。
@override final  String? format;
/// 替代文本/说明。
@override final  String? caption;

/// Create a copy of ImageInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageInfoCopyWith<_ImageInfo> get copyWith => __$ImageInfoCopyWithImpl<_ImageInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageInfo&&(identical(other.url, url) || other.url == url)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.format, format) || other.format == format)&&(identical(other.caption, caption) || other.caption == caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,thumbnail,width,height,fileSize,format,caption);

@override
String toString() {
  return 'ImageInfo(url: $url, thumbnail: $thumbnail, width: $width, height: $height, fileSize: $fileSize, format: $format, caption: $caption)';
}


}

/// @nodoc
abstract mixin class _$ImageInfoCopyWith<$Res> implements $ImageInfoCopyWith<$Res> {
  factory _$ImageInfoCopyWith(_ImageInfo value, $Res Function(_ImageInfo) _then) = __$ImageInfoCopyWithImpl;
@override @useResult
$Res call({
 String url, String? thumbnail, int? width, int? height, int? fileSize, String? format, String? caption
});




}
/// @nodoc
class __$ImageInfoCopyWithImpl<$Res>
    implements _$ImageInfoCopyWith<$Res> {
  __$ImageInfoCopyWithImpl(this._self, this._then);

  final _ImageInfo _self;
  final $Res Function(_ImageInfo) _then;

/// Create a copy of ImageInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? thumbnail = freezed,Object? width = freezed,Object? height = freezed,Object? fileSize = freezed,Object? format = freezed,Object? caption = freezed,}) {
  return _then(_ImageInfo(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,thumbnail: freezed == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,format: freezed == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ImageContent {

/// 唯一标识符。
 String get id;/// 标题/说明。
 String get title;/// 来源信息。
 ContentSource get source;/// 图片列表（非相册为单张，相册为多张）。
 List<ImageInfo> get images;/// 是否为相册（多图）。
 bool get isAlbum;/// 封面/缩略图 URL。
 String? get cover;/// 描述。
 String? get description;/// 作者/摄影师信息。
 Author? get author;/// 标签。
 List<String>? get tags;/// 分类。
 String? get category;/// 统计信息。
 ContentStats? get stats;/// 上传日期。
 DateTime? get createdAt;/// 更新日期。
 DateTime? get updatedAt;/// 图片分辨率字符串（如 "1920x1080"）。
 String? get resolution;/// 是否为 AI 生成内容。
 bool? get isAIGenerated;/// AI 模型名称（如 "Stable Diffusion"、"Midjourney"）。
 String? get aiModel;
/// Create a copy of ImageContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageContentCopyWith<ImageContent> get copyWith => _$ImageContentCopyWithImpl<ImageContent>(this as ImageContent, _$identity);

  /// Serializes this ImageContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.isAlbum, isAlbum) || other.isAlbum == isAlbum)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.isAIGenerated, isAIGenerated) || other.isAIGenerated == isAIGenerated)&&(identical(other.aiModel, aiModel) || other.aiModel == aiModel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,source,const DeepCollectionEquality().hash(images),isAlbum,cover,description,author,const DeepCollectionEquality().hash(tags),category,stats,createdAt,updatedAt,resolution,isAIGenerated,aiModel);

@override
String toString() {
  return 'ImageContent(id: $id, title: $title, source: $source, images: $images, isAlbum: $isAlbum, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, resolution: $resolution, isAIGenerated: $isAIGenerated, aiModel: $aiModel)';
}


}

/// @nodoc
abstract mixin class $ImageContentCopyWith<$Res>  {
  factory $ImageContentCopyWith(ImageContent value, $Res Function(ImageContent) _then) = _$ImageContentCopyWithImpl;
@useResult
$Res call({
 String id, String title, ContentSource source, List<ImageInfo> images, bool isAlbum, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, String? resolution, bool? isAIGenerated, String? aiModel
});


$ContentSourceCopyWith<$Res> get source;$AuthorCopyWith<$Res>? get author;$ContentStatsCopyWith<$Res>? get stats;

}
/// @nodoc
class _$ImageContentCopyWithImpl<$Res>
    implements $ImageContentCopyWith<$Res> {
  _$ImageContentCopyWithImpl(this._self, this._then);

  final ImageContent _self;
  final $Res Function(ImageContent) _then;

/// Create a copy of ImageContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? source = null,Object? images = null,Object? isAlbum = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? resolution = freezed,Object? isAIGenerated = freezed,Object? aiModel = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ContentSource,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<ImageInfo>,isAlbum: null == isAlbum ? _self.isAlbum : isAlbum // ignore: cast_nullable_to_non_nullable
as bool,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Author?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ContentStats?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as String?,isAIGenerated: freezed == isAIGenerated ? _self.isAIGenerated : isAIGenerated // ignore: cast_nullable_to_non_nullable
as bool?,aiModel: freezed == aiModel ? _self.aiModel : aiModel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ImageContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of ImageContent
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
}/// Create a copy of ImageContent
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
}
}


/// Adds pattern-matching-related methods to [ImageContent].
extension ImageContentPatterns on ImageContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageContent value)  $default,){
final _that = this;
switch (_that) {
case _ImageContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageContent value)?  $default,){
final _that = this;
switch (_that) {
case _ImageContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  ContentSource source,  List<ImageInfo> images,  bool isAlbum,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  String? resolution,  bool? isAIGenerated,  String? aiModel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageContent() when $default != null:
return $default(_that.id,_that.title,_that.source,_that.images,_that.isAlbum,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.resolution,_that.isAIGenerated,_that.aiModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  ContentSource source,  List<ImageInfo> images,  bool isAlbum,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  String? resolution,  bool? isAIGenerated,  String? aiModel)  $default,) {final _that = this;
switch (_that) {
case _ImageContent():
return $default(_that.id,_that.title,_that.source,_that.images,_that.isAlbum,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.resolution,_that.isAIGenerated,_that.aiModel);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  ContentSource source,  List<ImageInfo> images,  bool isAlbum,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  String? resolution,  bool? isAIGenerated,  String? aiModel)?  $default,) {final _that = this;
switch (_that) {
case _ImageContent() when $default != null:
return $default(_that.id,_that.title,_that.source,_that.images,_that.isAlbum,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.resolution,_that.isAIGenerated,_that.aiModel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageContent implements ImageContent {
  const _ImageContent({required this.id, required this.title, required this.source, required final  List<ImageInfo> images, required this.isAlbum, this.cover, this.description, this.author, final  List<String>? tags, this.category, this.stats, this.createdAt, this.updatedAt, this.resolution, this.isAIGenerated, this.aiModel}): _images = images,_tags = tags;
  factory _ImageContent.fromJson(Map<String, dynamic> json) => _$ImageContentFromJson(json);

/// 唯一标识符。
@override final  String id;
/// 标题/说明。
@override final  String title;
/// 来源信息。
@override final  ContentSource source;
/// 图片列表（非相册为单张，相册为多张）。
 final  List<ImageInfo> _images;
/// 图片列表（非相册为单张，相册为多张）。
@override List<ImageInfo> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

/// 是否为相册（多图）。
@override final  bool isAlbum;
/// 封面/缩略图 URL。
@override final  String? cover;
/// 描述。
@override final  String? description;
/// 作者/摄影师信息。
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
/// 上传日期。
@override final  DateTime? createdAt;
/// 更新日期。
@override final  DateTime? updatedAt;
/// 图片分辨率字符串（如 "1920x1080"）。
@override final  String? resolution;
/// 是否为 AI 生成内容。
@override final  bool? isAIGenerated;
/// AI 模型名称（如 "Stable Diffusion"、"Midjourney"）。
@override final  String? aiModel;

/// Create a copy of ImageContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageContentCopyWith<_ImageContent> get copyWith => __$ImageContentCopyWithImpl<_ImageContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.source, source) || other.source == source)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.isAlbum, isAlbum) || other.isAlbum == isAlbum)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.resolution, resolution) || other.resolution == resolution)&&(identical(other.isAIGenerated, isAIGenerated) || other.isAIGenerated == isAIGenerated)&&(identical(other.aiModel, aiModel) || other.aiModel == aiModel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,source,const DeepCollectionEquality().hash(_images),isAlbum,cover,description,author,const DeepCollectionEquality().hash(_tags),category,stats,createdAt,updatedAt,resolution,isAIGenerated,aiModel);

@override
String toString() {
  return 'ImageContent(id: $id, title: $title, source: $source, images: $images, isAlbum: $isAlbum, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, resolution: $resolution, isAIGenerated: $isAIGenerated, aiModel: $aiModel)';
}


}

/// @nodoc
abstract mixin class _$ImageContentCopyWith<$Res> implements $ImageContentCopyWith<$Res> {
  factory _$ImageContentCopyWith(_ImageContent value, $Res Function(_ImageContent) _then) = __$ImageContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, ContentSource source, List<ImageInfo> images, bool isAlbum, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, String? resolution, bool? isAIGenerated, String? aiModel
});


@override $ContentSourceCopyWith<$Res> get source;@override $AuthorCopyWith<$Res>? get author;@override $ContentStatsCopyWith<$Res>? get stats;

}
/// @nodoc
class __$ImageContentCopyWithImpl<$Res>
    implements _$ImageContentCopyWith<$Res> {
  __$ImageContentCopyWithImpl(this._self, this._then);

  final _ImageContent _self;
  final $Res Function(_ImageContent) _then;

/// Create a copy of ImageContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? source = null,Object? images = null,Object? isAlbum = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? resolution = freezed,Object? isAIGenerated = freezed,Object? aiModel = freezed,}) {
  return _then(_ImageContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ContentSource,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<ImageInfo>,isAlbum: null == isAlbum ? _self.isAlbum : isAlbum // ignore: cast_nullable_to_non_nullable
as bool,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Author?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ContentStats?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resolution: freezed == resolution ? _self.resolution : resolution // ignore: cast_nullable_to_non_nullable
as String?,isAIGenerated: freezed == isAIGenerated ? _self.isAIGenerated : isAIGenerated // ignore: cast_nullable_to_non_nullable
as bool?,aiModel: freezed == aiModel ? _self.aiModel : aiModel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ImageContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of ImageContent
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
}/// Create a copy of ImageContent
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
}
}

// dart format on
