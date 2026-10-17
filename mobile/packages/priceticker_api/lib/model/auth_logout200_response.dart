//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AuthLogout200Response {
  /// Returns a new [AuthLogout200Response] instance.
  AuthLogout200Response({
    required this.success,
    required this.message,
  });

  bool success;

  AuthLogout200ResponseMessageEnum message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AuthLogout200Response &&
    other.success == success &&
    other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (success.hashCode) +
    (message.hashCode);

  @override
  String toString() => 'AuthLogout200Response[success=$success, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'success'] = this.success;
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [AuthLogout200Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AuthLogout200Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AuthLogout200Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AuthLogout200Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AuthLogout200Response(
        success: mapValueOfType<bool>(json, r'success')!,
        message: AuthLogout200ResponseMessageEnum.fromJson(json[r'message'])!,
      );
    }
    return null;
  }

  static List<AuthLogout200Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AuthLogout200Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuthLogout200Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AuthLogout200Response> mapFromJson(dynamic json) {
    final map = <String, AuthLogout200Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AuthLogout200Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AuthLogout200Response-objects as value to a dart map
  static Map<String, List<AuthLogout200Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AuthLogout200Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AuthLogout200Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'success',
    'message',
  };
}


class AuthLogout200ResponseMessageEnum {
  /// Instantiate a new enum with the provided [value].
  const AuthLogout200ResponseMessageEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const logoutSuccessPeriod = AuthLogout200ResponseMessageEnum._(r'Logout success.');

  /// List of all possible values in this [enum][AuthLogout200ResponseMessageEnum].
  static const values = <AuthLogout200ResponseMessageEnum>[
    logoutSuccessPeriod,
  ];

  static AuthLogout200ResponseMessageEnum? fromJson(dynamic value) => AuthLogout200ResponseMessageEnumTypeTransformer().decode(value);

  static List<AuthLogout200ResponseMessageEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AuthLogout200ResponseMessageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuthLogout200ResponseMessageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AuthLogout200ResponseMessageEnum] to String,
/// and [decode] dynamic data back to [AuthLogout200ResponseMessageEnum].
class AuthLogout200ResponseMessageEnumTypeTransformer {
  factory AuthLogout200ResponseMessageEnumTypeTransformer() => _instance ??= const AuthLogout200ResponseMessageEnumTypeTransformer._();

  const AuthLogout200ResponseMessageEnumTypeTransformer._();

  String encode(AuthLogout200ResponseMessageEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a AuthLogout200ResponseMessageEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AuthLogout200ResponseMessageEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Logout success.': return AuthLogout200ResponseMessageEnum.logoutSuccessPeriod;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AuthLogout200ResponseMessageEnumTypeTransformer] instance.
  static AuthLogout200ResponseMessageEnumTypeTransformer? _instance;
}


