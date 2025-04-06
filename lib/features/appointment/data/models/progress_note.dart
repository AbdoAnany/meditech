import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressNote {
  final String id;
  final String userId;
  final String authorId; // doctor or staff ID
  final DateTime timestamp;
  final String noteType; // 'medical', 'dietary', 'exercise', 'general'
  final String content;
  final List<String> tags;
  final Map<String, dynamic> metrics; // Any measurements or values recorded

  ProgressNote({
    required this.id,
    required this.userId,
    required this.authorId,
    required this.timestamp,
    required this.noteType,
    required this.content,
    required this.tags,
    required this.metrics,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'authorId': authorId,
    'timestamp': timestamp,
    'noteType': noteType,
    'content': content,
    'tags': tags,
    'metrics': metrics,
  };

  factory ProgressNote.fromMap(Map<String, dynamic> map) => ProgressNote(
    id: map['id'],
    userId: map['userId'],
    authorId: map['authorId'],
    timestamp: (map['timestamp'] as Timestamp).toDate(),
    noteType: map['noteType'],
    content: map['content'],
    tags: List<String>.from(map['tags']),
    metrics: Map<String, dynamic>.from(map['metrics']),
  );
}