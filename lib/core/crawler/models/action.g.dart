// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CrawlerAction _$CrawlerActionFromJson(Map<String, dynamic> json) =>
    _CrawlerAction(
      type: $enumDecode(_$ActionTypeEnumMap, json['type']),
      params: json['params'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$CrawlerActionToJson(_CrawlerAction instance) =>
    <String, dynamic>{
      'type': _$ActionTypeEnumMap[instance.type]!,
      'params': instance.params,
    };

const _$ActionTypeEnumMap = {
  ActionType.wait: 'wait',
  ActionType.click: 'click',
  ActionType.scroll: 'scroll',
  ActionType.fill: 'fill',
  ActionType.script: 'script',
  ActionType.condition: 'condition',
  ActionType.loop: 'loop',
};

_WaitAction _$WaitActionFromJson(Map<String, dynamic> json) => _WaitAction(
  selector: json['selector'] as String?,
  timeout: (json['timeout'] as num?)?.toInt() ?? 5000,
);

Map<String, dynamic> _$WaitActionToJson(_WaitAction instance) =>
    <String, dynamic>{
      'selector': ?instance.selector,
      'timeout': instance.timeout,
    };

_ClickAction _$ClickActionFromJson(Map<String, dynamic> json) => _ClickAction(
  selector: json['selector'] as String,
  scrollIntoView: json['scroll_into_view'] as bool? ?? true,
);

Map<String, dynamic> _$ClickActionToJson(_ClickAction instance) =>
    <String, dynamic>{
      'selector': instance.selector,
      'scroll_into_view': instance.scrollIntoView,
    };

_ScrollAction _$ScrollActionFromJson(Map<String, dynamic> json) =>
    _ScrollAction(
      direction:
          $enumDecodeNullable(_$ScrollDirectionEnumMap, json['direction']) ??
          ScrollDirection.down,
      distance: (json['distance'] as num?)?.toInt() ?? 0,
      smooth: json['smooth'] as bool? ?? true,
    );

Map<String, dynamic> _$ScrollActionToJson(_ScrollAction instance) =>
    <String, dynamic>{
      'direction': _$ScrollDirectionEnumMap[instance.direction]!,
      'distance': instance.distance,
      'smooth': instance.smooth,
    };

const _$ScrollDirectionEnumMap = {
  ScrollDirection.up: 'up',
  ScrollDirection.down: 'down',
  ScrollDirection.left: 'left',
  ScrollDirection.right: 'right',
};

_FillAction _$FillActionFromJson(Map<String, dynamic> json) => _FillAction(
  selector: json['selector'] as String,
  value: json['value'] as String,
  simulateTyping: json['simulate_typing'] as bool? ?? false,
);

Map<String, dynamic> _$FillActionToJson(_FillAction instance) =>
    <String, dynamic>{
      'selector': instance.selector,
      'value': instance.value,
      'simulate_typing': instance.simulateTyping,
    };

_ScriptAction _$ScriptActionFromJson(Map<String, dynamic> json) =>
    _ScriptAction(
      code: json['code'] as String,
      awaitCompletion: json['await_completion'] as bool? ?? true,
    );

Map<String, dynamic> _$ScriptActionToJson(_ScriptAction instance) =>
    <String, dynamic>{
      'code': instance.code,
      'await_completion': instance.awaitCompletion,
    };

_ConditionAction _$ConditionActionFromJson(Map<String, dynamic> json) =>
    _ConditionAction(
      check: json['check'] as String,
      thenActions: (json['then_actions'] as List<dynamic>)
          .map((e) => CrawlerAction.fromJson(e as Map<String, dynamic>))
          .toList(),
      elseActions: (json['else_actions'] as List<dynamic>?)
          ?.map((e) => CrawlerAction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConditionActionToJson(_ConditionAction instance) =>
    <String, dynamic>{
      'check': instance.check,
      'then_actions': instance.thenActions.map((e) => e.toJson()).toList(),
      'else_actions': ?instance.elseActions?.map((e) => e.toJson()).toList(),
    };

_LoopAction _$LoopActionFromJson(Map<String, dynamic> json) => _LoopAction(
  count: (json['count'] as num).toInt(),
  actions: (json['actions'] as List<dynamic>)
      .map((e) => CrawlerAction.fromJson(e as Map<String, dynamic>))
      .toList(),
  delayMs: (json['delay_ms'] as num?)?.toInt() ?? 1000,
);

Map<String, dynamic> _$LoopActionToJson(_LoopAction instance) =>
    <String, dynamic>{
      'count': instance.count,
      'actions': instance.actions.map((e) => e.toJson()).toList(),
      'delay_ms': instance.delayMs,
    };
