//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreateProductSourceRequestExtractionStrategy {
  /// Returns a new [CreateProductSourceRequestExtractionStrategy] instance.
  CreateProductSourceRequestExtractionStrategy({
    required this.listContainer,
    required this.productTitle,
    required this.productUrl,
  });

  CreateProductSourceRequestExtractionStrategyListContainer listContainer;

  CreateProductSourceRequestExtractionStrategyListContainer productTitle;

  CreateProductSourceRequestExtractionStrategyListContainer productUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateProductSourceRequestExtractionStrategy &&
    other.listContainer == listContainer &&
    other.productTitle == productTitle &&
    other.productUrl == productUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (listContainer.hashCode) +
    (productTitle.hashCode) +
    (productUrl.hashCode);

  @override
  String toString() => 'CreateProductSourceRequestExtractionStrategy[listContainer=$listContainer, productTitle=$productTitle, productUrl=$productUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'list_container'] = this.listContainer;
      json[r'product_title'] = this.productTitle;
      json[r'product_url'] = this.productUrl;
    return json;
  }

  /// Returns a new [CreateProductSourceRequestExtractionStrategy] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateProductSourceRequestExtractionStrategy? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CreateProductSourceRequestExtractionStrategy[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CreateProductSourceRequestExtractionStrategy[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreateProductSourceRequestExtractionStrategy(
        listContainer: CreateProductSourceRequestExtractionStrategyListContainer.fromJson(json[r'list_container'])!,
        productTitle: CreateProductSourceRequestExtractionStrategyListContainer.fromJson(json[r'product_title'])!,
        productUrl: CreateProductSourceRequestExtractionStrategyListContainer.fromJson(json[r'product_url'])!,
      );
    }
    return null;
  }

  static List<CreateProductSourceRequestExtractionStrategy> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateProductSourceRequestExtractionStrategy>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateProductSourceRequestExtractionStrategy.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateProductSourceRequestExtractionStrategy> mapFromJson(dynamic json) {
    final map = <String, CreateProductSourceRequestExtractionStrategy>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateProductSourceRequestExtractionStrategy.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateProductSourceRequestExtractionStrategy-objects as value to a dart map
  static Map<String, List<CreateProductSourceRequestExtractionStrategy>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateProductSourceRequestExtractionStrategy>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateProductSourceRequestExtractionStrategy.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'list_container',
    'product_title',
    'product_url',
  };
}

