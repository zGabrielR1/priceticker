//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateStoreRequestScrapeStrategyImage {
  /// Returns a new [UpdateStoreRequestScrapeStrategyImage] instance.
  UpdateStoreRequestScrapeStrategyImage({
    this.type,
    this.value,
  });

  /// The value rules are conditional on the type: schema_org takes no value, everything else requires one. Shared with meta-extraction so a strategy that tests successfully can always be saved. See ScrapeStrategyValue.
  UpdateStoreRequestScrapeStrategyImageTypeEnum? type;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateStoreRequestScrapeStrategyImage &&
    other.type == type &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (type == null ? 0 : type!.hashCode) +
    (value == null ? 0 : value!.hashCode);

  @override
  String toString() => 'UpdateStoreRequestScrapeStrategyImage[type=$type, value=$value]';

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

  /// Returns a new [UpdateStoreRequestScrapeStrategyImage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateStoreRequestScrapeStrategyImage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateStoreRequestScrapeStrategyImage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateStoreRequestScrapeStrategyImage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateStoreRequestScrapeStrategyImage(
        type: UpdateStoreRequestScrapeStrategyImageTypeEnum.fromJson(json[r'type']),
        value: mapValueOfType<String>(json, r'value'),
      );
    }
    return null;
  }

  static List<UpdateStoreRequestScrapeStrategyImage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateStoreRequestScrapeStrategyImage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateStoreRequestScrapeStrategyImage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateStoreRequestScrapeStrategyImage> mapFromJson(dynamic json) {
    final map = <String, UpdateStoreRequestScrapeStrategyImage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateStoreRequestScrapeStrategyImage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateStoreRequestScrapeStrategyImage-objects as value to a dart map
  static Map<String, List<UpdateStoreRequestScrapeStrategyImage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateStoreRequestScrapeStrategyImage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateStoreRequestScrapeStrategyImage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

/// The value rules are conditional on the type: schema_org takes no value, everything else requires one. Shared with meta-extraction so a strategy that tests successfully can always be saved. See ScrapeStrategyValue.
class UpdateStoreRequestScrapeStrategyImageTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const UpdateStoreRequestScrapeStrategyImageTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const schemaOrg = UpdateStoreRequestScrapeStrategyImageTypeEnum._(r'schema_org');
  static const selector = UpdateStoreRequestScrapeStrategyImageTypeEnum._(r'selector');
  static const xpath = UpdateStoreRequestScrapeStrategyImageTypeEnum._(r'xpath');
  static const regex = UpdateStoreRequestScrapeStrategyImageTypeEnum._(r'regex');
  static const json = UpdateStoreRequestScrapeStrategyImageTypeEnum._(r'json');

  /// List of all possible values in this [enum][UpdateStoreRequestScrapeStrategyImageTypeEnum].
  static const values = <UpdateStoreRequestScrapeStrategyImageTypeEnum>[
    schemaOrg,
    selector,
    xpath,
    regex,
    json,
  ];

  static UpdateStoreRequestScrapeStrategyImageTypeEnum? fromJson(dynamic value) => UpdateStoreRequestScrapeStrategyImageTypeEnumTypeTransformer().decode(value);

  static List<UpdateStoreRequestScrapeStrategyImageTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateStoreRequestScrapeStrategyImageTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateStoreRequestScrapeStrategyImageTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UpdateStoreRequestScrapeStrategyImageTypeEnum] to String,
/// and [decode] dynamic data back to [UpdateStoreRequestScrapeStrategyImageTypeEnum].
class UpdateStoreRequestScrapeStrategyImageTypeEnumTypeTransformer {
  factory UpdateStoreRequestScrapeStrategyImageTypeEnumTypeTransformer() => _instance ??= const UpdateStoreRequestScrapeStrategyImageTypeEnumTypeTransformer._();

  const UpdateStoreRequestScrapeStrategyImageTypeEnumTypeTransformer._();

  String encode(UpdateStoreRequestScrapeStrategyImageTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UpdateStoreRequestScrapeStrategyImageTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UpdateStoreRequestScrapeStrategyImageTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'schema_org': return UpdateStoreRequestScrapeStrategyImageTypeEnum.schemaOrg;
        case r'selector': return UpdateStoreRequestScrapeStrategyImageTypeEnum.selector;
        case r'xpath': return UpdateStoreRequestScrapeStrategyImageTypeEnum.xpath;
        case r'regex': return UpdateStoreRequestScrapeStrategyImageTypeEnum.regex;
        case r'json': return UpdateStoreRequestScrapeStrategyImageTypeEnum.json;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UpdateStoreRequestScrapeStrategyImageTypeEnumTypeTransformer] instance.
  static UpdateStoreRequestScrapeStrategyImageTypeEnumTypeTransformer? _instance;
}


