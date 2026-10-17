//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateStoreRequestScrapeStrategyPrice {
  /// Returns a new [UpdateStoreRequestScrapeStrategyPrice] instance.
  UpdateStoreRequestScrapeStrategyPrice({
    this.type,
    this.value,
  });

  UpdateStoreRequestScrapeStrategyPriceTypeEnum? type;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateStoreRequestScrapeStrategyPrice &&
    other.type == type &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (type == null ? 0 : type!.hashCode) +
    (value == null ? 0 : value!.hashCode);

  @override
  String toString() => 'UpdateStoreRequestScrapeStrategyPrice[type=$type, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.value != null) {
      json[r'value'] = this.value;
    } else {
      json[r'value'] = null;
    }
    return json;
  }

  /// Returns a new [UpdateStoreRequestScrapeStrategyPrice] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateStoreRequestScrapeStrategyPrice? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateStoreRequestScrapeStrategyPrice[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateStoreRequestScrapeStrategyPrice[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateStoreRequestScrapeStrategyPrice(
        type: UpdateStoreRequestScrapeStrategyPriceTypeEnum.fromJson(json[r'type']),
        value: mapValueOfType<String>(json, r'value'),
      );
    }
    return null;
  }

  static List<UpdateStoreRequestScrapeStrategyPrice> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateStoreRequestScrapeStrategyPrice>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateStoreRequestScrapeStrategyPrice.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateStoreRequestScrapeStrategyPrice> mapFromJson(dynamic json) {
    final map = <String, UpdateStoreRequestScrapeStrategyPrice>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateStoreRequestScrapeStrategyPrice.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateStoreRequestScrapeStrategyPrice-objects as value to a dart map
  static Map<String, List<UpdateStoreRequestScrapeStrategyPrice>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateStoreRequestScrapeStrategyPrice>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateStoreRequestScrapeStrategyPrice.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class UpdateStoreRequestScrapeStrategyPriceTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const UpdateStoreRequestScrapeStrategyPriceTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const schemaOrg = UpdateStoreRequestScrapeStrategyPriceTypeEnum._(r'schema_org');
  static const selector = UpdateStoreRequestScrapeStrategyPriceTypeEnum._(r'selector');
  static const xpath = UpdateStoreRequestScrapeStrategyPriceTypeEnum._(r'xpath');
  static const regex = UpdateStoreRequestScrapeStrategyPriceTypeEnum._(r'regex');
  static const json = UpdateStoreRequestScrapeStrategyPriceTypeEnum._(r'json');

  /// List of all possible values in this [enum][UpdateStoreRequestScrapeStrategyPriceTypeEnum].
  static const values = <UpdateStoreRequestScrapeStrategyPriceTypeEnum>[
    schemaOrg,
    selector,
    xpath,
    regex,
    json,
  ];

  static UpdateStoreRequestScrapeStrategyPriceTypeEnum? fromJson(dynamic value) => UpdateStoreRequestScrapeStrategyPriceTypeEnumTypeTransformer().decode(value);

  static List<UpdateStoreRequestScrapeStrategyPriceTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateStoreRequestScrapeStrategyPriceTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateStoreRequestScrapeStrategyPriceTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UpdateStoreRequestScrapeStrategyPriceTypeEnum] to String,
/// and [decode] dynamic data back to [UpdateStoreRequestScrapeStrategyPriceTypeEnum].
class UpdateStoreRequestScrapeStrategyPriceTypeEnumTypeTransformer {
  factory UpdateStoreRequestScrapeStrategyPriceTypeEnumTypeTransformer() => _instance ??= const UpdateStoreRequestScrapeStrategyPriceTypeEnumTypeTransformer._();

  const UpdateStoreRequestScrapeStrategyPriceTypeEnumTypeTransformer._();

  String encode(UpdateStoreRequestScrapeStrategyPriceTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UpdateStoreRequestScrapeStrategyPriceTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UpdateStoreRequestScrapeStrategyPriceTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'schema_org': return UpdateStoreRequestScrapeStrategyPriceTypeEnum.schemaOrg;
        case r'selector': return UpdateStoreRequestScrapeStrategyPriceTypeEnum.selector;
        case r'xpath': return UpdateStoreRequestScrapeStrategyPriceTypeEnum.xpath;
        case r'regex': return UpdateStoreRequestScrapeStrategyPriceTypeEnum.regex;
        case r'json': return UpdateStoreRequestScrapeStrategyPriceTypeEnum.json;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UpdateStoreRequestScrapeStrategyPriceTypeEnumTypeTransformer] instance.
  static UpdateStoreRequestScrapeStrategyPriceTypeEnumTypeTransformer? _instance;
}


