//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateStoreRequestSettings {
  /// Returns a new [UpdateStoreRequestSettings] instance.
  UpdateStoreRequestSettings({
    this.scraperService,
    this.scraperServiceSettings,
    this.localeSettings,
  });

  UpdateStoreRequestSettingsScraperServiceEnum? scraperService;

  String? scraperServiceSettings;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MetaExtractionRequestStoreSettingsLocaleSettings? localeSettings;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateStoreRequestSettings &&
    other.scraperService == scraperService &&
    other.scraperServiceSettings == scraperServiceSettings &&
    other.localeSettings == localeSettings;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (scraperService == null ? 0 : scraperService!.hashCode) +
    (scraperServiceSettings == null ? 0 : scraperServiceSettings!.hashCode) +
    (localeSettings == null ? 0 : localeSettings!.hashCode);

  @override
  String toString() => 'UpdateStoreRequestSettings[scraperService=$scraperService, scraperServiceSettings=$scraperServiceSettings, localeSettings=$localeSettings]';

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
    if (this.localeSettings != null) {
      json[r'locale_settings'] = this.localeSettings;
    } else {
      json[r'locale_settings'] = null;
    }
    return json;
  }

  /// Returns a new [UpdateStoreRequestSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateStoreRequestSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateStoreRequestSettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateStoreRequestSettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateStoreRequestSettings(
        scraperService: UpdateStoreRequestSettingsScraperServiceEnum.fromJson(json[r'scraper_service']),
        scraperServiceSettings: mapValueOfType<String>(json, r'scraper_service_settings'),
        localeSettings: MetaExtractionRequestStoreSettingsLocaleSettings.fromJson(json[r'locale_settings']),
      );
    }
    return null;
  }

  static List<UpdateStoreRequestSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateStoreRequestSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateStoreRequestSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateStoreRequestSettings> mapFromJson(dynamic json) {
    final map = <String, UpdateStoreRequestSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateStoreRequestSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateStoreRequestSettings-objects as value to a dart map
  static Map<String, List<UpdateStoreRequestSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateStoreRequestSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateStoreRequestSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class UpdateStoreRequestSettingsScraperServiceEnum {
  /// Instantiate a new enum with the provided [value].
  const UpdateStoreRequestSettingsScraperServiceEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const http = UpdateStoreRequestSettingsScraperServiceEnum._(r'http');
  static const api = UpdateStoreRequestSettingsScraperServiceEnum._(r'api');

  /// List of all possible values in this [enum][UpdateStoreRequestSettingsScraperServiceEnum].
  static const values = <UpdateStoreRequestSettingsScraperServiceEnum>[
    http,
    api,
  ];

  static UpdateStoreRequestSettingsScraperServiceEnum? fromJson(dynamic value) => UpdateStoreRequestSettingsScraperServiceEnumTypeTransformer().decode(value);

  static List<UpdateStoreRequestSettingsScraperServiceEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateStoreRequestSettingsScraperServiceEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateStoreRequestSettingsScraperServiceEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UpdateStoreRequestSettingsScraperServiceEnum] to String,
/// and [decode] dynamic data back to [UpdateStoreRequestSettingsScraperServiceEnum].
class UpdateStoreRequestSettingsScraperServiceEnumTypeTransformer {
  factory UpdateStoreRequestSettingsScraperServiceEnumTypeTransformer() => _instance ??= const UpdateStoreRequestSettingsScraperServiceEnumTypeTransformer._();

  const UpdateStoreRequestSettingsScraperServiceEnumTypeTransformer._();

  String encode(UpdateStoreRequestSettingsScraperServiceEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UpdateStoreRequestSettingsScraperServiceEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UpdateStoreRequestSettingsScraperServiceEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'http': return UpdateStoreRequestSettingsScraperServiceEnum.http;
        case r'api': return UpdateStoreRequestSettingsScraperServiceEnum.api;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UpdateStoreRequestSettingsScraperServiceEnumTypeTransformer] instance.
  static UpdateStoreRequestSettingsScraperServiceEnumTypeTransformer? _instance;
}


