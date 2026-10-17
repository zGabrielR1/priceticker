//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class WatchesUpdateRequest {
  /// Returns a new [WatchesUpdateRequest] instance.
  WatchesUpdateRequest({
    this.type,
    this.name,
    this.config = const [],
    this.rules = const [],
    this.isActive,
  });

  WatchesUpdateRequestTypeEnum? type;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

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
  bool operator ==(Object other) => identical(this, other) || other is WatchesUpdateRequest &&
    other.type == type &&
    other.name == name &&
    _deepEquality.equals(other.config, config) &&
    _deepEquality.equals(other.rules, rules) &&
    other.isActive == isActive;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (type == null ? 0 : type!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (config.hashCode) +
    (rules.hashCode) +
    (isActive == null ? 0 : isActive!.hashCode);

  @override
  String toString() => 'WatchesUpdateRequest[type=$type, name=$name, config=$config, rules=$rules, isActive=$isActive]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
      json[r'config'] = this.config;
      json[r'rules'] = this.rules;
    if (this.isActive != null) {
      json[r'is_active'] = this.isActive;
    } else {
      json[r'is_active'] = null;
    }
    return json;
  }

  /// Returns a new [WatchesUpdateRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static WatchesUpdateRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "WatchesUpdateRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "WatchesUpdateRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return WatchesUpdateRequest(
        type: WatchesUpdateRequestTypeEnum.fromJson(json[r'type']),
        name: mapValueOfType<String>(json, r'name'),
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

  static List<WatchesUpdateRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WatchesUpdateRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WatchesUpdateRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, WatchesUpdateRequest> mapFromJson(dynamic json) {
    final map = <String, WatchesUpdateRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = WatchesUpdateRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of WatchesUpdateRequest-objects as value to a dart map
  static Map<String, List<WatchesUpdateRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<WatchesUpdateRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = WatchesUpdateRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class WatchesUpdateRequestTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const WatchesUpdateRequestTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const product = WatchesUpdateRequestTypeEnum._(r'product');
  static const family = WatchesUpdateRequestTypeEnum._(r'family');
  static const category = WatchesUpdateRequestTypeEnum._(r'category');
  static const brand = WatchesUpdateRequestTypeEnum._(r'brand');
  static const coupon = WatchesUpdateRequestTypeEnum._(r'coupon');

  /// List of all possible values in this [enum][WatchesUpdateRequestTypeEnum].
  static const values = <WatchesUpdateRequestTypeEnum>[
    product,
    family,
    category,
    brand,
    coupon,
  ];

  static WatchesUpdateRequestTypeEnum? fromJson(dynamic value) => WatchesUpdateRequestTypeEnumTypeTransformer().decode(value);

  static List<WatchesUpdateRequestTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <WatchesUpdateRequestTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = WatchesUpdateRequestTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [WatchesUpdateRequestTypeEnum] to String,
/// and [decode] dynamic data back to [WatchesUpdateRequestTypeEnum].
class WatchesUpdateRequestTypeEnumTypeTransformer {
  factory WatchesUpdateRequestTypeEnumTypeTransformer() => _instance ??= const WatchesUpdateRequestTypeEnumTypeTransformer._();

  const WatchesUpdateRequestTypeEnumTypeTransformer._();

  String encode(WatchesUpdateRequestTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a WatchesUpdateRequestTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  WatchesUpdateRequestTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'product': return WatchesUpdateRequestTypeEnum.product;
        case r'family': return WatchesUpdateRequestTypeEnum.family;
        case r'category': return WatchesUpdateRequestTypeEnum.category;
        case r'brand': return WatchesUpdateRequestTypeEnum.brand;
        case r'coupon': return WatchesUpdateRequestTypeEnum.coupon;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [WatchesUpdateRequestTypeEnumTypeTransformer] instance.
  static WatchesUpdateRequestTypeEnumTypeTransformer? _instance;
}


