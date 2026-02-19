// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BaseContent {

/// Unique identifier for this content.
 String get id;/// Content title.
 String get title;/// Cover/thumbnail image URL.
 String? get cover;/// Description/summary.
 String? get description;/// Author information.
 Author? get author;/// List of tags/categories.
 List<String>? get tags;/// Primary category name.
 String? get category;/// Content statistics.
 ContentStats? get stats;/// Original publish date.
 DateTime? get createdAt;/// Last update date.
 DateTime? get updatedAt;/// Source information (where content was crawled from).
 ContentSource get source;
/// Create a copy of BaseContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseContentCopyWith<BaseContent> get copyWith => _$BaseContentCopyWithImpl<BaseContent>(this as BaseContent, _$identity);

  /// Serializes this BaseContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,cover,description,author,const DeepCollectionEquality().hash(tags),category,stats,createdAt,updatedAt,source);

@override
String toString() {
  return 'BaseContent(id: $id, title: $title, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, source: $source)';
}


}

/// @nodoc
abstract mixin class $BaseContentCopyWith<$Res>  {
  factory $BaseContentCopyWith(BaseContent value, $Res Function(BaseContent) _then) = _$BaseContentCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, ContentSource source
});


$AuthorCopyWith<$Res>? get author;$ContentStatsCopyWith<$Res>? get stats;$ContentSourceCopyWith<$Res> get source;

}
/// @nodoc
class _$BaseContentCopyWithImpl<$Res>
    implements $BaseContentCopyWith<$Res> {
  _$BaseContentCopyWithImpl(this._self, this._then);

  final BaseContent _self;
  final $Res Function(BaseContent) _then;

/// Create a copy of BaseContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? source = null,}) {
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
as ContentSource,
  ));
}
/// Create a copy of BaseContent
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
}/// Create a copy of BaseContent
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
}/// Create a copy of BaseContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}


/// Adds pattern-matching-related methods to [BaseContent].
extension BaseContentPatterns on BaseContent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BaseContent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BaseContent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BaseContent value)  $default,){
final _that = this;
switch (_that) {
case _BaseContent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BaseContent value)?  $default,){
final _that = this;
switch (_that) {
case _BaseContent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BaseContent() when $default != null:
return $default(_that.id,_that.title,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source)  $default,) {final _that = this;
switch (_that) {
case _BaseContent():
return $default(_that.id,_that.title,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? cover,  String? description,  Author? author,  List<String>? tags,  String? category,  ContentStats? stats,  DateTime? createdAt,  DateTime? updatedAt,  ContentSource source)?  $default,) {final _that = this;
switch (_that) {
case _BaseContent() when $default != null:
return $default(_that.id,_that.title,_that.cover,_that.description,_that.author,_that.tags,_that.category,_that.stats,_that.createdAt,_that.updatedAt,_that.source);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BaseContent implements BaseContent {
  const _BaseContent({required this.id, required this.title, this.cover, this.description, this.author, final  List<String>? tags, this.category, this.stats, this.createdAt, this.updatedAt, required this.source}): _tags = tags;
  factory _BaseContent.fromJson(Map<String, dynamic> json) => _$BaseContentFromJson(json);

/// Unique identifier for this content.
@override final  String id;
/// Content title.
@override final  String title;
/// Cover/thumbnail image URL.
@override final  String? cover;
/// Description/summary.
@override final  String? description;
/// Author information.
@override final  Author? author;
/// List of tags/categories.
 final  List<String>? _tags;
/// List of tags/categories.
@override List<String>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Primary category name.
@override final  String? category;
/// Content statistics.
@override final  ContentStats? stats;
/// Original publish date.
@override final  DateTime? createdAt;
/// Last update date.
@override final  DateTime? updatedAt;
/// Source information (where content was crawled from).
@override final  ContentSource source;

/// Create a copy of BaseContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BaseContentCopyWith<_BaseContent> get copyWith => __$BaseContentCopyWithImpl<_BaseContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BaseContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BaseContent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.cover, cover) || other.cover == cover)&&(identical(other.description, description) || other.description == description)&&(identical(other.author, author) || other.author == author)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.category, category) || other.category == category)&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.source, source) || other.source == source));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,cover,description,author,const DeepCollectionEquality().hash(_tags),category,stats,createdAt,updatedAt,source);

@override
String toString() {
  return 'BaseContent(id: $id, title: $title, cover: $cover, description: $description, author: $author, tags: $tags, category: $category, stats: $stats, createdAt: $createdAt, updatedAt: $updatedAt, source: $source)';
}


}

/// @nodoc
abstract mixin class _$BaseContentCopyWith<$Res> implements $BaseContentCopyWith<$Res> {
  factory _$BaseContentCopyWith(_BaseContent value, $Res Function(_BaseContent) _then) = __$BaseContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? cover, String? description, Author? author, List<String>? tags, String? category, ContentStats? stats, DateTime? createdAt, DateTime? updatedAt, ContentSource source
});


@override $AuthorCopyWith<$Res>? get author;@override $ContentStatsCopyWith<$Res>? get stats;@override $ContentSourceCopyWith<$Res> get source;

}
/// @nodoc
class __$BaseContentCopyWithImpl<$Res>
    implements _$BaseContentCopyWith<$Res> {
  __$BaseContentCopyWithImpl(this._self, this._then);

  final _BaseContent _self;
  final $Res Function(_BaseContent) _then;

/// Create a copy of BaseContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? cover = freezed,Object? description = freezed,Object? author = freezed,Object? tags = freezed,Object? category = freezed,Object? stats = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? source = null,}) {
  return _then(_BaseContent(
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
as ContentSource,
  ));
}

/// Create a copy of BaseContent
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
}/// Create a copy of BaseContent
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
}/// Create a copy of BaseContent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ContentSourceCopyWith<$Res> get source {
  
  return $ContentSourceCopyWith<$Res>(_self.source, (value) {
    return _then(_self.copyWith(source: value));
  });
}
}

// dart format on
