// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'execution_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExecutionState _$ExecutionStateFromJson(
  Map<String, dynamic> json,
) => _ExecutionState(
  id: json['id'] as String,
  ruleId: json['rule_id'] as String,
  status:
      $enumDecodeNullable(_$ExecutionStatusEnumMap, json['status']) ??
      ExecutionStatus.idle,
  currentUrl: json['current_url'] as String?,
  currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
  totalPages: (json['total_pages'] as num?)?.toInt() ?? 0,
  extractedCount: (json['extracted_count'] as num?)?.toInt() ?? 0,
  failedCount: (json['failed_count'] as num?)?.toInt() ?? 0,
  errors:
      (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  warnings:
      (json['warnings'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  startTime: json['start_time'] == null
      ? null
      : DateTime.parse(json['start_time'] as String),
  endTime: json['end_time'] == null
      ? null
      : DateTime.parse(json['end_time'] as String),
  phase:
      $enumDecodeNullable(_$ExecutionPhaseEnumMap, json['phase']) ??
      ExecutionPhase.initializing,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$ExecutionStateToJson(_ExecutionState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rule_id': instance.ruleId,
      'status': _$ExecutionStatusEnumMap[instance.status]!,
      'current_url': ?instance.currentUrl,
      'current_page': instance.currentPage,
      'total_pages': instance.totalPages,
      'extracted_count': instance.extractedCount,
      'failed_count': instance.failedCount,
      'errors': instance.errors,
      'warnings': instance.warnings,
      'start_time': ?instance.startTime?.toIso8601String(),
      'end_time': ?instance.endTime?.toIso8601String(),
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
