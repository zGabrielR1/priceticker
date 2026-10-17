//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ClientConfig200ResponseDataCapabilities {
  /// Returns a new [ClientConfig200ResponseDataCapabilities] instance.
  ClientConfig200ResponseDataCapabilities({
    required this.productsFilterUrl,
    required this.productsCurrentUrl,
    required this.productsSparseFieldsets,
    required this.productsTags,
    required this.storesFilterDomain,
  });

  bool productsFilterUrl;

  bool productsCurrentUrl;

  bool productsSparseFieldsets;

  bool productsTags;

  bool storesFilterDomain;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClientConfig200ResponseDataCapabilities &&
    other.productsFilterUrl == productsFilterUrl &&
    other.productsCurrentUrl == productsCurrentUrl &&
    other.productsSparseFieldsets == productsSparseFieldsets &&
    other.productsTags == productsTags &&
    other.storesFilterDomain == storesFilterDomain;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (productsFilterUrl.hashCode) +
    (productsCurrentUrl.hashCode) +
    (productsSparseFieldsets.hashCode) +
    (productsTags.hashCode) +
    (storesFilterDomain.hashCode);

  @override
  String toString() => 'ClientConfig200ResponseDataCapabilities[productsFilterUrl=$productsFilterUrl, productsCurrentUrl=$productsCurrentUrl, productsSparseFieldsets=$productsSparseFieldsets, productsTags=$productsTags, storesFilterDomain=$storesFilterDomain]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'products_filter_url'] = this.productsFilterUrl;
      json[r'products_current_url'] = this.productsCurrentUrl;
      json[r'products_sparse_fieldsets'] = this.productsSparseFieldsets;
      json[r'products_tags'] = this.productsTags;
      json[r'stores_filter_domain'] = this.storesFilterDomain;
    return json;
  }

  /// Returns a new [ClientConfig200ResponseDataCapabilities] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClientConfig200ResponseDataCapabilities? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ClientConfig200ResponseDataCapabilities[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ClientConfig200ResponseDataCapabilities[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ClientConfig200ResponseDataCapabilities(
        productsFilterUrl: mapValueOfType<bool>(json, r'products_filter_url')!,
        productsCurrentUrl: mapValueOfType<bool>(json, r'products_current_url')!,
        productsSparseFieldsets: mapValueOfType<bool>(json, r'products_sparse_fieldsets')!,
        productsTags: mapValueOfType<bool>(json, r'products_tags')!,
        storesFilterDomain: mapValueOfType<bool>(json, r'stores_filter_domain')!,
      );
    }
    return null;
  }

  static List<ClientConfig200ResponseDataCapabilities> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClientConfig200ResponseDataCapabilities>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClientConfig200ResponseDataCapabilities.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClientConfig200ResponseDataCapabilities> mapFromJson(dynamic json) {
    final map = <String, ClientConfig200ResponseDataCapabilities>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClientConfig200ResponseDataCapabilities.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClientConfig200ResponseDataCapabilities-objects as value to a dart map
  static Map<String, List<ClientConfig200ResponseDataCapabilities>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClientConfig200ResponseDataCapabilities>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClientConfig200ResponseDataCapabilities.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'products_filter_url',
    'products_current_url',
    'products_sparse_fieldsets',
    'products_tags',
    'stores_filter_domain',
  };
}

