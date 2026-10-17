//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreateStoreRequestSettings {
  /// Returns a new [CreateStoreRequestSettings] instance.
  CreateStoreRequestSettings({
    required this.scraperService,
    this.scraperServiceSettings,
    this.localeSettings,
  });

  CreateStoreRequestSettingsScraperServiceEnum scraperService;

  String? scraperServiceSettings;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  CreateStoreRequestSettingsLocaleSettings? localeSettings;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateStoreRequestSettings &&
    other.scraperService == scraperService &&
    other.scraperServiceSettings == scraperServiceSettings &&
    other.localeSettings == localeSettings;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (scraperService.hashCode) +
    (scraperServiceSettings == null ? 0 : scraperServiceSettings!.hashCode) +
    (localeSettings == null ? 0 : localeSettings!.hashCode);

  @override
  String toString() => 'CreateStoreRequestSettings[scraperService=$scraperService, scraperServiceSettings=$scraperServiceSettings, localeSettings=$localeSettings]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'scraper_service'] = this.scraperService;
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

  /// Returns a new [CreateStoreRequestSettings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateStoreRequestSettings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CreateStoreRequestSettings[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CreateStoreRequestSettings[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreateStoreRequestSettings(
        scraperService: CreateStoreRequestSettingsScraperServiceEnum.fromJson(json[r'scraper_service'])!,
        scraperServiceSettings: mapValueOfType<String>(json, r'scraper_service_settings'),
        localeSettings: CreateStoreRequestSettingsLocaleSettings.fromJson(json[r'locale_settings']),
      );
    }
    return null;
  }

  static List<CreateStoreRequestSettings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateStoreRequestSettings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateStoreRequestSettings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateStoreRequestSettings> mapFromJson(dynamic json) {
    final map = <String, CreateStoreRequestSettings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateStoreRequestSettings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateStoreRequestSettings-objects as value to a dart map
  static Map<String, List<CreateStoreRequestSettings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateStoreRequestSettings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateStoreRequestSettings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'scraper_service',
  };
}


class CreateStoreRequestSettingsScraperServiceEnum {
  /// Instantiate a new enum with the provided [value].
  const CreateStoreRequestSettingsScraperServiceEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const http = CreateStoreRequestSettingsScraperServiceEnum._(r'http');
  static const api = CreateStoreRequestSettingsScraperServiceEnum._(r'api');

  /// List of all possible values in this [enum][CreateStoreRequestSettingsScraperServiceEnum].
  static const values = <CreateStoreRequestSettingsScraperServiceEnum>[
    http,
    api,
  ];

  static CreateStoreRequestSettingsScraperServiceEnum? fromJson(dynamic value) => CreateStoreRequestSettingsScraperServiceEnumTypeTransformer().decode(value);

  static List<CreateStoreRequestSettingsScraperServiceEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateStoreRequestSettingsScraperServiceEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateStoreRequestSettingsScraperServiceEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CreateStoreRequestSettingsScraperServiceEnum] to String,
/// and [decode] dynamic data back to [CreateStoreRequestSettingsScraperServiceEnum].
class CreateStoreRequestSettingsScraperServiceEnumTypeTransformer {
  factory CreateStoreRequestSettingsScraperServiceEnumTypeTransformer() => _instance ??= const CreateStoreRequestSettingsScraperServiceEnumTypeTransformer._();

  const CreateStoreRequestSettingsScraperServiceEnumTypeTransformer._();

  String encode(CreateStoreRequestSettingsScraperServiceEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CreateStoreRequestSettingsScraperServiceEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CreateStoreRequestSettingsScraperServiceEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'http': return CreateStoreRequestSettingsScraperServiceEnum.http;
        case r'api': return CreateStoreRequestSettingsScraperServiceEnum.api;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CreateStoreRequestSettingsScraperServiceEnumTypeTransformer] instance.
  static CreateStoreRequestSettingsScraperServiceEnumTypeTransformer? _instance;
}


