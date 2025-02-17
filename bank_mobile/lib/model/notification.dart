class Notification {
  final String title;
  final String body;
  final String tipo;

  Notification({required this.title, required this.body, required this.tipo});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
        title: json['title'], body: json['body'], tipo: json['tipo']);
  }
}
