//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MetaExtractionRequestStoreScrapeStrategyTitle {
  /// Returns a new [MetaExtractionRequestStoreScrapeStrategyTitle] instance.
  MetaExtractionRequestStoreScrapeStrategyTitle({
    this.type,
    this.value,
    this.prepend,
    this.append,
  });

  MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum? type;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? value;

  String? prepend;

  String? append;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MetaExtractionRequestStoreScrapeStrategyTitle &&
    other.type == type &&
    other.value == value &&
    other.prepend == prepend &&
    other.append == append;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (type == null ? 0 : type!.hashCode) +
    (value == null ? 0 : value!.hashCode) +
    (prepend == null ? 0 : prepend!.hashCode) +
    (append == null ? 0 : append!.hashCode);

  @override
  String toString() => 'MetaExtractionRequestStoreScrapeStrategyTitle[type=$type, value=$value, prepend=$prepend, append=$append]';

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
    if (this.prepend != null) {
      json[r'prepend'] = this.prepend;
    } else {
      json[r'prepend'] = null;
    }
    if (this.append != null) {
      json[r'append'] = this.append;
    } else {
      json[r'append'] = null;
    }
    return json;
  }

  /// Returns a new [MetaExtractionRequestStoreScrapeStrategyTitle] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MetaExtractionRequestStoreScrapeStrategyTitle? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MetaExtractionRequestStoreScrapeStrategyTitle[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MetaExtractionRequestStoreScrapeStrategyTitle[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MetaExtractionRequestStoreScrapeStrategyTitle(
        type: MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum.fromJson(json[r'type']),
        value: mapValueOfType<String>(json, r'value'),
        prepend: mapValueOfType<String>(json, r'prepend'),
        append: mapValueOfType<String>(json, r'append'),
      );
    }
    return null;
  }

  static List<MetaExtractionRequestStoreScrapeStrategyTitle> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MetaExtractionRequestStoreScrapeStrategyTitle>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MetaExtractionRequestStoreScrapeStrategyTitle.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MetaExtractionRequestStoreScrapeStrategyTitle> mapFromJson(dynamic json) {
    final map = <String, MetaExtractionRequestStoreScrapeStrategyTitle>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MetaExtractionRequestStoreScrapeStrategyTitle.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MetaExtractionRequestStoreScrapeStrategyTitle-objects as value to a dart map
  static Map<String, List<MetaExtractionRequestStoreScrapeStrategyTitle>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MetaExtractionRequestStoreScrapeStrategyTitle>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MetaExtractionRequestStoreScrapeStrategyTitle.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const schemaOrg = MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum._(r'schema_org');
  static const selector = MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum._(r'selector');
  static const xpath = MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum._(r'xpath');
  static const regex = MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum._(r'regex');
  static const json = MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum._(r'json');

  /// List of all possible values in this [enum][MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum].
  static const values = <MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum>[
    schemaOrg,
    selector,
    xpath,
    regex,
    json,
  ];

  static MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum? fromJson(dynamic value) => MetaExtractionRequestStoreScrapeStrategyTitleTypeEnumTypeTransformer().decode(value);

  static List<MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum] to String,
/// and [decode] dynamic data back to [MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum].
class MetaExtractionRequestStoreScrapeStrategyTitleTypeEnumTypeTransformer {
  factory MetaExtractionRequestStoreScrapeStrategyTitleTypeEnumTypeTransformer() => _instance ??= const MetaExtractionRequestStoreScrapeStrategyTitleTypeEnumTypeTransformer._();

  const MetaExtractionRequestStoreScrapeStrategyTitleTypeEnumTypeTransformer._();

  String encode(MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'schema_org': return MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum.schemaOrg;
        case r'selector': return MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum.selector;
        case r'xpath': return MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum.xpath;
        case r'regex': return MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum.regex;
        case r'json': return MetaExtractionRequestStoreScrapeStrategyTitleTypeEnum.json;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [MetaExtractionRequestStoreScrapeStrategyTitleTypeEnumTypeTransformer] instance.
  static MetaExtractionRequestStoreScrapeStrategyTitleTypeEnumTypeTransformer? _instance;
}


