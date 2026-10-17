//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSourceTransformer {
  /// Returns a new [ProductSourceTransformer] instance.
  ProductSourceTransformer({
    required this.id,
    required this.name,
    required this.slug,
    required this.type,
    required this.status,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.store,
    required this.user,
  });

  String id;

  String name;

  String slug;

  ProductSourceType type;

  ProductSourceStatus status;

  int? userId;

  DateTime? createdAt;

  DateTime? updatedAt;

  StoreResource store;

  UserResource user;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSourceTransformer &&
    other.id == id &&
    other.name == name &&
    other.slug == slug &&
    other.type == type &&
    other.status == status &&
    other.userId == userId &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt &&
    other.store == store &&
    other.user == user;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (slug.hashCode) +
    (type.hashCode) +
    (status.hashCode) +
    (userId == null ? 0 : userId!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (store.hashCode) +
    (user.hashCode);

  @override
  String toString() => 'ProductSourceTransformer[id=$id, name=$name, slug=$slug, type=$type, status=$status, userId=$userId, createdAt=$createdAt, updatedAt=$updatedAt, store=$store, user=$user]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
      json[r'slug'] = this.slug;
      json[r'type'] = this.type;
      json[r'status'] = this.status;
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
      json[r'store'] = this.store;
      json[r'user'] = this.user;
    return json;
  }

  /// Returns a new [ProductSourceTransformer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSourceTransformer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProductSourceTransformer[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProductSourceTransformer[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProductSourceTransformer(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        slug: mapValueOfType<String>(json, r'slug')!,
        type: ProductSourceType.fromJson(json[r'type'])!,
        status: ProductSourceStatus.fromJson(json[r'status'])!,
        userId: mapValueOfType<int>(json, r'user_id'),
        createdAt: mapDateTime(json, r'created_at', r''),
        updatedAt: mapDateTime(json, r'updated_at', r''),
        store: StoreResource.fromJson(json[r'store'])!,
        user: UserResource.fromJson(json[r'user'])!,
      );
    }
    return null;
  }

  static List<ProductSourceTransformer> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSourceTransformer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSourceTransformer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSourceTransformer> mapFromJson(dynamic json) {
    final map = <String, ProductSourceTransformer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSourceTransformer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSourceTransformer-objects as value to a dart map
  static Map<String, List<ProductSourceTransformer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSourceTransformer>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSourceTransformer.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'slug',
    'type',
    'status',
    'user_id',
    'created_at',
    'updated_at',
    'store',
    'user',
  };
}

