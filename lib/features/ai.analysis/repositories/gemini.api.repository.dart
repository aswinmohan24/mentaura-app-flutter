import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mentaura_app/features/ai.analysis/models/emotion.response.model.dart';

import '../../../core/constants/api.key.dart';

class GeminiApiRepository {
  Future<EmotionResponse> analyzeEmotion(String userMessage) async {
    final apiUrl =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$geminiApiKey";
    final Map<String, String> headers = {"Content-Type": "application/json"};

    String requestBodyText =
        "Analyze:$userMessage, Identify the primary emotion expressed from one of these : happy, surprised, neutral, sad, depressed, angry. Return JSON with keys: chatTitle (small and related to message), emotion(must be lowercase), confidence (0–1), suggestedReplyTitle (e.g., 'Ohh... I think you're feeling sad', must be short), suggestedReply(within two sentence and very short), activityTitle (e.g., 'Don't stay alone'), and explanation (e.g., 'Spend time with friends and share your emotions.'). Make all outputs friendly and emotion-appropriate.";

    final requestBody = {
      "contents": [
        {
          "parts": [
            {"text": requestBodyText}
          ]
        }
      ]
    };

    // try {
    final geminiResponse = await http.post(Uri.parse(apiUrl),
        headers: headers, body: jsonEncode(requestBody));
    final jsonBody = jsonDecode(geminiResponse.body);
    if (geminiResponse.statusCode == 200) {
      final responseBody =
          jsonBody["candidates"][0]["content"]["parts"][0]["text"];
      final cleanJson =
          responseBody.replaceAll(RegExp(r'```json|```'), '').trim();
      log("Detection $cleanJson");
      return EmotionResponse.fromJson(jsonDecode(cleanJson));
    } else {
      log("Failed to detect emotion $jsonBody");
      throw Exception("Failed to detect emotion");
    }
    // } catch (e) {
    // log("Error occured in emotion detection$e");
    // rethrow;
    // }
  }
}
