//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class V1DevicesStoreRequest {
  /// Returns a new [V1DevicesStoreRequest] instance.
  V1DevicesStoreRequest({
    required this.fcmToken,
    this.platform,
    this.deviceId,
  });

  String fcmToken;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? platform;

  String? deviceId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is V1DevicesStoreRequest &&
    other.fcmToken == fcmToken &&
    other.platform == platform &&
    other.deviceId == deviceId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (fcmToken.hashCode) +
    (platform == null ? 0 : platform!.hashCode) +
    (deviceId == null ? 0 : deviceId!.hashCode);

  @override
  String toString() => 'V1DevicesStoreRequest[fcmToken=$fcmToken, platform=$platform, deviceId=$deviceId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'fcm_token'] = this.fcmToken;
    if (this.platform != null) {
      json[r'platform'] = this.platform;
    } else {
      json[r'platform'] = null;
    }
    if (this.deviceId != null) {
      json[r'device_id'] = this.deviceId;
    } else {
      json[r'device_id'] = null;
    }
    return json;
  }

  /// Returns a new [V1DevicesStoreRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static V1DevicesStoreRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "V1DevicesStoreRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "V1DevicesStoreRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return V1DevicesStoreRequest(
        fcmToken: mapValueOfType<String>(json, r'fcm_token')!,
        platform: mapValueOfType<String>(json, r'platform'),
        deviceId: mapValueOfType<String>(json, r'device_id'),
      );
    }
    return null;
  }

  static List<V1DevicesStoreRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <V1DevicesStoreRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = V1DevicesStoreRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, V1DevicesStoreRequest> mapFromJson(dynamic json) {
    final map = <String, V1DevicesStoreRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = V1DevicesStoreRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of V1DevicesStoreRequest-objects as value to a dart map
  static Map<String, List<V1DevicesStoreRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<V1DevicesStoreRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = V1DevicesStoreRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'fcm_token',
  };
}

