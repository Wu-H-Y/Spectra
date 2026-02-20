import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/media/models/author.dart';
import 'package:spectra/core/media/models/content_source.dart';
import 'package:spectra/core/media/models/content_stats.dart';

part 'image_content.freezed.dart';
part 'image_content.g.dart';

/// 图片信息。
@freezed
sealed class ImageInfo with _$ImageInfo {
  const factory ImageInfo({
    /// 图片 URL。
    required String url,

    /// 缩略图/预览 URL。
    String? thumbnail,

    /// 图片宽度（像素）。
    int? width,

    /// 图片高度（像素）。
    int? height,

    /// 文件大小（字节）。
    int? fileSize,

    /// 图片格式（如 "jpg"、"png"、"webp"）。
    String? format,

    /// 替代文本/说明。
    String? caption,
  }) = _ImageInfo;

  factory ImageInfo.fromJson(Map<String, dynamic> json) =>
      _$ImageInfoFromJson(json);
}

/// 图片/相册内容模型。
@freezed
sealed class ImageContent with _$ImageContent {
  const factory ImageContent({
    /// 唯一标识符。
    required String id,

    /// 标题/说明。
    required String title,

    /// 来源信息。
    required ContentSource source,

    /// 图片列表（非相册为单张，相册为多张）。
    required List<ImageInfo> images,

    /// 是否为相册（多图）。
    required bool isAlbum,

    /// 封面/缩略图 URL。
    String? cover,

    /// 描述。
    String? description,

    /// 作者/摄影师信息。
    Author? author,

    /// 标签。
    List<String>? tags,

    /// 分类。
    String? category,

    /// 统计信息。
    ContentStats? stats,

    /// 上传日期。
    DateTime? createdAt,

    /// 更新日期。
    DateTime? updatedAt,

    /// 图片分辨率字符串（如 "1920x1080"）。
    String? resolution,

    /// 是否为 AI 生成内容。
    bool? isAIGenerated,

    /// AI 模型名称（如 "Stable Diffusion"、"Midjourney"）。
    String? aiModel,
  }) = _ImageContent;

  factory ImageContent.fromJson(Map<String, dynamic> json) =>
      _$ImageContentFromJson(json);
}
