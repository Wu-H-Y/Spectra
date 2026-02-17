import 'package:hive_ce_flutter/hive_flutter.dart';

/// Hive 服务
///
/// 管理 Hive 数据库的初始化和 Boxes。
class HiveService {
  HiveService._();

  static final HiveService _instance = HiveService._();
  static HiveService get instance => _instance;

  /// 是否已初始化
  bool _initialized = false;

  /// Settings Box
  late Box<dynamic> _settingsBox;

  /// Cache Box
  late Box<dynamic> _cacheBox;

  /// 获取 Settings Box
  Box<dynamic> get settingsBox => _settingsBox;

  /// 获取 Cache Box
  Box<dynamic> get cacheBox => _cacheBox;

  /// 初始化 Hive
  Future<void> initialize() async {
    if (_initialized) return;

    // 初始化 Hive for Flutter
    await Hive.initFlutter();

    // 注册 TypeAdapters (后续添加)

    // 打开 Boxes
    _settingsBox = await Hive.openBox<dynamic>('settings');
    _cacheBox = await Hive.openBox<dynamic>('cache');

    _initialized = true;
  }

  /// 关闭所有 Boxes
  Future<void> close() async {
    if (!_initialized) return;

    await _settingsBox.close();
    await _cacheBox.close();

    _initialized = false;
  }

  /// 清除所有数据
  Future<void> clearAll() async {
    await _settingsBox.clear();
    await _cacheBox.clear();
  }
}
