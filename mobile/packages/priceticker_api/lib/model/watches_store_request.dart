//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WatchesStoreRequest {
  /// Returns a new [WatchesStoreRequest] instance.
  WatchesStoreRequest({
    required this.type,
    required this.name,
    this.config = const [],
    this.rules = const [],
    this.isActive,
  });

  WatchesStoreRequestTypeEnum type;

  String name;

  List<String> config;

  List<String> rules;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isActive;

  @override
  bool operator ==(Object other) => identical(this, other) || other is WatchesStoreRequest &&
    other.type == type &&
    other.name == name &&
    _deepEquality.equals(other.config, config) &&
    _deepEquality.equals(other.rules, rules) &&
    other.isActive == isActive;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (type.hashCode) +
    (name.hashCode) +
    (config.hashCode) +
    (rules.hashCode) +
    (isActive == null ? 0 : isActive!.hashCode);

  @override
  String toString() => 'WatchesStoreRequest[type=$type, name=$name, config=$config, rules=$rules, isActive=$isActive]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'type'] = this.type;
      json[r'name'] = this.name;
      json[r'config'] = this.config;
      json[r'rules'] = this.rules;
    if (this.isActive != null) {
      json[r'is_active'] = this.isActive;
    } else {
      json[r'is_active'] = null;
    }
    return json;
  }

  /// Returns a new [WatchesStoreRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WatchesStoreRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "WatchesStoreRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "WatchesStoreRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WatchesStoreRequest(
        type: WatchesStoreRequestTypeEnum.fromJson(json[r'type'])!,
        name: mapValueOfType<String>(json, r'name')!,
        config: json[r'config'] is Iterable
            ? (json[r'config'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        rules: json[r'rules'] is Iterable
            ? (json[r'rules'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        isActive: mapValueOfType<bool>(json, r'is_active'),
      );
    }
    return null;
  }

  static List<WatchesStoreRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WatchesStoreRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WatchesStoreRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WatchesStoreRequest> mapFromJson(dynamic json) {
    final map = <String, WatchesStoreRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WatchesStoreRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WatchesStoreRequest-objects as value to a dart map
  static Map<String, List<WatchesStoreRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WatchesStoreRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = WatchesStoreRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'type',
    'name',
  };
}


class WatchesStoreRequestTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const WatchesStoreRequestTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const product = WatchesStoreRequestTypeEnum._(r'product');
  static const family = WatchesStoreRequestTypeEnum._(r'family');
  static const category = WatchesStoreRequestTypeEnum._(r'category');
  static const brand = WatchesStoreRequestTypeEnum._(r'brand');
  static const coupon = WatchesStoreRequestTypeEnum._(r'coupon');

  /// List of all possible values in this [enum][WatchesStoreRequestTypeEnum].
  static const values = <WatchesStoreRequestTypeEnum>[
    product,
    family,
    category,
    brand,
    coupon,
  ];

  static WatchesStoreRequestTypeEnum? fromJson(dynamic value) => WatchesStoreRequestTypeEnumTypeTransformer().decode(value);

  static List<WatchesStoreRequestTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WatchesStoreRequestTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WatchesStoreRequestTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WatchesStoreRequestTypeEnum] to String,
/// and [decode] dynamic data back to [WatchesStoreRequestTypeEnum].
class WatchesStoreRequestTypeEnumTypeTransformer {
  factory WatchesStoreRequestTypeEnumTypeTransformer() => _instance ??= const WatchesStoreRequestTypeEnumTypeTransformer._();

  const WatchesStoreRequestTypeEnumTypeTransformer._();

  String encode(WatchesStoreRequestTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a WatchesStoreRequestTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WatchesStoreRequestTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'product': return WatchesStoreRequestTypeEnum.product;
        case r'family': return WatchesStoreRequestTypeEnum.family;
        case r'category': return WatchesStoreRequestTypeEnum.category;
        case r'brand': return WatchesStoreRequestTypeEnum.brand;
        case r'coupon': return WatchesStoreRequestTypeEnum.coupon;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [WatchesStoreRequestTypeEnumTypeTransformer] instance.
  static WatchesStoreRequestTypeEnumTypeTransformer? _instance;
}


