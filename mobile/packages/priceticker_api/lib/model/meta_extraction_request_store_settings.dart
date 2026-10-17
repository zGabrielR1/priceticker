//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MetaExtractionRequestStoreSettings {
  /// Returns a new [MetaExtractionRequestStoreSettings] instance.
  MetaExtractionRequestStoreSettings({
    this.scraperService,
    this.scraperServiceSettings,
    this.cookies,
    this.localeSettings,
  });

  MetaExtractionRequestStoreSettingsScraperServiceEnum? scraperService;

  String? scraperServiceSettings;

  String? cookies;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MetaExtractionRequestStoreSettingsLocaleSettings? localeSettings;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MetaExtractionRequestStoreSettings &&
    other.scraperService == scraperService &&
    other.scraperServiceSettings == scraperServiceSettings &&
    other.cookies == cookies &&
    other.localeSettings == localeSettings;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (scraperService == null ? 0 : scraperService!.hashCode) +
    (scraperServiceSettings == null ? 0 : scraperServiceSettings!.hashCode) +
    (cookies == null ? 0 : cookies!.hashCode) +
    (localeSettings == null ? 0 : localeSettings!.hashCode);

  @override
  String toString() => 'MetaExtractionRequestStoreSettings[scraperService=$scraperService, scraperServiceSettings=$scraperServiceSettings, cookies=$cookies, localeSettings=$localeSettings]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.scraperService != null) {
      json[r'scraper_service'] = this.scraperService;
    } else {
      json[r'scraper_service'] = null;
    }
    if (this.scraperServiceSettings != null) {
      json[r'scraper_service_settings'] = this.scraperServiceSettings;
    } else {
      json[r'scraper_service_settings'] = null;
    }
    if (this.cookies != null) {
      json[r'cookies'] = this.cookies;
    } else {
      json[r'cookies'] = null;
    }
    if (this.localeSettings != null) {
      json[r'locale_settings'] = this.localeSettings;
    } else {
      json[r'locale_settings'] = null;
    }
    return json;
  }

  /// Returns a new [MetaExtractionRequestStoreSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MetaExtractionRequestStoreSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MetaExtractionRequestStoreSettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MetaExtractionRequestStoreSettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MetaExtractionRequestStoreSettings(
        scraperService: MetaExtractionRequestStoreSettingsScraperServiceEnum.fromJson(json[r'scraper_service']),
        scraperServiceSettings: mapValueOfType<String>(json, r'scraper_service_settings'),
        cookies: mapValueOfType<String>(json, r'cookies'),
        localeSettings: MetaExtractionRequestStoreSettingsLocaleSettings.fromJson(json[r'locale_settings']),
      );
    }
    return null;
  }

  static List<MetaExtractionRequestStoreSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MetaExtractionRequestStoreSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MetaExtractionRequestStoreSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MetaExtractionRequestStoreSettings> mapFromJson(dynamic json) {
    final map = <String, MetaExtractionRequestStoreSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MetaExtractionRequestStoreSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MetaExtractionRequestStoreSettings-objects as value to a dart map
  static Map<String, List<MetaExtractionRequestStoreSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MetaExtractionRequestStoreSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MetaExtractionRequestStoreSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class MetaExtractionRequestStoreSettingsScraperServiceEnum {
  /// Instantiate a new enum with the provided [value].
  const MetaExtractionRequestStoreSettingsScraperServiceEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const http = MetaExtractionRequestStoreSettingsScraperServiceEnum._(r'http');
  static const api = MetaExtractionRequestStoreSettingsScraperServiceEnum._(r'api');

  /// List of all possible values in this [enum][MetaExtractionRequestStoreSettingsScraperServiceEnum].
  static const values = <MetaExtractionRequestStoreSettingsScraperServiceEnum>[
    http,
    api,
  ];

  static MetaExtractionRequestStoreSettingsScraperServiceEnum? fromJson(dynamic value) => MetaExtractionRequestStoreSettingsScraperServiceEnumTypeTransformer().decode(value);

  static List<MetaExtractionRequestStoreSettingsScraperServiceEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MetaExtractionRequestStoreSettingsScraperServiceEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MetaExtractionRequestStoreSettingsScraperServiceEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MetaExtractionRequestStoreSettingsScraperServiceEnum] to String,
/// and [decode] dynamic data back to [MetaExtractionRequestStoreSettingsScraperServiceEnum].
class MetaExtractionRequestStoreSettingsScraperServiceEnumTypeTransformer {
  factory MetaExtractionRequestStoreSettingsScraperServiceEnumTypeTransformer() => _instance ??= const MetaExtractionRequestStoreSettingsScraperServiceEnumTypeTransformer._();

  const MetaExtractionRequestStoreSettingsScraperServiceEnumTypeTransformer._();

  String encode(MetaExtractionRequestStoreSettingsScraperServiceEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a MetaExtractionRequestStoreSettingsScraperServiceEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MetaExtractionRequestStoreSettingsScraperServiceEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'http': return MetaExtractionRequestStoreSettingsScraperServiceEnum.http;
        case r'api': return MetaExtractionRequestStoreSettingsScraperServiceEnum.api;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [MetaExtractionRequestStoreSettingsScraperServiceEnumTypeTransformer] instance.
  static MetaExtractionRequestStoreSettingsScraperServiceEnumTypeTransformer? _instance;
}


