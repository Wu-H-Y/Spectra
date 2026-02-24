// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'crawler_service.dart';

// **************************************************************************
// Generator: WorkerGenerator 9.0.0+2 (Squadron 7.4.0)
// **************************************************************************

// dart format width=80
/// Command ids used in operations map
const int _$batchSearchId = 1;
const int _$exploreId = 2;
const int _$getContentId = 3;
const int _$getDetailId = 4;
const int _$getTocId = 5;
const int _$searchId = 6;

/// WorkerService operations for CrawlerService
extension on CrawlerService {
  OperationsMap _$getOperations() => OperationsMap({
    _$batchSearchId: ($req) {
      final Stream<SearchProgress> $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = batchSearch($dsr.$1($req.args[0]), $dsr.$0($req.args[1]));
      } finally {}
      return $res;
    },
    _$exploreId: ($req) async {
      final List<Map<String, dynamic>> $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await explore(
          $dsr.$0($req.args[0]),
          $dsr.$2($req.args[1]),
          $dsr.$4($req.args[2]),
        );
      } finally {}
      return $res;
    },
    _$getContentId: ($req) async {
      final Map<String, dynamic>? $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await getContent($dsr.$0($req.args[0]), $dsr.$0($req.args[1]));
      } finally {}
      return $res;
    },
    _$getDetailId: ($req) async {
      final Map<String, dynamic>? $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await getDetail($dsr.$0($req.args[0]), $dsr.$0($req.args[1]));
      } finally {}
      return $res;
    },
    _$getTocId: ($req) async {
      final List<Map<String, dynamic>> $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await getToc(
          $dsr.$0($req.args[0]),
          $dsr.$0($req.args[1]),
          $dsr.$4($req.args[2]),
        );
      } finally {}
      return $res;
    },
    _$searchId: ($req) async {
      final List<Map<String, dynamic>> $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await search(
          $dsr.$0($req.args[0]),
          $dsr.$0($req.args[1]),
          $dsr.$4($req.args[2]),
        );
      } finally {}
      return $res;
    },
  });
}

/// Invoker for CrawlerService, implements the public interface to invoke the
/// remote service.
base mixin _$CrawlerService$Invoker on Invoker implements CrawlerService {
  @override
  Stream<SearchProgress> batchSearch(List<String> ruleIds, String query) {
    final Stream $res = stream(_$batchSearchId, args: [ruleIds, query]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $res.map($dsr.$5);
    } finally {}
  }

  @override
  Future<List<Map<String, dynamic>>> explore(
    String ruleId, [
    String? categoryId,
    int? page,
  ]) async {
    final dynamic $res = await send(
      _$exploreId,
      args: [ruleId, categoryId, page],
    );
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$8($res);
    } finally {}
  }

  @override
  Future<Map<String, dynamic>?> getContent(String ruleId, String url) async {
    final dynamic $res = await send(_$getContentId, args: [ruleId, url]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$9($res);
    } finally {}
  }

  @override
  Future<Map<String, dynamic>?> getDetail(String ruleId, String url) async {
    final dynamic $res = await send(_$getDetailId, args: [ruleId, url]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$9($res);
    } finally {}
  }

  @override
  Future<List<Map<String, dynamic>>> getToc(
    String ruleId,
    String url, [
    int? page,
  ]) async {
    final dynamic $res = await send(_$getTocId, args: [ruleId, url, page]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$8($res);
    } finally {}
  }

  @override
  Future<List<Map<String, dynamic>>> search(
    String ruleId,
    String query, [
    int? page,
  ]) async {
    final dynamic $res = await send(_$searchId, args: [ruleId, query, page]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$8($res);
    } finally {}
  }
}

/// Facade for CrawlerService, implements other details of the service unrelated to
/// invoking the remote service.
base mixin _$CrawlerService$Facade implements CrawlerService {
  @override
  Future<List<Map<String, dynamic>>> _executeSearch(
    String ruleId,
    String query,
    int? page,
  ) => throw UnimplementedError();

  @override
  Future<Map<String, dynamic>?> _executeGetDetail(String ruleId, String url) =>
      throw UnimplementedError();

  @override
  Future<List<Map<String, dynamic>>> _executeGetToc(
    String ruleId,
    String url,
    int? page,
  ) => throw UnimplementedError();

  @override
  Future<Map<String, dynamic>?> _executeGetContent(String ruleId, String url) =>
      throw UnimplementedError();

  @override
  Future<List<Map<String, dynamic>>> _executeExplore(
    String ruleId,
    String? categoryId,
    int? page,
  ) => throw UnimplementedError();
}

/// WorkerClient for CrawlerService
final class $CrawlerService$Client extends WorkerClient
    with _$CrawlerService$Invoker, _$CrawlerService$Facade
    implements CrawlerService {
  $CrawlerService$Client(PlatformChannel channelInfo)
    : super(Channel.deserialize(channelInfo)!);
}

/// Local worker extension for CrawlerService
extension $CrawlerServiceLocalWorkerExt on CrawlerService {
  // Get a fresh local worker instance.
  LocalWorker<CrawlerService> getLocalWorker([
    ExceptionManager? exceptionManager,
  ]) => LocalWorker.create(this, _$getOperations(), exceptionManager);
}

/// WorkerService class for CrawlerService
base class _$CrawlerService$WorkerService extends CrawlerService
    implements WorkerService {
  _$CrawlerService$WorkerService() : super();

  @override
  OperationsMap get operations => _$getOperations();
}

/// Service initializer for CrawlerService
WorkerService $CrawlerServiceInitializer(WorkerRequest $req) =>
    _$CrawlerService$WorkerService();

/// Worker for CrawlerService
base class CrawlerServiceWorker extends Worker
    with _$CrawlerService$Invoker, _$CrawlerService$Facade
    implements CrawlerService {
  CrawlerServiceWorker({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
  }) : super(
         $CrawlerServiceActivator(Squadron.platformType),
         threadHook: threadHook,
         exceptionManager: exceptionManager,
       );

  CrawlerServiceWorker.vm({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
  }) : super(
         $CrawlerServiceActivator(SquadronPlatformType.vm),
         threadHook: threadHook,
         exceptionManager: exceptionManager,
       );

  CrawlerServiceWorker.js({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
  }) : super(
         $CrawlerServiceActivator(SquadronPlatformType.js),
         threadHook: threadHook,
         exceptionManager: exceptionManager,
       );

  CrawlerServiceWorker.wasm({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
  }) : super(
         $CrawlerServiceActivator(SquadronPlatformType.wasm),
         threadHook: threadHook,
         exceptionManager: exceptionManager,
       );

  @override
  List? getStartArgs() => null;
}

/// Worker pool for CrawlerService
base class CrawlerServiceWorkerPool extends WorkerPool<CrawlerServiceWorker>
    with _$CrawlerService$Facade
    implements CrawlerService {
  CrawlerServiceWorkerPool({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
    ConcurrencySettings? concurrencySettings,
  }) : super(
         (ExceptionManager exceptionManager) => CrawlerServiceWorker(
           threadHook: threadHook,
           exceptionManager: exceptionManager,
         ),
         concurrencySettings: concurrencySettings,
         exceptionManager: exceptionManager,
       );

  CrawlerServiceWorkerPool.vm({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
    ConcurrencySettings? concurrencySettings,
  }) : super(
         (ExceptionManager exceptionManager) => CrawlerServiceWorker.vm(
           threadHook: threadHook,
           exceptionManager: exceptionManager,
         ),
         concurrencySettings: concurrencySettings,
         exceptionManager: exceptionManager,
       );

  CrawlerServiceWorkerPool.js({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
    ConcurrencySettings? concurrencySettings,
  }) : super(
         (ExceptionManager exceptionManager) => CrawlerServiceWorker.js(
           threadHook: threadHook,
           exceptionManager: exceptionManager,
         ),
         concurrencySettings: concurrencySettings,
         exceptionManager: exceptionManager,
       );

  CrawlerServiceWorkerPool.wasm({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
    ConcurrencySettings? concurrencySettings,
  }) : super(
         (ExceptionManager exceptionManager) => CrawlerServiceWorker.wasm(
           threadHook: threadHook,
           exceptionManager: exceptionManager,
         ),
         concurrencySettings: concurrencySettings,
         exceptionManager: exceptionManager,
       );

  @override
  Stream<SearchProgress> batchSearch(List<String> ruleIds, String query) =>
      stream((w) => w.batchSearch(ruleIds, query));

  @override
  Future<List<Map<String, dynamic>>> explore(
    String ruleId, [
    String? categoryId,
    int? page,
  ]) => execute((w) => w.explore(ruleId, categoryId, page));

  @override
  Future<Map<String, dynamic>?> getContent(String ruleId, String url) =>
      execute((w) => w.getContent(ruleId, url));

  @override
  Future<Map<String, dynamic>?> getDetail(String ruleId, String url) =>
      execute((w) => w.getDetail(ruleId, url));

  @override
  Future<List<Map<String, dynamic>>> getToc(
    String ruleId,
    String url, [
    int? page,
  ]) => execute((w) => w.getToc(ruleId, url, page));

  @override
  Future<List<Map<String, dynamic>>> search(
    String ruleId,
    String query, [
    int? page,
  ]) => execute((w) => w.search(ruleId, query, page));
}

final class _$Deser extends MarshalingContext {
  _$Deser({super.contextAware});
  late final $0 = value<String>();
  late final $1 = list<String>($0);
  late final $2 = Converter.allowNull($0);
  late final $3 = value<int>();
  late final $4 = Converter.allowNull($3);
  late final $5 = value<SearchProgress>();
  late final $6 = value<Object>();
  late final $7 = nmap<String, Object>(kcast: $0, vcast: $6);
  late final $8 = list<Map<String, dynamic>>($7);
  late final $9 = Converter.allowNull($7);
}
