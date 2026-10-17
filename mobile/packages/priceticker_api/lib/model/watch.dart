//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Watch {
  /// Returns a new [Watch] instance.
  Watch({
    required this.id,
    required this.userId,
    required this.type,
    required this.name,
    this.config,
    this.rules,
    required this.isActive,
    required this.lastAlertedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;

  int? userId;

  WatchType type;

  String name;

  dynamic config;

  dynamic rules;

  bool isActive;

  DateTime? lastAlertedAt;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Watch &&
    other.id == id &&
    other.userId == userId &&
    other.type == type &&
    other.name == name &&
    _deepEquality.equals(other.config, config) &&
    _deepEquality.equals(other.rules, rules) &&
    other.isActive == isActive &&
    other.lastAlertedAt == lastAlertedAt &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (userId == null ? 0 : userId!.hashCode) +
    (type.hashCode) +
    (name.hashCode) +
    (config.hashCode) +
    (rules.hashCode) +
    (isActive.hashCode) +
    (lastAlertedAt == null ? 0 : lastAlertedAt!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (updatedAt == null ? 0 : updatedAt!.hashCode);

  @override
  String toString() => 'Watch[id=$id, userId=$userId, type=$type, name=$name, config=$config, rules=$rules, isActive=$isActive, lastAlertedAt=$lastAlertedAt, createdAt=$createdAt, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
    if (this.userId != null) {
      json[r'user_id'] = this.userId;
    } else {
      json[r'user_id'] = null;
    }
      json[r'type'] = this.type;
      json[r'name'] = this.name;
      json[r'config'] = this.config;
      json[r'rules'] = this.rules;
      json[r'is_active'] = this.isActive;
    if (this.lastAlertedAt != null) {
      json[r'last_alerted_at'] = this.lastAlertedAt!.toUtc().toIso8601String();
    } else {
      json[r'last_alerted_at'] = null;
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
    return json;
  }

  /// Returns a new [Watch] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Watch? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Watch[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Watch[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Watch(
        id: mapValueOfType<int>(json, r'id')!,
        userId: mapValueOfType<int>(json, r'user_id'),
        type: WatchType.fromJson(json[r'type'])!,
        name: mapValueOfType<String>(json, r'name')!,
        config: json[r'config'],
        rules: json[r'rules'],
        isActive: mapValueOfType<bool>(json, r'is_active')!,
        lastAlertedAt: mapDateTime(json, r'last_alerted_at', r''),
        createdAt: mapDateTime(json, r'created_at', r''),
        updatedAt: mapDateTime(json, r'updated_at', r''),
      );
    }
    return null;
  }

  static List<Watch> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Watch>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Watch.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Watch> mapFromJson(dynamic json) {
    final map = <String, Watch>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Watch.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Watch-objects as value to a dart map
  static Map<String, List<Watch>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Watch>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Watch.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'user_id',
    'type',
    'name',
    'config',
    'rules',
    'is_active',
    'last_alerted_at',
    'created_at',
    'updated_at',
  };
}

