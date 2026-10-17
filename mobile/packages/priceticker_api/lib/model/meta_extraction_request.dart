//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MetaExtractionRequest {
  /// Returns a new [MetaExtractionRequest] instance.
  MetaExtractionRequest({
    required this.url,
    this.heal,
    this.store,
  });

  String url;

  /// Opt in to AI healing. Off by default: healing is slow and may propose a different strategy than the one being tested, so a caller has to ask for it and be prepared to wait (up to the published extraction budget).
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? heal;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MetaExtractionRequestStore? store;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MetaExtractionRequest &&
    other.url == url &&
    other.heal == heal &&
    other.store == store;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (url.hashCode) +
    (heal == null ? 0 : heal!.hashCode) +
    (store == null ? 0 : store!.hashCode);

  @override
  String toString() => 'MetaExtractionRequest[url=$url, heal=$heal, store=$store]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'url'] = this.url;
    if (this.heal != null) {
      json[r'heal'] = this.heal;
    } else {
      json[r'heal'] = null;
    }
    if (this.store != null) {
      json[r'store'] = this.store;
    } else {
      json[r'store'] = null;
    }
    return json;
  }

  /// Returns a new [MetaExtractionRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MetaExtractionRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MetaExtractionRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MetaExtractionRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MetaExtractionRequest(
        url: mapValueOfType<String>(json, r'url')!,
        heal: mapValueOfType<bool>(json, r'heal'),
        store: MetaExtractionRequestStore.fromJson(json[r'store']),
      );
    }
    return null;
  }

  static List<MetaExtractionRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MetaExtractionRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MetaExtractionRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MetaExtractionRequest> mapFromJson(dynamic json) {
    final map = <String, MetaExtractionRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MetaExtractionRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MetaExtractionRequest-objects as value to a dart map
  static Map<String, List<MetaExtractionRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MetaExtractionRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MetaExtractionRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'url',
  };
}

