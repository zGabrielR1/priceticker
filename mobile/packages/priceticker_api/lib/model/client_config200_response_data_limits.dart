//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ClientConfig200ResponseDataLimits {
  /// Returns a new [ClientConfig200ResponseDataLimits] instance.
  ClientConfig200ResponseDataLimits({
    required this.metaExtractionTimeoutSeconds,
  });

  int metaExtractionTimeoutSeconds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClientConfig200ResponseDataLimits &&
    other.metaExtractionTimeoutSeconds == metaExtractionTimeoutSeconds;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (metaExtractionTimeoutSeconds.hashCode);

  @override
  String toString() => 'ClientConfig200ResponseDataLimits[metaExtractionTimeoutSeconds=$metaExtractionTimeoutSeconds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'meta_extraction_timeout_seconds'] = this.metaExtractionTimeoutSeconds;
    return json;
  }

  /// Returns a new [ClientConfig200ResponseDataLimits] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClientConfig200ResponseDataLimits? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ClientConfig200ResponseDataLimits[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ClientConfig200ResponseDataLimits[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ClientConfig200ResponseDataLimits(
        metaExtractionTimeoutSeconds: mapValueOfType<int>(json, r'meta_extraction_timeout_seconds')!,
      );
    }
    return null;
  }

  static List<ClientConfig200ResponseDataLimits> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClientConfig200ResponseDataLimits>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClientConfig200ResponseDataLimits.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClientConfig200ResponseDataLimits> mapFromJson(dynamic json) {
    final map = <String, ClientConfig200ResponseDataLimits>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClientConfig200ResponseDataLimits.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClientConfig200ResponseDataLimits-objects as value to a dart map
  static Map<String, List<ClientConfig200ResponseDataLimits>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClientConfig200ResponseDataLimits>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClientConfig200ResponseDataLimits.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'meta_extraction_timeout_seconds',
  };
}

