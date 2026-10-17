//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AuthLogin401Response {
  /// Returns a new [AuthLogin401Response] instance.
  AuthLogin401Response({
    required this.success,
    required this.message,
  });

  bool success;

  AuthLogin401ResponseMessageEnum message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AuthLogin401Response &&
    other.success == success &&
    other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (success.hashCode) +
    (message.hashCode);

  @override
  String toString() => 'AuthLogin401Response[success=$success, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'success'] = this.success;
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [AuthLogin401Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AuthLogin401Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "AuthLogin401Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "AuthLogin401Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AuthLogin401Response(
        success: mapValueOfType<bool>(json, r'success')!,
        message: AuthLogin401ResponseMessageEnum.fromJson(json[r'message'])!,
      );
    }
    return null;
  }

  static List<AuthLogin401Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AuthLogin401Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuthLogin401Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AuthLogin401Response> mapFromJson(dynamic json) {
    final map = <String, AuthLogin401Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AuthLogin401Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AuthLogin401Response-objects as value to a dart map
  static Map<String, List<AuthLogin401Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AuthLogin401Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AuthLogin401Response.listFromJson(entry.value, growable: growable,);
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


class AuthLogin401ResponseMessageEnum {
  /// Instantiate a new enum with the provided [value].
  const AuthLogin401ResponseMessageEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const theProvidedCredentialsAreIncorrectPeriod = AuthLogin401ResponseMessageEnum._(r'The provided credentials are incorrect.');

  /// List of all possible values in this [enum][AuthLogin401ResponseMessageEnum].
  static const values = <AuthLogin401ResponseMessageEnum>[
    theProvidedCredentialsAreIncorrectPeriod,
  ];

  static AuthLogin401ResponseMessageEnum? fromJson(dynamic value) => AuthLogin401ResponseMessageEnumTypeTransformer().decode(value);

  static List<AuthLogin401ResponseMessageEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AuthLogin401ResponseMessageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuthLogin401ResponseMessageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AuthLogin401ResponseMessageEnum] to String,
/// and [decode] dynamic data back to [AuthLogin401ResponseMessageEnum].
class AuthLogin401ResponseMessageEnumTypeTransformer {
  factory AuthLogin401ResponseMessageEnumTypeTransformer() => _instance ??= const AuthLogin401ResponseMessageEnumTypeTransformer._();

  const AuthLogin401ResponseMessageEnumTypeTransformer._();

  String encode(AuthLogin401ResponseMessageEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a AuthLogin401ResponseMessageEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AuthLogin401ResponseMessageEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'The provided credentials are incorrect.': return AuthLogin401ResponseMessageEnum.theProvidedCredentialsAreIncorrectPeriod;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [AuthLogin401ResponseMessageEnumTypeTransformer] instance.
  static AuthLogin401ResponseMessageEnumTypeTransformer? _instance;
}


