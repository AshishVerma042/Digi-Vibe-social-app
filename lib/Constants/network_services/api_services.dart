import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String apiKey;
  final String model;

  OpenAIService({required this.apiKey, required this.model});

  Future<String> sendMessage(List<Map<String, dynamic>> messages) async {
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": model,
        "messages": messages,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["choices"][0]["message"]["content"].toString().trim();
    } else {
      throw Exception(
          "OpenAI Error: ${response.statusCode} ${response.body}");
    }
  }
}
