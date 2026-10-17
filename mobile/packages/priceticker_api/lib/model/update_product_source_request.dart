//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class UpdateProductSourceRequest {
  /// Returns a new [UpdateProductSourceRequest] instance.
  UpdateProductSourceRequest({
    this.name,
    this.searchUrl,
    this.type,
    this.storeId,
    this.settings = const [],
    this.status,
    this.notes,
    this.extractionStrategy,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? searchUrl;

  UpdateProductSourceRequestTypeEnum? type;

  int? storeId;

  List<String> settings;

  UpdateProductSourceRequestStatusEnum? status;

  String? notes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  UpdateProductSourceRequestExtractionStrategy? extractionStrategy;

  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateProductSourceRequest &&
    other.name == name &&
    other.searchUrl == searchUrl &&
    other.type == type &&
    other.storeId == storeId &&
    _deepEquality.equals(other.settings, settings) &&
    other.status == status &&
    other.notes == notes &&
    other.extractionStrategy == extractionStrategy;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name == null ? 0 : name!.hashCode) +
    (searchUrl == null ? 0 : searchUrl!.hashCode) +
    (type == null ? 0 : type!.hashCode) +
    (storeId == null ? 0 : storeId!.hashCode) +
    (settings.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (notes == null ? 0 : notes!.hashCode) +
    (extractionStrategy == null ? 0 : extractionStrategy!.hashCode);

  @override
  String toString() => 'UpdateProductSourceRequest[name=$name, searchUrl=$searchUrl, type=$type, storeId=$storeId, settings=$settings, status=$status, notes=$notes, extractionStrategy=$extractionStrategy]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.searchUrl != null) {
      json[r'search_url'] = this.searchUrl;
    } else {
      json[r'search_url'] = null;
    }
    if (this.type != null) {
      json[r'type'] = this.type;
    } else {
      json[r'type'] = null;
    }
    if (this.storeId != null) {
      json[r'store_id'] = this.storeId;
    } else {
      json[r'store_id'] = null;
    }
      json[r'settings'] = this.settings;
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
    if (this.notes != null) {
      json[r'notes'] = this.notes;
    } else {
      json[r'notes'] = null;
    }
    if (this.extractionStrategy != null) {
      json[r'extraction_strategy'] = this.extractionStrategy;
    } else {
      json[r'extraction_strategy'] = null;
    }
    return json;
  }

  /// Returns a new [UpdateProductSourceRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static UpdateProductSourceRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "UpdateProductSourceRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "UpdateProductSourceRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return UpdateProductSourceRequest(
        name: mapValueOfType<String>(json, r'name'),
        searchUrl: mapValueOfType<String>(json, r'search_url'),
        type: UpdateProductSourceRequestTypeEnum.fromJson(json[r'type']),
        storeId: mapValueOfType<int>(json, r'store_id'),
        settings: json[r'settings'] is Iterable
            ? (json[r'settings'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        status: UpdateProductSourceRequestStatusEnum.fromJson(json[r'status']),
        notes: mapValueOfType<String>(json, r'notes'),
        extractionStrategy: UpdateProductSourceRequestExtractionStrategy.fromJson(json[r'extraction_strategy']),
      );
    }
    return null;
  }

  static List<UpdateProductSourceRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateProductSourceRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateProductSourceRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, UpdateProductSourceRequest> mapFromJson(dynamic json) {
    final map = <String, UpdateProductSourceRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = UpdateProductSourceRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of UpdateProductSourceRequest-objects as value to a dart map
  static Map<String, List<UpdateProductSourceRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<UpdateProductSourceRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = UpdateProductSourceRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


class UpdateProductSourceRequestTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const UpdateProductSourceRequestTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const dealsSite = UpdateProductSourceRequestTypeEnum._(r'deals_site');
  static const onlineStore = UpdateProductSourceRequestTypeEnum._(r'online_store');

  /// List of all possible values in this [enum][UpdateProductSourceRequestTypeEnum].
  static const values = <UpdateProductSourceRequestTypeEnum>[
    dealsSite,
    onlineStore,
  ];

  static UpdateProductSourceRequestTypeEnum? fromJson(dynamic value) => UpdateProductSourceRequestTypeEnumTypeTransformer().decode(value);

  static List<UpdateProductSourceRequestTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateProductSourceRequestTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateProductSourceRequestTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UpdateProductSourceRequestTypeEnum] to String,
/// and [decode] dynamic data back to [UpdateProductSourceRequestTypeEnum].
class UpdateProductSourceRequestTypeEnumTypeTransformer {
  factory UpdateProductSourceRequestTypeEnumTypeTransformer() => _instance ??= const UpdateProductSourceRequestTypeEnumTypeTransformer._();

  const UpdateProductSourceRequestTypeEnumTypeTransformer._();

  String encode(UpdateProductSourceRequestTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UpdateProductSourceRequestTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UpdateProductSourceRequestTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'deals_site': return UpdateProductSourceRequestTypeEnum.dealsSite;
        case r'online_store': return UpdateProductSourceRequestTypeEnum.onlineStore;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UpdateProductSourceRequestTypeEnumTypeTransformer] instance.
  static UpdateProductSourceRequestTypeEnumTypeTransformer? _instance;
}



class UpdateProductSourceRequestStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const UpdateProductSourceRequestStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const active = UpdateProductSourceRequestStatusEnum._(r'active');
  static const inactive = UpdateProductSourceRequestStatusEnum._(r'inactive');
  static const draft = UpdateProductSourceRequestStatusEnum._(r'draft');

  /// List of all possible values in this [enum][UpdateProductSourceRequestStatusEnum].
  static const values = <UpdateProductSourceRequestStatusEnum>[
    active,
    inactive,
    draft,
  ];

  static UpdateProductSourceRequestStatusEnum? fromJson(dynamic value) => UpdateProductSourceRequestStatusEnumTypeTransformer().decode(value);

  static List<UpdateProductSourceRequestStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UpdateProductSourceRequestStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UpdateProductSourceRequestStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UpdateProductSourceRequestStatusEnum] to String,
/// and [decode] dynamic data back to [UpdateProductSourceRequestStatusEnum].
class UpdateProductSourceRequestStatusEnumTypeTransformer {
  factory UpdateProductSourceRequestStatusEnumTypeTransformer() => _instance ??= const UpdateProductSourceRequestStatusEnumTypeTransformer._();

  const UpdateProductSourceRequestStatusEnumTypeTransformer._();

  String encode(UpdateProductSourceRequestStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a UpdateProductSourceRequestStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UpdateProductSourceRequestStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'active': return UpdateProductSourceRequestStatusEnum.active;
        case r'inactive': return UpdateProductSourceRequestStatusEnum.inactive;
        case r'draft': return UpdateProductSourceRequestStatusEnum.draft;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UpdateProductSourceRequestStatusEnumTypeTransformer] instance.
  static UpdateProductSourceRequestStatusEnumTypeTransformer? _instance;
}


