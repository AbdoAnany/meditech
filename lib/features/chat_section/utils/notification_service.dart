import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendNotification({
  required String title,
  required String message,
  required dynamic registrationTokens,
  required Map data,
  String? topic,
}) async {
  final List tokens = registrationTokens is String
      ? [registrationTokens]
      : List.from(registrationTokens);
  final response = await http.post(
    Uri.parse('https://abdoanany.pythonanywhere.com/pushFCM'),
    body: json.encode({
      'title': title,
      'msg': message,
      'data': data,
      'topic': topic ?? '',
    }),
    headers: {'Content-Type': 'application/json'},
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to send notification: ${response.statusCode}');
  }
}