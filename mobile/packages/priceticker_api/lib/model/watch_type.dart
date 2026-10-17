//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class WatchType {
  /// Instantiate a new enum with the provided [value].
  const WatchType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const product = WatchType._(r'product');
  static const family = WatchType._(r'family');
  static const category = WatchType._(r'category');
  static const brand = WatchType._(r'brand');
  static const coupon = WatchType._(r'coupon');

  /// List of all possible values in this [enum][WatchType].
  static const values = <WatchType>[
    product,
    family,
    category,
    brand,
    coupon,
  ];

  static WatchType? fromJson(dynamic value) => WatchTypeTypeTransformer().decode(value);

  static List<WatchType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WatchType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WatchType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WatchType] to String,
/// and [decode] dynamic data back to [WatchType].
class WatchTypeTypeTransformer {
  factory WatchTypeTypeTransformer() => _instance ??= const WatchTypeTypeTransformer._();

  const WatchTypeTypeTransformer._();

  String encode(WatchType data) => data.value;

  /// Decodes a [dynamic value][data] to a WatchType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WatchType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'product': return WatchType.product;
        case r'family': return WatchType.family;
        case r'category': return WatchType.category;
        case r'brand': return WatchType.brand;
        case r'coupon': return WatchType.coupon;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [WatchTypeTypeTransformer] instance.
  static WatchTypeTypeTransformer? _instance;
}

