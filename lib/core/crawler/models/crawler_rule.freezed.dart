// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crawler_rule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CrawlerRule {

/// Rule unique identifier.
 String get id;/// Rule name.
 String get name;/// Rule description.
 String? get description;/// Media type this rule extracts.
 MediaType get mediaType;/// Rule version (semantic versioning).
 String get version;/// URL matching configuration.
 MatchConfig get match;/// HTTP request configuration.
 RequestConfig get request;/// Extraction configuration.
 ExtractConfig get extract;/// Actions to execute before extraction.
 List<CrawlerAction>? get beforeActions;/// Actions to execute after extraction.
 List<CrawlerAction>? get afterActions;/// Anti-crawl detection configuration.
 DetectionConfig? get detection;/// Rule author.
 String? get author;/// Rule source (official, third_party, user).
 String get source;/// Rule icon URL.
 String? get iconUrl;/// Rule tags.
 List<String>? get tags;/// Whether rule is enabled.
 bool get enabled;/// Creation timestamp.
 DateTime? get createdAt;/// Last update timestamp.
 DateTime? get updatedAt;
/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrawlerRuleCopyWith<CrawlerRule> get copyWith => _$CrawlerRuleCopyWithImpl<CrawlerRule>(this as CrawlerRule, _$identity);

  /// Serializes this CrawlerRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrawlerRule&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.version, version) || other.version == version)&&(identical(other.match, match) || other.match == match)&&(identical(other.request, request) || other.request == request)&&(identical(other.extract, extract) || other.extract == extract)&&const DeepCollectionEquality().equals(other.beforeActions, beforeActions)&&const DeepCollectionEquality().equals(other.afterActions, afterActions)&&(identical(other.detection, detection) || other.detection == detection)&&(identical(other.author, author) || other.author == author)&&(identical(other.source, source) || other.source == source)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,mediaType,version,match,request,extract,const DeepCollectionEquality().hash(beforeActions),const DeepCollectionEquality().hash(afterActions),detection,author,source,iconUrl,const DeepCollectionEquality().hash(tags),enabled,createdAt,updatedAt);

@override
String toString() {
  return 'CrawlerRule(id: $id, name: $name, description: $description, mediaType: $mediaType, version: $version, match: $match, request: $request, extract: $extract, beforeActions: $beforeActions, afterActions: $afterActions, detection: $detection, author: $author, source: $source, iconUrl: $iconUrl, tags: $tags, enabled: $enabled, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CrawlerRuleCopyWith<$Res>  {
  factory $CrawlerRuleCopyWith(CrawlerRule value, $Res Function(CrawlerRule) _then) = _$CrawlerRuleCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, MediaType mediaType, String version, MatchConfig match, RequestConfig request, ExtractConfig extract, List<CrawlerAction>? beforeActions, List<CrawlerAction>? afterActions, DetectionConfig? detection, String? author, String source, String? iconUrl, List<String>? tags, bool enabled, DateTime? createdAt, DateTime? updatedAt
});


$MatchConfigCopyWith<$Res> get match;$RequestConfigCopyWith<$Res> get request;$ExtractConfigCopyWith<$Res> get extract;$DetectionConfigCopyWith<$Res>? get detection;

}
/// @nodoc
class _$CrawlerRuleCopyWithImpl<$Res>
    implements $CrawlerRuleCopyWith<$Res> {
  _$CrawlerRuleCopyWithImpl(this._self, this._then);

  final CrawlerRule _self;
  final $Res Function(CrawlerRule) _then;

/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? mediaType = null,Object? version = null,Object? match = null,Object? request = null,Object? extract = null,Object? beforeActions = freezed,Object? afterActions = freezed,Object? detection = freezed,Object? author = freezed,Object? source = null,Object? iconUrl = freezed,Object? tags = freezed,Object? enabled = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as MediaType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,match: null == match ? _self.match : match // ignore: cast_nullable_to_non_nullable
as MatchConfig,request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as RequestConfig,extract: null == extract ? _self.extract : extract // ignore: cast_nullable_to_non_nullable
as ExtractConfig,beforeActions: freezed == beforeActions ? _self.beforeActions : beforeActions // ignore: cast_nullable_to_non_nullable
as List<CrawlerAction>?,afterActions: freezed == afterActions ? _self.afterActions : afterActions // ignore: cast_nullable_to_non_nullable
as List<CrawlerAction>?,detection: freezed == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as DetectionConfig?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,iconUrl: freezed == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchConfigCopyWith<$Res> get match {
  
  return $MatchConfigCopyWith<$Res>(_self.match, (value) {
    return _then(_self.copyWith(match: value));
  });
}/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestConfigCopyWith<$Res> get request {
  
  return $RequestConfigCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtractConfigCopyWith<$Res> get extract {
  
  return $ExtractConfigCopyWith<$Res>(_self.extract, (value) {
    return _then(_self.copyWith(extract: value));
  });
}/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionConfigCopyWith<$Res>? get detection {
    if (_self.detection == null) {
    return null;
  }

  return $DetectionConfigCopyWith<$Res>(_self.detection!, (value) {
    return _then(_self.copyWith(detection: value));
  });
}
}


/// Adds pattern-matching-related methods to [CrawlerRule].
extension CrawlerRulePatterns on CrawlerRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CrawlerRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CrawlerRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CrawlerRule value)  $default,){
final _that = this;
switch (_that) {
case _CrawlerRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CrawlerRule value)?  $default,){
final _that = this;
switch (_that) {
case _CrawlerRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  MediaType mediaType,  String version,  MatchConfig match,  RequestConfig request,  ExtractConfig extract,  List<CrawlerAction>? beforeActions,  List<CrawlerAction>? afterActions,  DetectionConfig? detection,  String? author,  String source,  String? iconUrl,  List<String>? tags,  bool enabled,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CrawlerRule() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.mediaType,_that.version,_that.match,_that.request,_that.extract,_that.beforeActions,_that.afterActions,_that.detection,_that.author,_that.source,_that.iconUrl,_that.tags,_that.enabled,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  MediaType mediaType,  String version,  MatchConfig match,  RequestConfig request,  ExtractConfig extract,  List<CrawlerAction>? beforeActions,  List<CrawlerAction>? afterActions,  DetectionConfig? detection,  String? author,  String source,  String? iconUrl,  List<String>? tags,  bool enabled,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CrawlerRule():
return $default(_that.id,_that.name,_that.description,_that.mediaType,_that.version,_that.match,_that.request,_that.extract,_that.beforeActions,_that.afterActions,_that.detection,_that.author,_that.source,_that.iconUrl,_that.tags,_that.enabled,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  MediaType mediaType,  String version,  MatchConfig match,  RequestConfig request,  ExtractConfig extract,  List<CrawlerAction>? beforeActions,  List<CrawlerAction>? afterActions,  DetectionConfig? detection,  String? author,  String source,  String? iconUrl,  List<String>? tags,  bool enabled,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CrawlerRule() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.mediaType,_that.version,_that.match,_that.request,_that.extract,_that.beforeActions,_that.afterActions,_that.detection,_that.author,_that.source,_that.iconUrl,_that.tags,_that.enabled,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CrawlerRule implements CrawlerRule {
  const _CrawlerRule({required this.id, required this.name, this.description, required this.mediaType, this.version = '1.0.0', required this.match, this.request = const RequestConfig(), required this.extract, final  List<CrawlerAction>? beforeActions, final  List<CrawlerAction>? afterActions, this.detection, this.author, this.source = 'user', this.iconUrl, final  List<String>? tags, this.enabled = true, this.createdAt, this.updatedAt}): _beforeActions = beforeActions,_afterActions = afterActions,_tags = tags;
  factory _CrawlerRule.fromJson(Map<String, dynamic> json) => _$CrawlerRuleFromJson(json);

/// Rule unique identifier.
@override final  String id;
/// Rule name.
@override final  String name;
/// Rule description.
@override final  String? description;
/// Media type this rule extracts.
@override final  MediaType mediaType;
/// Rule version (semantic versioning).
@override@JsonKey() final  String version;
/// URL matching configuration.
@override final  MatchConfig match;
/// HTTP request configuration.
@override@JsonKey() final  RequestConfig request;
/// Extraction configuration.
@override final  ExtractConfig extract;
/// Actions to execute before extraction.
 final  List<CrawlerAction>? _beforeActions;
/// Actions to execute before extraction.
@override List<CrawlerAction>? get beforeActions {
  final value = _beforeActions;
  if (value == null) return null;
  if (_beforeActions is EqualUnmodifiableListView) return _beforeActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Actions to execute after extraction.
 final  List<CrawlerAction>? _afterActions;
/// Actions to execute after extraction.
@override List<CrawlerAction>? get afterActions {
  final value = _afterActions;
  if (value == null) return null;
  if (_afterActions is EqualUnmodifiableListView) return _afterActions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Anti-crawl detection configuration.
@override final  DetectionConfig? detection;
/// Rule author.
@override final  String? author;
/// Rule source (official, third_party, user).
@override@JsonKey() final  String source;
/// Rule icon URL.
@override final  String? iconUrl;
/// Rule tags.
 final  List<String>? _tags;
/// Rule tags.
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Whether rule is enabled.
@override@JsonKey() final  bool enabled;
/// Creation timestamp.
@override final  DateTime? createdAt;
/// Last update timestamp.
@override final  DateTime? updatedAt;

/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrawlerRuleCopyWith<_CrawlerRule> get copyWith => __$CrawlerRuleCopyWithImpl<_CrawlerRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CrawlerRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrawlerRule&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.mediaType, mediaType) || other.mediaType == mediaType)&&(identical(other.version, version) || other.version == version)&&(identical(other.match, match) || other.match == match)&&(identical(other.request, request) || other.request == request)&&(identical(other.extract, extract) || other.extract == extract)&&const DeepCollectionEquality().equals(other._beforeActions, _beforeActions)&&const DeepCollectionEquality().equals(other._afterActions, _afterActions)&&(identical(other.detection, detection) || other.detection == detection)&&(identical(other.author, author) || other.author == author)&&(identical(other.source, source) || other.source == source)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,mediaType,version,match,request,extract,const DeepCollectionEquality().hash(_beforeActions),const DeepCollectionEquality().hash(_afterActions),detection,author,source,iconUrl,const DeepCollectionEquality().hash(_tags),enabled,createdAt,updatedAt);

@override
String toString() {
  return 'CrawlerRule(id: $id, name: $name, description: $description, mediaType: $mediaType, version: $version, match: $match, request: $request, extract: $extract, beforeActions: $beforeActions, afterActions: $afterActions, detection: $detection, author: $author, source: $source, iconUrl: $iconUrl, tags: $tags, enabled: $enabled, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CrawlerRuleCopyWith<$Res> implements $CrawlerRuleCopyWith<$Res> {
  factory _$CrawlerRuleCopyWith(_CrawlerRule value, $Res Function(_CrawlerRule) _then) = __$CrawlerRuleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, MediaType mediaType, String version, MatchConfig match, RequestConfig request, ExtractConfig extract, List<CrawlerAction>? beforeActions, List<CrawlerAction>? afterActions, DetectionConfig? detection, String? author, String source, String? iconUrl, List<String>? tags, bool enabled, DateTime? createdAt, DateTime? updatedAt
});


@override $MatchConfigCopyWith<$Res> get match;@override $RequestConfigCopyWith<$Res> get request;@override $ExtractConfigCopyWith<$Res> get extract;@override $DetectionConfigCopyWith<$Res>? get detection;

}
/// @nodoc
class __$CrawlerRuleCopyWithImpl<$Res>
    implements _$CrawlerRuleCopyWith<$Res> {
  __$CrawlerRuleCopyWithImpl(this._self, this._then);

  final _CrawlerRule _self;
  final $Res Function(_CrawlerRule) _then;

/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? mediaType = null,Object? version = null,Object? match = null,Object? request = null,Object? extract = null,Object? beforeActions = freezed,Object? afterActions = freezed,Object? detection = freezed,Object? author = freezed,Object? source = null,Object? iconUrl = freezed,Object? tags = freezed,Object? enabled = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CrawlerRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,mediaType: null == mediaType ? _self.mediaType : mediaType // ignore: cast_nullable_to_non_nullable
as MediaType,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,match: null == match ? _self.match : match // ignore: cast_nullable_to_non_nullable
as MatchConfig,request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as RequestConfig,extract: null == extract ? _self.extract : extract // ignore: cast_nullable_to_non_nullable
as ExtractConfig,beforeActions: freezed == beforeActions ? _self._beforeActions : beforeActions // ignore: cast_nullable_to_non_nullable
as List<CrawlerAction>?,afterActions: freezed == afterActions ? _self._afterActions : afterActions // ignore: cast_nullable_to_non_nullable
as List<CrawlerAction>?,detection: freezed == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as DetectionConfig?,author: freezed == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String?,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,iconUrl: freezed == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchConfigCopyWith<$Res> get match {
  
  return $MatchConfigCopyWith<$Res>(_self.match, (value) {
    return _then(_self.copyWith(match: value));
  });
}/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequestConfigCopyWith<$Res> get request {
  
  return $RequestConfigCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExtractConfigCopyWith<$Res> get extract {
  
  return $ExtractConfigCopyWith<$Res>(_self.extract, (value) {
    return _then(_self.copyWith(extract: value));
  });
}/// Create a copy of CrawlerRule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DetectionConfigCopyWith<$Res>? get detection {
    if (_self.detection == null) {
    return null;
  }

  return $DetectionConfigCopyWith<$Res>(_self.detection!, (value) {
    return _then(_self.copyWith(detection: value));
  });
}
}

// dart format on
