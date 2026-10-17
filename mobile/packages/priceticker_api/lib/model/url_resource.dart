//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UrlResource {
  /// Returns a new [UrlResource] instance.
  UrlResource({
    required this.id,
    required this.url,
    required this.productId,
    required this.storeId,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;

  String url;

  int productId;

  int storeId;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UrlResource &&
    other.id == id &&
    other.url == url &&
    other.productId == productId &&
    other.storeId == storeId &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (url.hashCode) +
    (productId.hashCode) +
    (storeId.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'UrlResource[id=$id, url=$url, productId=$productId, storeId=$storeId, createdAt=$createdAt, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'url'] = this.url;
      json[r'product_id'] = this.productId;
      json[r'store_id'] = this.storeId;
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
    return json;
  }

  /// Returns a new [UrlResource] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UrlResource? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UrlResource[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UrlResource[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UrlResource(
        id: mapValueOfType<String>(json, r'id')!,
        url: mapValueOfType<String>(json, r'url')!,
        productId: mapValueOfType<int>(json, r'product_id')!,
        storeId: mapValueOfType<int>(json, r'store_id')!,
        createdAt: mapDateTime(json, r'created_at', r''),
        updatedAt: mapDateTime(json, r'updated_at', r''),
      );
    }
    return null;
  }

  static List<UrlResource> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UrlResource>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UrlResource.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UrlResource> mapFromJson(dynamic json) {
    final map = <String, UrlResource>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UrlResource.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UrlResource-objects as value to a dart map
  static Map<String, List<UrlResource>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UrlResource>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UrlResource.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'url',
    'product_id',
    'store_id',
    'created_at',
    'updated_at',
  };
}

