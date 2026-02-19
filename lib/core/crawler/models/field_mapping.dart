import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/selector.dart';
import 'package:spectra/core/crawler/models/transform.dart';

part 'field_mapping.freezed.dart';
part 'field_mapping.g.dart';

/// Field mapping for extracting and transforming data.
@freezed
sealed class FieldMapping with _$FieldMapping {
  const factory FieldMapping({
    /// Target field name in output.
    required String field,

    /// Selector for extracting the value.
    required Selector selector,

    /// Default value if extraction fails.
    String? defaultValue,

    /// List of transformations to apply.
    List<Transform>? transforms,

    /// Whether this field is required.
    @Default(false) bool required,
  }) = _FieldMapping;

  factory FieldMapping.fromJson(Map<String, dynamic> json) =>
      _$FieldMappingFromJson(json);
}
