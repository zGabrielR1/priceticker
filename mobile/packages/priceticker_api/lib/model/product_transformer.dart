//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductTransformer {
  /// Returns a new [ProductTransformer] instance.
  ProductTransformer({
    required this.id,
    required this.title,
    required this.unitOfMeasure,
    required this.image,
    required this.status,
    required this.weight,
    required this.currentPrice,
    required this.notifyPrice,
    required this.notifyPercent,
    required this.notifyInStock,
    required this.refreshInterval,
    required this.nextCheckAt,
    required this.paused,
    required this.favourite,
    required this.onlyOfficial,
    this.priceCache = const [],
    this.ignoredUrls = const [],
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.tags = const [],
    required this.user,
    required this.insights,
  });

  int id;

  String title;

  String? unitOfMeasure;

  String? image;

  Statuses status;

  int weight;

  num? currentPrice;

  num? notifyPrice;

  num? notifyPercent;

  bool notifyInStock;

  int? refreshInterval;

  DateTime? nextCheckAt;

  bool paused;

  bool favourite;

  int onlyOfficial;

  List<Object> priceCache;

  List<Object> ignoredUrls;

  int userId;

  DateTime? createdAt;

  DateTime? updatedAt;

  List<TagTransformer> tags;

  UserResource user;

  String insights;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductTransformer &&
    other.id == id &&
    other.title == title &&
    other.unitOfMeasure == unitOfMeasure &&
    other.image == image &&
    other.status == status &&
    other.weight == weight &&
    other.currentPrice == currentPrice &&
    other.notifyPrice == notifyPrice &&
    other.notifyPercent == notifyPercent &&
    other.notifyInStock == notifyInStock &&
    other.refreshInterval == refreshInterval &&
    other.nextCheckAt == nextCheckAt &&
    other.paused == paused &&
    other.favourite == favourite &&
    other.onlyOfficial == onlyOfficial &&
    _deepEquality.equals(other.priceCache, priceCache) &&
    _deepEquality.equals(other.ignoredUrls, ignoredUrls) &&
    other.userId == userId &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt &&
    _deepEquality.equals(other.tags, tags) &&
    other.user == user &&
    other.insights == insights;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (title.hashCode) +
    (unitOfMeasure == null ? 0 : unitOfMeasure!.hashCode) +
    (image == null ? 0 : image!.hashCode) +
    (status.hashCode) +
    (weight.hashCode) +
    (currentPrice == null ? 0 : currentPrice!.hashCode) +
    (notifyPrice == null ? 0 : notifyPrice!.hashCode) +
    (notifyPercent == null ? 0 : notifyPercent!.hashCode) +
    (notifyInStock.hashCode) +
    (refreshInterval == null ? 0 : refreshInterval!.hashCode) +
    (nextCheckAt == null ? 0 : nextCheckAt!.hashCode) +
    (paused.hashCode) +
    (favourite.hashCode) +
    (onlyOfficial.hashCode) +
    (priceCache.hashCode) +
    (ignoredUrls.hashCode) +
    (userId.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (tags.hashCode) +
    (user.hashCode) +
    (insights.hashCode);

  @override
  String toString() => 'ProductTransformer[id=$id, title=$title, unitOfMeasure=$unitOfMeasure, image=$image, status=$status, weight=$weight, currentPrice=$currentPrice, notifyPrice=$notifyPrice, notifyPercent=$notifyPercent, notifyInStock=$notifyInStock, refreshInterval=$refreshInterval, nextCheckAt=$nextCheckAt, paused=$paused, favourite=$favourite, onlyOfficial=$onlyOfficial, priceCache=$priceCache, ignoredUrls=$ignoredUrls, userId=$userId, createdAt=$createdAt, updatedAt=$updatedAt, tags=$tags, user=$user, insights=$insights]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'title'] = this.title;
    if (this.unitOfMeasure != null) {
      json[r'unit_of_measure'] = this.unitOfMeasure;
    } else {
      json[r'unit_of_measure'] = null;
    }
    if (this.image != null) {
      json[r'image'] = this.image;
    } else {
      json[r'image'] = null;
    }
      json[r'status'] = this.status;
      json[r'weight'] = this.weight;
    if (this.currentPrice != null) {
      json[r'current_price'] = this.currentPrice;
    } else {
      json[r'current_price'] = null;
    }
    if (this.notifyPrice != null) {
      json[r'notify_price'] = this.notifyPrice;
    } else {
      json[r'notify_price'] = null;
    }
    if (this.notifyPercent != null) {
      json[r'notify_percent'] = this.notifyPercent;
    } else {
      json[r'notify_percent'] = null;
    }
      json[r'notify_in_stock'] = this.notifyInStock;
    if (this.refreshInterval != null) {
      json[r'refresh_interval'] = this.refreshInterval;
    } else {
      json[r'refresh_interval'] = null;
    }
    if (this.nextCheckAt != null) {
      json[r'next_check_at'] = this.nextCheckAt!.toUtc().toIso8601String();
    } else {
      json[r'next_check_at'] = null;
    }
      json[r'paused'] = this.paused;
      json[r'favourite'] = this.favourite;
      json[r'only_official'] = this.onlyOfficial;
      json[r'price_cache'] = this.priceCache;
      json[r'ignored_urls'] = this.ignoredUrls;
      json[r'user_id'] = this.userId;
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
      json[r'tags'] = this.tags;
      json[r'user'] = this.user;
      json[r'insights'] = this.insights;
    return json;
  }

  /// Returns a new [ProductTransformer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductTransformer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ProductTransformer[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ProductTransformer[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ProductTransformer(
        id: mapValueOfType<int>(json, r'id')!,
        title: mapValueOfType<String>(json, r'title')!,
        unitOfMeasure: mapValueOfType<String>(json, r'unit_of_measure'),
        image: mapValueOfType<String>(json, r'image'),
        status: Statuses.fromJson(json[r'status'])!,
        weight: mapValueOfType<int>(json, r'weight')!,
        currentPrice: json[r'current_price'] == null
            ? null
            : num.parse('${json[r'current_price']}'),
        notifyPrice: json[r'notify_price'] == null
            ? null
            : num.parse('${json[r'notify_price']}'),
        notifyPercent: json[r'notify_percent'] == null
            ? null
            : num.parse('${json[r'notify_percent']}'),
        notifyInStock: mapValueOfType<bool>(json, r'notify_in_stock')!,
        refreshInterval: mapValueOfType<int>(json, r'refresh_interval'),
        nextCheckAt: mapDateTime(json, r'next_check_at', r''),
        paused: mapValueOfType<bool>(json, r'paused')!,
        favourite: mapValueOfType<bool>(json, r'favourite')!,
        onlyOfficial: mapValueOfType<int>(json, r'only_official')!,
        priceCache: json[r'price_cache'],
        ignoredUrls: json[r'ignored_urls'],
        userId: mapValueOfType<int>(json, r'user_id')!,
        createdAt: mapDateTime(json, r'created_at', r''),
        updatedAt: mapDateTime(json, r'updated_at', r''),
        tags: TagTransformer.listFromJson(json[r'tags']),
        user: UserResource.fromJson(json[r'user'])!,
        insights: mapValueOfType<String>(json, r'insights')!,
      );
    }
    return null;
  }

  static List<ProductTransformer> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductTransformer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductTransformer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductTransformer> mapFromJson(dynamic json) {
    final map = <String, ProductTransformer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductTransformer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductTransformer-objects as value to a dart map
  static Map<String, List<ProductTransformer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductTransformer>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductTransformer.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'title',
    'unit_of_measure',
    'image',
    'status',
    'weight',
    'current_price',
    'notify_price',
    'notify_percent',
    'notify_in_stock',
    'refresh_interval',
    'next_check_at',
    'paused',
    'favourite',
    'only_official',
    'price_cache',
    'ignored_urls',
    'user_id',
    'created_at',
    'updated_at',
    'tags',
    'user',
    'insights',
  };
}

