//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TagTransformer {
  /// Returns a new [TagTransformer] instance.
  TagTransformer({
    required this.id,
    required this.name,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.weight,
    required this.products,
  });

  int id;

  String name;

  int? userId;

  DateTime? createdAt;

  DateTime? updatedAt;

  int weight;

  String products;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TagTransformer &&
    other.id == id &&
    other.name == name &&
    other.userId == userId &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt &&
    other.weight == weight &&
    other.products == products;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (userId == null ? 0 : userId!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (weight.hashCode) +
    (products.hashCode);

  @override
  String toString() => 'TagTransformer[id=$id, name=$name, userId=$userId, createdAt=$createdAt, updatedAt=$updatedAt, weight=$weight, products=$products]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
    if (this.userId != null) {
      json[r'user_id'] = this.userId;
    } else {
      json[r'user_id'] = null;
    }
    if (this.createdAt != null) {
      json[r'created_at'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'created_at'] = null;
    }
    if (this.updatedAt != null) {
      json[r'updated_at'] = this.updatedAt!.toUtc().toIso8601String();
    } else {
      json[r'updated_at'] = null;
    }
      json[r'weight'] = this.weight;
      json[r'products'] = this.products;
    return json;
  }

  /// Returns a new [TagTransformer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TagTransformer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TagTransformer[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TagTransformer[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TagTransformer(
        id: mapValueOfType<int>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        userId: mapValueOfType<int>(json, r'user_id'),
        createdAt: mapDateTime(json, r'created_at', r''),
        updatedAt: mapDateTime(json, r'updated_at', r''),
        weight: mapValueOfType<int>(json, r'weight')!,
        products: mapValueOfType<String>(json, r'products')!,
      );
    }
    return null;
  }

  static List<TagTransformer> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TagTransformer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TagTransformer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TagTransformer> mapFromJson(dynamic json) {
    final map = <String, TagTransformer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TagTransformer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TagTransformer-objects as value to a dart map
  static Map<String, List<TagTransformer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TagTransformer>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TagTransformer.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'user_id',
    'created_at',
    'updated_at',
    'weight',
    'products',
  };
}

