// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// Generator: WorkerGenerator 9.0.0+2 (Squadron 7.4.0)
// **************************************************************************

import 'package:squadron/squadron.dart';

import 'crawler_service.dart';

void _start$CrawlerService(WorkerRequest command) {
  /// VM entry point for CrawlerService
  run($CrawlerServiceInitializer, command);
}

EntryPoint $getCrawlerServiceActivator(SquadronPlatformType platform) {
  if (platform.isVm) {
    return _start$CrawlerService;
  } else {
    throw UnsupportedError('${platform.label} not supported.');
  }
}
