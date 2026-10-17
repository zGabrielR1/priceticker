//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class V1DevicesDestroy204Response {
  /// Returns a new [V1DevicesDestroy204Response] instance.
  V1DevicesDestroy204Response({
    required this.message,
  });

  V1DevicesDestroy204ResponseMessageEnum message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is V1DevicesDestroy204Response &&
    other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (message.hashCode);

  @override
  String toString() => 'V1DevicesDestroy204Response[message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [V1DevicesDestroy204Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static V1DevicesDestroy204Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "V1DevicesDestroy204Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "V1DevicesDestroy204Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return V1DevicesDestroy204Response(
        message: V1DevicesDestroy204ResponseMessageEnum.fromJson(json[r'message'])!,
      );
    }
    return null;
  }

  static List<V1DevicesDestroy204Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <V1DevicesDestroy204Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = V1DevicesDestroy204Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, V1DevicesDestroy204Response> mapFromJson(dynamic json) {
    final map = <String, V1DevicesDestroy204Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = V1DevicesDestroy204Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of V1DevicesDestroy204Response-objects as value to a dart map
  static Map<String, List<V1DevicesDestroy204Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<V1DevicesDestroy204Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = V1DevicesDestroy204Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'message',
  };
}


class V1DevicesDestroy204ResponseMessageEnum {
  /// Instantiate a new enum with the provided [value].
  const V1DevicesDestroy204ResponseMessageEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const deleted = V1DevicesDestroy204ResponseMessageEnum._(r'Deleted');

  /// List of all possible values in this [enum][V1DevicesDestroy204ResponseMessageEnum].
  static const values = <V1DevicesDestroy204ResponseMessageEnum>[
    deleted,
  ];

  static V1DevicesDestroy204ResponseMessageEnum? fromJson(dynamic value) => V1DevicesDestroy204ResponseMessageEnumTypeTransformer().decode(value);

  static List<V1DevicesDestroy204ResponseMessageEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <V1DevicesDestroy204ResponseMessageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = V1DevicesDestroy204ResponseMessageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [V1DevicesDestroy204ResponseMessageEnum] to String,
/// and [decode] dynamic data back to [V1DevicesDestroy204ResponseMessageEnum].
class V1DevicesDestroy204ResponseMessageEnumTypeTransformer {
  factory V1DevicesDestroy204ResponseMessageEnumTypeTransformer() => _instance ??= const V1DevicesDestroy204ResponseMessageEnumTypeTransformer._();

  const V1DevicesDestroy204ResponseMessageEnumTypeTransformer._();

  String encode(V1DevicesDestroy204ResponseMessageEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a V1DevicesDestroy204ResponseMessageEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  V1DevicesDestroy204ResponseMessageEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Deleted': return V1DevicesDestroy204ResponseMessageEnum.deleted;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [V1DevicesDestroy204ResponseMessageEnumTypeTransformer] instance.
  static V1DevicesDestroy204ResponseMessageEnumTypeTransformer? _instance;
}


