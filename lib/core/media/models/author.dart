import 'package:freezed_annotation/freezed_annotation.dart';

part 'author.freezed.dart';
part 'author.g.dart';

/// 媒体内容的作者信息。
///
/// 表示内容的创建者或上传者。
@freezed
sealed class Author with _$Author {
  /// 创建 [Author] 实例。
  const factory Author({
    /// 作者显示名称（必需）。
    required String name,

    /// 作者唯一标识符（可选，平台特定）。
    String? id,

    /// 作者头像 URL。
    String? avatar,

    /// 作者描述/简介。
    String? description,

    /// 粉丝数量。
    int? followerCount,
  }) = _Author;

  /// 从 JSON 创建 [Author]。
  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);
}
