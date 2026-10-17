//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreateProductRequest {
  /// Returns a new [CreateProductRequest] instance.
  CreateProductRequest({
    required this.title,
    required this.url,
    this.productId,
    this.image,
    this.status,
    this.weight,
    this.notifyPrice,
    this.notifyPercent,
    this.favourite,
    this.onlyOfficial,
    this.createStore,
    this.notifyInStock,
    this.paused,
    this.refreshInterval,
  });

  String title;

  String url;

  int? productId;

  String? image;

  CreateProductRequestStatusEnum? status;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? weight;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? notifyPrice;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? notifyPercent;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? favourite;

  bool? onlyOfficial;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? createStore;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? notifyInStock;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? paused;

  CreateProductRequestRefreshIntervalEnum? refreshInterval;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateProductRequest &&
    other.title == title &&
    other.url == url &&
    other.productId == productId &&
    other.image == image &&
    other.status == status &&
    other.weight == weight &&
    other.notifyPrice == notifyPrice &&
    other.notifyPercent == notifyPercent &&
    other.favourite == favourite &&
    other.onlyOfficial == onlyOfficial &&
    other.createStore == createStore &&
    other.notifyInStock == notifyInStock &&
    other.paused == paused &&
    other.refreshInterval == refreshInterval;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (url.hashCode) +
    (productId == null ? 0 : productId!.hashCode) +
    (image == null ? 0 : image!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (weight == null ? 0 : weight!.hashCode) +
    (notifyPrice == null ? 0 : notifyPrice!.hashCode) +
    (notifyPercent == null ? 0 : notifyPercent!.hashCode) +
    (favourite == null ? 0 : favourite!.hashCode) +
    (onlyOfficial == null ? 0 : onlyOfficial!.hashCode) +
    (createStore == null ? 0 : createStore!.hashCode) +
    (notifyInStock == null ? 0 : notifyInStock!.hashCode) +
    (paused == null ? 0 : paused!.hashCode) +
    (refreshInterval == null ? 0 : refreshInterval!.hashCode);

  @override
  String toString() => 'CreateProductRequest[title=$title, url=$url, productId=$productId, image=$image, status=$status, weight=$weight, notifyPrice=$notifyPrice, notifyPercent=$notifyPercent, favourite=$favourite, onlyOfficial=$onlyOfficial, createStore=$createStore, notifyInStock=$notifyInStock, paused=$paused, refreshInterval=$refreshInterval]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
      json[r'url'] = this.url;
    if (this.productId != null) {
      json[r'product_id'] = this.productId;
    } else {
      json[r'product_id'] = null;
    }
    if (this.image != null) {
      json[r'image'] = this.image;
    } else {
      json[r'image'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.weight != null) {
      json[r'weight'] = this.weight;
    } else {
      json[r'weight'] = null;
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
    if (this.favourite != null) {
      json[r'favourite'] = this.favourite;
    } else {
      json[r'favourite'] = null;
    }
    if (this.onlyOfficial != null) {
      json[r'only_official'] = this.onlyOfficial;
    } else {
      json[r'only_official'] = null;
    }
    if (this.createStore != null) {
      json[r'create_store'] = this.createStore;
    } else {
      json[r'create_store'] = null;
    }
    if (this.notifyInStock != null) {
      json[r'notify_in_stock'] = this.notifyInStock;
    } else {
      json[r'notify_in_stock'] = null;
    }
    if (this.paused != null) {
      json[r'paused'] = this.paused;
    } else {
      json[r'paused'] = null;
    }
    if (this.refreshInterval != null) {
      json[r'refresh_interval'] = this.refreshInterval;
    } else {
      json[r'refresh_interval'] = null;
    }
    return json;
  }

  /// Returns a new [CreateProductRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateProductRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CreateProductRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CreateProductRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreateProductRequest(
        title: mapValueOfType<String>(json, r'title')!,
        url: mapValueOfType<String>(json, r'url')!,
        productId: mapValueOfType<int>(json, r'product_id'),
        image: mapValueOfType<String>(json, r'image'),
        status: CreateProductRequestStatusEnum.fromJson(json[r'status']),
        weight: num.parse('${json[r'weight']}'),
        notifyPrice: num.parse('${json[r'notify_price']}'),
        notifyPercent: num.parse('${json[r'notify_percent']}'),
        favourite: mapValueOfType<bool>(json, r'favourite'),
        onlyOfficial: mapValueOfType<bool>(json, r'only_official'),
        createStore: mapValueOfType<bool>(json, r'create_store'),
        notifyInStock: mapValueOfType<bool>(json, r'notify_in_stock'),
        paused: mapValueOfType<bool>(json, r'paused'),
        refreshInterval: CreateProductRequestRefreshIntervalEnum.fromJson(json[r'refresh_interval']),
      );
    }
    return null;
  }

  static List<CreateProductRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateProductRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateProductRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateProductRequest> mapFromJson(dynamic json) {
    final map = <String, CreateProductRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateProductRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateProductRequest-objects as value to a dart map
  static Map<String, List<CreateProductRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateProductRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateProductRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'url',
  };
}


class CreateProductRequestStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const CreateProductRequestStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const p = CreateProductRequestStatusEnum._(r'p');
  static const a = CreateProductRequestStatusEnum._(r'a');

  /// List of all possible values in this [enum][CreateProductRequestStatusEnum].
  static const values = <CreateProductRequestStatusEnum>[
    p,
    a,
  ];

  static CreateProductRequestStatusEnum? fromJson(dynamic value) => CreateProductRequestStatusEnumTypeTransformer().decode(value);

  static List<CreateProductRequestStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateProductRequestStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateProductRequestStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CreateProductRequestStatusEnum] to String,
/// and [decode] dynamic data back to [CreateProductRequestStatusEnum].
class CreateProductRequestStatusEnumTypeTransformer {
  factory CreateProductRequestStatusEnumTypeTransformer() => _instance ??= const CreateProductRequestStatusEnumTypeTransformer._();

  const CreateProductRequestStatusEnumTypeTransformer._();

  String encode(CreateProductRequestStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CreateProductRequestStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CreateProductRequestStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'p': return CreateProductRequestStatusEnum.p;
        case r'a': return CreateProductRequestStatusEnum.a;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CreateProductRequestStatusEnumTypeTransformer] instance.
  static CreateProductRequestStatusEnumTypeTransformer? _instance;
}



class CreateProductRequestRefreshIntervalEnum {
  /// Instantiate a new enum with the provided [value].
  const CreateProductRequestRefreshIntervalEnum._(this.value);

  /// The underlying value of this enum member.
  final int value;

  @override
  String toString() => value.toString();

  int toJson() => value;

  static const number300 = CreateProductRequestRefreshIntervalEnum._(300);
  static const number600 = CreateProductRequestRefreshIntervalEnum._(600);
  static const number900 = CreateProductRequestRefreshIntervalEnum._(900);
  static const number1800 = CreateProductRequestRefreshIntervalEnum._(1800);
  static const number3600 = CreateProductRequestRefreshIntervalEnum._(3600);
  static const number7200 = CreateProductRequestRefreshIntervalEnum._(7200);
  static const number14400 = CreateProductRequestRefreshIntervalEnum._(14400);
  static const number21600 = CreateProductRequestRefreshIntervalEnum._(21600);
  static const number43200 = CreateProductRequestRefreshIntervalEnum._(43200);
  static const number86400 = CreateProductRequestRefreshIntervalEnum._(86400);

  /// List of all possible values in this [enum][CreateProductRequestRefreshIntervalEnum].
  static const values = <CreateProductRequestRefreshIntervalEnum>[
    number300,
    number600,
    number900,
    number1800,
    number3600,
    number7200,
    number14400,
    number21600,
    number43200,
    number86400,
  ];

  static CreateProductRequestRefreshIntervalEnum? fromJson(dynamic value) => CreateProductRequestRefreshIntervalEnumTypeTransformer().decode(value);

  static List<CreateProductRequestRefreshIntervalEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateProductRequestRefreshIntervalEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateProductRequestRefreshIntervalEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CreateProductRequestRefreshIntervalEnum] to int,
/// and [decode] dynamic data back to [CreateProductRequestRefreshIntervalEnum].
class CreateProductRequestRefreshIntervalEnumTypeTransformer {
  factory CreateProductRequestRefreshIntervalEnumTypeTransformer() => _instance ??= const CreateProductRequestRefreshIntervalEnumTypeTransformer._();

  const CreateProductRequestRefreshIntervalEnumTypeTransformer._();

  int encode(CreateProductRequestRefreshIntervalEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CreateProductRequestRefreshIntervalEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CreateProductRequestRefreshIntervalEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case 300: return CreateProductRequestRefreshIntervalEnum.number300;
        case 600: return CreateProductRequestRefreshIntervalEnum.number600;
        case 900: return CreateProductRequestRefreshIntervalEnum.number900;
        case 1800: return CreateProductRequestRefreshIntervalEnum.number1800;
        case 3600: return CreateProductRequestRefreshIntervalEnum.number3600;
        case 7200: return CreateProductRequestRefreshIntervalEnum.number7200;
        case 14400: return CreateProductRequestRefreshIntervalEnum.number14400;
        case 21600: return CreateProductRequestRefreshIntervalEnum.number21600;
        case 43200: return CreateProductRequestRefreshIntervalEnum.number43200;
        case 86400: return CreateProductRequestRefreshIntervalEnum.number86400;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CreateProductRequestRefreshIntervalEnumTypeTransformer] instance.
  static CreateProductRequestRefreshIntervalEnumTypeTransformer? _instance;
}


