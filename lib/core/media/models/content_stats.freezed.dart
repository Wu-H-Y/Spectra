// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContentStats {

/// 浏览/播放次数。
 int? get viewCount;/// 点赞/支持数。
 int? get likeCount;/// 收藏/书签数。
 int? get favoriteCount;/// 评论数。
 int? get commentCount;/// 分享/转发数。
 int? get shareCount;/// 评分（通常为 0-10 或 0-5 分制）。
 double? get rating;/// 收到的评分数。
 int? get ratingCount;
/// Create a copy of ContentStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentStatsCopyWith<ContentStats> get copyWith => _$ContentStatsCopyWithImpl<ContentStats>(this as ContentStats, _$identity);

  /// Serializes this ContentStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContentStats&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.shareCount, shareCount) || other.shareCount == shareCount)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,viewCount,likeCount,favoriteCount,commentCount,shareCount,rating,ratingCount);

@override
String toString() {
  return 'ContentStats(viewCount: $viewCount, likeCount: $likeCount, favoriteCount: $favoriteCount, commentCount: $commentCount, shareCount: $shareCount, rating: $rating, ratingCount: $ratingCount)';
}


}

/// @nodoc
abstract mixin class $ContentStatsCopyWith<$Res>  {
  factory $ContentStatsCopyWith(ContentStats value, $Res Function(ContentStats) _then) = _$ContentStatsCopyWithImpl;
@useResult
$Res call({
 int? viewCount, int? likeCount, int? favoriteCount, int? commentCount, int? shareCount, double? rating, int? ratingCount
});




}
/// @nodoc
class _$ContentStatsCopyWithImpl<$Res>
    implements $ContentStatsCopyWith<$Res> {
  _$ContentStatsCopyWithImpl(this._self, this._then);

  final ContentStats _self;
  final $Res Function(ContentStats) _then;

/// Create a copy of ContentStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? viewCount = freezed,Object? likeCount = freezed,Object? favoriteCount = freezed,Object? commentCount = freezed,Object? shareCount = freezed,Object? rating = freezed,Object? ratingCount = freezed,}) {
  return _then(_self.copyWith(
viewCount: freezed == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int?,likeCount: freezed == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int?,favoriteCount: freezed == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int?,commentCount: freezed == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int?,shareCount: freezed == shareCount ? _self.shareCount : shareCount // ignore: cast_nullable_to_non_nullable
as int?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: freezed == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ContentStats].
extension ContentStatsPatterns on ContentStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContentStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContentStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContentStats value)  $default,){
final _that = this;
switch (_that) {
case _ContentStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContentStats value)?  $default,){
final _that = this;
switch (_that) {
case _ContentStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? viewCount,  int? likeCount,  int? favoriteCount,  int? commentCount,  int? shareCount,  double? rating,  int? ratingCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContentStats() when $default != null:
return $default(_that.viewCount,_that.likeCount,_that.favoriteCount,_that.commentCount,_that.shareCount,_that.rating,_that.ratingCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? viewCount,  int? likeCount,  int? favoriteCount,  int? commentCount,  int? shareCount,  double? rating,  int? ratingCount)  $default,) {final _that = this;
switch (_that) {
case _ContentStats():
return $default(_that.viewCount,_that.likeCount,_that.favoriteCount,_that.commentCount,_that.shareCount,_that.rating,_that.ratingCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? viewCount,  int? likeCount,  int? favoriteCount,  int? commentCount,  int? shareCount,  double? rating,  int? ratingCount)?  $default,) {final _that = this;
switch (_that) {
case _ContentStats() when $default != null:
return $default(_that.viewCount,_that.likeCount,_that.favoriteCount,_that.commentCount,_that.shareCount,_that.rating,_that.ratingCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContentStats implements ContentStats {
  const _ContentStats({this.viewCount, this.likeCount, this.favoriteCount, this.commentCount, this.shareCount, this.rating, this.ratingCount});
  factory _ContentStats.fromJson(Map<String, dynamic> json) => _$ContentStatsFromJson(json);

/// 浏览/播放次数。
@override final  int? viewCount;
/// 点赞/支持数。
@override final  int? likeCount;
/// 收藏/书签数。
@override final  int? favoriteCount;
/// 评论数。
@override final  int? commentCount;
/// 分享/转发数。
@override final  int? shareCount;
/// 评分（通常为 0-10 或 0-5 分制）。
@override final  double? rating;
/// 收到的评分数。
@override final  int? ratingCount;

/// Create a copy of ContentStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContentStatsCopyWith<_ContentStats> get copyWith => __$ContentStatsCopyWithImpl<_ContentStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContentStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContentStats&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.likeCount, likeCount) || other.likeCount == likeCount)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.shareCount, shareCount) || other.shareCount == shareCount)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.ratingCount, ratingCount) || other.ratingCount == ratingCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,viewCount,likeCount,favoriteCount,commentCount,shareCount,rating,ratingCount);

@override
String toString() {
  return 'ContentStats(viewCount: $viewCount, likeCount: $likeCount, favoriteCount: $favoriteCount, commentCount: $commentCount, shareCount: $shareCount, rating: $rating, ratingCount: $ratingCount)';
}


}

/// @nodoc
abstract mixin class _$ContentStatsCopyWith<$Res> implements $ContentStatsCopyWith<$Res> {
  factory _$ContentStatsCopyWith(_ContentStats value, $Res Function(_ContentStats) _then) = __$ContentStatsCopyWithImpl;
@override @useResult
$Res call({
 int? viewCount, int? likeCount, int? favoriteCount, int? commentCount, int? shareCount, double? rating, int? ratingCount
});




}
/// @nodoc
class __$ContentStatsCopyWithImpl<$Res>
    implements _$ContentStatsCopyWith<$Res> {
  __$ContentStatsCopyWithImpl(this._self, this._then);

  final _ContentStats _self;
  final $Res Function(_ContentStats) _then;

/// Create a copy of ContentStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? viewCount = freezed,Object? likeCount = freezed,Object? favoriteCount = freezed,Object? commentCount = freezed,Object? shareCount = freezed,Object? rating = freezed,Object? ratingCount = freezed,}) {
  return _then(_ContentStats(
viewCount: freezed == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int?,likeCount: freezed == likeCount ? _self.likeCount : likeCount // ignore: cast_nullable_to_non_nullable
as int?,favoriteCount: freezed == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int?,commentCount: freezed == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int?,shareCount: freezed == shareCount ? _self.shareCount : shareCount // ignore: cast_nullable_to_non_nullable
as int?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,ratingCount: freezed == ratingCount ? _self.ratingCount : ratingCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
