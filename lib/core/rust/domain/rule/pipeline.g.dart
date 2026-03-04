// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pipeline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AggregationDef_First _$AggregationDef_FirstFromJson(
  Map<String, dynamic> json,
) => AggregationDef_First($type: json['runtimeType'] as String?);

Map<String, dynamic> _$AggregationDef_FirstToJson(
  AggregationDef_First instance,
) => <String, dynamic>{'runtimeType': instance.$type};

AggregationDef_Last _$AggregationDef_LastFromJson(Map<String, dynamic> json) =>
    AggregationDef_Last($type: json['runtimeType'] as String?);

Map<String, dynamic> _$AggregationDef_LastToJson(
  AggregationDef_Last instance,
) => <String, dynamic>{'runtimeType': instance.$type};

AggregationDef_Join _$AggregationDef_JoinFromJson(Map<String, dynamic> json) =>
    AggregationDef_Join(
      separator: json['separator'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$AggregationDef_JoinToJson(
  AggregationDef_Join instance,
) => <String, dynamic>{
  'separator': instance.separator,
  'runtimeType': instance.$type,
};

AggregationDef_Array _$AggregationDef_ArrayFromJson(
  Map<String, dynamic> json,
) => AggregationDef_Array($type: json['runtimeType'] as String?);

Map<String, dynamic> _$AggregationDef_ArrayToJson(
  AggregationDef_Array instance,
) => <String, dynamic>{'runtimeType': instance.$type};

_FlowEdge _$FlowEdgeFromJson(Map<String, dynamic> json) => _FlowEdge(
  id: json['id'] as String,
  source: json['source'] as String,
  target: json['target'] as String,
);

Map<String, dynamic> _$FlowEdgeToJson(_FlowEdge instance) => <String, dynamic>{
  'id': instance.id,
  'source': instance.source,
  'target': instance.target,
};

_FlowNode _$FlowNodeFromJson(Map<String, dynamic> json) => _FlowNode(
  id: json['id'] as String,
  x: (json['x'] as num).toDouble(),
  y: (json['y'] as num).toDouble(),
  data: NodePayload.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FlowNodeToJson(_FlowNode instance) => <String, dynamic>{
  'id': instance.id,
  'x': instance.x,
  'y': instance.y,
  'data': instance.data.toJson(),
};

NodePayload_Selector _$NodePayload_SelectorFromJson(
  Map<String, dynamic> json,
) => NodePayload_Selector(
  SelectorDef.fromJson(json['field0'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$NodePayload_SelectorToJson(
  NodePayload_Selector instance,
) => <String, dynamic>{
  'field0': instance.field0.toJson(),
  'runtimeType': instance.$type,
};

NodePayload_Transform _$NodePayload_TransformFromJson(
  Map<String, dynamic> json,
) => NodePayload_Transform(
  TransformDef.fromJson(json['field0'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$NodePayload_TransformToJson(
  NodePayload_Transform instance,
) => <String, dynamic>{
  'field0': instance.field0.toJson(),
  'runtimeType': instance.$type,
};

NodePayload_Aggregation _$NodePayload_AggregationFromJson(
  Map<String, dynamic> json,
) => NodePayload_Aggregation(
  AggregationDef.fromJson(json['field0'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$NodePayload_AggregationToJson(
  NodePayload_Aggregation instance,
) => <String, dynamic>{
  'field0': instance.field0.toJson(),
  'runtimeType': instance.$type,
};

_PipelineGraph _$PipelineGraphFromJson(Map<String, dynamic> json) =>
    _PipelineGraph(
      nodes: (json['nodes'] as List<dynamic>)
          .map((e) => FlowNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      edges: (json['edges'] as List<dynamic>)
          .map((e) => FlowEdge.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PipelineGraphToJson(_PipelineGraph instance) =>
    <String, dynamic>{
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
      'edges': instance.edges.map((e) => e.toJson()).toList(),
    };

SelectorDef_Css _$SelectorDef_CssFromJson(Map<String, dynamic> json) =>
    SelectorDef_Css(
      selector: json['selector'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SelectorDef_CssToJson(SelectorDef_Css instance) =>
    <String, dynamic>{
      'selector': instance.selector,
      'runtimeType': instance.$type,
    };

SelectorDef_XPath _$SelectorDef_XPathFromJson(Map<String, dynamic> json) =>
    SelectorDef_XPath(
      query: json['query'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SelectorDef_XPathToJson(SelectorDef_XPath instance) =>
    <String, dynamic>{'query': instance.query, 'runtimeType': instance.$type};

SelectorDef_JsonPath _$SelectorDef_JsonPathFromJson(
  Map<String, dynamic> json,
) => SelectorDef_JsonPath(
  path: json['path'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$SelectorDef_JsonPathToJson(
  SelectorDef_JsonPath instance,
) => <String, dynamic>{'path': instance.path, 'runtimeType': instance.$type};

SelectorDef_Regex _$SelectorDef_RegexFromJson(Map<String, dynamic> json) =>
    SelectorDef_Regex(
      pattern: json['pattern'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$SelectorDef_RegexToJson(SelectorDef_Regex instance) =>
    <String, dynamic>{
      'pattern': instance.pattern,
      'runtimeType': instance.$type,
    };

TransformDef_Trim _$TransformDef_TrimFromJson(Map<String, dynamic> json) =>
    TransformDef_Trim($type: json['runtimeType'] as String?);

Map<String, dynamic> _$TransformDef_TrimToJson(TransformDef_Trim instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

TransformDef_Lower _$TransformDef_LowerFromJson(Map<String, dynamic> json) =>
    TransformDef_Lower($type: json['runtimeType'] as String?);

Map<String, dynamic> _$TransformDef_LowerToJson(TransformDef_Lower instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

TransformDef_Upper _$TransformDef_UpperFromJson(Map<String, dynamic> json) =>
    TransformDef_Upper($type: json['runtimeType'] as String?);

Map<String, dynamic> _$TransformDef_UpperToJson(TransformDef_Upper instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

TransformDef_RegexReplace _$TransformDef_RegexReplaceFromJson(
  Map<String, dynamic> json,
) => TransformDef_RegexReplace(
  pattern: json['pattern'] as String,
  replace: json['replace'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$TransformDef_RegexReplaceToJson(
  TransformDef_RegexReplace instance,
) => <String, dynamic>{
  'pattern': instance.pattern,
  'replace': instance.replace,
  'runtimeType': instance.$type,
};

TransformDef_Text _$TransformDef_TextFromJson(Map<String, dynamic> json) =>
    TransformDef_Text($type: json['runtimeType'] as String?);

Map<String, dynamic> _$TransformDef_TextToJson(TransformDef_Text instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

TransformDef_Attr _$TransformDef_AttrFromJson(Map<String, dynamic> json) =>
    TransformDef_Attr(
      name: json['name'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TransformDef_AttrToJson(TransformDef_Attr instance) =>
    <String, dynamic>{'name': instance.name, 'runtimeType': instance.$type};

TransformDef_Url _$TransformDef_UrlFromJson(Map<String, dynamic> json) =>
    TransformDef_Url($type: json['runtimeType'] as String?);

Map<String, dynamic> _$TransformDef_UrlToJson(TransformDef_Url instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

TransformDef_Js _$TransformDef_JsFromJson(Map<String, dynamic> json) =>
    TransformDef_Js(
      script: json['script'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TransformDef_JsToJson(TransformDef_Js instance) =>
    <String, dynamic>{'script': instance.script, 'runtimeType': instance.$type};
