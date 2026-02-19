// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'music_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AudioQuality {

/// Quality label (e.g., "320kbps", "128kbps", "FLAC").
 String get label;/// Audio stream URL.
 String get url;/// Audio codec (e.g., "mp3", "aac", "flac").
 String? get codec;/// Bitrate in kbps.
 int? get bitrate;/// Sample rate in Hz.
 int? get sampleRate;/// File size in bytes.
 int? get fileSize;
/// Create a copy of AudioQuality
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioQualityCopyWith<AudioQuality> get copyWith => _$AudioQualityCopyWithImpl<AudioQuality>(this as AudioQuality, _$identity);

  /// Serializes this AudioQuality to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioQuality&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url)&&(identical(other.codec, codec) || other.codec == codec)&&(identical(other.bitrate, bitrate) || other.bitrate == bitrate)&&(identical(other.sampleRate, sampleRate) || other.sampleRate == sampleRate)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,url,codec,bitrate,sampleRate,fileSize);

@override
String toString() {
  return 'AudioQuality(label: $label, url: $url, codec: $codec, bitrate: $bitrate, sampleRate: $sampleRate, fileSize: $fileSize)';
}


}

/// @nodoc
abstract mixin class $AudioQualityCopyWith<$Res>  {
  factory $AudioQualityCopyWith(AudioQuality value, $Res Function(AudioQuality) _then) = _$AudioQualityCopyWithImpl;
@useResult
$Res call({
 String label, String url, String? codec, int? bitrate, int? sampleRate, int? fileSize
});




}
/// @nodoc
class _$AudioQualityCopyWithImpl<$Res>
    implements $AudioQualityCopyWith<$Res> {
  _$AudioQualityCopyWithImpl(this._self, this._then);

  final AudioQuality _self;
  final $Res Function(AudioQuality) _then;

/// Create a copy of AudioQuality
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? url = null,Object? codec = freezed,Object? bitrate = freezed,Object? sampleRate = freezed,Object? fileSize = freezed,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,codec: freezed == codec ? _self.codec : codec // ignore: cast_nullable_to_non_nullable
as String?,bitrate: freezed == bitrate ? _self.bitrate : bitrate // ignore: cast_nullable_to_non_nullable
as int?,sampleRate: freezed == sampleRate ? _self.sampleRate : sampleRate // ignore: cast_nullable_to_non_nullable
as int?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioQuality].
extension AudioQualityPatterns on AudioQuality {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AudioQuality value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AudioQuality() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AudioQuality value)  $default,){
final _that = this;
switch (_that) {
case _AudioQuality():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AudioQuality value)?  $default,){
final _that = this;
switch (_that) {
case _AudioQuality() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String url,  String? codec,  int? bitrate,  int? sampleRate,  int? fileSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AudioQuality() when $default != null:
return $default(_that.label,_that.url,_that.codec,_that.bitrate,_that.sampleRate,_that.fileSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String url,  String? codec,  int? bitrate,  int? sampleRate,  int? fileSize)  $default,) {final _that = this;
switch (_that) {
case _AudioQuality():
return $default(_that.label,_that.url,_that.codec,_that.bitrate,_that.sampleRate,_that.fileSize);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String url,  String? codec,  int? bitrate,  int? sampleRate,  int? fileSize)?  $default,) {final _that = this;
switch (_that) {
case _AudioQuality() when $default != null:
return $default(_that.label,_that.url,_that.codec,_that.bitrate,_that.sampleRate,_that.fileSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AudioQuality implements AudioQuality {
  const _AudioQuality({required this.label, required this.url, this.codec, this.bitrate, this.sampleRate, this.fileSize});
  factory _AudioQuality.fromJson(Map<String, dynamic> json) => _$AudioQualityFromJson(json);

/// Quality label (e.g., "320kbps", "128kbps", "FLAC").
@override final  String label;
/// Audio stream URL.
@override final  String url;
/// Audio codec (e.g., "mp3", "aac", "flac").
@override final  String? codec;
/// Bitrate in kbps.
@override final  int? bitrate;
/// Sample rate in Hz.
@override final  int? sampleRate;
/// File size in bytes.
@override final  int? fileSize;

/// Create a copy of AudioQuality
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioQualityCopyWith<_AudioQuality> get copyWith => __$AudioQualityCopyWithImpl<_AudioQuality>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AudioQualityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioQuality&&(identical(other.label, label) || other.label == label)&&(identical(other.url, url) || other.url == url)&&(identical(other.codec, codec) || other.codec == codec)&&(identical(other.bitrate, bitrate) || other.bitrate == bitrate)&&(identical(other.sampleRate, sampleRate) || other.sampleRate == sampleRate)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,url,codec,bitrate,sampleRate,fileSize);

@override
String toString() {
  return 'AudioQuality(label: $label, url: $url, codec: $codec, bitrate: $bitrate, sampleRate: $sampleRate, fileSize: $fileSize)';
}


}

/// @nodoc
abstract mixin class _$AudioQualityCopyWith<$Res> implements $AudioQualityCopyWith<$Res> {
  factory _$AudioQualityCopyWith(_AudioQuality value, $Res Function(_AudioQuality) _then) = __$AudioQualityCopyWithImpl;
@override @useResult
$Res call({
 String label, String url, String? codec, int? bitrate, int? sampleRate, int? fileSize
});




}
/// @nodoc
class __$AudioQualityCopyWithImpl<$Res>
    implements _$AudioQualityCopyWith<$Res> {
  __$AudioQualityCopyWithImpl(this._self, this._then);

  final _AudioQuality _self;
  final $Res Function(_AudioQuality) _then;

/// Create a copy of AudioQuality
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? url = null,Object? codec = freezed,Object? bitrate = freezed,Object? sampleRate = freezed,Object? fileSize = freezed,}) {
  return _then(_AudioQuality(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,codec: freezed == codec ? _self.codec : codec // ignore: cast_nullable_to_non_nullable
as String?,bitrate: freezed == bitrate ? _self.bitrate : bitrate // ignore: cast_nullable_to_non_nullable
as int?,sampleRate: freezed == sampleRate ? _self.sampleRate : sampleRate // ignore: cast_nullable_to_non_nullable
as int?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$Lyrics {

/// Plain text lyrics.
 String? get text;/// LRC format lyrics with timestamps.
 String? get lrc;/// Language code.
 String? get language;
/// Create a copy of Lyrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LyricsCopyWith<Lyrics> get copyWith => _$LyricsCopyWithImpl<Lyrics>(this as Lyrics, _$identity);

  /// Serializes this Lyrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lyrics&&(identical(other.text, text) || other.text == text)&&(identical(other.lrc, lrc) || other.lrc == lrc)&&(identical(other.language, language) || other.language == language));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,lrc,language);

@override
String toString() {
  return 'Lyrics(text: $text, lrc: $lrc, language: $language)';
}


}

/// @nodoc
abstract mixin class $LyricsCopyWith<$Res>  {
  factory $LyricsCopyWith(Lyrics value, $Res Function(Lyrics) _then) = _$LyricsCopyWithImpl;
@useResult
$Res call({
 String? text, String? lrc, String? language
});




}
/// @nodoc
class _$LyricsCopyWithImpl<$Res>
    implements $LyricsCopyWith<$Res> {
  _$LyricsCopyWithImpl(this._self, this._then);

  final Lyrics _self;
  final $Res Function(Lyrics) _then;

/// Create a copy of Lyrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = freezed,Object? lrc = freezed,Object? language = freezed,}) {
  return _then(_self.copyWith(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,lrc: freezed == lrc ? _self.lrc : lrc // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Lyrics].
extension LyricsPatterns on Lyrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Lyrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Lyrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Lyrics value)  $default,){
final _that = this;
switch (_that) {
case _Lyrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Lyrics value)?  $default,){
final _that = this;
switch (_that) {
case _Lyrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? text,  String? lrc,  String? language)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Lyrics() when $default != null:
return $default(_that.text,_that.lrc,_that.language);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? text,  String? lrc,  String? language)  $default,) {final _that = this;
switch (_that) {
case _Lyrics():
return $default(_that.text,_that.lrc,_that.language);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? text,  String? lrc,  String? language)?  $default,) {final _that = this;
switch (_that) {
case _Lyrics() when $default != null:
return $default(_that.text,_that.lrc,_that.language);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Lyrics implements Lyrics {
  const _Lyrics({this.text, this.lrc, this.language});
  factory _Lyrics.fromJson(Map<String, dynamic> json) => _$LyricsFromJson(json);

/// Plain text lyrics.
@override final  String? text;
/// LRC format lyrics with timestamps.
@override final  String? lrc;
/// Language code.
@override final  String? language;

/// Create a copy of Lyrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LyricsCopyWith<_Lyrics> get copyWith => __$LyricsCopyWithImpl<_Lyrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LyricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Lyrics&&(identical(other.text, text) || other.text == text)&&(identical(other.lrc, lrc) || other.lrc == lrc)&&(identical(other.language, language) || other.language == language));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,lrc,language);

@override
String toString() {
  return 'Lyrics(text: $text, lrc: $lrc, language: $language)';
}


}

/// @nodoc
abstract mixin class _$LyricsCopyWith<$Res> implements $LyricsCopyWith<$Res> {
  factory _$LyricsCopyWith(_Lyrics value, $Res Function(_Lyrics) _then) = __$LyricsCopyWithImpl;
@override @useResult
$Res call({
 String? text, String? lrc, String? language
});




}
/// @nodoc
class __$LyricsCopyWithImpl<$Res>
    implements _$LyricsCopyWith<$Res> {
  __$LyricsCopyWithImpl(this._self, this._then);

  final _Lyrics _self;
  final $Res Function(_Lyrics) _then;

/// Create a copy of Lyrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = freezed,Object? lrc = freezed,Object? language = freezed,}) {
  return _then(_Lyrics(
text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,lrc: freezed == lrc ? _self.lrc : lrc // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MusicContent {

/// Unique identifier.
 String get id;/// Track title.
 String get title;/// Cover/album art URL.
 String? get cover;/// Description.
 String? get description;/// Artist information.
 Author? get artistInfo;/// Tags.
 List<String>? get tags;/// Genre/category.
 String? get category;/// Statistics.
 ContentStats? get stats;/// Release date.
 DateTime? get createdAt;/// Update date.
 DateTime? get updatedAt;/// Source information.
 ContentSource get source;/// Primary audio playback URL.
 String? get audioUrl;/// Duration in seconds.
 int? get duration;/// Artist name(s) - can be comma-separated or array.
 String? get artist;/// Album name.
 String? get album;/// Album cover URL (if different from cover).
 String? get albumCover;/// Available quality options.
 List<AudioQuality>? get qualities;/// Lyrics.
 Lyrics? get lyrics;/// Music video URL.
 String? get mvUrl;/// Copyright information.
 String? get copyright;
/// Create a copy of MusicContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MusicContentCopyWith<MusicContent> get copyWith => _$MusicContentCopyWithImpl<MusicContent>(this as MusicContent, _$identity);

  /// Serializes this MusicContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MusicContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.artistInfo, artistInfo) || other.artistInfo == artistInfo)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.source, source) || other.source == source)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.album, album) || other.album == album)&&(identical(other.albumCover, albumCover) || other.albumCover == albumCover)&&const DeepCollectionEquality().equals(other.qualities, qualities)&&(identical(other.lyrics, lyrics) || other.lyrics == lyrics)&&(identical(other.mvUrl, mvUrl) || other.mvUrl == mvUrl)&&(identical(other.copyright, copyright) || other.copyright == copyright));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,cover,description,artistInfo,const DeepCollectionEquality().hash(tags),category,stats,createdAt,updatedAt,source,audioUrl,duration,artist,album,albumCover,const DeepCollectionEquality().hash(qualities),lyrics,mvUrl,copyright]);

@override
String toString() {
  return 'MusicContent(id: $id, title: $title, cover: $cover, description: $description, artistInfo: $artistInfo, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, source: $source, audioUrl: $audioUrl, duration: $duration, artist: $artist, album: $album, albumCover: $albumCover, qualities: $qualities, lyrics: $lyrics, mvUrl: $mvUrl, copyright: $copyright)';
}


}

/// @nodoc
abstract mixin class $MusicContentCopyWith<$Res>  {
  factory $MusicContentCopyWith(MusicContent value, $Res Function(MusicContent) _then) = _$MusicContentCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? cover, String? description, Author? artistInfo, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, ContentSource source, String? audioUrl, int? duration, String? artist, String? album, String? albumCover, List<AudioQuality>? qualities, Lyrics? lyrics, String? mvUrl, String? copyright
});


$AuthorCopyWith<$Res>? get artistInfo;$ContentStatsCopyWith<$Res>? get stats;$ContentSourceCopyWith<$Res> get source;$LyricsCopyWith<$Res>? get lyrics;

}
/// @nodoc
class _$MusicContentCopyWithImpl<$Res>
    implements $MusicContentCopyWith<$Res> {
  _$MusicContentCopyWithImpl(this._self, this._then);

  final MusicContent _self;
  final $Res Function(MusicContent) _then;

/// Create a copy of MusicContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? cover = freezed,Object? description = freezed,Object? artistInfo = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? source = null,Object? audioUrl = freezed,Object? duration = freezed,Object? artist = freezed,Object? album = freezed,Object? albumCover = freezed,Object? qualities = freezed,Object? lyrics = freezed,Object? mvUrl = freezed,Object? copyright = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,artistInfo: freezed == artistInfo ? _self.artistInfo : artistInfo // ignore: cast_nullable_to_non_nullable
as Author?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ContentStats?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ContentSource,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,artist: freezed == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String?,album: freezed == album ? _self.album : album // ignore: cast_nullable_to_non_nullable
as String?,albumCover: freezed == albumCover ? _self.albumCover : albumCover // ignore: cast_nullable_to_non_nullable
as String?,qualities: freezed == qualities ? _self.qualities : qualities // ignore: cast_nullable_to_non_nullable
as List<AudioQuality>?,lyrics: freezed == lyrics ? _self.lyrics : lyrics // ignore: cast_nullable_to_non_nullable
as Lyrics?,mvUrl: freezed == mvUrl ? _self.mvUrl : mvUrl // ignore: cast_nullable_to_non_nullable
as String?,copyright: freezed == copyright ? _self.copyright : copyright // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of MusicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthorCopyWith<$Res>? get artistInfo {
    if (_self.artistInfo == null) {
    return null;
  }

  return $AuthorCopyWith<$Res>(_self.artistInfo!, (value) {
    return _then(_self.copyWith(artistInfo: value));
  });
}/// Create a copy of MusicContent
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
}/// Create a copy of MusicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of MusicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LyricsCopyWith<$Res>? get lyrics {
    if (_self.lyrics == null) {
    return null;
  }

  return $LyricsCopyWith<$Res>(_self.lyrics!, (value) {
    return _then(_self.copyWith(lyrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [MusicContent].
extension MusicContentPatterns on MusicContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MusicContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MusicContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MusicContent value)  $default,){
final _that = this;
switch (_that) {
case _MusicContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MusicContent value)?  $default,){
final _that = this;
switch (_that) {
case _MusicContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? cover,  String? description,  Author? artistInfo,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source,  String? audioUrl,  int? duration,  String? artist,  String? album,  String? albumCover,  List<AudioQuality>? qualities,  Lyrics? lyrics,  String? mvUrl,  String? copyright)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MusicContent() when $default != null:
return $default(_that.id,_that.title,_that.cover,_that.description,_that.artistInfo,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source,_that.audioUrl,_that.duration,_that.artist,_that.album,_that.albumCover,_that.qualities,_that.lyrics,_that.mvUrl,_that.copyright);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? cover,  String? description,  Author? artistInfo,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source,  String? audioUrl,  int? duration,  String? artist,  String? album,  String? albumCover,  List<AudioQuality>? qualities,  Lyrics? lyrics,  String? mvUrl,  String? copyright)  $default,) {final _that = this;
switch (_that) {
case _MusicContent():
return $default(_that.id,_that.title,_that.cover,_that.description,_that.artistInfo,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source,_that.audioUrl,_that.duration,_that.artist,_that.album,_that.albumCover,_that.qualities,_that.lyrics,_that.mvUrl,_that.copyright);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? cover,  String? description,  Author? artistInfo,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source,  String? audioUrl,  int? duration,  String? artist,  String? album,  String? albumCover,  List<AudioQuality>? qualities,  Lyrics? lyrics,  String? mvUrl,  String? copyright)?  $default,) {final _that = this;
switch (_that) {
case _MusicContent() when $default != null:
return $default(_that.id,_that.title,_that.cover,_that.description,_that.artistInfo,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source,_that.audioUrl,_that.duration,_that.artist,_that.album,_that.albumCover,_that.qualities,_that.lyrics,_that.mvUrl,_that.copyright);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MusicContent implements MusicContent {
  const _MusicContent({required this.id, required this.title, this.cover, this.description, this.artistInfo, final  List<String>? tags, this.category, this.stats, this.createdAt, this.updatedAt, required this.source, this.audioUrl, this.duration, this.artist, this.album, this.albumCover, final  List<AudioQuality>? qualities, this.lyrics, this.mvUrl, this.copyright}): _tags = tags,_qualities = qualities;
  factory _MusicContent.fromJson(Map<String, dynamic> json) => _$MusicContentFromJson(json);

/// Unique identifier.
@override final  String id;
/// Track title.
@override final  String title;
/// Cover/album art URL.
@override final  String? cover;
/// Description.
@override final  String? description;
/// Artist information.
@override final  Author? artistInfo;
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

/// Genre/category.
@override final  String? category;
/// Statistics.
@override final  ContentStats? stats;
/// Release date.
@override final  DateTime? createdAt;
/// Update date.
@override final  DateTime? updatedAt;
/// Source information.
@override final  ContentSource source;
/// Primary audio playback URL.
@override final  String? audioUrl;
/// Duration in seconds.
@override final  int? duration;
/// Artist name(s) - can be comma-separated or array.
@override final  String? artist;
/// Album name.
@override final  String? album;
/// Album cover URL (if different from cover).
@override final  String? albumCover;
/// Available quality options.
 final  List<AudioQuality>? _qualities;
/// Available quality options.
@override List<AudioQuality>? get qualities {
  final value = _qualities;
  if (value == null) return null;
  if (_qualities is EqualUnmodifiableListView) return _qualities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Lyrics.
@override final  Lyrics? lyrics;
/// Music video URL.
@override final  String? mvUrl;
/// Copyright information.
@override final  String? copyright;

/// Create a copy of MusicContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MusicContentCopyWith<_MusicContent> get copyWith => __$MusicContentCopyWithImpl<_MusicContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MusicContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MusicContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.artistInfo, artistInfo) || other.artistInfo == artistInfo)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.source, source) || other.source == source)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.album, album) || other.album == album)&&(identical(other.albumCover, albumCover) || other.albumCover == albumCover)&&const DeepCollectionEquality().equals(other._qualities, _qualities)&&(identical(other.lyrics, lyrics) || other.lyrics == lyrics)&&(identical(other.mvUrl, mvUrl) || other.mvUrl == mvUrl)&&(identical(other.copyright, copyright) || other.copyright == copyright));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,cover,description,artistInfo,const DeepCollectionEquality().hash(_tags),category,stats,createdAt,updatedAt,source,audioUrl,duration,artist,album,albumCover,const DeepCollectionEquality().hash(_qualities),lyrics,mvUrl,copyright]);

@override
String toString() {
  return 'MusicContent(id: $id, title: $title, cover: $cover, description: $description, artistInfo: $artistInfo, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, source: $source, audioUrl: $audioUrl, duration: $duration, artist: $artist, album: $album, albumCover: $albumCover, qualities: $qualities, lyrics: $lyrics, mvUrl: $mvUrl, copyright: $copyright)';
}


}

/// @nodoc
abstract mixin class _$MusicContentCopyWith<$Res> implements $MusicContentCopyWith<$Res> {
  factory _$MusicContentCopyWith(_MusicContent value, $Res Function(_MusicContent) _then) = __$MusicContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? cover, String? description, Author? artistInfo, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, ContentSource source, String? audioUrl, int? duration, String? artist, String? album, String? albumCover, List<AudioQuality>? qualities, Lyrics? lyrics, String? mvUrl, String? copyright
});


@override $AuthorCopyWith<$Res>? get artistInfo;@override $ContentStatsCopyWith<$Res>? get stats;@override $ContentSourceCopyWith<$Res> get source;@override $LyricsCopyWith<$Res>? get lyrics;

}
/// @nodoc
class __$MusicContentCopyWithImpl<$Res>
    implements _$MusicContentCopyWith<$Res> {
  __$MusicContentCopyWithImpl(this._self, this._then);

  final _MusicContent _self;
  final $Res Function(_MusicContent) _then;

/// Create a copy of MusicContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? cover = freezed,Object? description = freezed,Object? artistInfo = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? source = null,Object? audioUrl = freezed,Object? duration = freezed,Object? artist = freezed,Object? album = freezed,Object? albumCover = freezed,Object? qualities = freezed,Object? lyrics = freezed,Object? mvUrl = freezed,Object? copyright = freezed,}) {
  return _then(_MusicContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,cover: freezed == cover ? _self.cover : cover // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,artistInfo: freezed == artistInfo ? _self.artistInfo : artistInfo // ignore: cast_nullable_to_non_nullable
as Author?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,stats: freezed == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as ContentStats?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ContentSource,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,artist: freezed == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String?,album: freezed == album ? _self.album : album // ignore: cast_nullable_to_non_nullable
as String?,albumCover: freezed == albumCover ? _self.albumCover : albumCover // ignore: cast_nullable_to_non_nullable
as String?,qualities: freezed == qualities ? _self._qualities : qualities // ignore: cast_nullable_to_non_nullable
as List<AudioQuality>?,lyrics: freezed == lyrics ? _self.lyrics : lyrics // ignore: cast_nullable_to_non_nullable
as Lyrics?,mvUrl: freezed == mvUrl ? _self.mvUrl : mvUrl // ignore: cast_nullable_to_non_nullable
as String?,copyright: freezed == copyright ? _self.copyright : copyright // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of MusicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthorCopyWith<$Res>? get artistInfo {
    if (_self.artistInfo == null) {
    return null;
  }

  return $AuthorCopyWith<$Res>(_self.artistInfo!, (value) {
    return _then(_self.copyWith(artistInfo: value));
  });
}/// Create a copy of MusicContent
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
}/// Create a copy of MusicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}/// Create a copy of MusicContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LyricsCopyWith<$Res>? get lyrics {
    if (_self.lyrics == null) {
    return null;
  }

  return $LyricsCopyWith<$Res>(_self.lyrics!, (value) {
    return _then(_self.copyWith(lyrics: value));
  });
}
}

// dart format on
