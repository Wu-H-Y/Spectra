import 'package:flutter_test/flutter_test.dart';
import 'package:spectra/core/crawler/executor/transform_pipeline.dart';
import 'package:spectra/core/crawler/models/models.dart';

void main() {
  group('CrawlerRule', () {
    test('should create a valid rule from JSON', () {
      final json = {
        'id': 'test-rule',
        'name': 'Test Rule',
        'mediaType': 'video',
        'match': {
          'pattern': 'example.com/video',
          'type': 'regex',
        },
        'extract': {
          'detail': {
            'items': [
              {
                'field': 'title',
                'selector': {
                  'type': 'css',
                  'expression': 'h1.title',
                },
              },
            ],
          },
        },
      };

      final rule = CrawlerRule.fromJson(json);

      expect(rule.id, 'test-rule');
      expect(rule.name, 'Test Rule');
      expect(rule.mediaType, MediaType.video);
      expect(rule.match.pattern, 'example.com/video');
    });

    test('should create rule with glob pattern', () {
      const rule = CrawlerRule(
        id: 'test',
        name: 'Test',
        mediaType: MediaType.video,
        match: MatchConfig(
          pattern: '*/video/*',
          type: MatchPatternType.glob,
        ),
        extract: ExtractConfig(),
      );

      expect(rule.match.type, MatchPatternType.glob);
    });
  });

  group('Selector', () {
    test('should create CSS selector', () {
      const selector = Selector(
        type: SelectorType.css,
        expression: '.video-title',
      );

      expect(selector.type, SelectorType.css);
      expect(selector.expression, '.video-title');
    });

    test('should create XPath selector', () {
      const selector = Selector(
        type: SelectorType.xpath,
        expression: '//div[@class="title"]',
      );

      expect(selector.type, SelectorType.xpath);
      expect(selector.expression, '//div[@class="title"]');
    });

    test('should support fallback selectors', () {
      const selector = Selector(
        type: SelectorType.css,
        expression: '.title',
        fallbacks: [
          Selector(type: SelectorType.css, expression: 'h1'),
          Selector(type: SelectorType.xpath, expression: '//h1'),
        ],
      );

      expect(selector.fallbacks, hasLength(2));
    });
  });

  group('FieldMapping', () {
    test('should create field mapping with transforms', () {
      const mapping = FieldMapping(
        field: 'viewCount',
        selector: Selector(
          type: SelectorType.css,
          expression: '.views',
        ),
        transforms: [
          Transform(type: TransformType.number),
        ],
      );

      expect(mapping.field, 'viewCount');
      expect(mapping.transforms, hasLength(1));
    });
  });

  group('PaginationConfig', () {
    test('should create URL pagination', () {
      const pagination = PaginationConfig(
        type: PaginationType.url,
        urlTemplate: '/page/{page}',
        maxPages: 10,
      );

      expect(pagination.type, PaginationType.url);
      expect(pagination.maxPages, 10);
    });

    test('should create click pagination', () {
      const pagination = PaginationConfig(
        type: PaginationType.click,
        clickSelector: Selector(
          type: SelectorType.css,
          expression: '.next-page',
        ),
        maxPages: 5,
      );

      expect(pagination.type, PaginationType.click);
    });

    test('should create infinite scroll pagination', () {
      const pagination = PaginationConfig(
        type: PaginationType.infiniteScroll,
        scrollContainer: Selector(
          type: SelectorType.css,
          expression: '.content',
        ),
      );

      expect(pagination.type, PaginationType.infiniteScroll);
      expect(pagination.waitAfterLoadMs, 2000);
    });
  });

  group('Action', () {
    test('should create wait action', () {
      const action = CrawlerAction(
        type: ActionType.wait,
        params: {'durationMs': 1000},
      );

      expect(action.type, ActionType.wait);
      expect(action.params['durationMs'], 1000);
    });

    test('should create click action', () {
      const action = CrawlerAction(
        type: ActionType.click,
        params: {
          'selector': '.button',
          'selectorType': 'css',
        },
      );

      expect(action.type, ActionType.click);
    });

    test('should create scroll action', () {
      const action = CrawlerAction(
        type: ActionType.scroll,
        params: {
          'direction': 'down',
          'distance': 500,
        },
      );

      expect(action.type, ActionType.scroll);
    });

    test('should create condition action', () {
      const action = CrawlerAction(
        type: ActionType.condition,
        params: {
          'condition': {
            'type': 'exists',
            'selector': '.captcha',
          },
          'thenActions': [
            {
              'type': 'wait',
              'params': {'durationMs': 5000},
            },
          ],
        },
      );

      expect(action.type, ActionType.condition);
    });

    test('should create loop action', () {
      const action = CrawlerAction(
        type: ActionType.loop,
        params: {
          'maxIterations': 10,
          'actions': [
            {
              'type': 'scroll',
              'params': {'direction': 'down'},
            },
          ],
        },
      );

      expect(action.type, ActionType.loop);
    });
  });

  group('DetectionConfig', () {
    test('should create captcha detection config', () {
      const config = DetectionConfig(
        captcha: CaptchaDetection(),
      );

      expect(config.captcha?.detectRecaptcha, isTrue);
      expect(config.captcha?.detectHcaptcha, isTrue);
    });

    test('should create rate limit detection config', () {
      const config = DetectionConfig(
        rateLimit: RateLimitDetection(
          statusCodes: [429, 503],
        ),
      );

      expect(config.rateLimit?.statusCodes, contains(429));
    });
  });

  group('TransformPipeline', () {
    final pipeline = TransformPipeline();

    test('should apply trim transform', () {
      final result = pipeline.apply(
        '  hello world  ',
        [const Transform(type: TransformType.trim)],
      );
      expect(result, 'hello world');
    });

    test('should apply regex transform', () {
      final result = pipeline.apply(
        'views: 12345',
        [
          const Transform(
            type: TransformType.regex,
            params: r'\d+',
          ),
        ],
      );
      expect(result, '12345');
    });

    test('should chain multiple transforms', () {
      final result = pipeline.apply(
        '  hello-world  ',
        [
          const Transform(type: TransformType.trim),
          const Transform(
            type: TransformType.replace,
            params: {'find': '-', 'replace': ''},
          ),
        ],
      );
      expect(result, 'helloworld');
    });

    test('should parse number', () {
      final result = pipeline.apply(
        'views: 1,234,567',
        [const Transform(type: TransformType.number)],
      );
      expect(result, '1234567');
    });

    test('should convert to lowercase', () {
      final result = pipeline.apply(
        'HELLO WORLD',
        [const Transform(type: TransformType.lowercase)],
      );
      expect(result, 'hello world');
    });

    test('should convert to uppercase', () {
      final result = pipeline.apply(
        'hello world',
        [const Transform(type: TransformType.uppercase)],
      );
      expect(result, 'HELLO WORLD');
    });

    test('should format large numbers', () {
      final result = pipeline.apply(
        '1500000',
        [const Transform(type: TransformType.formatNumber)],
      );
      expect(result, '1.5M');
    });

    test('should format thousands', () {
      final result = pipeline.apply(
        '15000',
        [const Transform(type: TransformType.formatNumber)],
      );
      expect(result, '15.0K');
    });
  });
}
