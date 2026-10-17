//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSourcesCreate201Response {
  /// Returns a new [ProductSourcesCreate201Response] instance.
  ProductSourcesCreate201Response({
    required this.data,
    required this.message,
  });

  ProductSourceTransformer data;

  ProductSourcesCreate201ResponseMessageEnum message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSourcesCreate201Response &&
    other.data == data &&
    other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (data.hashCode) +
    (message.hashCode);

  @override
  String toString() => 'ProductSourcesCreate201Response[data=$data, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'data'] = this.data;
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [ProductSourcesCreate201Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSourcesCreate201Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProductSourcesCreate201Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProductSourcesCreate201Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProductSourcesCreate201Response(
        data: ProductSourceTransformer.fromJson(json[r'data'])!,
        message: ProductSourcesCreate201ResponseMessageEnum.fromJson(json[r'message'])!,
      );
    }
    return null;
  }

  static List<ProductSourcesCreate201Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSourcesCreate201Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSourcesCreate201Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSourcesCreate201Response> mapFromJson(dynamic json) {
    final map = <String, ProductSourcesCreate201Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSourcesCreate201Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSourcesCreate201Response-objects as value to a dart map
  static Map<String, List<ProductSourcesCreate201Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSourcesCreate201Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSourcesCreate201Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'data',
    'message',
  };
}


class ProductSourcesCreate201ResponseMessageEnum {
  /// Instantiate a new enum with the provided [value].
  const ProductSourcesCreate201ResponseMessageEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const productSourceCreated = ProductSourcesCreate201ResponseMessageEnum._(r'Product source created');

  /// List of all possible values in this [enum][ProductSourcesCreate201ResponseMessageEnum].
  static const values = <ProductSourcesCreate201ResponseMessageEnum>[
    productSourceCreated,
  ];

  static ProductSourcesCreate201ResponseMessageEnum? fromJson(dynamic value) => ProductSourcesCreate201ResponseMessageEnumTypeTransformer().decode(value);

  static List<ProductSourcesCreate201ResponseMessageEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSourcesCreate201ResponseMessageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSourcesCreate201ResponseMessageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductSourcesCreate201ResponseMessageEnum] to String,
/// and [decode] dynamic data back to [ProductSourcesCreate201ResponseMessageEnum].
class ProductSourcesCreate201ResponseMessageEnumTypeTransformer {
  factory ProductSourcesCreate201ResponseMessageEnumTypeTransformer() => _instance ??= const ProductSourcesCreate201ResponseMessageEnumTypeTransformer._();

  const ProductSourcesCreate201ResponseMessageEnumTypeTransformer._();

  String encode(ProductSourcesCreate201ResponseMessageEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a ProductSourcesCreate201ResponseMessageEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductSourcesCreate201ResponseMessageEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Product source created': return ProductSourcesCreate201ResponseMessageEnum.productSourceCreated;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ProductSourcesCreate201ResponseMessageEnumTypeTransformer] instance.
  static ProductSourcesCreate201ResponseMessageEnumTypeTransformer? _instance;
}


