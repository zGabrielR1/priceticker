//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MetaExtraction200Response {
  /// Returns a new [MetaExtraction200Response] instance.
  MetaExtraction200Response({
    required this.data,
  });

  MetaExtractionResource data;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MetaExtraction200Response &&
    other.data == data;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (data.hashCode);

  @override
  String toString() => 'MetaExtraction200Response[data=$data]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'data'] = this.data;
    return json;
  }

  /// Returns a new [MetaExtraction200Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MetaExtraction200Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MetaExtraction200Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MetaExtraction200Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MetaExtraction200Response(
        data: MetaExtractionResource.fromJson(json[r'data'])!,
      );
    }
    return null;
  }

  static List<MetaExtraction200Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MetaExtraction200Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MetaExtraction200Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MetaExtraction200Response> mapFromJson(dynamic json) {
    final map = <String, MetaExtraction200Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MetaExtraction200Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MetaExtraction200Response-objects as value to a dart map
  static Map<String, List<MetaExtraction200Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MetaExtraction200Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MetaExtraction200Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'data',
  };
}

