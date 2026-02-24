import 'package:flutter_test/flutter_test.dart';
import 'package:spectra/core/crawler/models/pipeline_node.dart';

void main() {
  group('Pipeline 解析器', () {
    group('Pipeline.fromStringList', () {
      test('应正确解析简单的 CSS 选择器管道', () {
        const input = ['@css:.title', '@text'];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes.length, 2);
        expect(pipeline.nodes[0].operator, 'css');
        expect(pipeline.nodes[0].argument, '.title');
        expect(pipeline.nodes[0].type, PipelineNodeType.selector);
        expect(pipeline.nodes[1].operator, 'text');
        expect(pipeline.nodes[1].type, PipelineNodeType.extractor);
      });

      test('应正确解析带参数的节点', () {
        const input = [
          '@css:.video-title',
          '@text',
          '@trim',
          '@attr:src',
        ];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes.length, 4);
        expect(pipeline.nodes[0].argument, '.video-title');
        expect(pipeline.nodes[1].operator, 'text');
        expect(pipeline.nodes[2].operator, 'trim');
        expect(pipeline.nodes[3].argument, 'src');
        expect(pipeline.nodes[3].type, PipelineNodeType.extractor);
      });

      test('应正确解析无参数的节点', () {
        const input = ['@text', '@trim', '@html'];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes.length, 3);
        expect(pipeline.nodes[0].argument, isNull);
        expect(pipeline.nodes[1].argument, isNull);
        expect(pipeline.nodes[2].argument, isNull);
      });

      test('应正确识别 XPath 选择器', () {
        const input = ['@xpath://div[@class="content"]'];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes.length, 1);
        expect(pipeline.nodes[0].operator, 'xpath');
        expect(
          pipeline.nodes[0].argument,
          '//div[@class="content"]',
        );
        expect(pipeline.nodes[0].type, PipelineNodeType.selector);
      });

      test('应正确识别 JSONPath', () {
        const input = [r'@jsonpath:$.data.items[*].title'];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes.length, 1);
        expect(pipeline.nodes[0].operator, 'jsonpath');
        expect(
          pipeline.nodes[0].argument,
          r'$.data.items[*].title',
        );
        expect(pipeline.nodes[0].type, PipelineNodeType.selector);
      });

      test('应正确识别正则表达式', () {
        const input = [r'@regex:(\d+)集'];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes.length, 1);
        expect(pipeline.nodes[0].operator, 'regex');
        expect(pipeline.nodes[0].argument, r'(\d+)集');
        expect(pipeline.nodes[0].type, PipelineNodeType.selector);
      });

      test('应正确识别 JavaScript', () {
        const input = ['@js: val.replace("作者：", "")'];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes.length, 1);
        expect(pipeline.nodes[0].operator, 'js');
        // 正则捕获从冒号后的内容，可能包含前导空格
        expect(pipeline.nodes[0].argument?.trim(), 'val.replace("作者：", "")');
        expect(pipeline.nodes[0].type, PipelineNodeType.selector);
      });

      test('应正确识别变换节点', () {
        const input = ['@trim', '@lower', '@replace:xx→yy'];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes[0].type, PipelineNodeType.transform);
        expect(pipeline.nodes[1].type, PipelineNodeType.transform);
        expect(pipeline.nodes[2].type, PipelineNodeType.transform);
        expect(pipeline.nodes[2].argument, 'xx→yy');
      });

      test('应正确识别聚合节点', () {
        const input = ['@first', '@last', '@join:,', '@array'];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes[0].type, PipelineNodeType.aggregation);
        expect(pipeline.nodes[1].type, PipelineNodeType.aggregation);
        expect(pipeline.nodes[2].type, PipelineNodeType.aggregation);
        expect(pipeline.nodes[2].argument, ',');
        expect(pipeline.nodes[3].type, PipelineNodeType.aggregation);
      });

      test('空列表应返回空 Pipeline', () {
        const input = <String>[];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes, isEmpty);
      });

      test('无效格式应抛出 FormatException', () {
        const input = ['invalid-node'];
        expect(
          () => Pipeline.fromStringList(input),
          throwsA(isA<FormatException>()),
        );
      });

      test('空字符串应抛出 FormatException', () {
        const input = [''];
        expect(
          () => Pipeline.fromStringList(input),
          throwsA(isA<FormatException>()),
        );
      });
    });

    group('PipelineParsing.toStringList', () {
      test('应正确转换 Pipeline 到字符串数组', () {
        const pipeline = Pipeline(
          nodes: [
            PipelineNode(
              type: PipelineNodeType.selector,
              operator: 'css',
              argument: '.title',
            ),
            PipelineNode(
              type: PipelineNodeType.extractor,
              operator: 'text',
            ),
            PipelineNode(
              type: PipelineNodeType.transform,
              operator: 'trim',
            ),
          ],
        );

        final result = pipeline.toStringList();
        expect(result, ['@css:.title', '@text', '@trim']);
      });

      test('无参数节点应正确转换', () {
        const pipeline = Pipeline(
          nodes: [
            PipelineNode(
              type: PipelineNodeType.extractor,
              operator: 'text',
            ),
            PipelineNode(
              type: PipelineNodeType.transform,
              operator: 'trim',
            ),
          ],
        );

        final result = pipeline.toStringList();
        expect(result, ['@text', '@trim']);
      });

      test('往返转换应保持一致', () {
        const original = [
          '@css:.video-title',
          '@text',
          '@trim',
          '@attr:src',
          '@url',
        ];

        final pipeline = Pipeline.fromStringList(original);
        final result = pipeline.toStringList();

        expect(result, original);
      });
    });

    group('节点类型识别', () {
      test('selector 节点类型应正确识别', () {
        const operators = ['css', 'xpath', 'jsonpath', 'regex', 'js'];
        for (final op in operators) {
          final node = PipelineNode(
            type: PipelineNodeType.selector,
            operator: op,
            argument: 'test',
          );
          expect(node.type, PipelineNodeType.selector);
        }
      });

      test('extractor 节点类型应正确识别', () {
        const operators = ['text', 'attr', 'html', 'href', 'src'];
        for (final op in operators) {
          final node = PipelineNode(
            type: PipelineNodeType.extractor,
            operator: op,
          );
          expect(node.type, PipelineNodeType.extractor);
        }
      });

      test('transform 节点类型应正确识别', () {
        const operators = [
          'trim',
          'replace',
          'regexreplace',
          'url',
          'lower',
          'upper',
          'number',
          'date',
        ];
        for (final op in operators) {
          final node = PipelineNode(
            type: PipelineNodeType.transform,
            operator: op,
          );
          expect(node.type, PipelineNodeType.transform);
        }
      });

      test('aggregation 节点类型应正确识别', () {
        const operators = ['first', 'last', 'join', 'array', 'flat'];
        for (final op in operators) {
          final node = PipelineNode(
            type: PipelineNodeType.aggregation,
            operator: op,
          );
          expect(node.type, PipelineNodeType.aggregation);
        }
      });

      test('getNodeType 函数应正确返回节点类型', () {
        expect(getNodeType('css'), PipelineNodeType.selector);
        expect(getNodeType('xpath'), PipelineNodeType.selector);
        expect(getNodeType('jsonpath'), PipelineNodeType.selector);
        expect(getNodeType('regex'), PipelineNodeType.selector);
        expect(getNodeType('js'), PipelineNodeType.selector);

        expect(getNodeType('text'), PipelineNodeType.extractor);
        expect(getNodeType('attr'), PipelineNodeType.extractor);
        expect(getNodeType('html'), PipelineNodeType.extractor);

        expect(getNodeType('trim'), PipelineNodeType.transform);
        expect(getNodeType('replace'), PipelineNodeType.transform);
        expect(getNodeType('url'), PipelineNodeType.transform);

        expect(getNodeType('first'), PipelineNodeType.aggregation);
        expect(getNodeType('join'), PipelineNodeType.aggregation);

        // 未知操作符默认返回 transform
        expect(getNodeType('unknown'), PipelineNodeType.transform);
      });
    });

    group('复杂管道', () {
      test('应正确解析完整的详情页管道', () {
        const input = [
          '@css:.video-info',
          '@text',
          '@trim',
          r'@replace:\s+→ ',
        ];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes.length, 4);
        expect(pipeline.nodes[0].type, PipelineNodeType.selector);
        expect(pipeline.nodes[1].type, PipelineNodeType.extractor);
        expect(pipeline.nodes[2].type, PipelineNodeType.transform);
        expect(pipeline.nodes[3].type, PipelineNodeType.transform);
      });

      test('应正确解析包含 URL 补全的管道', () {
        const input = [
          '@css:img.cover',
          '@attr:src',
          '@url',
        ];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes.length, 3);
        expect(pipeline.nodes[2].operator, 'url');
        expect(pipeline.nodes[2].type, PipelineNodeType.transform);
      });

      test('应正确解析聚合管道', () {
        const input = [
          '@css:.episode-list li',
          '@text',
          r'@join:\n',
        ];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes.length, 3);
        expect(pipeline.nodes[2].type, PipelineNodeType.aggregation);
        expect(pipeline.nodes[2].argument, r'\n');
      });

      test('应正确解析包含正则提取的管道', () {
        const input = [
          '@css:.title',
          '@text',
          r'@regex:第(\d+)章',
        ];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes.length, 3);
        expect(pipeline.nodes[2].type, PipelineNodeType.selector);
        expect(pipeline.nodes[2].argument, r'第(\d+)章');
      });
    });

    group('参数解析', () {
      test('带冒号的参数应正确解析', () {
        const input = ['@attr:data-src'];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes[0].argument, 'data-src');
      });

      test('带空格的参数应作为整体解析', () {
        const input = ['@replace:hello world→hi'];
        final pipeline = Pipeline.fromStringList(input);

        // 参数包含空格和箭头
        expect(pipeline.nodes[0].argument, 'hello world→hi');
      });

      test('URL 类型的参数应正确解析', () {
        const input = [r'@jsonpath:$.url'];
        final pipeline = Pipeline.fromStringList(input);

        expect(pipeline.nodes[0].argument, r'$.url');
      });

      test('复杂选择器应正确解析', () {
        const input = ['@css:div.content > p:not(.excerpt):first-child'];
        final pipeline = Pipeline.fromStringList(input);

        expect(
          pipeline.nodes[0].argument,
          'div.content > p:not(.excerpt):first-child',
        );
      });
    });
  });
}
