//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class V1AuthTokenRequest {
  /// Returns a new [V1AuthTokenRequest] instance.
  V1AuthTokenRequest({
    required this.email,
    required this.password,
    this.deviceName,
  });

  String email;

  String password;

  String? deviceName;

  @override
  bool operator ==(Object other) => identical(this, other) || other is V1AuthTokenRequest &&
    other.email == email &&
    other.password == password &&
    other.deviceName == deviceName;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email.hashCode) +
    (password.hashCode) +
    (deviceName == null ? 0 : deviceName!.hashCode);

  @override
  String toString() => 'V1AuthTokenRequest[email=$email, password=$password, deviceName=$deviceName]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'email'] = this.email;
      json[r'password'] = this.password;
    if (this.deviceName != null) {
      json[r'device_name'] = this.deviceName;
    } else {
      json[r'device_name'] = null;
    }
    return json;
  }

  /// Returns a new [V1AuthTokenRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static V1AuthTokenRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "V1AuthTokenRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "V1AuthTokenRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return V1AuthTokenRequest(
        email: mapValueOfType<String>(json, r'email')!,
        password: mapValueOfType<String>(json, r'password')!,
        deviceName: mapValueOfType<String>(json, r'device_name'),
      );
    }
    return null;
  }

  static List<V1AuthTokenRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <V1AuthTokenRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = V1AuthTokenRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, V1AuthTokenRequest> mapFromJson(dynamic json) {
    final map = <String, V1AuthTokenRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = V1AuthTokenRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of V1AuthTokenRequest-objects as value to a dart map
  static Map<String, List<V1AuthTokenRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<V1AuthTokenRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = V1AuthTokenRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'email',
    'password',
  };
}

