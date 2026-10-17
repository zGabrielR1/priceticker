//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductsCreate201Response {
  /// Returns a new [ProductsCreate201Response] instance.
  ProductsCreate201Response({
    required this.data,
    required this.message,
  });

  ProductTransformer data;

  ProductsCreate201ResponseMessageEnum message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductsCreate201Response &&
    other.data == data &&
    other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (data.hashCode) +
    (message.hashCode);

  @override
  String toString() => 'ProductsCreate201Response[data=$data, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'data'] = this.data;
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [ProductsCreate201Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductsCreate201Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProductsCreate201Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProductsCreate201Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProductsCreate201Response(
        data: ProductTransformer.fromJson(json[r'data'])!,
        message: ProductsCreate201ResponseMessageEnum.fromJson(json[r'message'])!,
      );
    }
    return null;
  }

  static List<ProductsCreate201Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductsCreate201Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductsCreate201Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductsCreate201Response> mapFromJson(dynamic json) {
    final map = <String, ProductsCreate201Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductsCreate201Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductsCreate201Response-objects as value to a dart map
  static Map<String, List<ProductsCreate201Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductsCreate201Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductsCreate201Response.listFromJson(entry.value, growable: growable,);
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


class ProductsCreate201ResponseMessageEnum {
  /// Instantiate a new enum with the provided [value].
  const ProductsCreate201ResponseMessageEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const productCreated = ProductsCreate201ResponseMessageEnum._(r'Product created');

  /// List of all possible values in this [enum][ProductsCreate201ResponseMessageEnum].
  static const values = <ProductsCreate201ResponseMessageEnum>[
    productCreated,
  ];

  static ProductsCreate201ResponseMessageEnum? fromJson(dynamic value) => ProductsCreate201ResponseMessageEnumTypeTransformer().decode(value);

  static List<ProductsCreate201ResponseMessageEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductsCreate201ResponseMessageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductsCreate201ResponseMessageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductsCreate201ResponseMessageEnum] to String,
/// and [decode] dynamic data back to [ProductsCreate201ResponseMessageEnum].
class ProductsCreate201ResponseMessageEnumTypeTransformer {
  factory ProductsCreate201ResponseMessageEnumTypeTransformer() => _instance ??= const ProductsCreate201ResponseMessageEnumTypeTransformer._();

  const ProductsCreate201ResponseMessageEnumTypeTransformer._();

  String encode(ProductsCreate201ResponseMessageEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a ProductsCreate201ResponseMessageEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductsCreate201ResponseMessageEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Product created': return ProductsCreate201ResponseMessageEnum.productCreated;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ProductsCreate201ResponseMessageEnumTypeTransformer] instance.
  static ProductsCreate201ResponseMessageEnumTypeTransformer? _instance;
}


