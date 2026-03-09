import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:spectra/core/rust/rules_ir/'
    'normalized_model.dart';

void main() {
  test(
    'NormalizedModel json roundtrip preserves camelCase keys '
    'and defaults',
    () {
      const example = NormalizedModel(
        search: SearchModel(
          items: [
            SearchItem(
              title: '搜索标题',
              url: 'https://example.com/search/1',
              cover: 'https://example.com/search-cover.jpg',
              author: '作者甲',
            ),
          ],
        ),
        detail: DetailModel(
          title: '详情标题',
          cover: 'https://example.com/detail-cover.jpg',
          author: '作者乙',
          description: '详情描述',
          tags: ['连载', '精选'],
        ),
        toc: TocModel(
          chapters: [
            ChapterItem(
              title: '第一章',
              url: 'https://example.com/chapter-1',
            ),
          ],
        ),
        content: ContentModel(
          contentTextHtml: '<p>正文</p>',
          contentTextPlain: '正文',
          mediaAssets: [
            MediaAsset(
              url: 'https://example.com/video.mp4',
              title: '视频资源',
              cover: 'https://example.com/video-cover.jpg',
            ),
          ],
        ),
        media: MediaExtension(
          video: MediaSpec(extra: {'resolution': '1080p'}),
          music: MediaSpec(extra: {'bitrate': '320kbps'}),
          novel: MediaSpec(extra: {'wordCount': '1024'}),
          comic: MediaSpec(extra: {'pageCount': '12'}),
          image: MediaSpec(extra: {'format': 'png'}),
        ),
      );

      final encoded = jsonEncode(example.toJson());
      final decoded = NormalizedModel.fromJson(
        jsonDecode(encoded) as Map<String, dynamic>,
      );

      expect(decoded, equals(example));
      expect(encoded, contains('contentTextHtml'));
      expect(encoded, contains('contentTextPlain'));
      expect(encoded, contains('mediaAssets'));
      expect(encoded, contains('mediaType'));
    },
  );
}
