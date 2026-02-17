import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'core/database/drift/app_database.dart';
import 'core/database/hive/hive_service.dart';
import 'core/router/app_router.dart';
import 'core/theme/theme.dart';
import 'l10n/generated/app_localizations.dart';
import 'shared/providers/settings_provider.dart';

void main() async {
  // 1. 确保 Flutter 绑定初始化
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

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

  // 5. 启动应用（使用 ProviderScope 包裹）
  runApp(ProviderScope(child: const AppReadyHandler(child: SpectraApp())));
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

  // TODO: 添加其他初始化任务
}

/// Spectra 应用入口
class SpectraApp extends ConsumerWidget {
  const SpectraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听路由
    final router = ref.watch(routerProvider);

    // 监听持久化的主题模式和语言
    final themeMode = ref.watch(persistedThemeModeProvider);
    final locale = ref.watch(persistedLocaleProvider);

    return MaterialApp.router(
      title: 'Spectra',
      debugShowCheckedModeBanner: false,

      // 路由配置
      routerConfig: router,

      // 本地化配置
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('zh', 'CN')],
      locale: locale,

      // 主题配置
      theme: SpectraTheme.light,
      darkTheme: SpectraTheme.dark,
      themeMode: themeMode.flutterThemeMode,
    );
  }
}

/// 启动完成后显示窗口的辅助类
class AppReadyHandler extends StatefulWidget {
  const AppReadyHandler({super.key, required this.child});

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
