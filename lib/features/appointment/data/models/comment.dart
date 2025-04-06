class Comment {
  final String id;
  final String text;
  final DateTime timestamp;

  Comment({
    required this.id,
    required this.text,
    required this.timestamp,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'],
      text: map['text'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'text': text,
    'timestamp': timestamp.toIso8601String(),
  };
}
