//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class StoreTransformer {
  /// Returns a new [StoreTransformer] instance.
  StoreTransformer({
    required this.id,
    required this.name,
    required this.slug,
    required this.initials,
    this.domains = const [],
    required this.scrapeStrategy,
    this.settings = const [],
    required this.notes,
    required this.cookies,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.currency,
    required this.locale,
    required this.user,
    this.urls = const [],
    this.products = const [],
  });

  int id;

  String name;

  String slug;

  String? initials;

  List<Object> domains;

  String? scrapeStrategy;

  List<Object> settings;

  String? notes;

  String? cookies;

  int? userId;

  DateTime? createdAt;

  DateTime? updatedAt;

  StoreTransformerCurrency currency;

  String locale;

  UserResource user;

  List<UrlResource> urls;

  List<ProductTransformer> products;

  @override
  bool operator ==(Object other) => identical(this, other) || other is StoreTransformer &&
    other.id == id &&
    other.name == name &&
    other.slug == slug &&
    other.initials == initials &&
    _deepEquality.equals(other.domains, domains) &&
    other.scrapeStrategy == scrapeStrategy &&
    _deepEquality.equals(other.settings, settings) &&
    other.notes == notes &&
    other.cookies == cookies &&
    other.userId == userId &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt &&
    other.currency == currency &&
    other.locale == locale &&
    other.user == user &&
    _deepEquality.equals(other.urls, urls) &&
    _deepEquality.equals(other.products, products);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (slug.hashCode) +
    (initials == null ? 0 : initials!.hashCode) +
    (domains.hashCode) +
    (scrapeStrategy == null ? 0 : scrapeStrategy!.hashCode) +
    (settings.hashCode) +
    (notes == null ? 0 : notes!.hashCode) +
    (cookies == null ? 0 : cookies!.hashCode) +
    (userId == null ? 0 : userId!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode) +
    (currency.hashCode) +
    (locale.hashCode) +
    (user.hashCode) +
    (urls.hashCode) +
    (products.hashCode);

  @override
  String toString() => 'StoreTransformer[id=$id, name=$name, slug=$slug, initials=$initials, domains=$domains, scrapeStrategy=$scrapeStrategy, settings=$settings, notes=$notes, cookies=$cookies, userId=$userId, createdAt=$createdAt, updatedAt=$updatedAt, currency=$currency, locale=$locale, user=$user, urls=$urls, products=$products]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
      json[r'slug'] = this.slug;
    if (this.initials != null) {
      json[r'initials'] = this.initials;
    } else {
      json[r'initials'] = null;
    }
      json[r'domains'] = this.domains;
    if (this.scrapeStrategy != null) {
      json[r'scrape_strategy'] = this.scrapeStrategy;
    } else {
      json[r'scrape_strategy'] = null;
    }
      json[r'settings'] = this.settings;
    if (this.notes != null) {
      json[r'notes'] = this.notes;
    } else {
      json[r'notes'] = null;
    }
    if (this.cookies != null) {
      json[r'cookies'] = this.cookies;
    } else {
      json[r'cookies'] = null;
    }
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
      json[r'currency'] = this.currency;
      json[r'locale'] = this.locale;
      json[r'user'] = this.user;
      json[r'urls'] = this.urls;
      json[r'products'] = this.products;
    return json;
  }

  /// Returns a new [StoreTransformer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static StoreTransformer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "StoreTransformer[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "StoreTransformer[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return StoreTransformer(
        id: mapValueOfType<int>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        slug: mapValueOfType<String>(json, r'slug')!,
        initials: mapValueOfType<String>(json, r'initials'),
        domains: json[r'domains'],
        scrapeStrategy: mapValueOfType<String>(json, r'scrape_strategy'),
        settings: json[r'settings'],
        notes: mapValueOfType<String>(json, r'notes'),
        cookies: mapValueOfType<String>(json, r'cookies'),
        userId: mapValueOfType<int>(json, r'user_id'),
        createdAt: mapDateTime(json, r'created_at', r''),
        updatedAt: mapDateTime(json, r'updated_at', r''),
        currency: StoreTransformerCurrency.fromJson(json[r'currency'])!,
        locale: mapValueOfType<String>(json, r'locale')!,
        user: UserResource.fromJson(json[r'user'])!,
        urls: UrlResource.listFromJson(json[r'urls']),
        products: ProductTransformer.listFromJson(json[r'products']),
      );
    }
    return null;
  }

  static List<StoreTransformer> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StoreTransformer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StoreTransformer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, StoreTransformer> mapFromJson(dynamic json) {
    final map = <String, StoreTransformer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = StoreTransformer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of StoreTransformer-objects as value to a dart map
  static Map<String, List<StoreTransformer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<StoreTransformer>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = StoreTransformer.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'slug',
    'initials',
    'domains',
    'scrape_strategy',
    'settings',
    'notes',
    'cookies',
    'user_id',
    'created_at',
    'updated_at',
    'currency',
    'locale',
    'user',
    'urls',
  };
}

