//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreateProductSourceRequest {
  /// Returns a new [CreateProductSourceRequest] instance.
  CreateProductSourceRequest({
    required this.name,
    required this.searchUrl,
    required this.type,
    this.storeId,
    this.settings = const [],
    this.status,
    this.notes,
    required this.extractionStrategy,
  });

  String name;

  String searchUrl;

  CreateProductSourceRequestTypeEnum type;

  int? storeId;

  List<String> settings;

  CreateProductSourceRequestStatusEnum? status;

  String? notes;

  CreateProductSourceRequestExtractionStrategy extractionStrategy;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateProductSourceRequest &&
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
    (name.hashCode) +
    (searchUrl.hashCode) +
    (type.hashCode) +
    (storeId == null ? 0 : storeId!.hashCode) +
    (settings.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (notes == null ? 0 : notes!.hashCode) +
    (extractionStrategy.hashCode);

  @override
  String toString() => 'CreateProductSourceRequest[name=$name, searchUrl=$searchUrl, type=$type, storeId=$storeId, settings=$settings, status=$status, notes=$notes, extractionStrategy=$extractionStrategy]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'search_url'] = this.searchUrl;
      json[r'type'] = this.type;
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
      json[r'extraction_strategy'] = this.extractionStrategy;
    return json;
  }

  /// Returns a new [CreateProductSourceRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateProductSourceRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CreateProductSourceRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CreateProductSourceRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreateProductSourceRequest(
        name: mapValueOfType<String>(json, r'name')!,
        searchUrl: mapValueOfType<String>(json, r'search_url')!,
        type: CreateProductSourceRequestTypeEnum.fromJson(json[r'type'])!,
        storeId: mapValueOfType<int>(json, r'store_id'),
        settings: json[r'settings'] is Iterable
            ? (json[r'settings'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        status: CreateProductSourceRequestStatusEnum.fromJson(json[r'status']),
        notes: mapValueOfType<String>(json, r'notes'),
        extractionStrategy: CreateProductSourceRequestExtractionStrategy.fromJson(json[r'extraction_strategy'])!,
      );
    }
    return null;
  }

  static List<CreateProductSourceRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateProductSourceRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateProductSourceRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateProductSourceRequest> mapFromJson(dynamic json) {
    final map = <String, CreateProductSourceRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateProductSourceRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateProductSourceRequest-objects as value to a dart map
  static Map<String, List<CreateProductSourceRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateProductSourceRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CreateProductSourceRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'search_url',
    'type',
    'extraction_strategy',
  };
}


class CreateProductSourceRequestTypeEnum {
  /// Instantiate a new enum with the provided [value].
  const CreateProductSourceRequestTypeEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const dealsSite = CreateProductSourceRequestTypeEnum._(r'deals_site');
  static const onlineStore = CreateProductSourceRequestTypeEnum._(r'online_store');

  /// List of all possible values in this [enum][CreateProductSourceRequestTypeEnum].
  static const values = <CreateProductSourceRequestTypeEnum>[
    dealsSite,
    onlineStore,
  ];

  static CreateProductSourceRequestTypeEnum? fromJson(dynamic value) => CreateProductSourceRequestTypeEnumTypeTransformer().decode(value);

  static List<CreateProductSourceRequestTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateProductSourceRequestTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateProductSourceRequestTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CreateProductSourceRequestTypeEnum] to String,
/// and [decode] dynamic data back to [CreateProductSourceRequestTypeEnum].
class CreateProductSourceRequestTypeEnumTypeTransformer {
  factory CreateProductSourceRequestTypeEnumTypeTransformer() => _instance ??= const CreateProductSourceRequestTypeEnumTypeTransformer._();

  const CreateProductSourceRequestTypeEnumTypeTransformer._();

  String encode(CreateProductSourceRequestTypeEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CreateProductSourceRequestTypeEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CreateProductSourceRequestTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'deals_site': return CreateProductSourceRequestTypeEnum.dealsSite;
        case r'online_store': return CreateProductSourceRequestTypeEnum.onlineStore;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CreateProductSourceRequestTypeEnumTypeTransformer] instance.
  static CreateProductSourceRequestTypeEnumTypeTransformer? _instance;
}



class CreateProductSourceRequestStatusEnum {
  /// Instantiate a new enum with the provided [value].
  const CreateProductSourceRequestStatusEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const active = CreateProductSourceRequestStatusEnum._(r'active');
  static const inactive = CreateProductSourceRequestStatusEnum._(r'inactive');
  static const draft = CreateProductSourceRequestStatusEnum._(r'draft');

  /// List of all possible values in this [enum][CreateProductSourceRequestStatusEnum].
  static const values = <CreateProductSourceRequestStatusEnum>[
    active,
    inactive,
    draft,
  ];

  static CreateProductSourceRequestStatusEnum? fromJson(dynamic value) => CreateProductSourceRequestStatusEnumTypeTransformer().decode(value);

  static List<CreateProductSourceRequestStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateProductSourceRequestStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateProductSourceRequestStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CreateProductSourceRequestStatusEnum] to String,
/// and [decode] dynamic data back to [CreateProductSourceRequestStatusEnum].
class CreateProductSourceRequestStatusEnumTypeTransformer {
  factory CreateProductSourceRequestStatusEnumTypeTransformer() => _instance ??= const CreateProductSourceRequestStatusEnumTypeTransformer._();

  const CreateProductSourceRequestStatusEnumTypeTransformer._();

  String encode(CreateProductSourceRequestStatusEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a CreateProductSourceRequestStatusEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CreateProductSourceRequestStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'active': return CreateProductSourceRequestStatusEnum.active;
        case r'inactive': return CreateProductSourceRequestStatusEnum.inactive;
        case r'draft': return CreateProductSourceRequestStatusEnum.draft;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [CreateProductSourceRequestStatusEnumTypeTransformer] instance.
  static CreateProductSourceRequestStatusEnumTypeTransformer? _instance;
}


