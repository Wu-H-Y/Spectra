// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'similarity_service.dart';

// **************************************************************************
// Generator: WorkerGenerator 9.0.0+2 (Squadron 7.4.0)
// **************************************************************************

// dart format width=80
/// Command ids used in operations map
const int _$batchFuzzySearchScoreId = 1;
const int _$batchJaccardId = 2;
const int _$fuzzySearchScoreId = 3;
const int _$jaccardId = 4;
const int _$levenshteinId = 5;
const int _$levenshteinTokensId = 6;
const int _$normalizeTitleId = 7;
const int _$sorensenDiceId = 8;

/// WorkerService operations for SimilarityService
extension on SimilarityService {
  OperationsMap _$getOperations() => OperationsMap({
    _$batchFuzzySearchScoreId: ($req) async {
      final List<double> $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await batchFuzzySearchScore(
          $dsr.$0($req.args[0]),
          $dsr.$1($req.args[1]),
        );
      } finally {}
      return $res;
    },
    _$batchJaccardId: ($req) async {
      final List<double> $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await batchJaccard($dsr.$0($req.args[0]), $dsr.$1($req.args[1]));
      } finally {}
      return $res;
    },
    _$fuzzySearchScoreId: ($req) async {
      final double $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await fuzzySearchScore(
          $dsr.$0($req.args[0]),
          $dsr.$0($req.args[1]),
        );
      } finally {}
      return $res;
    },
    _$jaccardId: ($req) async {
      final double $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await jaccard($dsr.$0($req.args[0]), $dsr.$0($req.args[1]));
      } finally {}
      return $res;
    },
    _$levenshteinId: ($req) async {
      final double $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await levenshtein($dsr.$0($req.args[0]), $dsr.$0($req.args[1]));
      } finally {}
      return $res;
    },
    _$levenshteinTokensId: ($req) async {
      final double $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await levenshteinTokens(
          $dsr.$0($req.args[0]),
          $dsr.$0($req.args[1]),
        );
      } finally {}
      return $res;
    },
    _$normalizeTitleId: ($req) async {
      final String $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await normalizeTitle($dsr.$0($req.args[0]));
      } finally {}
      return $res;
    },
    _$sorensenDiceId: ($req) async {
      final double $res;
      try {
        final $dsr = _$Deser(contextAware: false);
        $res = await sorensenDice($dsr.$0($req.args[0]), $dsr.$0($req.args[1]));
      } finally {}
      return $res;
    },
  });
}

/// Invoker for SimilarityService, implements the public interface to invoke the
/// remote service.
base mixin _$SimilarityService$Invoker on Invoker implements SimilarityService {
  @override
  Future<List<double>> batchFuzzySearchScore(
    String query,
    List<String> targets,
  ) async {
    final dynamic $res = await send(
      _$batchFuzzySearchScoreId,
      args: [query, targets],
    );
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$3($res);
    } finally {}
  }

  @override
  Future<List<double>> batchJaccard(String query, List<String> targets) async {
    final dynamic $res = await send(_$batchJaccardId, args: [query, targets]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$3($res);
    } finally {}
  }

  @override
  Future<double> fuzzySearchScore(String query, String target) async {
    final dynamic $res = await send(
      _$fuzzySearchScoreId,
      args: [query, target],
    );
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$2($res);
    } finally {}
  }

  @override
  Future<double> jaccard(String a, String b) async {
    final dynamic $res = await send(_$jaccardId, args: [a, b]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$2($res);
    } finally {}
  }

  @override
  Future<double> levenshtein(String a, String b) async {
    final dynamic $res = await send(_$levenshteinId, args: [a, b]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$2($res);
    } finally {}
  }

  @override
  Future<double> levenshteinTokens(String a, String b) async {
    final dynamic $res = await send(_$levenshteinTokensId, args: [a, b]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$2($res);
    } finally {}
  }

  @override
  Future<String> normalizeTitle(String title) async {
    final dynamic $res = await send(_$normalizeTitleId, args: [title]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$0($res);
    } finally {}
  }

  @override
  Future<double> sorensenDice(String a, String b) async {
    final dynamic $res = await send(_$sorensenDiceId, args: [a, b]);
    try {
      final $dsr = _$Deser(contextAware: false);
      return $dsr.$2($res);
    } finally {}
  }
}

/// Facade for SimilarityService, implements other details of the service unrelated to
/// invoking the remote service.
base mixin _$SimilarityService$Facade implements SimilarityService {}

/// WorkerClient for SimilarityService
final class $SimilarityService$Client extends WorkerClient
    with _$SimilarityService$Invoker, _$SimilarityService$Facade
    implements SimilarityService {
  $SimilarityService$Client(PlatformChannel channelInfo)
    : super(Channel.deserialize(channelInfo)!);
}

/// Local worker extension for SimilarityService
extension $SimilarityServiceLocalWorkerExt on SimilarityService {
  // Get a fresh local worker instance.
  LocalWorker<SimilarityService> getLocalWorker([
    ExceptionManager? exceptionManager,
  ]) => LocalWorker.create(this, _$getOperations(), exceptionManager);
}

/// WorkerService class for SimilarityService
base class _$SimilarityService$WorkerService extends SimilarityService
    implements WorkerService {
  _$SimilarityService$WorkerService() : super();

  @override
  OperationsMap get operations => _$getOperations();
}

/// Service initializer for SimilarityService
WorkerService $SimilarityServiceInitializer(WorkerRequest $req) =>
    _$SimilarityService$WorkerService();

/// Worker for SimilarityService
base class SimilarityServiceWorker extends Worker
    with _$SimilarityService$Invoker, _$SimilarityService$Facade
    implements SimilarityService {
  SimilarityServiceWorker({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
  }) : super(
         $SimilarityServiceActivator(Squadron.platformType),
         threadHook: threadHook,
         exceptionManager: exceptionManager,
       );

  SimilarityServiceWorker.vm({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
  }) : super(
         $SimilarityServiceActivator(SquadronPlatformType.vm),
         threadHook: threadHook,
         exceptionManager: exceptionManager,
       );

  SimilarityServiceWorker.js({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
  }) : super(
         $SimilarityServiceActivator(SquadronPlatformType.js),
         threadHook: threadHook,
         exceptionManager: exceptionManager,
       );

  SimilarityServiceWorker.wasm({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
  }) : super(
         $SimilarityServiceActivator(SquadronPlatformType.wasm),
         threadHook: threadHook,
         exceptionManager: exceptionManager,
       );

  @override
  List? getStartArgs() => null;
}

/// Worker pool for SimilarityService
base class SimilarityServiceWorkerPool
    extends WorkerPool<SimilarityServiceWorker>
    with _$SimilarityService$Facade
    implements SimilarityService {
  SimilarityServiceWorkerPool({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
    ConcurrencySettings? concurrencySettings,
  }) : super(
         (ExceptionManager exceptionManager) => SimilarityServiceWorker(
           threadHook: threadHook,
           exceptionManager: exceptionManager,
         ),
         concurrencySettings: concurrencySettings,
         exceptionManager: exceptionManager,
       );

  SimilarityServiceWorkerPool.vm({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
    ConcurrencySettings? concurrencySettings,
  }) : super(
         (ExceptionManager exceptionManager) => SimilarityServiceWorker.vm(
           threadHook: threadHook,
           exceptionManager: exceptionManager,
         ),
         concurrencySettings: concurrencySettings,
         exceptionManager: exceptionManager,
       );

  SimilarityServiceWorkerPool.js({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
    ConcurrencySettings? concurrencySettings,
  }) : super(
         (ExceptionManager exceptionManager) => SimilarityServiceWorker.js(
           threadHook: threadHook,
           exceptionManager: exceptionManager,
         ),
         concurrencySettings: concurrencySettings,
         exceptionManager: exceptionManager,
       );

  SimilarityServiceWorkerPool.wasm({
    PlatformThreadHook? threadHook,
    ExceptionManager? exceptionManager,
    ConcurrencySettings? concurrencySettings,
  }) : super(
         (ExceptionManager exceptionManager) => SimilarityServiceWorker.wasm(
           threadHook: threadHook,
           exceptionManager: exceptionManager,
         ),
         concurrencySettings: concurrencySettings,
         exceptionManager: exceptionManager,
       );

  @override
  Future<List<double>> batchFuzzySearchScore(
    String query,
    List<String> targets,
  ) => execute((w) => w.batchFuzzySearchScore(query, targets));

  @override
  Future<List<double>> batchJaccard(String query, List<String> targets) =>
      execute((w) => w.batchJaccard(query, targets));

  @override
  Future<double> fuzzySearchScore(String query, String target) =>
      execute((w) => w.fuzzySearchScore(query, target));

  @override
  Future<double> jaccard(String a, String b) => execute((w) => w.jaccard(a, b));

  @override
  Future<double> levenshtein(String a, String b) =>
      execute((w) => w.levenshtein(a, b));

  @override
  Future<double> levenshteinTokens(String a, String b) =>
      execute((w) => w.levenshteinTokens(a, b));

  @override
  Future<String> normalizeTitle(String title) =>
      execute((w) => w.normalizeTitle(title));

  @override
  Future<double> sorensenDice(String a, String b) =>
      execute((w) => w.sorensenDice(a, b));
}

final class _$Deser extends MarshalingContext {
  _$Deser({super.contextAware});
  late final $0 = value<String>();
  late final $1 = list<String>($0);
  late final $2 = value<double>();
  late final $3 = list<double>($2);
}
