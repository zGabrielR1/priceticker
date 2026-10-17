//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class V1AuthRevoke200Response {
  /// Returns a new [V1AuthRevoke200Response] instance.
  V1AuthRevoke200Response({
    required this.message,
  });

  V1AuthRevoke200ResponseMessageEnum message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is V1AuthRevoke200Response &&
    other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (message.hashCode);

  @override
  String toString() => 'V1AuthRevoke200Response[message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [V1AuthRevoke200Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static V1AuthRevoke200Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "V1AuthRevoke200Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "V1AuthRevoke200Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return V1AuthRevoke200Response(
        message: V1AuthRevoke200ResponseMessageEnum.fromJson(json[r'message'])!,
      );
    }
    return null;
  }

  static List<V1AuthRevoke200Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <V1AuthRevoke200Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = V1AuthRevoke200Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, V1AuthRevoke200Response> mapFromJson(dynamic json) {
    final map = <String, V1AuthRevoke200Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = V1AuthRevoke200Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of V1AuthRevoke200Response-objects as value to a dart map
  static Map<String, List<V1AuthRevoke200Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<V1AuthRevoke200Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = V1AuthRevoke200Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'message',
  };
}


class V1AuthRevoke200ResponseMessageEnum {
  /// Instantiate a new enum with the provided [value].
  const V1AuthRevoke200ResponseMessageEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const tokenRevoked = V1AuthRevoke200ResponseMessageEnum._(r'Token revoked');

  /// List of all possible values in this [enum][V1AuthRevoke200ResponseMessageEnum].
  static const values = <V1AuthRevoke200ResponseMessageEnum>[
    tokenRevoked,
  ];

  static V1AuthRevoke200ResponseMessageEnum? fromJson(dynamic value) => V1AuthRevoke200ResponseMessageEnumTypeTransformer().decode(value);

  static List<V1AuthRevoke200ResponseMessageEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <V1AuthRevoke200ResponseMessageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = V1AuthRevoke200ResponseMessageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [V1AuthRevoke200ResponseMessageEnum] to String,
/// and [decode] dynamic data back to [V1AuthRevoke200ResponseMessageEnum].
class V1AuthRevoke200ResponseMessageEnumTypeTransformer {
  factory V1AuthRevoke200ResponseMessageEnumTypeTransformer() => _instance ??= const V1AuthRevoke200ResponseMessageEnumTypeTransformer._();

  const V1AuthRevoke200ResponseMessageEnumTypeTransformer._();

  String encode(V1AuthRevoke200ResponseMessageEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a V1AuthRevoke200ResponseMessageEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  V1AuthRevoke200ResponseMessageEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Token revoked': return V1AuthRevoke200ResponseMessageEnum.tokenRevoked;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [V1AuthRevoke200ResponseMessageEnumTypeTransformer] instance.
  static V1AuthRevoke200ResponseMessageEnumTypeTransformer? _instance;
}


