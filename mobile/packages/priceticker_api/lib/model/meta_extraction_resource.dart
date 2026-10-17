//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MetaExtractionResource {
  /// Returns a new [MetaExtractionResource] instance.
  MetaExtractionResource({
    required this.title,
    required this.price,
    required this.currency,
    required this.locale,
    required this.image,
    required this.description,
    required this.availability,
    this.store = const {},
    required this.healing,
  });

  String title;

  String price;

  MetaExtractionResourceCurrency currency;

  String locale;

  String image;

  String description;

  String availability;

  Map<String, StoreResource> store;

  /// Always present, so a client can explain a thin result (\"AI detection timed out\") rather than silently showing empty fields.
  String healing;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MetaExtractionResource &&
    other.title == title &&
    other.price == price &&
    other.currency == currency &&
    other.locale == locale &&
    other.image == image &&
    other.description == description &&
    other.availability == availability &&
    _deepEquality.equals(other.store, store) &&
    other.healing == healing;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (price.hashCode) +
    (currency.hashCode) +
    (locale.hashCode) +
    (image.hashCode) +
    (description.hashCode) +
    (availability.hashCode) +
    (store.hashCode) +
    (healing.hashCode);

  @override
  String toString() => 'MetaExtractionResource[title=$title, price=$price, currency=$currency, locale=$locale, image=$image, description=$description, availability=$availability, store=$store, healing=$healing]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
      json[r'price'] = this.price;
      json[r'currency'] = this.currency;
      json[r'locale'] = this.locale;
      json[r'image'] = this.image;
      json[r'description'] = this.description;
      json[r'availability'] = this.availability;
      json[r'store'] = this.store;
      json[r'healing'] = this.healing;
    return json;
  }

  /// Returns a new [MetaExtractionResource] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MetaExtractionResource? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MetaExtractionResource[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MetaExtractionResource[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MetaExtractionResource(
        title: mapValueOfType<String>(json, r'title')!,
        price: mapValueOfType<String>(json, r'price')!,
        currency: MetaExtractionResourceCurrency.fromJson(json[r'currency'])!,
        locale: mapValueOfType<String>(json, r'locale')!,
        image: mapValueOfType<String>(json, r'image')!,
        description: mapValueOfType<String>(json, r'description')!,
        availability: mapValueOfType<String>(json, r'availability')!,
        store: StoreResource.mapFromJson(json[r'store']),
        healing: mapValueOfType<String>(json, r'healing')!,
      );
    }
    return null;
  }

  static List<MetaExtractionResource> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MetaExtractionResource>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MetaExtractionResource.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MetaExtractionResource> mapFromJson(dynamic json) {
    final map = <String, MetaExtractionResource>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MetaExtractionResource.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MetaExtractionResource-objects as value to a dart map
  static Map<String, List<MetaExtractionResource>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MetaExtractionResource>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MetaExtractionResource.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'price',
    'currency',
    'locale',
    'image',
    'description',
    'availability',
    'store',
    'healing',
  };
}

