//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MetaExtractionRequestStoreScrapeStrategy {
  /// Returns a new [MetaExtractionRequestStoreScrapeStrategy] instance.
  MetaExtractionRequestStoreScrapeStrategy({
    this.title,
    this.price,
    this.image,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MetaExtractionRequestStoreScrapeStrategyTitle? title;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MetaExtractionRequestStoreScrapeStrategyTitle? price;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  MetaExtractionRequestStoreScrapeStrategyTitle? image;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MetaExtractionRequestStoreScrapeStrategy &&
    other.title == title &&
    other.price == price &&
    other.image == image;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title == null ? 0 : title!.hashCode) +
    (price == null ? 0 : price!.hashCode) +
    (image == null ? 0 : image!.hashCode);

  @override
  String toString() => 'MetaExtractionRequestStoreScrapeStrategy[title=$title, price=$price, image=$image]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    if (this.price != null) {
      json[r'price'] = this.price;
    } else {
      json[r'price'] = null;
    }
    if (this.image != null) {
      json[r'image'] = this.image;
    } else {
      json[r'image'] = null;
    }
    return json;
  }

  /// Returns a new [MetaExtractionRequestStoreScrapeStrategy] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MetaExtractionRequestStoreScrapeStrategy? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MetaExtractionRequestStoreScrapeStrategy[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MetaExtractionRequestStoreScrapeStrategy[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MetaExtractionRequestStoreScrapeStrategy(
        title: MetaExtractionRequestStoreScrapeStrategyTitle.fromJson(json[r'title']),
        price: MetaExtractionRequestStoreScrapeStrategyTitle.fromJson(json[r'price']),
        image: MetaExtractionRequestStoreScrapeStrategyTitle.fromJson(json[r'image']),
      );
    }
    return null;
  }

  static List<MetaExtractionRequestStoreScrapeStrategy> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MetaExtractionRequestStoreScrapeStrategy>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MetaExtractionRequestStoreScrapeStrategy.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MetaExtractionRequestStoreScrapeStrategy> mapFromJson(dynamic json) {
    final map = <String, MetaExtractionRequestStoreScrapeStrategy>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MetaExtractionRequestStoreScrapeStrategy.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MetaExtractionRequestStoreScrapeStrategy-objects as value to a dart map
  static Map<String, List<MetaExtractionRequestStoreScrapeStrategy>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MetaExtractionRequestStoreScrapeStrategy>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MetaExtractionRequestStoreScrapeStrategy.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

