//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AuthLogin201Response {
  /// Returns a new [AuthLogin201Response] instance.
  AuthLogin201Response({
    required this.success,
    required this.message,
    required this.token,
  });

  bool success;

  AuthLogin201ResponseMessageEnum message;

  String token;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AuthLogin201Response &&
    other.success == success &&
    other.message == message &&
    other.token == token;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (success.hashCode) +
    (message.hashCode) +
    (token.hashCode);

  @override
  String toString() => 'AuthLogin201Response[success=$success, message=$message, token=$token]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'success'] = this.success;
      json[r'message'] = this.message;
      json[r'token'] = this.token;
    return json;
  }

  /// Returns a new [AuthLogin201Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AuthLogin201Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AuthLogin201Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AuthLogin201Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AuthLogin201Response(
        success: mapValueOfType<bool>(json, r'success')!,
        message: AuthLogin201ResponseMessageEnum.fromJson(json[r'message'])!,
        token: mapValueOfType<String>(json, r'token')!,
      );
    }
    return null;
  }

  static List<AuthLogin201Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AuthLogin201Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuthLogin201Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AuthLogin201Response> mapFromJson(dynamic json) {
    final map = <String, AuthLogin201Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AuthLogin201Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AuthLogin201Response-objects as value to a dart map
  static Map<String, List<AuthLogin201Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AuthLogin201Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AuthLogin201Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'success',
    'message',
    'token',
  };
}


class AuthLogin201ResponseMessageEnum {
  /// Instantiate a new enum with the provided [value].
  const AuthLogin201ResponseMessageEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const loginSuccessPeriod = AuthLogin201ResponseMessageEnum._(r'Login success.');

  /// List of all possible values in this [enum][AuthLogin201ResponseMessageEnum].
  static const values = <AuthLogin201ResponseMessageEnum>[
    loginSuccessPeriod,
  ];

  static AuthLogin201ResponseMessageEnum? fromJson(dynamic value) => AuthLogin201ResponseMessageEnumTypeTransformer().decode(value);

  static List<AuthLogin201ResponseMessageEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AuthLogin201ResponseMessageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuthLogin201ResponseMessageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AuthLogin201ResponseMessageEnum] to String,
/// and [decode] dynamic data back to [AuthLogin201ResponseMessageEnum].
class AuthLogin201ResponseMessageEnumTypeTransformer {
  factory AuthLogin201ResponseMessageEnumTypeTransformer() => _instance ??= const AuthLogin201ResponseMessageEnumTypeTransformer._();

  const AuthLogin201ResponseMessageEnumTypeTransformer._();

  String encode(AuthLogin201ResponseMessageEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a AuthLogin201ResponseMessageEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AuthLogin201ResponseMessageEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Login success.': return AuthLogin201ResponseMessageEnum.loginSuccessPeriod;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AuthLogin201ResponseMessageEnumTypeTransformer] instance.
  static AuthLogin201ResponseMessageEnumTypeTransformer? _instance;
}


