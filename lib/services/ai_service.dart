/*import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> generateText(String prompt) async {
    final url = Uri.parse(
        "http:// 192.168.1.7:5000/generate"); // Change this if using a real server
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"prompt": prompt}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['generated_text'] ?? "No response";
    } else {
      throw Exception("Failed to generate text");
    }
  }
}
*/

import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  static const String apiUrl = "http:// 192.168.1.7:5000/generate";

  static Future<String?> generateSummary(
      String education, String experience, String skills) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "education": education,
          "experience": experience,
          "skills": skills,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['summary'];
      } else {
        return "Error: ${response.body}";
      }
    } catch (e) {
      return "Failed to connect to AI service";
    }
  }
}
