//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateStoreRequest {
  /// Returns a new [UpdateStoreRequest] instance.
  UpdateStoreRequest({
    this.name,
    this.slug,
    this.initials,
    this.notes,
    this.userId,
    this.settings,
    this.domains = const [],
    this.scrapeStrategy,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? slug;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? initials;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? notes;

  int? userId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UpdateStoreRequestSettings? settings;

  List<MetaExtractionRequestStoreDomainsInner> domains;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UpdateStoreRequestScrapeStrategy? scrapeStrategy;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateStoreRequest &&
    other.name == name &&
    other.slug == slug &&
    other.initials == initials &&
    other.notes == notes &&
    other.userId == userId &&
    other.settings == settings &&
    _deepEquality.equals(other.domains, domains) &&
    other.scrapeStrategy == scrapeStrategy;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (slug == null ? 0 : slug!.hashCode) +
    (initials == null ? 0 : initials!.hashCode) +
    (notes == null ? 0 : notes!.hashCode) +
    (userId == null ? 0 : userId!.hashCode) +
    (settings == null ? 0 : settings!.hashCode) +
    (domains.hashCode) +
    (scrapeStrategy == null ? 0 : scrapeStrategy!.hashCode);

  @override
  String toString() => 'UpdateStoreRequest[name=$name, slug=$slug, initials=$initials, notes=$notes, userId=$userId, settings=$settings, domains=$domains, scrapeStrategy=$scrapeStrategy]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.slug != null) {
      json[r'slug'] = this.slug;
    } else {
      json[r'slug'] = null;
    }
    if (this.initials != null) {
      json[r'initials'] = this.initials;
    } else {
      json[r'initials'] = null;
    }
    if (this.notes != null) {
      json[r'notes'] = this.notes;
    } else {
      json[r'notes'] = null;
    }
    if (this.userId != null) {
      json[r'user_id'] = this.userId;
    } else {
      json[r'user_id'] = null;
    }
    if (this.settings != null) {
      json[r'settings'] = this.settings;
    } else {
      json[r'settings'] = null;
    }
      json[r'domains'] = this.domains;
    if (this.scrapeStrategy != null) {
      json[r'scrape_strategy'] = this.scrapeStrategy;
    } else {
      json[r'scrape_strategy'] = null;
    }
    return json;
  }

  /// Returns a new [UpdateStoreRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateStoreRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateStoreRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateStoreRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateStoreRequest(
        name: mapValueOfType<String>(json, r'name'),
        slug: mapValueOfType<String>(json, r'slug'),
        initials: mapValueOfType<String>(json, r'initials'),
        notes: mapValueOfType<String>(json, r'notes'),
        userId: mapValueOfType<int>(json, r'user_id'),
        settings: UpdateStoreRequestSettings.fromJson(json[r'settings']),
        domains: MetaExtractionRequestStoreDomainsInner.listFromJson(json[r'domains']),
        scrapeStrategy: UpdateStoreRequestScrapeStrategy.fromJson(json[r'scrape_strategy']),
      );
    }
    return null;
  }

  static List<UpdateStoreRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateStoreRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateStoreRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateStoreRequest> mapFromJson(dynamic json) {
    final map = <String, UpdateStoreRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateStoreRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateStoreRequest-objects as value to a dart map
  static Map<String, List<UpdateStoreRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateStoreRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateStoreRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}



