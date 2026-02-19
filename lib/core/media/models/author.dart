import 'package:freezed_annotation/freezed_annotation.dart';

part 'author.freezed.dart';
part 'author.g.dart';

/// Author information for media content.
///
/// Represents the creator or uploader of content.
@freezed
sealed class Author with _$Author {
  /// Creates an [Author] instance.
  const factory Author({
    /// Author display name (required).
    required String name,

    /// Author unique identifier (optional, platform-specific).
    String? id,

    /// Author avatar URL.
    String? avatar,

    /// Author description/bio.
    String? description,

    /// Number of followers.
    int? followerCount,
  }) = _Author;

  /// Creates an [Author] from JSON.
  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}
