class Notification {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;

  Notification(
      {required this.id,
      required this.title,
      required this.body,
      required this.createdAt});
  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
