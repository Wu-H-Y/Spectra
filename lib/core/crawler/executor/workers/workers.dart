/// Squadron Worker Services
///
/// 提供爬虫任务和相似度计算的 Worker 服务，
/// 在独立 Isolate 中执行以避免阻塞 UI 线程
library;

export 'crawler_service.dart';
export 'similarity_service.dart';
