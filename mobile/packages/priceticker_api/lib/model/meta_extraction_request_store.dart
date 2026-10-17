//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MetaExtractionRequestStore {
  /// Returns a new [MetaExtractionRequestStore] instance.
  MetaExtractionRequestStore({
    this.name,
    this.domains = const [],
    this.settings,
    this.scrapeStrategy,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  List<MetaExtractionRequestStoreDomainsInner> domains;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MetaExtractionRequestStoreSettings? settings;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MetaExtractionRequestStoreScrapeStrategy? scrapeStrategy;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MetaExtractionRequestStore &&
    other.name == name &&
    _deepEquality.equals(other.domains, domains) &&
    other.settings == settings &&
    other.scrapeStrategy == scrapeStrategy;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (domains.hashCode) +
    (settings == null ? 0 : settings!.hashCode) +
    (scrapeStrategy == null ? 0 : scrapeStrategy!.hashCode);

  @override
  String toString() => 'MetaExtractionRequestStore[name=$name, domains=$domains, settings=$settings, scrapeStrategy=$scrapeStrategy]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
      json[r'domains'] = this.domains;
    if (this.settings != null) {
      json[r'settings'] = this.settings;
    } else {
      json[r'settings'] = null;
    }
    if (this.scrapeStrategy != null) {
      json[r'scrape_strategy'] = this.scrapeStrategy;
    } else {
      json[r'scrape_strategy'] = null;
    }
    return json;
  }

  /// Returns a new [MetaExtractionRequestStore] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MetaExtractionRequestStore? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MetaExtractionRequestStore[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MetaExtractionRequestStore[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MetaExtractionRequestStore(
        name: mapValueOfType<String>(json, r'name'),
        domains: MetaExtractionRequestStoreDomainsInner.listFromJson(json[r'domains']),
        settings: MetaExtractionRequestStoreSettings.fromJson(json[r'settings']),
        scrapeStrategy: MetaExtractionRequestStoreScrapeStrategy.fromJson(json[r'scrape_strategy']),
      );
    }
    return null;
  }

  static List<MetaExtractionRequestStore> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MetaExtractionRequestStore>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MetaExtractionRequestStore.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MetaExtractionRequestStore> mapFromJson(dynamic json) {
    final map = <String, MetaExtractionRequestStore>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MetaExtractionRequestStore.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MetaExtractionRequestStore-objects as value to a dart map
  static Map<String, List<MetaExtractionRequestStore>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MetaExtractionRequestStore>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MetaExtractionRequestStore.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

