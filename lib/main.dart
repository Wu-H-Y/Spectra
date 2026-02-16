import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:window_manager/window_manager.dart';

import 'pages/home/home_page.dart';
import 'theme/spectra_theme.dart';

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

  runApp(const SpectraApp());
}

/// 执行繁重的初始化任务
///
/// 在这里添加需要启动时完成的任务：
/// - 数据库初始化
/// - 配置加载
/// - 引擎预热
/// - 检查更新
Future<void> _initializeHeavyTasks() async {
  // TODO: 添加实际的初始化任务
  // 模拟耗时任务
  await Future.delayed(const Duration(milliseconds: 3000));
}

/// Spectra 应用入口
class SpectraApp extends StatefulWidget {
  const SpectraApp({super.key});

  @override
  State<SpectraApp> createState() => _SpectraAppState();
}

class _SpectraAppState extends State<SpectraApp> {
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spectra',
      debugShowCheckedModeBanner: false,

      // 主题配置
      theme: SpectraTheme.light,
      darkTheme: SpectraTheme.dark,
      themeMode: ThemeMode.dark, // 默认深色模式

      // 主页作为首页
      home: const HomePage(),
    );
  }
}
