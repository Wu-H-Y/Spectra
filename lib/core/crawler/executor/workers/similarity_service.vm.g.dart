// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// Generator: WorkerGenerator 9.0.0+2 (Squadron 7.4.0)
// **************************************************************************

import 'package:squadron/squadron.dart';

import 'similarity_service.dart';

void _start$SimilarityService(WorkerRequest command) {
  /// VM entry point for SimilarityService
  run($SimilarityServiceInitializer, command);
}

EntryPoint $getSimilarityServiceActivator(SquadronPlatformType platform) {
  if (platform.isVm) {
    return _start$SimilarityService;
  } else {
    throw UnsupportedError('${platform.label} not supported.');
  }
}
