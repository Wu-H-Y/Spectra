// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoQuality {

/// 画质标签（如 "1080p"、"720p"、"480p"）。
 String get label;/// 视频流 URL。
 String get url;/// 视频编码（如 "h264"、"h265"、"vp9"）。
 String? get codec;/// 码率（kbps）。
 int? get bitrate;/// 分辨率宽度。
 int? get width;/// 分辨率高度。
 int? get height;/// 文件大小（字节）。
 int? get fileSize;
/// Create a copy of VideoQuality
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoQualityCopyWith<VideoQuality> get copyWith => _$VideoQualityCopyWithImpl<VideoQuality>(this as VideoQuality, _$identity);

  /// Serializes this VideoQuality to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoQuality&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url)&&(identical(other.codec, codec) || other.codec == codec)&&(identical(other.bitrate, bitrate) || other.bitrate == bitrate)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,url,codec,bitrate,width,height,fileSize);

@override
String toString() {
  return 'VideoQuality(label: $label, url: $url, codec: $codec, bitrate: $bitrate, width: $width, height: $height, fileSize: $fileSize)';
}


}

/// @nodoc
abstract mixin class $VideoQualityCopyWith<$Res>  {
  factory $VideoQualityCopyWith(VideoQuality value, $Res Function(VideoQuality) _then) = _$VideoQualityCopyWithImpl;
@useResult
$Res call({
 String label, String url, String? codec, int? bitrate, int? width, int? height, int? fileSize
});




}
/// @nodoc
class _$VideoQualityCopyWithImpl<$Res>
    implements $VideoQualityCopyWith<$Res> {
  _$VideoQualityCopyWithImpl(this._self, this._then);

  final VideoQuality _self;
  final $Res Function(VideoQuality) _then;

/// Create a copy of VideoQuality
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? url = null,Object? codec = freezed,Object? bitrate = freezed,Object? width = freezed,Object? height = freezed,Object? fileSize = freezed,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,codec: freezed == codec ? _self.codec : codec // ignore: cast_nullable_to_non_nullable
as String?,bitrate: freezed == bitrate ? _self.bitrate : bitrate // ignore: cast_nullable_to_non_nullable
as int?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoQuality].
extension VideoQualityPatterns on VideoQuality {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoQuality value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoQuality() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoQuality value)  $default,){
final _that = this;
switch (_that) {
case _VideoQuality():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoQuality value)?  $default,){
final _that = this;
switch (_that) {
case _VideoQuality() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String url,  String? codec,  int? bitrate,  int? width,  int? height,  int? fileSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoQuality() when $default != null:
return $default(_that.label,_that.url,_that.codec,_that.bitrate,_that.width,_that.height,_that.fileSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String url,  String? codec,  int? bitrate,  int? width,  int? height,  int? fileSize)  $default,) {final _that = this;
switch (_that) {
case _VideoQuality():
return $default(_that.label,_that.url,_that.codec,_that.bitrate,_that.width,_that.height,_that.fileSize);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String url,  String? codec,  int? bitrate,  int? width,  int? height,  int? fileSize)?  $default,) {final _that = this;
switch (_that) {
case _VideoQuality() when $default != null:
return $default(_that.label,_that.url,_that.codec,_that.bitrate,_that.width,_that.height,_that.fileSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoQuality implements VideoQuality {
  const _VideoQuality({required this.label, required this.url, this.codec, this.bitrate, this.width, this.height, this.fileSize});
  factory _VideoQuality.fromJson(Map<String, dynamic> json) => _$VideoQualityFromJson(json);

/// 画质标签（如 "1080p"、"720p"、"480p"）。
@override final  String label;
/// 视频流 URL。
@override final  String url;
/// 视频编码（如 "h264"、"h265"、"vp9"）。
@override final  String? codec;
/// 码率（kbps）。
@override final  int? bitrate;
/// 分辨率宽度。
@override final  int? width;
/// 分辨率高度。
@override final  int? height;
/// 文件大小（字节）。
@override final  int? fileSize;

/// Create a copy of VideoQuality
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoQualityCopyWith<_VideoQuality> get copyWith => __$VideoQualityCopyWithImpl<_VideoQuality>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoQualityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoQuality&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url)&&(identical(other.codec, codec) || other.codec == codec)&&(identical(other.bitrate, bitrate) || other.bitrate == bitrate)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,url,codec,bitrate,width,height,fileSize);

@override
String toString() {
  return 'VideoQuality(label: $label, url: $url, codec: $codec, bitrate: $bitrate, width: $width, height: $height, fileSize: $fileSize)';
}


}

/// @nodoc
abstract mixin class _$VideoQualityCopyWith<$Res> implements $VideoQualityCopyWith<$Res> {
  factory _$VideoQualityCopyWith(_VideoQuality value, $Res Function(_VideoQuality) _then) = __$VideoQualityCopyWithImpl;
@override @useResult
$Res call({
 String label, String url, String? codec, int? bitrate, int? width, int? height, int? fileSize
});




}
/// @nodoc
class __$VideoQualityCopyWithImpl<$Res>
    implements _$VideoQualityCopyWith<$Res> {
  __$VideoQualityCopyWithImpl(this._self, this._then);

  final _VideoQuality _self;
  final $Res Function(_VideoQuality) _then;

/// Create a copy of VideoQuality
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? url = null,Object? codec = freezed,Object? bitrate = freezed,Object? width = freezed,Object? height = freezed,Object? fileSize = freezed,}) {
  return _then(_VideoQuality(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,codec: freezed == codec ? _self.codec : codec // ignore: cast_nullable_to_non_nullable
as String?,bitrate: freezed == bitrate ? _self.bitrate : bitrate // ignore: cast_nullable_to_non_nullable
as int?,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$VideoChapter {

/// 章节 ID。
 String get id;/// 章节标题。
 String get title;/// 章节索引/编号。
 int get index;/// 章节 URL（如果为单独页面）。
 String? get url;/// 时长（秒）。
 int? get duration;
/// Create a copy of VideoChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoChapterCopyWith<VideoChapter> get copyWith => _$VideoChapterCopyWithImpl<VideoChapter>(this as VideoChapter, _$identity);

  /// Serializes this VideoChapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.index, index) || other.index == index)&&(identical(other.url, url) || other.url == url)&&(identical(other.duration, duration) || other.duration == duration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,index,url,duration);

@override
String toString() {
  return 'VideoChapter(id: $id, title: $title, index: $index, url: $url, duration: $duration)';
}


}

/// @nodoc
abstract mixin class $VideoChapterCopyWith<$Res>  {
  factory $VideoChapterCopyWith(VideoChapter value, $Res Function(VideoChapter) _then) = _$VideoChapterCopyWithImpl;
@useResult
$Res call({
 String id, String title, int index, String? url, int? duration
});




}
/// @nodoc
class _$VideoChapterCopyWithImpl<$Res>
    implements $VideoChapterCopyWith<$Res> {
  _$VideoChapterCopyWithImpl(this._self, this._then);

  final VideoChapter _self;
  final $Res Function(VideoChapter) _then;

/// Create a copy of VideoChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? index = null,Object? url = freezed,Object? duration = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoChapter].
extension VideoChapterPatterns on VideoChapter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoChapter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoChapter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoChapter value)  $default,){
final _that = this;
switch (_that) {
case _VideoChapter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoChapter value)?  $default,){
final _that = this;
switch (_that) {
case _VideoChapter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  int index,  String? url,  int? duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoChapter() when $default != null:
return $default(_that.id,_that.title,_that.index,_that.url,_that.duration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  int index,  String? url,  int? duration)  $default,) {final _that = this;
switch (_that) {
case _VideoChapter():
return $default(_that.id,_that.title,_that.index,_that.url,_that.duration);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  int index,  String? url,  int? duration)?  $default,) {final _that = this;
switch (_that) {
case _VideoChapter() when $default != null:
return $default(_that.id,_that.title,_that.index,_that.url,_that.duration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoChapter implements VideoChapter {
  const _VideoChapter({required this.id, required this.title, required this.index, this.url, this.duration});
  factory _VideoChapter.fromJson(Map<String, dynamic> json) => _$VideoChapterFromJson(json);

/// 章节 ID。
@override final  String id;
/// 章节标题。
@override final  String title;
/// 章节索引/编号。
@override final  int index;
/// 章节 URL（如果为单独页面）。
@override final  String? url;
/// 时长（秒）。
@override final  int? duration;

/// Create a copy of VideoChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoChapterCopyWith<_VideoChapter> get copyWith => __$VideoChapterCopyWithImpl<_VideoChapter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoChapterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.index, index) || other.index == index)&&(identical(other.url, url) || other.url == url)&&(identical(other.duration, duration) || other.duration == duration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,index,url,duration);

@override
String toString() {
  return 'VideoChapter(id: $id, title: $title, index: $index, url: $url, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$VideoChapterCopyWith<$Res> implements $VideoChapterCopyWith<$Res> {
  factory _$VideoChapterCopyWith(_VideoChapter value, $Res Function(_VideoChapter) _then) = __$VideoChapterCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, int index, String? url, int? duration
});




}
/// @nodoc
class __$VideoChapterCopyWithImpl<$Res>
    implements _$VideoChapterCopyWith<$Res> {
  __$VideoChapterCopyWithImpl(this._self, this._then);

  final _VideoChapter _self;
  final $Res Function(_VideoChapter) _then;

/// Create a copy of VideoChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? index = null,Object? url = freezed,Object? duration = freezed,}) {
  return _then(_VideoChapter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$Subtitle {

/// 语言代码（如 "en"、"zh"、"ja"）。
 String get language;/// 字幕 URL（VTT、SRT、ASS 格式）。
 String get url;/// 语言显示名称。
 String? get label;/// 是否为默认字幕。
 bool get isDefault;
/// Create a copy of Subtitle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubtitleCopyWith<Subtitle> get copyWith => _$SubtitleCopyWithImpl<Subtitle>(this as Subtitle, _$identity);

  /// Serializes this Subtitle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Subtitle&&(identical(other.language, language) || other.language == language)&&(identical(other.url, url) || other.url == url)&&(identical(other.label, label) || other.label == label)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,url,label,isDefault);

@override
String toString() {
  return 'Subtitle(language: $language, url: $url, label: $label, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $SubtitleCopyWith<$Res>  {
  factory $SubtitleCopyWith(Subtitle value, $Res Function(Subtitle) _then) = _$SubtitleCopyWithImpl;
@useResult
$Res call({
 String language, String url, String? label, bool isDefault
});




}
/// @nodoc
class _$SubtitleCopyWithImpl<$Res>
    implements $SubtitleCopyWith<$Res> {
  _$SubtitleCopyWithImpl(this._self, this._then);

  final Subtitle _self;
  final $Res Function(Subtitle) _then;

/// Create a copy of Subtitle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? url = null,Object? label = freezed,Object? isDefault = null,}) {
  return _then(_self.copyWith(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Subtitle].
extension SubtitlePatterns on Subtitle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Subtitle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Subtitle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Subtitle value)  $default,){
final _that = this;
switch (_that) {
case _Subtitle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Subtitle value)?  $default,){
final _that = this;
switch (_that) {
case _Subtitle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String language,  String url,  String? label,  bool isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Subtitle() when $default != null:
return $default(_that.language,_that.url,_that.label,_that.isDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String language,  String url,  String? label,  bool isDefault)  $default,) {final _that = this;
switch (_that) {
case _Subtitle():
return $default(_that.language,_that.url,_that.label,_that.isDefault);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String language,  String url,  String? label,  bool isDefault)?  $default,) {final _that = this;
switch (_that) {
case _Subtitle() when $default != null:
return $default(_that.language,_that.url,_that.label,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Subtitle implements Subtitle {
  const _Subtitle({required this.language, required this.url, this.label, this.isDefault = false});
  factory _Subtitle.fromJson(Map<String, dynamic> json) => _$SubtitleFromJson(json);

/// 语言代码（如 "en"、"zh"、"ja"）。
@override final  String language;
/// 字幕 URL（VTT、SRT、ASS 格式）。
@override final  String url;
/// 语言显示名称。
@override final  String? label;
/// 是否为默认字幕。
@override@JsonKey() final  bool isDefault;

/// Create a copy of Subtitle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubtitleCopyWith<_Subtitle> get copyWith => __$SubtitleCopyWithImpl<_Subtitle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubtitleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Subtitle&&(identical(other.language, language) || other.language == language)&&(identical(other.url, url) || other.url == url)&&(identical(other.label, label) || other.label == label)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,url,label,isDefault);

@override
String toString() {
  return 'Subtitle(language: $language, url: $url, label: $label, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$SubtitleCopyWith<$Res> implements $SubtitleCopyWith<$Res> {
  factory _$SubtitleCopyWith(_Subtitle value, $Res Function(_Subtitle) _then) = __$SubtitleCopyWithImpl;
@override @useResult
$Res call({
 String language, String url, String? label, bool isDefault
});




}
/// @nodoc
class __$SubtitleCopyWithImpl<$Res>
    implements _$SubtitleCopyWith<$Res> {
  __$SubtitleCopyWithImpl(this._self, this._then);

  final _Subtitle _self;
  final $Res Function(_Subtitle) _then;

/// Create a copy of Subtitle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? url = null,Object? label = freezed,Object? isDefault = null,}) {
  return _then(_Subtitle(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DanmakuConfig {

/// 弹幕数据 URL（XML 或 JSON 格式）。
 String? get url;/// 原始弹幕数据（如果嵌入）。
 String? get rawData;/// 是否启用弹幕。
 bool get enabled;
/// Create a copy of DanmakuConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DanmakuConfigCopyWith<DanmakuConfig> get copyWith => _$DanmakuConfigCopyWithImpl<DanmakuConfig>(this as DanmakuConfig, _$identity);

  /// Serializes this DanmakuConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DanmakuConfig&&(identical(other.url, url) || other.url == url)&&(identical(other.rawData, rawData) || other.rawData == rawData)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,rawData,enabled);

@override
String toString() {
  return 'DanmakuConfig(url: $url, rawData: $rawData, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $DanmakuConfigCopyWith<$Res>  {
  factory $DanmakuConfigCopyWith(DanmakuConfig value, $Res Function(DanmakuConfig) _then) = _$DanmakuConfigCopyWithImpl;
@useResult
$Res call({
 String? url, String? rawData, bool enabled
});




}
/// @nodoc
class _$DanmakuConfigCopyWithImpl<$Res>
    implements $DanmakuConfigCopyWith<$Res> {
  _$DanmakuConfigCopyWithImpl(this._self, this._then);

  final DanmakuConfig _self;
  final $Res Function(DanmakuConfig) _then;

/// Create a copy of DanmakuConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = freezed,Object? rawData = freezed,Object? enabled = null,}) {
  return _then(_self.copyWith(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,rawData: freezed == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DanmakuConfig].
extension DanmakuConfigPatterns on DanmakuConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DanmakuConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DanmakuConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DanmakuConfig value)  $default,){
final _that = this;
switch (_that) {
case _DanmakuConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DanmakuConfig value)?  $default,){
final _that = this;
switch (_that) {
case _DanmakuConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? url,  String? rawData,  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DanmakuConfig() when $default != null:
return $default(_that.url,_that.rawData,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? url,  String? rawData,  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _DanmakuConfig():
return $default(_that.url,_that.rawData,_that.enabled);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? url,  String? rawData,  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _DanmakuConfig() when $default != null:
return $default(_that.url,_that.rawData,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DanmakuConfig implements DanmakuConfig {
  const _DanmakuConfig({this.url, this.rawData, this.enabled = true});
  factory _DanmakuConfig.fromJson(Map<String, dynamic> json) => _$DanmakuConfigFromJson(json);

/// 弹幕数据 URL（XML 或 JSON 格式）。
@override final  String? url;
/// 原始弹幕数据（如果嵌入）。
@override final  String? rawData;
/// 是否启用弹幕。
@override@JsonKey() final  bool enabled;

/// Create a copy of DanmakuConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DanmakuConfigCopyWith<_DanmakuConfig> get copyWith => __$DanmakuConfigCopyWithImpl<_DanmakuConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DanmakuConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DanmakuConfig&&(identical(other.url, url) || other.url == url)&&(identical(other.rawData, rawData) || other.rawData == rawData)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,rawData,enabled);

@override
String toString() {
  return 'DanmakuConfig(url: $url, rawData: $rawData, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$DanmakuConfigCopyWith<$Res> implements $DanmakuConfigCopyWith<$Res> {
  factory _$DanmakuConfigCopyWith(_DanmakuConfig value, $Res Function(_DanmakuConfig) _then) = __$DanmakuConfigCopyWithImpl;
@override @useResult
$Res call({
 String? url, String? rawData, bool enabled
});




}
/// @nodoc
class __$DanmakuConfigCopyWithImpl<$Res>
    implements _$DanmakuConfigCopyWith<$Res> {
  __$DanmakuConfigCopyWithImpl(this._self, this._then);

  final _DanmakuConfig _self;
  final $Res Function(_DanmakuConfig) _then;

/// Create a copy of DanmakuConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = freezed,Object? rawData = freezed,Object? enabled = null,}) {
  return _then(_DanmakuConfig(
url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,rawData: freezed == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$VideoContent {

/// 唯一标识符。
 String get id;/// 视频标题。
 String get title;/// 来源信息。
 ContentSource get source;/// 封面图片 URL。
 String? get cover;/// 描述/摘要。
 String? get description;/// 作者/上传者信息。
 Author? get author;/// 标签。
 List<String>? get tags;/// 分类。
 String? get category;/// 统计信息。
 ContentStats? get stats;/// 发布日期。
 DateTime? get createdAt;/// 更新日期。
 DateTime? get updatedAt;/// 视频时长（秒）。
 int? get duration;/// 主要播放 URL。
 String? get playUrl;/// 可用的画质选项。
 List<VideoQuality>? get qualities;/// 剧集/章节列表。
 List<VideoChapter>? get chapters;/// 预览/GIF URL。
 String? get previewUrl;/// 字幕轨道。
 List<Subtitle>? get subtitles;/// 弹幕配置。
 DanmakuConfig? get danmaku;/// 视频状态。
 VideoStatus? get status;/// 是否需要 VIP 订阅。
 bool get isVip;/// 是否需要付费。
 bool get isPaid;
/// Create a copy of VideoContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoContentCopyWith<VideoContent> get copyWith => _$VideoContentCopyWithImpl<VideoContent>(this as VideoContent, _$identity);

  /// Serializes this VideoContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.source, source) || other.source == source)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl)&&const DeepCollectionEquality().equals(other.qualities, qualities)&&const DeepCollectionEquality().equals(other.chapters, chapters)&&(identical(other.previewUrl, previewUrl) || other.previewUrl == previewUrl)&&const DeepCollectionEquality().equals(other.subtitles, subtitles)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku)&&(identical(other.status, status) || other.status == status)&&(identical(other.isVip, isVip) || other.isVip == isVip)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,source,cover,description,author,const DeepCollectionEquality().hash(tags),category,stats,createdAt,updatedAt,duration,playUrl,const DeepCollectionEquality().hash(qualities),const DeepCollectionEquality().hash(chapters),previewUrl,const DeepCollectionEquality().hash(subtitles),danmaku,status,isVip,isPaid]);

@override
String toString() {
  return 'VideoContent(id: $id, title: $title, source: $source, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, duration: $duration, playUrl: $playUrl, qualities: $qualities, chapters: $chapters, previewUrl: $previewUrl, subtitles: $subtitles, danmaku: $danmaku, status: $status, isVip: $isVip, isPaid: $isPaid)';
}


}

/// @nodoc
abstract mixin class $VideoContentCopyWith<$Res>  {
  factory $VideoContentCopyWith(VideoContent value, $Res Function(VideoContent) _then) = _$VideoContentCopyWithImpl;
@useResult
$Res call({
 String id, String title, ContentSource source, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, int? duration, String? playUrl, List<VideoQuality>? qualities, List<VideoChapter>? chapters, String? previewUrl, List<Subtitle>? subtitles, DanmakuConfig? danmaku, VideoStatus? status, bool isVip, bool isPaid
});


$ContentSourceCopyWith<$Res> get source;$AuthorCopyWith<$Res>? get author;$ContentStatsCopyWith<$Res>? get stats;$DanmakuConfigCopyWith<$Res>? get danmaku;

}
/// @nodoc
class _$VideoContentCopyWithImpl<$Res>
    implements $VideoContentCopyWith<$Res> {
  _$VideoContentCopyWithImpl(this._self, this._then);

  final VideoContent _self;
  final $Res Function(VideoContent) _then;

/// Create a copy of VideoContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? source = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? duration = freezed,Object? playUrl = freezed,Object? qualities = freezed,Object? chapters = freezed,Object? previewUrl = freezed,Object? subtitles = freezed,Object? danmaku = freezed,Object? status = freezed,Object? isVip = null,Object? isPaid = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ContentSource,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Author?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ContentStats?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,playUrl: freezed == playUrl ? _self.playUrl : playUrl // ignore: cast_nullable_to_non_nullable
as String?,qualities: freezed == qualities ? _self.qualities : qualities // ignore: cast_nullable_to_non_nullable
as List<VideoQuality>?,chapters: freezed == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<VideoChapter>?,previewUrl: freezed == previewUrl ? _self.previewUrl : previewUrl // ignore: cast_nullable_to_non_nullable
as String?,subtitles: freezed == subtitles ? _self.subtitles : subtitles // ignore: cast_nullable_to_non_nullable
as List<Subtitle>?,danmaku: freezed == danmaku ? _self.danmaku : danmaku // ignore: cast_nullable_to_non_nullable
as DanmakuConfig?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VideoStatus?,isVip: null == isVip ? _self.isVip : isVip // ignore: cast_nullable_to_non_nullable
as bool,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of VideoContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of VideoContent
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
}/// Create a copy of VideoContent
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
}/// Create a copy of VideoContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DanmakuConfigCopyWith<$Res>? get danmaku {
    if (_self.danmaku == null) {
    return null;
  }

  return $DanmakuConfigCopyWith<$Res>(_self.danmaku!, (value) {
    return _then(_self.copyWith(danmaku: value));
  });
}
}


/// Adds pattern-matching-related methods to [VideoContent].
extension VideoContentPatterns on VideoContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoContent value)  $default,){
final _that = this;
switch (_that) {
case _VideoContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoContent value)?  $default,){
final _that = this;
switch (_that) {
case _VideoContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  ContentSource source,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  int? duration,  String? playUrl,  List<VideoQuality>? qualities,  List<VideoChapter>? chapters,  String? previewUrl,  List<Subtitle>? subtitles,  DanmakuConfig? danmaku,  VideoStatus? status,  bool isVip,  bool isPaid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoContent() when $default != null:
return $default(_that.id,_that.title,_that.source,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.duration,_that.playUrl,_that.qualities,_that.chapters,_that.previewUrl,_that.subtitles,_that.danmaku,_that.status,_that.isVip,_that.isPaid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  ContentSource source,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  int? duration,  String? playUrl,  List<VideoQuality>? qualities,  List<VideoChapter>? chapters,  String? previewUrl,  List<Subtitle>? subtitles,  DanmakuConfig? danmaku,  VideoStatus? status,  bool isVip,  bool isPaid)  $default,) {final _that = this;
switch (_that) {
case _VideoContent():
return $default(_that.id,_that.title,_that.source,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.duration,_that.playUrl,_that.qualities,_that.chapters,_that.previewUrl,_that.subtitles,_that.danmaku,_that.status,_that.isVip,_that.isPaid);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  ContentSource source,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  int? duration,  String? playUrl,  List<VideoQuality>? qualities,  List<VideoChapter>? chapters,  String? previewUrl,  List<Subtitle>? subtitles,  DanmakuConfig? danmaku,  VideoStatus? status,  bool isVip,  bool isPaid)?  $default,) {final _that = this;
switch (_that) {
case _VideoContent() when $default != null:
return $default(_that.id,_that.title,_that.source,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.duration,_that.playUrl,_that.qualities,_that.chapters,_that.previewUrl,_that.subtitles,_that.danmaku,_that.status,_that.isVip,_that.isPaid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoContent implements VideoContent {
  const _VideoContent({required this.id, required this.title, required this.source, this.cover, this.description, this.author, final  List<String>? tags, this.category, this.stats, this.createdAt, this.updatedAt, this.duration, this.playUrl, final  List<VideoQuality>? qualities, final  List<VideoChapter>? chapters, this.previewUrl, final  List<Subtitle>? subtitles, this.danmaku, this.status, this.isVip = false, this.isPaid = false}): _tags = tags,_qualities = qualities,_chapters = chapters,_subtitles = subtitles;
  factory _VideoContent.fromJson(Map<String, dynamic> json) => _$VideoContentFromJson(json);

/// 唯一标识符。
@override final  String id;
/// 视频标题。
@override final  String title;
/// 来源信息。
@override final  ContentSource source;
/// 封面图片 URL。
@override final  String? cover;
/// 描述/摘要。
@override final  String? description;
/// 作者/上传者信息。
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
/// 视频时长（秒）。
@override final  int? duration;
/// 主要播放 URL。
@override final  String? playUrl;
/// 可用的画质选项。
 final  List<VideoQuality>? _qualities;
/// 可用的画质选项。
@override List<VideoQuality>? get qualities {
  final value = _qualities;
  if (value == null) return null;
  if (_qualities is EqualUnmodifiableListView) return _qualities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// 剧集/章节列表。
 final  List<VideoChapter>? _chapters;
/// 剧集/章节列表。
@override List<VideoChapter>? get chapters {
  final value = _chapters;
  if (value == null) return null;
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// 预览/GIF URL。
@override final  String? previewUrl;
/// 字幕轨道。
 final  List<Subtitle>? _subtitles;
/// 字幕轨道。
@override List<Subtitle>? get subtitles {
  final value = _subtitles;
  if (value == null) return null;
  if (_subtitles is EqualUnmodifiableListView) return _subtitles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// 弹幕配置。
@override final  DanmakuConfig? danmaku;
/// 视频状态。
@override final  VideoStatus? status;
/// 是否需要 VIP 订阅。
@override@JsonKey() final  bool isVip;
/// 是否需要付费。
@override@JsonKey() final  bool isPaid;

/// Create a copy of VideoContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoContentCopyWith<_VideoContent> get copyWith => __$VideoContentCopyWithImpl<_VideoContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.source, source) || other.source == source)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl)&&const DeepCollectionEquality().equals(other._qualities, _qualities)&&const DeepCollectionEquality().equals(other._chapters, _chapters)&&(identical(other.previewUrl, previewUrl) || other.previewUrl == previewUrl)&&const DeepCollectionEquality().equals(other._subtitles, _subtitles)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku)&&(identical(other.status, status) || other.status == status)&&(identical(other.isVip, isVip) || other.isVip == isVip)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,source,cover,description,author,const DeepCollectionEquality().hash(_tags),category,stats,createdAt,updatedAt,duration,playUrl,const DeepCollectionEquality().hash(_qualities),const DeepCollectionEquality().hash(_chapters),previewUrl,const DeepCollectionEquality().hash(_subtitles),danmaku,status,isVip,isPaid]);

@override
String toString() {
  return 'VideoContent(id: $id, title: $title, source: $source, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, duration: $duration, playUrl: $playUrl, qualities: $qualities, chapters: $chapters, previewUrl: $previewUrl, subtitles: $subtitles, danmaku: $danmaku, status: $status, isVip: $isVip, isPaid: $isPaid)';
}


}

/// @nodoc
abstract mixin class _$VideoContentCopyWith<$Res> implements $VideoContentCopyWith<$Res> {
  factory _$VideoContentCopyWith(_VideoContent value, $Res Function(_VideoContent) _then) = __$VideoContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, ContentSource source, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, int? duration, String? playUrl, List<VideoQuality>? qualities, List<VideoChapter>? chapters, String? previewUrl, List<Subtitle>? subtitles, DanmakuConfig? danmaku, VideoStatus? status, bool isVip, bool isPaid
});


@override $ContentSourceCopyWith<$Res> get source;@override $AuthorCopyWith<$Res>? get author;@override $ContentStatsCopyWith<$Res>? get stats;@override $DanmakuConfigCopyWith<$Res>? get danmaku;

}
/// @nodoc
class __$VideoContentCopyWithImpl<$Res>
    implements _$VideoContentCopyWith<$Res> {
  __$VideoContentCopyWithImpl(this._self, this._then);

  final _VideoContent _self;
  final $Res Function(_VideoContent) _then;

/// Create a copy of VideoContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? source = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? duration = freezed,Object? playUrl = freezed,Object? qualities = freezed,Object? chapters = freezed,Object? previewUrl = freezed,Object? subtitles = freezed,Object? danmaku = freezed,Object? status = freezed,Object? isVip = null,Object? isPaid = null,}) {
  return _then(_VideoContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ContentSource,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Author?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ContentStats?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,playUrl: freezed == playUrl ? _self.playUrl : playUrl // ignore: cast_nullable_to_non_nullable
as String?,qualities: freezed == qualities ? _self._qualities : qualities // ignore: cast_nullable_to_non_nullable
as List<VideoQuality>?,chapters: freezed == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<VideoChapter>?,previewUrl: freezed == previewUrl ? _self.previewUrl : previewUrl // ignore: cast_nullable_to_non_nullable
as String?,subtitles: freezed == subtitles ? _self._subtitles : subtitles // ignore: cast_nullable_to_non_nullable
as List<Subtitle>?,danmaku: freezed == danmaku ? _self.danmaku : danmaku // ignore: cast_nullable_to_non_nullable
as DanmakuConfig?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as VideoStatus?,isVip: null == isVip ? _self.isVip : isVip // ignore: cast_nullable_to_non_nullable
as bool,isPaid: null == isPaid ? _self.isPaid : isPaid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of VideoContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of VideoContent
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
}/// Create a copy of VideoContent
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
}/// Create a copy of VideoContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DanmakuConfigCopyWith<$Res>? get danmaku {
    if (_self.danmaku == null) {
    return null;
  }

  return $DanmakuConfigCopyWith<$Res>(_self.danmaku!, (value) {
    return _then(_self.copyWith(danmaku: value));
  });
}
}

// dart format on
