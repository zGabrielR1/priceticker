//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ClientConfig200ResponseData {
  /// Returns a new [ClientConfig200ResponseData] instance.
  ClientConfig200ResponseData({
    required this.capabilities,
    required this.limits,
    required this.appVersion,
  });

  ClientConfig200ResponseDataCapabilities capabilities;

  ClientConfig200ResponseDataLimits limits;

  String appVersion;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClientConfig200ResponseData &&
    other.capabilities == capabilities &&
    other.limits == limits &&
    other.appVersion == appVersion;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (capabilities.hashCode) +
    (limits.hashCode) +
    (appVersion.hashCode);

  @override
  String toString() => 'ClientConfig200ResponseData[capabilities=$capabilities, limits=$limits, appVersion=$appVersion]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'capabilities'] = this.capabilities;
      json[r'limits'] = this.limits;
      json[r'app_version'] = this.appVersion;
    return json;
  }

  /// Returns a new [ClientConfig200ResponseData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClientConfig200ResponseData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ClientConfig200ResponseData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ClientConfig200ResponseData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ClientConfig200ResponseData(
        capabilities: ClientConfig200ResponseDataCapabilities.fromJson(json[r'capabilities'])!,
        limits: ClientConfig200ResponseDataLimits.fromJson(json[r'limits'])!,
        appVersion: mapValueOfType<String>(json, r'app_version')!,
      );
    }
    return null;
  }

  static List<ClientConfig200ResponseData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClientConfig200ResponseData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClientConfig200ResponseData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClientConfig200ResponseData> mapFromJson(dynamic json) {
    final map = <String, ClientConfig200ResponseData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClientConfig200ResponseData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClientConfig200ResponseData-objects as value to a dart map
  static Map<String, List<ClientConfig200ResponseData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClientConfig200ResponseData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClientConfig200ResponseData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'capabilities',
    'limits',
    'app_version',
  };
}

