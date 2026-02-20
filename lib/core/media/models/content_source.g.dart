// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentSource _$ContentSourceFromJson(Map<String, dynamic> json) =>
    _ContentSource(
      ruleId: json['ruleId'] as String,
      siteName: json['siteName'] as String,
      originalUrl: json['originalUrl'] as String,
      crawledAt: DateTime.parse(json['crawledAt'] as String),
      siteIcon: json['siteIcon'] as String?,
    );

Map<String, dynamic> _$ContentSourceToJson(_ContentSource instance) =>
    <String, dynamic>{
      'ruleId': instance.ruleId,
      'siteName': instance.siteName,
      'originalUrl': instance.originalUrl,
      'crawledAt': instance.crawledAt.toIso8601String(),
      'siteIcon': instance.siteIcon,
    };
