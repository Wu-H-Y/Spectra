import 'dart:async';
import 'dart:math';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
import 'package:spectra/core/crawler/models/action.dart';
import 'package:spectra/core/crawler/models/detection_config.dart';
import 'package:spectra/core/crawler/models/selector.dart';
import 'package:spectra/core/crawler/models/selector_type.dart';
import 'package:spectra/core/crawler/selector/selector_engine.dart';
import 'package:talker/talker.dart';

/// 动作执行结果。
class ActionResult {
  /// 创建动作执行结果。
  const ActionResult({
    required this.isSuccess,
    this.error,
    this.data,
  });

  /// 创建成功结果。
  const ActionResult.ok([this.data]) : isSuccess = true, error = null;

  /// 创建失败结果。
  const ActionResult.fail(this.error) : isSuccess = false, data = null;

  /// 执行是否成功。
  final bool isSuccess;

  /// 错误信息（如果失败）。
  final String? error;

  /// 额外数据。
  final Map<String, dynamic>? data;

  /// 执行是否成功（兼容旧代码）。
  bool get success => isSuccess;
}

/// 页面上下文（动作执行时的环境）。
class PageContext {
  /// 创建页面上下文。
  const PageContext({
    required this.html,
    required this.url,
    this.headers = const {},
    this.cookies = const {},
    this.executeJs,
    this.clickElement,
    this.fillElement,
    this.scrollTo,
    this.waitForSelector,
    this.waitForTimeout,
  });

  /// 当前页面 HTML 内容。
  final String html;

  /// 当前页面 URL。
  final String url;

  /// 请求头。
  final Map<String, String> headers;

  /// Cookies。
  final Map<String, String> cookies;

  /// 执行 JavaScript 的回调。
  final Future<String?> Function(String code)? executeJs;

  /// 点击元素的回调。
  final Future<bool> Function(String selector)? clickElement;

  /// 填充表单的回调。
  final Future<bool> Function(String selector, String value)? fillElement;

  /// 滚动页面的回调。
  final Future<void> Function(ScrollDirection direction, int distance)?
  scrollTo;

  /// 等待选择器的回调。
  final Future<bool> Function(String selector, int timeout)? waitForSelector;

  /// 等待超时的回调。
  final Future<void> Function(int milliseconds)? waitForTimeout;
}

/// 动作执行器。
///
/// 执行页面交互动作（等待、点击、滚动、填充、脚本）。
class ActionExecutor {
  /// 创建动作执行器。
  ActionExecutor({
    SelectorEngine? selectorEngine,
    Talker? logger,
  }) : _selectorEngine = selectorEngine ?? SelectorEngine(),
       _logger = logger;

  final SelectorEngine _selectorEngine;
  final Talker? _logger;

  /// 执行单个动作。
  ///
  /// [action] - 要执行的动作。
  /// [context] - 页面上下文。
  ///
  /// 返回执行结果。
  Future<ActionResult> execute(
    CrawlerAction action,
    PageContext context,
  ) async {
    _logger?.info('执行动作: ${action.type}');

    switch (action.type) {
      case ActionType.wait:
        return _executeWait(action, context);
      case ActionType.click:
        return _executeClick(action, context);
      case ActionType.scroll:
        return _executeScroll(action, context);
      case ActionType.fill:
        return _executeFill(action, context);
      case ActionType.script:
        return _executeScript(action, context);
      case ActionType.condition:
      case ActionType.loop:
        return const ActionResult.fail('请使用 ConditionEvaluator 或 LoopExecutor');
    }
  }

  /// 执行动作序列。
  ///
  /// [actions] - 动作列表。
  /// [context] - 页面上下文。
  ///
  /// 返回所有执行结果。
  Future<List<ActionResult>> executeAll(
    List<CrawlerAction> actions,
    PageContext context,
  ) async {
    final results = <ActionResult>[];

    for (final action in actions) {
      final result = await execute(action, context);
      results.add(result);

      // 如果动作失败且是必需的，停止执行
      if (!result.success) {
        _logger?.warning('动作执行失败: ${result.error}');
        break;
      }
    }

    return results;
  }

  Future<ActionResult> _executeWait(
    CrawlerAction action,
    PageContext context,
  ) async {
    final params = action.params;
    final waitAction = WaitAction(
      selector: params['selector'] as String?,
      timeout: params['timeout'] as int? ?? 5000,
    );

    if (waitAction.selector != null) {
      // 等待选择器出现
      if (context.waitForSelector != null) {
        final success = await context.waitForSelector!(
          waitAction.selector!,
          waitAction.timeout,
        );
        if (success) {
          return const ActionResult.ok();
        }
        return ActionResult.fail('等待选择器超时: ${waitAction.selector}');
      }

      // 如果没有回调，尝试在 HTML 中查找元素
      final result = _selectorEngine.evaluate(
        context.html,
        Selector(
          type: SelectorType.css,
          expression: waitAction.selector!,
        ),
      );

      if (result.success) {
        return const ActionResult.ok();
      }
      return ActionResult.fail('未找到选择器: ${waitAction.selector}');
    } else {
      // 等待固定时间
      if (context.waitForTimeout != null) {
        await context.waitForTimeout!(waitAction.timeout);
      } else {
        await Future<void>.delayed(
          Duration(milliseconds: waitAction.timeout),
        );
      }
      return const ActionResult.ok();
    }
  }

  Future<ActionResult> _executeClick(
    CrawlerAction action,
    PageContext context,
  ) async {
    final params = action.params;
    final clickAction = ClickAction(
      selector: params['selector'] as String,
      scrollIntoView: params['scrollIntoView'] as bool? ?? true,
    );

    // 首先检查元素是否存在
    final result = _selectorEngine.evaluate(
      context.html,
      Selector(
        type: SelectorType.css,
        expression: clickAction.selector,
      ),
    );

    if (!result.success) {
      return ActionResult.fail('未找到可点击的元素: ${clickAction.selector}');
    }

    // 执行点击
    if (context.clickElement != null) {
      final success = await context.clickElement!(clickAction.selector);
      if (success) {
        return const ActionResult.ok();
      }
      return ActionResult.fail('点击元素失败: ${clickAction.selector}');
    }

    _logger?.warning('点击回调未设置，模拟点击');
    return const ActionResult.ok();
  }

  Future<ActionResult> _executeScroll(
    CrawlerAction action,
    PageContext context,
  ) async {
    final params = action.params;
    final directionStr = params['direction'] as String? ?? 'down';
    final direction = switch (directionStr) {
      'up' => ScrollDirection.up,
      'left' => ScrollDirection.left,
      'right' => ScrollDirection.right,
      _ => ScrollDirection.down,
    };

    final scrollAction = ScrollAction(
      direction: direction,
      distance: params['distance'] as int? ?? 0,
      smooth: params['smooth'] as bool? ?? true,
    );

    if (context.scrollTo != null) {
      await context.scrollTo!(scrollAction.direction, scrollAction.distance);
    } else {
      _logger?.warning('滚动回调未设置，跳过滚动');
    }

    // 滚动后等待一小段时间让内容加载
    await Future<void>.delayed(const Duration(milliseconds: 500));

    return const ActionResult.ok();
  }

  Future<ActionResult> _executeFill(
    CrawlerAction action,
    PageContext context,
  ) async {
    final params = action.params;
    final fillAction = FillAction(
      selector: params['selector'] as String,
      value: params['value'] as String,
      simulateTyping: params['simulateTyping'] as bool? ?? false,
    );

    // 检查元素是否存在
    final result = _selectorEngine.evaluate(
      context.html,
      Selector(
        type: SelectorType.css,
        expression: fillAction.selector,
      ),
    );

    if (!result.success) {
      return ActionResult.fail('未找到表单字段: ${fillAction.selector}');
    }

    // 执行填充
    if (context.fillElement != null) {
      final success = await context.fillElement!(
        fillAction.selector,
        fillAction.value,
      );
      if (success) {
        return const ActionResult.ok();
      }
      return ActionResult.fail('填充表单失败: ${fillAction.selector}');
    }

    _logger?.warning('填充回调未设置，模拟填充');
    return const ActionResult.ok();
  }

  Future<ActionResult> _executeScript(
    CrawlerAction action,
    PageContext context,
  ) async {
    final params = action.params;
    final scriptAction = ScriptAction(
      code: params['code'] as String,
      awaitCompletion: params['awaitCompletion'] as bool? ?? true,
    );

    if (context.executeJs != null) {
      final result = await context.executeJs!(scriptAction.code);
      return ActionResult.ok({'result': result});
    }

    // 使用选择器引擎的 JS 评估
    final jsSelector = Selector(
      type: SelectorType.js,
      expression: scriptAction.code,
    );

    final result = _selectorEngine.evaluate(context.html, jsSelector);
    if (result.success) {
      return ActionResult.ok({'values': result.values});
    }
    return ActionResult.fail('脚本执行失败: ${result.error}');
  }
}

/// 条件评估器。
///
/// 评估条件并执行相应的动作。
class ConditionEvaluator {
  /// 创建条件评估器。
  ConditionEvaluator({
    ActionExecutor? actionExecutor,
    Talker? logger,
  }) : _actionExecutor = actionExecutor ?? ActionExecutor(),
       _logger = logger;

  final ActionExecutor _actionExecutor;
  final Talker? _logger;

  /// 评估条件动作。
  ///
  /// [action] - 条件动作。
  /// [context] - 页面上下文。
  ///
  /// 返回执行结果。
  Future<ActionResult> evaluate(
    ConditionAction action,
    PageContext context,
  ) async {
    _logger?.info('评估条件: ${action.check}');

    final conditionMet = await _checkCondition(action.check, context);

    if (conditionMet) {
      _logger?.info('条件为真，执行 then 动作');
      final results = await _actionExecutor.executeAll(
        action.thenActions,
        context,
      );
      final allSuccess = results.every((r) => r.success);
      if (allSuccess) {
        return ActionResult.ok({'branch': 'then', 'results': results});
      }
      return const ActionResult.fail('then 动作执行失败');
    } else {
      _logger?.info('条件为假');
      if (action.elseActions != null && action.elseActions!.isNotEmpty) {
        _logger?.info('执行 else 动作');
        final results = await _actionExecutor.executeAll(
          action.elseActions!,
          context,
        );
        final allSuccess = results.every((r) => r.success);
        if (allSuccess) {
          return ActionResult.ok({'branch': 'else', 'results': results});
        }
        return const ActionResult.fail('else 动作执行失败');
      }
      return const ActionResult.ok({'branch': 'none'});
    }
  }

  Future<bool> _checkCondition(String check, PageContext context) async {
    // 尝试作为选择器检查
    final selectorResult = Selector(
      type: SelectorType.css,
      expression: check,
    );

    final selectorEval = SelectorEngine().evaluate(
      context.html,
      selectorResult,
    );
    if (selectorEval.success && selectorEval.values.isNotEmpty) {
      return true;
    }

    // 尝试作为 XPath 检查
    final xpathResult = Selector(
      type: SelectorType.xpath,
      expression: check,
    );

    final xpathEval = SelectorEngine().evaluate(context.html, xpathResult);
    if (xpathEval.success && xpathEval.values.isNotEmpty) {
      return true;
    }

    // 尝试作为 JavaScript 表达式
    if (context.executeJs != null) {
      try {
        final jsResult = await context.executeJs!(
          'Boolean($check).toString()',
        );
        return jsResult?.toLowerCase() == 'true';
      } on Exception catch (_) {
        // 忽略错误
      }
    }

    return false;
  }
}

/// 循环执行器。
///
/// 执行重复的动作序列。
class LoopExecutor {
  /// 创建循环执行器。
  LoopExecutor({
    ActionExecutor? actionExecutor,
    Talker? logger,
  }) : _actionExecutor = actionExecutor ?? ActionExecutor(),
       _logger = logger;

  final ActionExecutor _actionExecutor;
  final Talker? _logger;

  /// 执行循环动作。
  ///
  /// [action] - 循环动作。
  /// [context] - 页面上下文。
  ///
  /// 返回执行结果。
  Future<ActionResult> execute(
    LoopAction action,
    PageContext context,
  ) async {
    _logger?.info('开始循环，次数: ${action.count}');

    final allResults = <List<ActionResult>>[];
    var successCount = 0;

    for (var i = 0; i < action.count; i++) {
      _logger?.info('循环迭代 ${i + 1}/${action.count}');

      final results = await _actionExecutor.executeAll(
        action.actions,
        context,
      );

      allResults.add(results);

      if (results.every((r) => r.success)) {
        successCount++;
      } else {
        _logger?.warning('迭代 ${i + 1} 失败');
      }

      // 在迭代之间添加延迟（除了最后一次）
      if (i < action.count - 1 && action.delayMs > 0) {
        await Future<void>.delayed(
          Duration(milliseconds: action.delayMs),
        );
      }
    }

    _logger?.info(
      '循环完成: $successCount/${action.count} 成功',
    );

    return ActionResult.ok({
      'totalIterations': action.count,
      'successCount': successCount,
      'allResults': allResults,
    });
  }
}

/// 检测到的验证码类型。
enum CaptchaType {
  /// reCAPTCHA v2/v3。
  recaptcha,

  /// hCaptcha。
  hcaptcha,

  /// 通用图片验证码。
  generic,

  /// Cloudflare Turnstile。
  turnstile,
}

/// 验证码检测结果。
class CaptchaDetectionResult {
  /// 创建验证码检测结果。
  const CaptchaDetectionResult({
    required this.detected,
    this.type,
    this.siteKey,
    this.selector,
  });

  /// 检测到验证码。
  const CaptchaDetectionResult.found({
    required this.type,
    this.siteKey,
    this.selector,
  }) : detected = true;

  /// 是否检测到验证码。
  final bool detected;

  /// 验证码类型。
  final CaptchaType? type;

  /// 站点密钥（用于第三方服务）。
  final String? siteKey;

  /// 验证码元素选择器。
  final String? selector;

  /// 未检测到验证码。
  static const CaptchaDetectionResult none = CaptchaDetectionResult(
    detected: false,
  );
}

/// 验证码检测器。
///
/// 检测页面中的验证码（reCAPTCHA、hCaptcha 等）。
class CaptchaDetector {
  /// 创建验证码检测器。
  CaptchaDetector({
    CaptchaDetection? config,
    Talker? logger,
  }) : _config = config ?? const CaptchaDetection(),
       _logger = logger;

  final CaptchaDetection _config;
  final Talker? _logger;

  /// 在 HTML 中检测验证码。
  ///
  /// [html] - 页面 HTML 内容。
  ///
  /// 返回检测结果。
  CaptchaDetectionResult detect(String html) {
    final document = html_parser.parse(html);

    // 检测 reCAPTCHA
    if (_config.detectRecaptcha) {
      final recaptchaResult = _detectRecaptcha(document);
      if (recaptchaResult.detected) {
        _logger?.info('检测到 reCAPTCHA');
        return recaptchaResult;
      }
    }

    // 检测 hCaptcha
    if (_config.detectHcaptcha) {
      final hcaptchaResult = _detectHcaptcha(document);
      if (hcaptchaResult.detected) {
        _logger?.info('检测到 hCaptcha');
        return hcaptchaResult;
      }
    }

    // 检测 Cloudflare Turnstile
    final turnstileResult = _detectTurnstile(document);
    if (turnstileResult.detected) {
      _logger?.info('检测到 Cloudflare Turnstile');
      return turnstileResult;
    }

    // 检测通用图片验证码
    if (_config.detectGeneric) {
      final genericResult = _detectGenericCaptcha(document);
      if (genericResult.detected) {
        _logger?.info('检测到通用验证码');
        return genericResult;
      }
    }

    return CaptchaDetectionResult.none;
  }

  CaptchaDetectionResult _detectRecaptcha(dom.Document document) {
    // 查找 reCAPTCHA 元素
    final gRecaptcha = document.querySelectorAll('.g-recaptcha');
    if (gRecaptcha.isNotEmpty) {
      final siteKey = gRecaptcha.first.attributes['data-sitekey'];
      return CaptchaDetectionResult.found(
        type: CaptchaType.recaptcha,
        siteKey: siteKey,
        selector: '.g-recaptcha',
      );
    }

    // 查找 reCAPTCHA v3
    final gRecaptchaResponse = document.querySelectorAll(
      '[name="g-recaptcha-response"]',
    );
    if (gRecaptchaResponse.isNotEmpty) {
      return const CaptchaDetectionResult.found(
        type: CaptchaType.recaptcha,
        selector: '[name="g-recaptcha-response"]',
      );
    }

    // 查找 reCAPTCHA 脚本
    final scripts = document.querySelectorAll('script');
    for (final script in scripts) {
      final src = script.attributes['src'] ?? '';
      if (src.contains('google.com/recaptcha') ||
          src.contains('recaptcha.net')) {
        return const CaptchaDetectionResult.found(
          type: CaptchaType.recaptcha,
        );
      }
    }

    return CaptchaDetectionResult.none;
  }

  CaptchaDetectionResult _detectHcaptcha(dom.Document document) {
    // 查找 hCaptcha 元素
    final hCaptcha = document.querySelectorAll('.h-captcha');
    if (hCaptcha.isNotEmpty) {
      final siteKey = hCaptcha.first.attributes['data-sitekey'];
      return CaptchaDetectionResult.found(
        type: CaptchaType.hcaptcha,
        siteKey: siteKey,
        selector: '.h-captcha',
      );
    }

    // 查找 hCaptcha 脚本
    final scripts = document.querySelectorAll('script');
    for (final script in scripts) {
      final src = script.attributes['src'] ?? '';
      if (src.contains('hcaptcha.com')) {
        return const CaptchaDetectionResult.found(
          type: CaptchaType.hcaptcha,
        );
      }
    }

    return CaptchaDetectionResult.none;
  }

  CaptchaDetectionResult _detectTurnstile(dom.Document document) {
    // 查找 Cloudflare Turnstile 元素
    final turnstile = document.querySelectorAll('.cf-turnstile');
    if (turnstile.isNotEmpty) {
      final siteKey = turnstile.first.attributes['data-sitekey'];
      return CaptchaDetectionResult.found(
        type: CaptchaType.turnstile,
        siteKey: siteKey,
        selector: '.cf-turnstile',
      );
    }

    // 查找 Turnstile 脚本
    final scripts = document.querySelectorAll('script');
    for (final script in scripts) {
      final src = script.attributes['src'] ?? '';
      if (src.contains('challenges.cloudflare.com')) {
        return const CaptchaDetectionResult.found(
          type: CaptchaType.turnstile,
        );
      }
    }

    return CaptchaDetectionResult.none;
  }

  CaptchaDetectionResult _detectGenericCaptcha(dom.Document document) {
    // 查找常见的验证码图片元素
    final captchaImg = document.querySelectorAll('img[src*="captcha"]');
    if (captchaImg.isNotEmpty) {
      return const CaptchaDetectionResult.found(
        type: CaptchaType.generic,
        selector: 'img[src*="captcha"]',
      );
    }

    // 查找验证码输入框
    final captchaInput = document.querySelectorAll(
      'input[name*="captcha"], input[id*="captcha"]',
    );
    if (captchaInput.isNotEmpty) {
      return const CaptchaDetectionResult.found(
        type: CaptchaType.generic,
        selector: 'input[name*="captcha"]',
      );
    }

    return CaptchaDetectionResult.none;
  }
}

/// 频率限制检测结果。
class RateLimitResult {
  /// 创建频率限制检测结果。
  const RateLimitResult({
    required this.isRateLimited,
    this.statusCode,
    this.retryAfter,
    this.reason,
  });

  /// 被限制。
  const RateLimitResult.limited({
    this.statusCode,
    this.retryAfter,
    this.reason,
  }) : isRateLimited = true;

  /// 是否被频率限制。
  final bool isRateLimited;

  /// HTTP 状态码。
  final int? statusCode;

  /// 建议等待时间（秒）。
  final int? retryAfter;

  /// 原因描述。
  final String? reason;

  /// 未被限制。
  static const RateLimitResult notLimited = RateLimitResult(
    isRateLimited: false,
  );
}

/// 频率限制检测器。
///
/// 检测 HTTP 响应是否表示频率限制。
class RateLimitDetector {
  /// 创建频率限制检测器。
  RateLimitDetector({
    RateLimitDetection? config,
    Talker? logger,
  }) : _config = config ?? const RateLimitDetection(),
       _logger = logger;

  final RateLimitDetection _config;
  final Talker? _logger;

  /// 检测响应是否被频率限制。
  ///
  /// [statusCode] - HTTP 状态码。
  /// [body] - 响应体。
  /// [headers] - 响应头。
  ///
  /// 返回检测结果。
  RateLimitResult detect({
    required int statusCode,
    String? body,
    Map<String, String>? headers,
  }) {
    // 检查状态码
    if (_config.statusCodes.contains(statusCode)) {
      _logger?.warning('检测到频率限制状态码: $statusCode');

      // 尝试从响应头获取 Retry-After
      final retryAfter = _parseRetryAfter(headers?['retry-after']);

      return RateLimitResult.limited(
        statusCode: statusCode,
        retryAfter: retryAfter,
        reason: 'HTTP $statusCode',
      );
    }

    // 检查响应体中的文本模式
    if (body != null && _config.textPatterns != null) {
      for (final pattern in _config.textPatterns!) {
        if (body.toLowerCase().contains(pattern.toLowerCase())) {
          _logger?.warning('检测到频率限制文本模式: $pattern');
          return RateLimitResult.limited(
            reason: '文本模式匹配: $pattern',
          );
        }
      }
    }

    return RateLimitResult.notLimited;
  }

  int? _parseRetryAfter(String? value) {
    if (value == null) return null;

    // 尝试解析为秒数
    final seconds = int.tryParse(value);
    if (seconds != null) return seconds;

    // 尝试解析为日期
    try {
      final date = DateTime.parse(value);
      final now = DateTime.now();
      return date.difference(now).inSeconds;
    } on FormatException catch (_) {
      return null;
    }
  }
}

/// 代理配置。
class ProxyConfig {
  /// 创建代理配置。
  const ProxyConfig({
    required this.url,
    this.username,
    this.password,
    this.country,
    this.type = ProxyType.http,
  });

  /// 代理 URL（例如 http://proxy:8080 或 socks5://proxy:1080）。
  final String url;

  /// 用户名（可选）。
  final String? username;

  /// 密码（可选）。
  final String? password;

  /// 代理国家/地区（可选）。
  final String? country;

  /// 代理类型。
  final ProxyType type;

  /// 是否需要认证。
  bool get needsAuth => username != null && password != null;
}

/// 代理类型。
enum ProxyType {
  /// HTTP 代理。
  http,

  /// HTTPS 代理。
  https,

  /// SOCKS4 代理。
  socks4,

  /// SOCKS5 代理。
  socks5,
}

/// 代理管理器。
///
/// 管理代理轮换和故障转移。
class ProxyManager {
  /// 创建代理管理器。
  ProxyManager({
    List<ProxyConfig>? proxies,
    Talker? logger,
  }) : _proxies = proxies ?? [],
       _logger = logger;

  /// 从列表初始化代理。
  factory ProxyManager.fromList(List<String> proxyUrls) {
    final proxies = proxyUrls.map((url) {
      final uri = Uri.parse(url);
      final userInfo = uri.userInfo.split(':');
      return ProxyConfig(
        url: url,
        username: userInfo.isNotEmpty ? userInfo.first : null,
        password: userInfo.length > 1 ? userInfo.last : null,
        type: uri.scheme == 'socks5'
            ? ProxyType.socks5
            : uri.scheme == 'socks4'
            ? ProxyType.socks4
            : uri.scheme == 'https'
            ? ProxyType.https
            : ProxyType.http,
      );
    }).toList();

    return ProxyManager(proxies: proxies);
  }

  final List<ProxyConfig> _proxies;
  final Talker? _logger;
  final Random _random = Random();
  int _currentIndex = 0;

  /// 是否有可用代理。
  bool get hasProxies => _proxies.isNotEmpty;

  /// 代理数量。
  int get proxyCount => _proxies.length;

  /// 添加代理。
  void addProxy(ProxyConfig proxy) {
    _proxies.add(proxy);
    _logger?.info('添加代理: ${proxy.url}');
  }

  /// 移除代理。
  void removeProxy(ProxyConfig proxy) {
    _proxies.remove(proxy);
    _logger?.info('移除代理: ${proxy.url}');
  }

  /// 清除所有代理。
  void clearProxies() {
    _proxies.clear();
    _logger?.info('清除所有代理');
  }

  /// 获取下一个代理（轮询方式）。
  ProxyConfig? getNextProxy() {
    if (_proxies.isEmpty) return null;

    final proxy = _proxies[_currentIndex];
    _currentIndex = (_currentIndex + 1) % _proxies.length;

    _logger?.info('选择代理 (轮询): ${proxy.url}');
    return proxy;
  }

  /// 获取随机代理。
  ProxyConfig? getRandomProxy() {
    if (_proxies.isEmpty) return null;

    final proxy = _proxies[_random.nextInt(_proxies.length)];
    _logger?.info('选择代理 (随机): ${proxy.url}');
    return proxy;
  }

  /// 标记代理失败（用于故障转移）。
  void markProxyFailed(ProxyConfig proxy) {
    _logger?.warning('代理失败: ${proxy.url}');

    // 简单实现：移除失败的代理
    // 更复杂的实现可以使用健康检查和恢复机制
    _proxies.remove(proxy);
  }
}

/// 请求节流器。
///
/// 实现请求之间的延迟和随机抖动。
class RequestThrottler {
  /// 创建请求节流器。
  RequestThrottler({
    int minDelayMs = 1000,
    int maxDelayMs = 5000,
    bool useJitter = true,
    Talker? logger,
  }) : _minDelayMs = minDelayMs,
       _maxDelayMs = maxDelayMs,
       _useJitter = useJitter,
       _logger = logger;

  final int _minDelayMs;
  final int _maxDelayMs;
  final bool _useJitter;
  final Talker? _logger;

  DateTime? _lastRequestTime;
  final Random _random = Random();

  /// 执行节流等待。
  ///
  /// 在请求之间调用此方法以确保适当的延迟。
  Future<void> throttle() async {
    final now = DateTime.now();

    if (_lastRequestTime != null) {
      final elapsed = now.difference(_lastRequestTime!).inMilliseconds;
      var delay = _useJitter
          ? _minDelayMs + _random.nextInt(_maxDelayMs - _minDelayMs)
          : _minDelayMs;

      // 使用指数退避（如果启用了抖动）
      if (_useJitter && delay > _minDelayMs) {
        delay = (_minDelayMs + delay) ~/ 2;
      }

      if (elapsed < delay) {
        final waitMs = delay - elapsed;
        _logger?.info('节流等待: ${waitMs}ms');
        await Future<void>.delayed(Duration(milliseconds: waitMs));
      }
    }

    _lastRequestTime = DateTime.now();
  }

  /// 重置节流状态。
  void reset() {
    _lastRequestTime = null;
    _logger?.info('节流器已重置');
  }

  /// 使用指数退避重试。
  ///
  /// [operation] - 要执行的操作。
  /// [maxRetries] - 最大重试次数。
  /// [baseDelayMs] - 基础延迟（毫秒）。
  /// [maxDelayMs] - 最大延迟（毫秒）。
  static Future<T> withExponentialBackoff<T>(
    Future<T> Function() operation, {
    int maxRetries = 3,
    int baseDelayMs = 1000,
    int maxDelayMs = 30000,
  }) async {
    var attempt = 0;
    Exception? lastError;

    while (attempt < maxRetries) {
      try {
        return await operation();
      } on Exception catch (e) {
        lastError = e;
        attempt++;

        if (attempt >= maxRetries) break;

        final delay = (baseDelayMs * (1 << attempt)).clamp(0, maxDelayMs);
        await Future<void>.delayed(Duration(milliseconds: delay));
      }
    }

    throw lastError ?? Exception('操作失败');
  }
}
