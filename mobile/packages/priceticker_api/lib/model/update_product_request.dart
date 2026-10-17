//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateProductRequest {
  /// Returns a new [UpdateProductRequest] instance.
  UpdateProductRequest({
    required this.title,
    required this.image,
    this.status,
    this.weight,
    this.notifyPrice,
    this.notifyPercent,
    this.favourite,
    this.onlyOfficial,
    this.notifyInStock,
    this.paused,
    this.refreshInterval,
  });

  String title;

  String image;

  UpdateProductRequestStatusEnum? status;

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
  bool? notifyInStock;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? paused;

  UpdateProductRequestRefreshIntervalEnum? refreshInterval;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateProductRequest &&
    other.title == title &&
    other.image == image &&
    other.status == status &&
    other.weight == weight &&
    other.notifyPrice == notifyPrice &&
    other.notifyPercent == notifyPercent &&
    other.favourite == favourite &&
    other.onlyOfficial == onlyOfficial &&
    other.notifyInStock == notifyInStock &&
    other.paused == paused &&
    other.refreshInterval == refreshInterval;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (image.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (weight == null ? 0 : weight!.hashCode) +
    (notifyPrice == null ? 0 : notifyPrice!.hashCode) +
    (notifyPercent == null ? 0 : notifyPercent!.hashCode) +
    (favourite == null ? 0 : favourite!.hashCode) +
    (onlyOfficial == null ? 0 : onlyOfficial!.hashCode) +
    (notifyInStock == null ? 0 : notifyInStock!.hashCode) +
    (paused == null ? 0 : paused!.hashCode) +
    (refreshInterval == null ? 0 : refreshInterval!.hashCode);

  @override
  String toString() => 'UpdateProductRequest[title=$title, image=$image, status=$status, weight=$weight, notifyPrice=$notifyPrice, notifyPercent=$notifyPercent, favourite=$favourite, onlyOfficial=$onlyOfficial, notifyInStock=$notifyInStock, paused=$paused, refreshInterval=$refreshInterval]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
      json[r'image'] = this.image;
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

  /// Returns a new [UpdateProductRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateProductRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateProductRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateProductRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateProductRequest(
        title: mapValueOfType<String>(json, r'title')!,
        image: mapValueOfType<String>(json, r'image')!,
        status: UpdateProductRequestStatusEnum.fromJson(json[r'status']),
        weight: num.parse('${json[r'weight']}'),
        notifyPrice: num.parse('${json[r'notify_price']}'),
        notifyPercent: num.parse('${json[r'notify_percent']}'),
        favourite: mapValueOfType<bool>(json, r'favourite'),
        onlyOfficial: mapValueOfType<bool>(json, r'only_official'),
        notifyInStock: mapValueOfType<bool>(json, r'notify_in_stock'),
        paused: mapValueOfType<bool>(json, r'paused'),
        refreshInterval: UpdateProductRequestRefreshIntervalEnum.fromJson(json[r'refresh_interval']),
      );
    }
    return null;
  }

  static List<UpdateProductRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateProductRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateProductRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateProductRequest> mapFromJson(dynamic json) {
    final map = <String, UpdateProductRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateProductRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateProductRequest-objects as value to a dart map
  static Map<String, List<UpdateProductRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateProductRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateProductRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'image',
  };
}


class UpdateProductRequestStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const UpdateProductRequestStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const p = UpdateProductRequestStatusEnum._(r'p');
  static const a = UpdateProductRequestStatusEnum._(r'a');

  /// List of all possible values in this [enum][UpdateProductRequestStatusEnum].
  static const values = <UpdateProductRequestStatusEnum>[
    p,
    a,
  ];

  static UpdateProductRequestStatusEnum? fromJson(dynamic value) => UpdateProductRequestStatusEnumTypeTransformer().decode(value);

  static List<UpdateProductRequestStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateProductRequestStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateProductRequestStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UpdateProductRequestStatusEnum] to String,
/// and [decode] dynamic data back to [UpdateProductRequestStatusEnum].
class UpdateProductRequestStatusEnumTypeTransformer {
  factory UpdateProductRequestStatusEnumTypeTransformer() => _instance ??= const UpdateProductRequestStatusEnumTypeTransformer._();

  const UpdateProductRequestStatusEnumTypeTransformer._();

  String encode(UpdateProductRequestStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UpdateProductRequestStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UpdateProductRequestStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'p': return UpdateProductRequestStatusEnum.p;
        case r'a': return UpdateProductRequestStatusEnum.a;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UpdateProductRequestStatusEnumTypeTransformer] instance.
  static UpdateProductRequestStatusEnumTypeTransformer? _instance;
}



class UpdateProductRequestRefreshIntervalEnum {
  /// Instantiate a new enum with the provided [value].
  const UpdateProductRequestRefreshIntervalEnum._(this.value);

  /// The underlying value of this enum member.
  final int value;

  @override
  String toString() => value.toString();

  int toJson() => value;

  static const number300 = UpdateProductRequestRefreshIntervalEnum._(300);
  static const number600 = UpdateProductRequestRefreshIntervalEnum._(600);
  static const number900 = UpdateProductRequestRefreshIntervalEnum._(900);
  static const number1800 = UpdateProductRequestRefreshIntervalEnum._(1800);
  static const number3600 = UpdateProductRequestRefreshIntervalEnum._(3600);
  static const number7200 = UpdateProductRequestRefreshIntervalEnum._(7200);
  static const number14400 = UpdateProductRequestRefreshIntervalEnum._(14400);
  static const number21600 = UpdateProductRequestRefreshIntervalEnum._(21600);
  static const number43200 = UpdateProductRequestRefreshIntervalEnum._(43200);
  static const number86400 = UpdateProductRequestRefreshIntervalEnum._(86400);

  /// List of all possible values in this [enum][UpdateProductRequestRefreshIntervalEnum].
  static const values = <UpdateProductRequestRefreshIntervalEnum>[
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

  static UpdateProductRequestRefreshIntervalEnum? fromJson(dynamic value) => UpdateProductRequestRefreshIntervalEnumTypeTransformer().decode(value);

  static List<UpdateProductRequestRefreshIntervalEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateProductRequestRefreshIntervalEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateProductRequestRefreshIntervalEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UpdateProductRequestRefreshIntervalEnum] to int,
/// and [decode] dynamic data back to [UpdateProductRequestRefreshIntervalEnum].
class UpdateProductRequestRefreshIntervalEnumTypeTransformer {
  factory UpdateProductRequestRefreshIntervalEnumTypeTransformer() => _instance ??= const UpdateProductRequestRefreshIntervalEnumTypeTransformer._();

  const UpdateProductRequestRefreshIntervalEnumTypeTransformer._();

  int encode(UpdateProductRequestRefreshIntervalEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UpdateProductRequestRefreshIntervalEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UpdateProductRequestRefreshIntervalEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case 300: return UpdateProductRequestRefreshIntervalEnum.number300;
        case 600: return UpdateProductRequestRefreshIntervalEnum.number600;
        case 900: return UpdateProductRequestRefreshIntervalEnum.number900;
        case 1800: return UpdateProductRequestRefreshIntervalEnum.number1800;
        case 3600: return UpdateProductRequestRefreshIntervalEnum.number3600;
        case 7200: return UpdateProductRequestRefreshIntervalEnum.number7200;
        case 14400: return UpdateProductRequestRefreshIntervalEnum.number14400;
        case 21600: return UpdateProductRequestRefreshIntervalEnum.number21600;
        case 43200: return UpdateProductRequestRefreshIntervalEnum.number43200;
        case 86400: return UpdateProductRequestRefreshIntervalEnum.number86400;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UpdateProductRequestRefreshIntervalEnumTypeTransformer] instance.
  static UpdateProductRequestRefreshIntervalEnumTypeTransformer? _instance;
}


