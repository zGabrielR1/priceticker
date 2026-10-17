class Watch {
  Watch({
    required this.id,
    required this.type,
    required this.name,
    this.isActive = true,
    this.config = const {},
    this.rules = const {},
  });

  final int id;
  final String type;
  final String name;
  final bool isActive;
  final Map<String, dynamic> config;
  final Map<String, dynamic> rules;

  factory Watch.fromJson(Map<String, dynamic> j) => Watch(
        id: j['id'] as int,
        type: j['type'] as String,
        name: j['name'] as String,
        isActive: (j['is_active'] as bool?) ?? true,
        config: (j['config'] as Map<String, dynamic>?) ?? {},
        rules: (j['rules'] as Map<String, dynamic>?) ?? {},
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'is_active': isActive,
        'config': config,
        'rules': rules,
      };
}
