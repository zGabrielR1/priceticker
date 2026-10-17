//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StoreResource {
  /// Returns a new [StoreResource] instance.
  StoreResource({
    required this.id,
    required this.name,
    required this.slug,
    required this.initials,
    this.domains = const [],
    required this.scrapeSettings,
    this.settings = const [],
    required this.currency,
    required this.locale,
  });

  String id;

  String name;

  String slug;

  String? initials;

  List<Object> domains;

  /// Exposed as `scrape_settings` in the API; the model attribute is `scrape_strategy`. The name differs intentionally to keep the public contract stable.
  String? scrapeSettings;

  List<Object> settings;

  StoreResourceCurrency currency;

  String locale;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StoreResource &&
    other.id == id &&
    other.name == name &&
    other.slug == slug &&
    other.initials == initials &&
    _deepEquality.equals(other.domains, domains) &&
    other.scrapeSettings == scrapeSettings &&
    _deepEquality.equals(other.settings, settings) &&
    other.currency == currency &&
    other.locale == locale;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (slug.hashCode) +
    (initials == null ? 0 : initials!.hashCode) +
    (domains.hashCode) +
    (scrapeSettings == null ? 0 : scrapeSettings!.hashCode) +
    (settings.hashCode) +
    (currency.hashCode) +
    (locale.hashCode);

  @override
  String toString() => 'StoreResource[id=$id, name=$name, slug=$slug, initials=$initials, domains=$domains, scrapeSettings=$scrapeSettings, settings=$settings, currency=$currency, locale=$locale]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
      json[r'slug'] = this.slug;
    if (this.initials != null) {
      json[r'initials'] = this.initials;
    } else {
      json[r'initials'] = null;
    }
      json[r'domains'] = this.domains;
    if (this.scrapeSettings != null) {
      json[r'scrape_settings'] = this.scrapeSettings;
    } else {
      json[r'scrape_settings'] = null;
    }
      json[r'settings'] = this.settings;
      json[r'currency'] = this.currency;
      json[r'locale'] = this.locale;
    return json;
  }

  /// Returns a new [StoreResource] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StoreResource? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StoreResource[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StoreResource[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StoreResource(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        slug: mapValueOfType<String>(json, r'slug')!,
        initials: mapValueOfType<String>(json, r'initials'),
        domains: json[r'domains'],
        scrapeSettings: mapValueOfType<String>(json, r'scrape_settings'),
        settings: json[r'settings'],
        currency: StoreResourceCurrency.fromJson(json[r'currency'])!,
        locale: mapValueOfType<String>(json, r'locale')!,
      );
    }
    return null;
  }

  static List<StoreResource> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StoreResource>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StoreResource.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StoreResource> mapFromJson(dynamic json) {
    final map = <String, StoreResource>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StoreResource.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StoreResource-objects as value to a dart map
  static Map<String, List<StoreResource>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StoreResource>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StoreResource.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'slug',
    'initials',
    'domains',
    'scrape_settings',
    'settings',
    'currency',
    'locale',
  };
}

