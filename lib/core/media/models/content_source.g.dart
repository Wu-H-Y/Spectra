// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContentSource _$ContentSourceFromJson(Map<String, dynamic> json) =>
    _ContentSource(
      ruleId: json['rule_id'] as String,
      siteName: json['site_name'] as String,
      originalUrl: json['original_url'] as String,
      crawledAt: DateTime.parse(json['crawled_at'] as String),
      siteIcon: json['site_icon'] as String?,
    );

Map<String, dynamic> _$ContentSourceToJson(_ContentSource instance) =>
    <String, dynamic>{
      'rule_id': instance.ruleId,
      'site_name': instance.siteName,
      'original_url': instance.originalUrl,
      'crawled_at': instance.crawledAt.toIso8601String(),
      'site_icon': ?instance.siteIcon,
    };
