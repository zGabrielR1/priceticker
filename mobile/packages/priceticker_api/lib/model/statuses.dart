//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class Statuses {
  /// Instantiate a new enum with the provided [value].
  const Statuses._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const p = Statuses._(r'p');
  static const a = Statuses._(r'a');

  /// List of all possible values in this [enum][Statuses].
  static const values = <Statuses>[
    p,
    a,
  ];

  static Statuses? fromJson(dynamic value) => StatusesTypeTransformer().decode(value);

  static List<Statuses> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Statuses>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Statuses.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [Statuses] to String,
/// and [decode] dynamic data back to [Statuses].
class StatusesTypeTransformer {
  factory StatusesTypeTransformer() => _instance ??= const StatusesTypeTransformer._();

  const StatusesTypeTransformer._();

  String encode(Statuses data) => data.value;

  /// Decodes a [dynamic value][data] to a Statuses.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  Statuses? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'p': return Statuses.p;
        case r'a': return Statuses.a;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [StatusesTypeTransformer] instance.
  static StatusesTypeTransformer? _instance;
}

