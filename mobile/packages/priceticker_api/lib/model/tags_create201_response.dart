//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TagsCreate201Response {
  /// Returns a new [TagsCreate201Response] instance.
  TagsCreate201Response({
    required this.data,
    required this.message,
  });

  TagTransformer data;

  TagsCreate201ResponseMessageEnum message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TagsCreate201Response &&
    other.data == data &&
    other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (data.hashCode) +
    (message.hashCode);

  @override
  String toString() => 'TagsCreate201Response[data=$data, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'data'] = this.data;
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [TagsCreate201Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TagsCreate201Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TagsCreate201Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TagsCreate201Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TagsCreate201Response(
        data: TagTransformer.fromJson(json[r'data'])!,
        message: TagsCreate201ResponseMessageEnum.fromJson(json[r'message'])!,
      );
    }
    return null;
  }

  static List<TagsCreate201Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TagsCreate201Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TagsCreate201Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TagsCreate201Response> mapFromJson(dynamic json) {
    final map = <String, TagsCreate201Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TagsCreate201Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TagsCreate201Response-objects as value to a dart map
  static Map<String, List<TagsCreate201Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TagsCreate201Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TagsCreate201Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'data',
    'message',
  };
}


class TagsCreate201ResponseMessageEnum {
  /// Instantiate a new enum with the provided [value].
  const TagsCreate201ResponseMessageEnum._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const tagCreated = TagsCreate201ResponseMessageEnum._(r'Tag created');

  /// List of all possible values in this [enum][TagsCreate201ResponseMessageEnum].
  static const values = <TagsCreate201ResponseMessageEnum>[
    tagCreated,
  ];

  static TagsCreate201ResponseMessageEnum? fromJson(dynamic value) => TagsCreate201ResponseMessageEnumTypeTransformer().decode(value);

  static List<TagsCreate201ResponseMessageEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TagsCreate201ResponseMessageEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TagsCreate201ResponseMessageEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [TagsCreate201ResponseMessageEnum] to String,
/// and [decode] dynamic data back to [TagsCreate201ResponseMessageEnum].
class TagsCreate201ResponseMessageEnumTypeTransformer {
  factory TagsCreate201ResponseMessageEnumTypeTransformer() => _instance ??= const TagsCreate201ResponseMessageEnumTypeTransformer._();

  const TagsCreate201ResponseMessageEnumTypeTransformer._();

  String encode(TagsCreate201ResponseMessageEnum data) => data.value;

  /// Decodes a [dynamic value][data] to a TagsCreate201ResponseMessageEnum.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  TagsCreate201ResponseMessageEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'Tag created': return TagsCreate201ResponseMessageEnum.tagCreated;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [TagsCreate201ResponseMessageEnumTypeTransformer] instance.
  static TagsCreate201ResponseMessageEnumTypeTransformer? _instance;
}


