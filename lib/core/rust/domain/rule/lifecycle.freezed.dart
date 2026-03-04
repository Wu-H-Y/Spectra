// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lifecycle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentConfig {

 PipelineGraph get pipeline; bool get sniffMedia;
/// Create a copy of ContentConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentConfigCopyWith<ContentConfig> get copyWith => _$ContentConfigCopyWithImpl<ContentConfig>(this as ContentConfig, _$identity);

  /// Serializes this ContentConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentConfig&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline)&&(identical(other.sniffMedia, sniffMedia) || other.sniffMedia == sniffMedia));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pipeline,sniffMedia);

@override
String toString() {
  return 'ContentConfig(pipeline: $pipeline, sniffMedia: $sniffMedia)';
}


}

/// @nodoc
abstract mixin class $ContentConfigCopyWith<$Res>  {
  factory $ContentConfigCopyWith(ContentConfig value, $Res Function(ContentConfig) _then) = _$ContentConfigCopyWithImpl;
@useResult
$Res call({
 PipelineGraph pipeline, bool sniffMedia
});


$PipelineGraphCopyWith<$Res> get pipeline;

}
/// @nodoc
class _$ContentConfigCopyWithImpl<$Res>
    implements $ContentConfigCopyWith<$Res> {
  _$ContentConfigCopyWithImpl(this._self, this._then);

  final ContentConfig _self;
  final $Res Function(ContentConfig) _then;

/// Create a copy of ContentConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pipeline = null,Object? sniffMedia = null,}) {
  return _then(_self.copyWith(
pipeline: null == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as PipelineGraph,sniffMedia: null == sniffMedia ? _self.sniffMedia : sniffMedia // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ContentConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PipelineGraphCopyWith<$Res> get pipeline {
  
  return $PipelineGraphCopyWith<$Res>(_self.pipeline, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}
}


/// Adds pattern-matching-related methods to [ContentConfig].
extension ContentConfigPatterns on ContentConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentConfig value)  $default,){
final _that = this;
switch (_that) {
case _ContentConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ContentConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PipelineGraph pipeline,  bool sniffMedia)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentConfig() when $default != null:
return $default(_that.pipeline,_that.sniffMedia);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PipelineGraph pipeline,  bool sniffMedia)  $default,) {final _that = this;
switch (_that) {
case _ContentConfig():
return $default(_that.pipeline,_that.sniffMedia);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PipelineGraph pipeline,  bool sniffMedia)?  $default,) {final _that = this;
switch (_that) {
case _ContentConfig() when $default != null:
return $default(_that.pipeline,_that.sniffMedia);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentConfig implements ContentConfig {
  const _ContentConfig({required this.pipeline, required this.sniffMedia});
  factory _ContentConfig.fromJson(Map<String, dynamic> json) => _$ContentConfigFromJson(json);

@override final  PipelineGraph pipeline;
@override final  bool sniffMedia;

/// Create a copy of ContentConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentConfigCopyWith<_ContentConfig> get copyWith => __$ContentConfigCopyWithImpl<_ContentConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentConfig&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline)&&(identical(other.sniffMedia, sniffMedia) || other.sniffMedia == sniffMedia));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pipeline,sniffMedia);

@override
String toString() {
  return 'ContentConfig(pipeline: $pipeline, sniffMedia: $sniffMedia)';
}


}

/// @nodoc
abstract mixin class _$ContentConfigCopyWith<$Res> implements $ContentConfigCopyWith<$Res> {
  factory _$ContentConfigCopyWith(_ContentConfig value, $Res Function(_ContentConfig) _then) = __$ContentConfigCopyWithImpl;
@override @useResult
$Res call({
 PipelineGraph pipeline, bool sniffMedia
});


@override $PipelineGraphCopyWith<$Res> get pipeline;

}
/// @nodoc
class __$ContentConfigCopyWithImpl<$Res>
    implements _$ContentConfigCopyWith<$Res> {
  __$ContentConfigCopyWithImpl(this._self, this._then);

  final _ContentConfig _self;
  final $Res Function(_ContentConfig) _then;

/// Create a copy of ContentConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pipeline = null,Object? sniffMedia = null,}) {
  return _then(_ContentConfig(
pipeline: null == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as PipelineGraph,sniffMedia: null == sniffMedia ? _self.sniffMedia : sniffMedia // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ContentConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PipelineGraphCopyWith<$Res> get pipeline {
  
  return $PipelineGraphCopyWith<$Res>(_self.pipeline, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}
}


/// @nodoc
mixin _$DetailConfig {

 PipelineGraph get pipeline;
/// Create a copy of DetailConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DetailConfigCopyWith<DetailConfig> get copyWith => _$DetailConfigCopyWithImpl<DetailConfig>(this as DetailConfig, _$identity);

  /// Serializes this DetailConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DetailConfig&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pipeline);

@override
String toString() {
  return 'DetailConfig(pipeline: $pipeline)';
}


}

/// @nodoc
abstract mixin class $DetailConfigCopyWith<$Res>  {
  factory $DetailConfigCopyWith(DetailConfig value, $Res Function(DetailConfig) _then) = _$DetailConfigCopyWithImpl;
@useResult
$Res call({
 PipelineGraph pipeline
});


$PipelineGraphCopyWith<$Res> get pipeline;

}
/// @nodoc
class _$DetailConfigCopyWithImpl<$Res>
    implements $DetailConfigCopyWith<$Res> {
  _$DetailConfigCopyWithImpl(this._self, this._then);

  final DetailConfig _self;
  final $Res Function(DetailConfig) _then;

/// Create a copy of DetailConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pipeline = null,}) {
  return _then(_self.copyWith(
pipeline: null == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as PipelineGraph,
  ));
}
/// Create a copy of DetailConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PipelineGraphCopyWith<$Res> get pipeline {
  
  return $PipelineGraphCopyWith<$Res>(_self.pipeline, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}
}


/// Adds pattern-matching-related methods to [DetailConfig].
extension DetailConfigPatterns on DetailConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DetailConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DetailConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DetailConfig value)  $default,){
final _that = this;
switch (_that) {
case _DetailConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DetailConfig value)?  $default,){
final _that = this;
switch (_that) {
case _DetailConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PipelineGraph pipeline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DetailConfig() when $default != null:
return $default(_that.pipeline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PipelineGraph pipeline)  $default,) {final _that = this;
switch (_that) {
case _DetailConfig():
return $default(_that.pipeline);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PipelineGraph pipeline)?  $default,) {final _that = this;
switch (_that) {
case _DetailConfig() when $default != null:
return $default(_that.pipeline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DetailConfig implements DetailConfig {
  const _DetailConfig({required this.pipeline});
  factory _DetailConfig.fromJson(Map<String, dynamic> json) => _$DetailConfigFromJson(json);

@override final  PipelineGraph pipeline;

/// Create a copy of DetailConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DetailConfigCopyWith<_DetailConfig> get copyWith => __$DetailConfigCopyWithImpl<_DetailConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DetailConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DetailConfig&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pipeline);

@override
String toString() {
  return 'DetailConfig(pipeline: $pipeline)';
}


}

/// @nodoc
abstract mixin class _$DetailConfigCopyWith<$Res> implements $DetailConfigCopyWith<$Res> {
  factory _$DetailConfigCopyWith(_DetailConfig value, $Res Function(_DetailConfig) _then) = __$DetailConfigCopyWithImpl;
@override @useResult
$Res call({
 PipelineGraph pipeline
});


@override $PipelineGraphCopyWith<$Res> get pipeline;

}
/// @nodoc
class __$DetailConfigCopyWithImpl<$Res>
    implements _$DetailConfigCopyWith<$Res> {
  __$DetailConfigCopyWithImpl(this._self, this._then);

  final _DetailConfig _self;
  final $Res Function(_DetailConfig) _then;

/// Create a copy of DetailConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pipeline = null,}) {
  return _then(_DetailConfig(
pipeline: null == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as PipelineGraph,
  ));
}

/// Create a copy of DetailConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PipelineGraphCopyWith<$Res> get pipeline {
  
  return $PipelineGraphCopyWith<$Res>(_self.pipeline, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}
}


/// @nodoc
mixin _$ExploreConfig {

 String get url; PipelineGraph get pipeline;
/// Create a copy of ExploreConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreConfigCopyWith<ExploreConfig> get copyWith => _$ExploreConfigCopyWithImpl<ExploreConfig>(this as ExploreConfig, _$identity);

  /// Serializes this ExploreConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreConfig&&(identical(other.url, url) || other.url == url)&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,pipeline);

@override
String toString() {
  return 'ExploreConfig(url: $url, pipeline: $pipeline)';
}


}

/// @nodoc
abstract mixin class $ExploreConfigCopyWith<$Res>  {
  factory $ExploreConfigCopyWith(ExploreConfig value, $Res Function(ExploreConfig) _then) = _$ExploreConfigCopyWithImpl;
@useResult
$Res call({
 String url, PipelineGraph pipeline
});


$PipelineGraphCopyWith<$Res> get pipeline;

}
/// @nodoc
class _$ExploreConfigCopyWithImpl<$Res>
    implements $ExploreConfigCopyWith<$Res> {
  _$ExploreConfigCopyWithImpl(this._self, this._then);

  final ExploreConfig _self;
  final $Res Function(ExploreConfig) _then;

/// Create a copy of ExploreConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? pipeline = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,pipeline: null == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as PipelineGraph,
  ));
}
/// Create a copy of ExploreConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PipelineGraphCopyWith<$Res> get pipeline {
  
  return $PipelineGraphCopyWith<$Res>(_self.pipeline, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}
}


/// Adds pattern-matching-related methods to [ExploreConfig].
extension ExploreConfigPatterns on ExploreConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreConfig value)  $default,){
final _that = this;
switch (_that) {
case _ExploreConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  PipelineGraph pipeline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreConfig() when $default != null:
return $default(_that.url,_that.pipeline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  PipelineGraph pipeline)  $default,) {final _that = this;
switch (_that) {
case _ExploreConfig():
return $default(_that.url,_that.pipeline);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  PipelineGraph pipeline)?  $default,) {final _that = this;
switch (_that) {
case _ExploreConfig() when $default != null:
return $default(_that.url,_that.pipeline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExploreConfig implements ExploreConfig {
  const _ExploreConfig({required this.url, required this.pipeline});
  factory _ExploreConfig.fromJson(Map<String, dynamic> json) => _$ExploreConfigFromJson(json);

@override final  String url;
@override final  PipelineGraph pipeline;

/// Create a copy of ExploreConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreConfigCopyWith<_ExploreConfig> get copyWith => __$ExploreConfigCopyWithImpl<_ExploreConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExploreConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreConfig&&(identical(other.url, url) || other.url == url)&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,pipeline);

@override
String toString() {
  return 'ExploreConfig(url: $url, pipeline: $pipeline)';
}


}

/// @nodoc
abstract mixin class _$ExploreConfigCopyWith<$Res> implements $ExploreConfigCopyWith<$Res> {
  factory _$ExploreConfigCopyWith(_ExploreConfig value, $Res Function(_ExploreConfig) _then) = __$ExploreConfigCopyWithImpl;
@override @useResult
$Res call({
 String url, PipelineGraph pipeline
});


@override $PipelineGraphCopyWith<$Res> get pipeline;

}
/// @nodoc
class __$ExploreConfigCopyWithImpl<$Res>
    implements _$ExploreConfigCopyWith<$Res> {
  __$ExploreConfigCopyWithImpl(this._self, this._then);

  final _ExploreConfig _self;
  final $Res Function(_ExploreConfig) _then;

/// Create a copy of ExploreConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? pipeline = null,}) {
  return _then(_ExploreConfig(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,pipeline: null == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as PipelineGraph,
  ));
}

/// Create a copy of ExploreConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PipelineGraphCopyWith<$Res> get pipeline {
  
  return $PipelineGraphCopyWith<$Res>(_self.pipeline, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}
}


/// @nodoc
mixin _$Lifecycle {

 ExploreConfig? get explore; SearchConfig? get search; DetailConfig? get detail; TocConfig? get toc; ContentConfig? get content;
/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LifecycleCopyWith<Lifecycle> get copyWith => _$LifecycleCopyWithImpl<Lifecycle>(this as Lifecycle, _$identity);

  /// Serializes this Lifecycle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lifecycle&&(identical(other.explore, explore) || other.explore == explore)&&(identical(other.search, search) || other.search == search)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.toc, toc) || other.toc == toc)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,explore,search,detail,toc,content);

@override
String toString() {
  return 'Lifecycle(explore: $explore, search: $search, detail: $detail, toc: $toc, content: $content)';
}


}

/// @nodoc
abstract mixin class $LifecycleCopyWith<$Res>  {
  factory $LifecycleCopyWith(Lifecycle value, $Res Function(Lifecycle) _then) = _$LifecycleCopyWithImpl;
@useResult
$Res call({
 ExploreConfig? explore, SearchConfig? search, DetailConfig? detail, TocConfig? toc, ContentConfig? content
});


$ExploreConfigCopyWith<$Res>? get explore;$SearchConfigCopyWith<$Res>? get search;$DetailConfigCopyWith<$Res>? get detail;$TocConfigCopyWith<$Res>? get toc;$ContentConfigCopyWith<$Res>? get content;

}
/// @nodoc
class _$LifecycleCopyWithImpl<$Res>
    implements $LifecycleCopyWith<$Res> {
  _$LifecycleCopyWithImpl(this._self, this._then);

  final Lifecycle _self;
  final $Res Function(Lifecycle) _then;

/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? explore = freezed,Object? search = freezed,Object? detail = freezed,Object? toc = freezed,Object? content = freezed,}) {
  return _then(_self.copyWith(
explore: freezed == explore ? _self.explore : explore // ignore: cast_nullable_to_non_nullable
as ExploreConfig?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as SearchConfig?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as DetailConfig?,toc: freezed == toc ? _self.toc : toc // ignore: cast_nullable_to_non_nullable
as TocConfig?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as ContentConfig?,
  ));
}
/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExploreConfigCopyWith<$Res>? get explore {
    if (_self.explore == null) {
    return null;
  }

  return $ExploreConfigCopyWith<$Res>(_self.explore!, (value) {
    return _then(_self.copyWith(explore: value));
  });
}/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchConfigCopyWith<$Res>? get search {
    if (_self.search == null) {
    return null;
  }

  return $SearchConfigCopyWith<$Res>(_self.search!, (value) {
    return _then(_self.copyWith(search: value));
  });
}/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetailConfigCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $DetailConfigCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TocConfigCopyWith<$Res>? get toc {
    if (_self.toc == null) {
    return null;
  }

  return $TocConfigCopyWith<$Res>(_self.toc!, (value) {
    return _then(_self.copyWith(toc: value));
  });
}/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentConfigCopyWith<$Res>? get content {
    if (_self.content == null) {
    return null;
  }

  return $ContentConfigCopyWith<$Res>(_self.content!, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// Adds pattern-matching-related methods to [Lifecycle].
extension LifecyclePatterns on Lifecycle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Lifecycle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Lifecycle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Lifecycle value)  $default,){
final _that = this;
switch (_that) {
case _Lifecycle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Lifecycle value)?  $default,){
final _that = this;
switch (_that) {
case _Lifecycle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExploreConfig? explore,  SearchConfig? search,  DetailConfig? detail,  TocConfig? toc,  ContentConfig? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Lifecycle() when $default != null:
return $default(_that.explore,_that.search,_that.detail,_that.toc,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExploreConfig? explore,  SearchConfig? search,  DetailConfig? detail,  TocConfig? toc,  ContentConfig? content)  $default,) {final _that = this;
switch (_that) {
case _Lifecycle():
return $default(_that.explore,_that.search,_that.detail,_that.toc,_that.content);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExploreConfig? explore,  SearchConfig? search,  DetailConfig? detail,  TocConfig? toc,  ContentConfig? content)?  $default,) {final _that = this;
switch (_that) {
case _Lifecycle() when $default != null:
return $default(_that.explore,_that.search,_that.detail,_that.toc,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Lifecycle implements Lifecycle {
  const _Lifecycle({this.explore, this.search, this.detail, this.toc, this.content});
  factory _Lifecycle.fromJson(Map<String, dynamic> json) => _$LifecycleFromJson(json);

@override final  ExploreConfig? explore;
@override final  SearchConfig? search;
@override final  DetailConfig? detail;
@override final  TocConfig? toc;
@override final  ContentConfig? content;

/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LifecycleCopyWith<_Lifecycle> get copyWith => __$LifecycleCopyWithImpl<_Lifecycle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LifecycleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Lifecycle&&(identical(other.explore, explore) || other.explore == explore)&&(identical(other.search, search) || other.search == search)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.toc, toc) || other.toc == toc)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,explore,search,detail,toc,content);

@override
String toString() {
  return 'Lifecycle(explore: $explore, search: $search, detail: $detail, toc: $toc, content: $content)';
}


}

/// @nodoc
abstract mixin class _$LifecycleCopyWith<$Res> implements $LifecycleCopyWith<$Res> {
  factory _$LifecycleCopyWith(_Lifecycle value, $Res Function(_Lifecycle) _then) = __$LifecycleCopyWithImpl;
@override @useResult
$Res call({
 ExploreConfig? explore, SearchConfig? search, DetailConfig? detail, TocConfig? toc, ContentConfig? content
});


@override $ExploreConfigCopyWith<$Res>? get explore;@override $SearchConfigCopyWith<$Res>? get search;@override $DetailConfigCopyWith<$Res>? get detail;@override $TocConfigCopyWith<$Res>? get toc;@override $ContentConfigCopyWith<$Res>? get content;

}
/// @nodoc
class __$LifecycleCopyWithImpl<$Res>
    implements _$LifecycleCopyWith<$Res> {
  __$LifecycleCopyWithImpl(this._self, this._then);

  final _Lifecycle _self;
  final $Res Function(_Lifecycle) _then;

/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? explore = freezed,Object? search = freezed,Object? detail = freezed,Object? toc = freezed,Object? content = freezed,}) {
  return _then(_Lifecycle(
explore: freezed == explore ? _self.explore : explore // ignore: cast_nullable_to_non_nullable
as ExploreConfig?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as SearchConfig?,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as DetailConfig?,toc: freezed == toc ? _self.toc : toc // ignore: cast_nullable_to_non_nullable
as TocConfig?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as ContentConfig?,
  ));
}

/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExploreConfigCopyWith<$Res>? get explore {
    if (_self.explore == null) {
    return null;
  }

  return $ExploreConfigCopyWith<$Res>(_self.explore!, (value) {
    return _then(_self.copyWith(explore: value));
  });
}/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SearchConfigCopyWith<$Res>? get search {
    if (_self.search == null) {
    return null;
  }

  return $SearchConfigCopyWith<$Res>(_self.search!, (value) {
    return _then(_self.copyWith(search: value));
  });
}/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetailConfigCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $DetailConfigCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TocConfigCopyWith<$Res>? get toc {
    if (_self.toc == null) {
    return null;
  }

  return $TocConfigCopyWith<$Res>(_self.toc!, (value) {
    return _then(_self.copyWith(toc: value));
  });
}/// Create a copy of Lifecycle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentConfigCopyWith<$Res>? get content {
    if (_self.content == null) {
    return null;
  }

  return $ContentConfigCopyWith<$Res>(_self.content!, (value) {
    return _then(_self.copyWith(content: value));
  });
}
}


/// @nodoc
mixin _$SearchConfig {

 String get url; PipelineGraph get pipeline;
/// Create a copy of SearchConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchConfigCopyWith<SearchConfig> get copyWith => _$SearchConfigCopyWithImpl<SearchConfig>(this as SearchConfig, _$identity);

  /// Serializes this SearchConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchConfig&&(identical(other.url, url) || other.url == url)&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,pipeline);

@override
String toString() {
  return 'SearchConfig(url: $url, pipeline: $pipeline)';
}


}

/// @nodoc
abstract mixin class $SearchConfigCopyWith<$Res>  {
  factory $SearchConfigCopyWith(SearchConfig value, $Res Function(SearchConfig) _then) = _$SearchConfigCopyWithImpl;
@useResult
$Res call({
 String url, PipelineGraph pipeline
});


$PipelineGraphCopyWith<$Res> get pipeline;

}
/// @nodoc
class _$SearchConfigCopyWithImpl<$Res>
    implements $SearchConfigCopyWith<$Res> {
  _$SearchConfigCopyWithImpl(this._self, this._then);

  final SearchConfig _self;
  final $Res Function(SearchConfig) _then;

/// Create a copy of SearchConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? pipeline = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,pipeline: null == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as PipelineGraph,
  ));
}
/// Create a copy of SearchConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PipelineGraphCopyWith<$Res> get pipeline {
  
  return $PipelineGraphCopyWith<$Res>(_self.pipeline, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}
}


/// Adds pattern-matching-related methods to [SearchConfig].
extension SearchConfigPatterns on SearchConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchConfig value)  $default,){
final _that = this;
switch (_that) {
case _SearchConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchConfig value)?  $default,){
final _that = this;
switch (_that) {
case _SearchConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  PipelineGraph pipeline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchConfig() when $default != null:
return $default(_that.url,_that.pipeline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  PipelineGraph pipeline)  $default,) {final _that = this;
switch (_that) {
case _SearchConfig():
return $default(_that.url,_that.pipeline);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  PipelineGraph pipeline)?  $default,) {final _that = this;
switch (_that) {
case _SearchConfig() when $default != null:
return $default(_that.url,_that.pipeline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchConfig implements SearchConfig {
  const _SearchConfig({required this.url, required this.pipeline});
  factory _SearchConfig.fromJson(Map<String, dynamic> json) => _$SearchConfigFromJson(json);

@override final  String url;
@override final  PipelineGraph pipeline;

/// Create a copy of SearchConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchConfigCopyWith<_SearchConfig> get copyWith => __$SearchConfigCopyWithImpl<_SearchConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchConfig&&(identical(other.url, url) || other.url == url)&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,pipeline);

@override
String toString() {
  return 'SearchConfig(url: $url, pipeline: $pipeline)';
}


}

/// @nodoc
abstract mixin class _$SearchConfigCopyWith<$Res> implements $SearchConfigCopyWith<$Res> {
  factory _$SearchConfigCopyWith(_SearchConfig value, $Res Function(_SearchConfig) _then) = __$SearchConfigCopyWithImpl;
@override @useResult
$Res call({
 String url, PipelineGraph pipeline
});


@override $PipelineGraphCopyWith<$Res> get pipeline;

}
/// @nodoc
class __$SearchConfigCopyWithImpl<$Res>
    implements _$SearchConfigCopyWith<$Res> {
  __$SearchConfigCopyWithImpl(this._self, this._then);

  final _SearchConfig _self;
  final $Res Function(_SearchConfig) _then;

/// Create a copy of SearchConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? pipeline = null,}) {
  return _then(_SearchConfig(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,pipeline: null == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as PipelineGraph,
  ));
}

/// Create a copy of SearchConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PipelineGraphCopyWith<$Res> get pipeline {
  
  return $PipelineGraphCopyWith<$Res>(_self.pipeline, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}
}


/// @nodoc
mixin _$TocConfig {

 PipelineGraph get pipeline;
/// Create a copy of TocConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TocConfigCopyWith<TocConfig> get copyWith => _$TocConfigCopyWithImpl<TocConfig>(this as TocConfig, _$identity);

  /// Serializes this TocConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TocConfig&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pipeline);

@override
String toString() {
  return 'TocConfig(pipeline: $pipeline)';
}


}

/// @nodoc
abstract mixin class $TocConfigCopyWith<$Res>  {
  factory $TocConfigCopyWith(TocConfig value, $Res Function(TocConfig) _then) = _$TocConfigCopyWithImpl;
@useResult
$Res call({
 PipelineGraph pipeline
});


$PipelineGraphCopyWith<$Res> get pipeline;

}
/// @nodoc
class _$TocConfigCopyWithImpl<$Res>
    implements $TocConfigCopyWith<$Res> {
  _$TocConfigCopyWithImpl(this._self, this._then);

  final TocConfig _self;
  final $Res Function(TocConfig) _then;

/// Create a copy of TocConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pipeline = null,}) {
  return _then(_self.copyWith(
pipeline: null == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as PipelineGraph,
  ));
}
/// Create a copy of TocConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PipelineGraphCopyWith<$Res> get pipeline {
  
  return $PipelineGraphCopyWith<$Res>(_self.pipeline, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}
}


/// Adds pattern-matching-related methods to [TocConfig].
extension TocConfigPatterns on TocConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TocConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TocConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TocConfig value)  $default,){
final _that = this;
switch (_that) {
case _TocConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TocConfig value)?  $default,){
final _that = this;
switch (_that) {
case _TocConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PipelineGraph pipeline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TocConfig() when $default != null:
return $default(_that.pipeline);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PipelineGraph pipeline)  $default,) {final _that = this;
switch (_that) {
case _TocConfig():
return $default(_that.pipeline);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PipelineGraph pipeline)?  $default,) {final _that = this;
switch (_that) {
case _TocConfig() when $default != null:
return $default(_that.pipeline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TocConfig implements TocConfig {
  const _TocConfig({required this.pipeline});
  factory _TocConfig.fromJson(Map<String, dynamic> json) => _$TocConfigFromJson(json);

@override final  PipelineGraph pipeline;

/// Create a copy of TocConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TocConfigCopyWith<_TocConfig> get copyWith => __$TocConfigCopyWithImpl<_TocConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TocConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TocConfig&&(identical(other.pipeline, pipeline) || other.pipeline == pipeline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pipeline);

@override
String toString() {
  return 'TocConfig(pipeline: $pipeline)';
}


}

/// @nodoc
abstract mixin class _$TocConfigCopyWith<$Res> implements $TocConfigCopyWith<$Res> {
  factory _$TocConfigCopyWith(_TocConfig value, $Res Function(_TocConfig) _then) = __$TocConfigCopyWithImpl;
@override @useResult
$Res call({
 PipelineGraph pipeline
});


@override $PipelineGraphCopyWith<$Res> get pipeline;

}
/// @nodoc
class __$TocConfigCopyWithImpl<$Res>
    implements _$TocConfigCopyWith<$Res> {
  __$TocConfigCopyWithImpl(this._self, this._then);

  final _TocConfig _self;
  final $Res Function(_TocConfig) _then;

/// Create a copy of TocConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pipeline = null,}) {
  return _then(_TocConfig(
pipeline: null == pipeline ? _self.pipeline : pipeline // ignore: cast_nullable_to_non_nullable
as PipelineGraph,
  ));
}

/// Create a copy of TocConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PipelineGraphCopyWith<$Res> get pipeline {
  
  return $PipelineGraphCopyWith<$Res>(_self.pipeline, (value) {
    return _then(_self.copyWith(pipeline: value));
  });
}
}

// dart format on
