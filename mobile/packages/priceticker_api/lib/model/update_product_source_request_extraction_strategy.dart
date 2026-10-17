//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateProductSourceRequestExtractionStrategy {
  /// Returns a new [UpdateProductSourceRequestExtractionStrategy] instance.
  UpdateProductSourceRequestExtractionStrategy({
    this.listContainer,
    this.productTitle,
    this.productUrl,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UpdateProductSourceRequestExtractionStrategyListContainer? listContainer;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UpdateProductSourceRequestExtractionStrategyListContainer? productTitle;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UpdateProductSourceRequestExtractionStrategyListContainer? productUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateProductSourceRequestExtractionStrategy &&
    other.listContainer == listContainer &&
    other.productTitle == productTitle &&
    other.productUrl == productUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (listContainer == null ? 0 : listContainer!.hashCode) +
    (productTitle == null ? 0 : productTitle!.hashCode) +
    (productUrl == null ? 0 : productUrl!.hashCode);

  @override
  String toString() => 'UpdateProductSourceRequestExtractionStrategy[listContainer=$listContainer, productTitle=$productTitle, productUrl=$productUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.listContainer != null) {
      json[r'list_container'] = this.listContainer;
    } else {
      json[r'list_container'] = null;
    }
    if (this.productTitle != null) {
      json[r'product_title'] = this.productTitle;
    } else {
      json[r'product_title'] = null;
    }
    if (this.productUrl != null) {
      json[r'product_url'] = this.productUrl;
    } else {
      json[r'product_url'] = null;
    }
    return json;
  }

  /// Returns a new [UpdateProductSourceRequestExtractionStrategy] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateProductSourceRequestExtractionStrategy? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateProductSourceRequestExtractionStrategy[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateProductSourceRequestExtractionStrategy[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateProductSourceRequestExtractionStrategy(
        listContainer: UpdateProductSourceRequestExtractionStrategyListContainer.fromJson(json[r'list_container']),
        productTitle: UpdateProductSourceRequestExtractionStrategyListContainer.fromJson(json[r'product_title']),
        productUrl: UpdateProductSourceRequestExtractionStrategyListContainer.fromJson(json[r'product_url']),
      );
    }
    return null;
  }

  static List<UpdateProductSourceRequestExtractionStrategy> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateProductSourceRequestExtractionStrategy>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateProductSourceRequestExtractionStrategy.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateProductSourceRequestExtractionStrategy> mapFromJson(dynamic json) {
    final map = <String, UpdateProductSourceRequestExtractionStrategy>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateProductSourceRequestExtractionStrategy.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateProductSourceRequestExtractionStrategy-objects as value to a dart map
  static Map<String, List<UpdateProductSourceRequestExtractionStrategy>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateProductSourceRequestExtractionStrategy>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateProductSourceRequestExtractionStrategy.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

