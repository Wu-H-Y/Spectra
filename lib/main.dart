import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:spectra/core/database/drift/app_database.dart';
import 'package:spectra/core/database/hive/hive_service.dart';
import 'package:spectra/core/router/app_router.dart';
import 'package:spectra/core/rust/frb_generated.dart';
import 'package:spectra/core/theme/theme.dart';
import 'package:spectra/l10n/generated/l10n.dart';
import 'package:spectra/shared/providers/settings_provider.dart';
import 'package:spectra/shared/providers/talker_provider.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  // 1. 确保 Flutter 绑定初始化
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // 2. 保持原生启动屏（遮挡初始化过程）
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 3. 初始化窗口管理器（桌面端）
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: Size(1280, 720),
    minimumSize: Size(800, 600),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    title: 'Spectra',
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    // 窗口配置完成，但暂不显示
  });

  // 4. 执行后台初始化任务
  await _initializeHeavyTasks();

  // 5. 创建 Talker 实例并启动应用
  final talker = createTalker();
  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver(talker: talker)],
      overrides: [
        talkerProvider.overrideWithValue(talker),
      ],
      child: const AppReadyHandler(child: SpectraApp()),
    ),
  );
}

/// 执行繁重的初始化任务
///
/// 在这里添加需要启动时完成的任务：
/// - 数据库初始化
/// - 配置加载
/// - 引擎预热
/// - 检查更新
Future<void> _initializeHeavyTasks() async {
  // 初始化 Hive
  await HiveService.instance.initialize();

  // 初始化 Drift 数据库
  // ignore: unused_local_variable
  final db = AppDatabase();

  // 初始化 rustlib
  await RustLib.init();

  // TODO(developer): 添加其他初始化任务
}

/// Spectra 应用入口
///
/// 这是应用的主 Widget，负责配置：
/// - 路由
/// - 本地化
/// - 主题
class SpectraApp extends HookConsumerWidget {
  /// 创建 Spectra 应用实例
  const SpectraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听路由
    final router = ref.watch(routerProvider);

    // 监听持久化的主题模式和语言
    final themeMode = ref.watch(persistedThemeModeProvider);
    final locale = ref.watch(persistedLocaleProvider);

    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          title: 'Spectra',
          debugShowCheckedModeBanner: false,

          // 路由配置
          routerConfig: router,

          // 本地化配置
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: locale,

          // 主题配置
          theme: SpectraTheme.light,
          darkTheme: SpectraTheme.dark,
          themeMode: themeMode.flutterThemeMode,
        );
      },
    );
  }
}

/// 启动完成后显示窗口的辅助类
///
/// 在第一帧渲染完成后显示窗口并移除启动屏
class AppReadyHandler extends StatefulWidget {
  /// 创建启动完成处理器
  ///
  /// [child] 是应用的主 Widget
  const AppReadyHandler({required this.child, super.key});

  /// 子 Widget
  final Widget child;

  @override
  State<AppReadyHandler> createState() => _AppReadyHandlerState();
}

class _AppReadyHandlerState extends State<AppReadyHandler> {
  @override
  void initState() {
    super.initState();

    // 当第一帧渲染完成后，显示窗口并移除启动屏
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // 显示窗口
      await windowManager.show();
      // 聚焦窗口
      await windowManager.focus();
      // 移除启动屏
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
