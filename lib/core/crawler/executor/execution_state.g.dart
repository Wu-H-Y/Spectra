// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExecutionState _$ExecutionStateFromJson(
  Map<String, dynamic> json,
) => _ExecutionState(
  id: json['id'] as String,
  ruleId: json['ruleId'] as String,
  status:
      $enumDecodeNullable(_$ExecutionStatusEnumMap, json['status']) ??
      ExecutionStatus.idle,
  currentUrl: json['currentUrl'] as String?,
  currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
  extractedCount: (json['extractedCount'] as num?)?.toInt() ?? 0,
  failedCount: (json['failedCount'] as num?)?.toInt() ?? 0,
  errors:
      (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  warnings:
      (json['warnings'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  startTime: json['startTime'] == null
      ? null
      : DateTime.parse(json['startTime'] as String),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  phase:
      $enumDecodeNullable(_$ExecutionPhaseEnumMap, json['phase']) ??
      ExecutionPhase.initializing,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$ExecutionStateToJson(_ExecutionState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ruleId': instance.ruleId,
      'status': _$ExecutionStatusEnumMap[instance.status]!,
      'currentUrl': instance.currentUrl,
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'extractedCount': instance.extractedCount,
      'failedCount': instance.failedCount,
      'errors': instance.errors,
      'warnings': instance.warnings,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'phase': _$ExecutionPhaseEnumMap[instance.phase]!,
      'metadata': instance.metadata,
    };

const _$ExecutionStatusEnumMap = {
  ExecutionStatus.idle: 'idle',
  ExecutionStatus.running: 'running',
  ExecutionStatus.paused: 'paused',
  ExecutionStatus.completed: 'completed',
  ExecutionStatus.failed: 'failed',
  ExecutionStatus.cancelled: 'cancelled',
};

const _$ExecutionPhaseEnumMap = {
  ExecutionPhase.initializing: 'initializing',
  ExecutionPhase.loading: 'loading',
  ExecutionPhase.beforeActions: 'beforeActions',
  ExecutionPhase.listExtraction: 'listExtraction',
  ExecutionPhase.detailExtraction: 'detailExtraction',
  ExecutionPhase.contentExtraction: 'contentExtraction',
  ExecutionPhase.pagination: 'pagination',
  ExecutionPhase.afterActions: 'afterActions',
  ExecutionPhase.completed: 'completed',
  ExecutionPhase.failed: 'failed',
};
