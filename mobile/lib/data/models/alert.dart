class Alert {
  Alert({required this.id, required this.title, required this.body, this.readAt});
  final String id;
  final String title;
  final String body;
  final DateTime? readAt;
  bool get isRead => readAt != null;

  factory Alert.fromJson(Map<String, dynamic> j) => Alert(
        id: j['id'] as String,
        title: (j['data']?['title'] ?? j['title'] ?? '') as String,
        body: (j['data']?['body'] ?? j['body'] ?? '') as String,
        readAt: j['read_at'] != null ? DateTime.parse(j['read_at'] as String) : null,
      );
}
