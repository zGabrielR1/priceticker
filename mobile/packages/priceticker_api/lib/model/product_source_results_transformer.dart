//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSourceResultsTransformer {
  /// Returns a new [ProductSourceResultsTransformer] instance.
  ProductSourceResultsTransformer({
    required this.title,
    required this.url,
    this.source_,
    this.sourceId,
  });

  String title;

  String url;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? source_;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sourceId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSourceResultsTransformer &&
    other.title == title &&
    other.url == url &&
    other.source_ == source_ &&
    other.sourceId == sourceId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (url.hashCode) +
    (source_ == null ? 0 : source_!.hashCode) +
    (sourceId == null ? 0 : sourceId!.hashCode);

  @override
  String toString() => 'ProductSourceResultsTransformer[title=$title, url=$url, source_=$source_, sourceId=$sourceId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
      json[r'url'] = this.url;
    if (this.source_ != null) {
      json[r'source'] = this.source_;
    } else {
      json[r'source'] = null;
    }
    if (this.sourceId != null) {
      json[r'source_id'] = this.sourceId;
    } else {
      json[r'source_id'] = null;
    }
    return json;
  }

  /// Returns a new [ProductSourceResultsTransformer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSourceResultsTransformer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProductSourceResultsTransformer[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProductSourceResultsTransformer[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProductSourceResultsTransformer(
        title: mapValueOfType<String>(json, r'title')!,
        url: mapValueOfType<String>(json, r'url')!,
        source_: mapValueOfType<String>(json, r'source'),
        sourceId: mapValueOfType<String>(json, r'source_id'),
      );
    }
    return null;
  }

  static List<ProductSourceResultsTransformer> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSourceResultsTransformer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSourceResultsTransformer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSourceResultsTransformer> mapFromJson(dynamic json) {
    final map = <String, ProductSourceResultsTransformer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSourceResultsTransformer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSourceResultsTransformer-objects as value to a dart map
  static Map<String, List<ProductSourceResultsTransformer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSourceResultsTransformer>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSourceResultsTransformer.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'url',
  };
}

