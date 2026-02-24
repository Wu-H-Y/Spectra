// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pipeline_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PipelineNode _$PipelineNodeFromJson(Map<String, dynamic> json) =>
    _PipelineNode(
      type: $enumDecode(_$PipelineNodeTypeEnumMap, json['type']),
      operator: json['operator'] as String,
      argument: json['argument'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$PipelineNodeToJson(_PipelineNode instance) =>
    <String, dynamic>{
      'type': _$PipelineNodeTypeEnumMap[instance.type]!,
      'operator': instance.operator,
      'argument': ?instance.argument,
      'description': ?instance.description,
    };

const _$PipelineNodeTypeEnumMap = {
  PipelineNodeType.selector: 'selector',
  PipelineNodeType.extractor: 'extractor',
  PipelineNodeType.transform: 'transform',
  PipelineNodeType.aggregation: 'aggregation',
};

_Pipeline _$PipelineFromJson(Map<String, dynamic> json) => _Pipeline(
  nodes: (json['nodes'] as List<dynamic>)
      .map((e) => PipelineNode.fromJson(e as Map<String, dynamic>))
      .toList(),
  outputField: json['output_field'] as String?,
);

Map<String, dynamic> _$PipelineToJson(_Pipeline instance) => <String, dynamic>{
  'nodes': instance.nodes.map((e) => e.toJson()).toList(),
  'output_field': ?instance.outputField,
};
