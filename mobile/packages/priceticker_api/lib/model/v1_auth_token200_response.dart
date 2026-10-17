//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class V1AuthToken200Response {
  /// Returns a new [V1AuthToken200Response] instance.
  V1AuthToken200Response({
    required this.token,
    required this.tokenType,
  });

  String token;

  V1AuthToken200ResponseTokenTypeEnum tokenType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is V1AuthToken200Response &&
    other.token == token &&
    other.tokenType == tokenType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (token.hashCode) +
    (tokenType.hashCode);

  @override
  String toString() => 'V1AuthToken200Response[token=$token, tokenType=$tokenType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'token'] = this.token;
      json[r'token_type'] = this.tokenType;
    return json;
  }

  /// Returns a new [V1AuthToken200Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static V1AuthToken200Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "V1AuthToken200Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "V1AuthToken200Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return V1AuthToken200Response(
        token: mapValueOfType<String>(json, r'token')!,
        tokenType: V1AuthToken200ResponseTokenTypeEnum.fromJson(json[r'token_type'])!,
      );
    }
    return null;
  }

  static List<V1AuthToken200Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <V1AuthToken200Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = V1AuthToken200Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, V1AuthToken200Response> mapFromJson(dynamic json) {
    final map = <String, V1AuthToken200Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = V1AuthToken200Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of V1AuthToken200Response-objects as value to a dart map
  static Map<String, List<V1AuthToken200Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<V1AuthToken200Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = V1AuthToken200Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'token',
    'token_type',
  };
}


class V1AuthToken200ResponseTokenTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const V1AuthToken200ResponseTokenTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const bearer = V1AuthToken200ResponseTokenTypeEnum._(r'Bearer');

  /// List of all possible values in this [enum][V1AuthToken200ResponseTokenTypeEnum].
  static const values = <V1AuthToken200ResponseTokenTypeEnum>[
    bearer,
  ];

  static V1AuthToken200ResponseTokenTypeEnum? fromJson(dynamic value) => V1AuthToken200ResponseTokenTypeEnumTypeTransformer().decode(value);

  static List<V1AuthToken200ResponseTokenTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <V1AuthToken200ResponseTokenTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = V1AuthToken200ResponseTokenTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [V1AuthToken200ResponseTokenTypeEnum] to String,
/// and [decode] dynamic data back to [V1AuthToken200ResponseTokenTypeEnum].
class V1AuthToken200ResponseTokenTypeEnumTypeTransformer {
  factory V1AuthToken200ResponseTokenTypeEnumTypeTransformer() => _instance ??= const V1AuthToken200ResponseTokenTypeEnumTypeTransformer._();

  const V1AuthToken200ResponseTokenTypeEnumTypeTransformer._();

  String encode(V1AuthToken200ResponseTokenTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a V1AuthToken200ResponseTokenTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  V1AuthToken200ResponseTokenTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Bearer': return V1AuthToken200ResponseTokenTypeEnum.bearer;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [V1AuthToken200ResponseTokenTypeEnumTypeTransformer] instance.
  static V1AuthToken200ResponseTokenTypeEnumTypeTransformer? _instance;
}


