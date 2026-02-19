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

/// Quality label (e.g., "1080p", "720p", "480p").
 String get label;/// Video stream URL.
 String get url;/// Video codec (e.g., "h264", "h265", "vp9").
 String? get codec;/// Bitrate in kbps.
 int? get bitrate;/// Resolution width.
 int? get width;/// Resolution height.
 int? get height;/// File size in bytes.
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

/// Quality label (e.g., "1080p", "720p", "480p").
@override final  String label;
/// Video stream URL.
@override final  String url;
/// Video codec (e.g., "h264", "h265", "vp9").
@override final  String? codec;
/// Bitrate in kbps.
@override final  int? bitrate;
/// Resolution width.
@override final  int? width;
/// Resolution height.
@override final  int? height;
/// File size in bytes.
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

/// Chapter ID.
 String get id;/// Chapter title.
 String get title;/// Chapter URL (if separate page).
 String? get url;/// Duration in seconds.
 int? get duration;/// Chapter index/number.
 int get index;
/// Create a copy of VideoChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoChapterCopyWith<VideoChapter> get copyWith => _$VideoChapterCopyWithImpl<VideoChapter>(this as VideoChapter, _$identity);

  /// Serializes this VideoChapter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.index, index) || other.index == index));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,url,duration,index);

@override
String toString() {
  return 'VideoChapter(id: $id, title: $title, url: $url, duration: $duration, index: $index)';
}


}

/// @nodoc
abstract mixin class $VideoChapterCopyWith<$Res>  {
  factory $VideoChapterCopyWith(VideoChapter value, $Res Function(VideoChapter) _then) = _$VideoChapterCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? url, int? duration, int index
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? url = freezed,Object? duration = freezed,Object? index = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? url,  int? duration,  int index)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoChapter() when $default != null:
return $default(_that.id,_that.title,_that.url,_that.duration,_that.index);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? url,  int? duration,  int index)  $default,) {final _that = this;
switch (_that) {
case _VideoChapter():
return $default(_that.id,_that.title,_that.url,_that.duration,_that.index);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? url,  int? duration,  int index)?  $default,) {final _that = this;
switch (_that) {
case _VideoChapter() when $default != null:
return $default(_that.id,_that.title,_that.url,_that.duration,_that.index);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoChapter implements VideoChapter {
  const _VideoChapter({required this.id, required this.title, this.url, this.duration, required this.index});
  factory _VideoChapter.fromJson(Map<String, dynamic> json) => _$VideoChapterFromJson(json);

/// Chapter ID.
@override final  String id;
/// Chapter title.
@override final  String title;
/// Chapter URL (if separate page).
@override final  String? url;
/// Duration in seconds.
@override final  int? duration;
/// Chapter index/number.
@override final  int index;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoChapter&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.index, index) || other.index == index));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,url,duration,index);

@override
String toString() {
  return 'VideoChapter(id: $id, title: $title, url: $url, duration: $duration, index: $index)';
}


}

/// @nodoc
abstract mixin class _$VideoChapterCopyWith<$Res> implements $VideoChapterCopyWith<$Res> {
  factory _$VideoChapterCopyWith(_VideoChapter value, $Res Function(_VideoChapter) _then) = __$VideoChapterCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? url, int? duration, int index
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? url = freezed,Object? duration = freezed,Object? index = null,}) {
  return _then(_VideoChapter(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Subtitle {

/// Language code (e.g., "en", "zh", "ja").
 String get language;/// Language display name.
 String? get label;/// Subtitle URL (VTT, SRT, ASS format).
 String get url;/// Whether this is the default subtitle.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Subtitle&&(identical(other.language, language) || other.language == language)&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,label,url,isDefault);

@override
String toString() {
  return 'Subtitle(language: $language, label: $label, url: $url, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $SubtitleCopyWith<$Res>  {
  factory $SubtitleCopyWith(Subtitle value, $Res Function(Subtitle) _then) = _$SubtitleCopyWithImpl;
@useResult
$Res call({
 String language, String? label, String url, bool isDefault
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
@pragma('vm:prefer-inline') @override $Res call({Object? language = null,Object? label = freezed,Object? url = null,Object? isDefault = null,}) {
  return _then(_self.copyWith(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String language,  String? label,  String url,  bool isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Subtitle() when $default != null:
return $default(_that.language,_that.label,_that.url,_that.isDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String language,  String? label,  String url,  bool isDefault)  $default,) {final _that = this;
switch (_that) {
case _Subtitle():
return $default(_that.language,_that.label,_that.url,_that.isDefault);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String language,  String? label,  String url,  bool isDefault)?  $default,) {final _that = this;
switch (_that) {
case _Subtitle() when $default != null:
return $default(_that.language,_that.label,_that.url,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Subtitle implements Subtitle {
  const _Subtitle({required this.language, this.label, required this.url, this.isDefault = false});
  factory _Subtitle.fromJson(Map<String, dynamic> json) => _$SubtitleFromJson(json);

/// Language code (e.g., "en", "zh", "ja").
@override final  String language;
/// Language display name.
@override final  String? label;
/// Subtitle URL (VTT, SRT, ASS format).
@override final  String url;
/// Whether this is the default subtitle.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Subtitle&&(identical(other.language, language) || other.language == language)&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,language,label,url,isDefault);

@override
String toString() {
  return 'Subtitle(language: $language, label: $label, url: $url, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$SubtitleCopyWith<$Res> implements $SubtitleCopyWith<$Res> {
  factory _$SubtitleCopyWith(_Subtitle value, $Res Function(_Subtitle) _then) = __$SubtitleCopyWithImpl;
@override @useResult
$Res call({
 String language, String? label, String url, bool isDefault
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
@override @pragma('vm:prefer-inline') $Res call({Object? language = null,Object? label = freezed,Object? url = null,Object? isDefault = null,}) {
  return _then(_Subtitle(
language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DanmakuConfig {

/// Danmaku data URL (XML or JSON format).
 String? get url;/// Raw danmaku data (if embedded).
 String? get rawData;/// Whether danmaku is enabled.
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

/// Danmaku data URL (XML or JSON format).
@override final  String? url;
/// Raw danmaku data (if embedded).
@override final  String? rawData;
/// Whether danmaku is enabled.
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

/// Unique identifier.
 String get id;/// Video title.
 String get title;/// Cover image URL.
 String? get cover;/// Description/summary.
 String? get description;/// Author/uploader information.
 Author? get author;/// Tags.
 List<String>? get tags;/// Category.
 String? get category;/// Statistics.
 ContentStats? get stats;/// Publish date.
 DateTime? get createdAt;/// Update date.
 DateTime? get updatedAt;/// Source information.
 ContentSource get source;/// Video duration in seconds.
 int? get duration;/// Primary playback URL.
 String? get playUrl;/// Available quality options.
 List<VideoQuality>? get qualities;/// Episode/chapter list.
 List<VideoChapter>? get chapters;/// Preview/GIF URL.
 String? get previewUrl;/// Subtitle tracks.
 List<Subtitle>? get subtitles;/// Danmaku configuration.
 DanmakuConfig? get danmaku;/// Video status.
 VideoStatus? get status;/// Whether VIP subscription is required.
 bool get isVip;/// Whether payment is required.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.source, source) || other.source == source)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl)&&const DeepCollectionEquality().equals(other.qualities, qualities)&&const DeepCollectionEquality().equals(other.chapters, chapters)&&(identical(other.previewUrl, previewUrl) || other.previewUrl == previewUrl)&&const DeepCollectionEquality().equals(other.subtitles, subtitles)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku)&&(identical(other.status, status) || other.status == status)&&(identical(other.isVip, isVip) || other.isVip == isVip)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,cover,description,author,const DeepCollectionEquality().hash(tags),category,stats,createdAt,updatedAt,source,duration,playUrl,const DeepCollectionEquality().hash(qualities),const DeepCollectionEquality().hash(chapters),previewUrl,const DeepCollectionEquality().hash(subtitles),danmaku,status,isVip,isPaid]);

@override
String toString() {
  return 'VideoContent(id: $id, title: $title, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, source: $source, duration: $duration, playUrl: $playUrl, qualities: $qualities, chapters: $chapters, previewUrl: $previewUrl, subtitles: $subtitles, danmaku: $danmaku, status: $status, isVip: $isVip, isPaid: $isPaid)';
}


}

/// @nodoc
abstract mixin class $VideoContentCopyWith<$Res>  {
  factory $VideoContentCopyWith(VideoContent value, $Res Function(VideoContent) _then) = _$VideoContentCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, ContentSource source, int? duration, String? playUrl, List<VideoQuality>? qualities, List<VideoChapter>? chapters, String? previewUrl, List<Subtitle>? subtitles, DanmakuConfig? danmaku, VideoStatus? status, bool isVip, bool isPaid
});


$AuthorCopyWith<$Res>? get author;$ContentStatsCopyWith<$Res>? get stats;$ContentSourceCopyWith<$Res> get source;$DanmakuConfigCopyWith<$Res>? get danmaku;

}
/// @nodoc
class _$VideoContentCopyWithImpl<$Res>
    implements $VideoContentCopyWith<$Res> {
  _$VideoContentCopyWithImpl(this._self, this._then);

  final VideoContent _self;
  final $Res Function(VideoContent) _then;

/// Create a copy of VideoContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? source = null,Object? duration = freezed,Object? playUrl = freezed,Object? qualities = freezed,Object? chapters = freezed,Object? previewUrl = freezed,Object? subtitles = freezed,Object? danmaku = freezed,Object? status = freezed,Object? isVip = null,Object? isPaid = null,}) {
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
as ContentSource,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
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
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source,  int? duration,  String? playUrl,  List<VideoQuality>? qualities,  List<VideoChapter>? chapters,  String? previewUrl,  List<Subtitle>? subtitles,  DanmakuConfig? danmaku,  VideoStatus? status,  bool isVip,  bool isPaid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoContent() when $default != null:
return $default(_that.id,_that.title,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source,_that.duration,_that.playUrl,_that.qualities,_that.chapters,_that.previewUrl,_that.subtitles,_that.danmaku,_that.status,_that.isVip,_that.isPaid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source,  int? duration,  String? playUrl,  List<VideoQuality>? qualities,  List<VideoChapter>? chapters,  String? previewUrl,  List<Subtitle>? subtitles,  DanmakuConfig? danmaku,  VideoStatus? status,  bool isVip,  bool isPaid)  $default,) {final _that = this;
switch (_that) {
case _VideoContent():
return $default(_that.id,_that.title,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source,_that.duration,_that.playUrl,_that.qualities,_that.chapters,_that.previewUrl,_that.subtitles,_that.danmaku,_that.status,_that.isVip,_that.isPaid);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source,  int? duration,  String? playUrl,  List<VideoQuality>? qualities,  List<VideoChapter>? chapters,  String? previewUrl,  List<Subtitle>? subtitles,  DanmakuConfig? danmaku,  VideoStatus? status,  bool isVip,  bool isPaid)?  $default,) {final _that = this;
switch (_that) {
case _VideoContent() when $default != null:
return $default(_that.id,_that.title,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source,_that.duration,_that.playUrl,_that.qualities,_that.chapters,_that.previewUrl,_that.subtitles,_that.danmaku,_that.status,_that.isVip,_that.isPaid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoContent implements VideoContent {
  const _VideoContent({required this.id, required this.title, this.cover, this.description, this.author, final  List<String>? tags, this.category, this.stats, this.createdAt, this.updatedAt, required this.source, this.duration, this.playUrl, final  List<VideoQuality>? qualities, final  List<VideoChapter>? chapters, this.previewUrl, final  List<Subtitle>? subtitles, this.danmaku, this.status, this.isVip = false, this.isPaid = false}): _tags = tags,_qualities = qualities,_chapters = chapters,_subtitles = subtitles;
  factory _VideoContent.fromJson(Map<String, dynamic> json) => _$VideoContentFromJson(json);

/// Unique identifier.
@override final  String id;
/// Video title.
@override final  String title;
/// Cover image URL.
@override final  String? cover;
/// Description/summary.
@override final  String? description;
/// Author/uploader information.
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
/// Video duration in seconds.
@override final  int? duration;
/// Primary playback URL.
@override final  String? playUrl;
/// Available quality options.
 final  List<VideoQuality>? _qualities;
/// Available quality options.
@override List<VideoQuality>? get qualities {
  final value = _qualities;
  if (value == null) return null;
  if (_qualities is EqualUnmodifiableListView) return _qualities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Episode/chapter list.
 final  List<VideoChapter>? _chapters;
/// Episode/chapter list.
@override List<VideoChapter>? get chapters {
  final value = _chapters;
  if (value == null) return null;
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Preview/GIF URL.
@override final  String? previewUrl;
/// Subtitle tracks.
 final  List<Subtitle>? _subtitles;
/// Subtitle tracks.
@override List<Subtitle>? get subtitles {
  final value = _subtitles;
  if (value == null) return null;
  if (_subtitles is EqualUnmodifiableListView) return _subtitles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Danmaku configuration.
@override final  DanmakuConfig? danmaku;
/// Video status.
@override final  VideoStatus? status;
/// Whether VIP subscription is required.
@override@JsonKey() final  bool isVip;
/// Whether payment is required.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.source, source) || other.source == source)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.playUrl, playUrl) || other.playUrl == playUrl)&&const DeepCollectionEquality().equals(other._qualities, _qualities)&&const DeepCollectionEquality().equals(other._chapters, _chapters)&&(identical(other.previewUrl, previewUrl) || other.previewUrl == previewUrl)&&const DeepCollectionEquality().equals(other._subtitles, _subtitles)&&(identical(other.danmaku, danmaku) || other.danmaku == danmaku)&&(identical(other.status, status) || other.status == status)&&(identical(other.isVip, isVip) || other.isVip == isVip)&&(identical(other.isPaid, isPaid) || other.isPaid == isPaid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,cover,description,author,const DeepCollectionEquality().hash(_tags),category,stats,createdAt,updatedAt,source,duration,playUrl,const DeepCollectionEquality().hash(_qualities),const DeepCollectionEquality().hash(_chapters),previewUrl,const DeepCollectionEquality().hash(_subtitles),danmaku,status,isVip,isPaid]);

@override
String toString() {
  return 'VideoContent(id: $id, title: $title, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, source: $source, duration: $duration, playUrl: $playUrl, qualities: $qualities, chapters: $chapters, previewUrl: $previewUrl, subtitles: $subtitles, danmaku: $danmaku, status: $status, isVip: $isVip, isPaid: $isPaid)';
}


}

/// @nodoc
abstract mixin class _$VideoContentCopyWith<$Res> implements $VideoContentCopyWith<$Res> {
  factory _$VideoContentCopyWith(_VideoContent value, $Res Function(_VideoContent) _then) = __$VideoContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, ContentSource source, int? duration, String? playUrl, List<VideoQuality>? qualities, List<VideoChapter>? chapters, String? previewUrl, List<Subtitle>? subtitles, DanmakuConfig? danmaku, VideoStatus? status, bool isVip, bool isPaid
});


@override $AuthorCopyWith<$Res>? get author;@override $ContentStatsCopyWith<$Res>? get stats;@override $ContentSourceCopyWith<$Res> get source;@override $DanmakuConfigCopyWith<$Res>? get danmaku;

}
/// @nodoc
class __$VideoContentCopyWithImpl<$Res>
    implements _$VideoContentCopyWith<$Res> {
  __$VideoContentCopyWithImpl(this._self, this._then);

  final _VideoContent _self;
  final $Res Function(_VideoContent) _then;

/// Create a copy of VideoContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? source = null,Object? duration = freezed,Object? playUrl = freezed,Object? qualities = freezed,Object? chapters = freezed,Object? previewUrl = freezed,Object? subtitles = freezed,Object? danmaku = freezed,Object? status = freezed,Object? isVip = null,Object? isPaid = null,}) {
  return _then(_VideoContent(
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
as ContentSource,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
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
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
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
