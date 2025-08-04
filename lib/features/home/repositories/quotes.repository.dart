import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:mentaura_app/features/home/models/quotes.model.dart';

class QuotesRepository {
  Future<QuotesModel?> getDailyQuotes() async {
    try {
      final url = Uri.parse('https://zenquotes.io/api/random');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final quote = data[0]['q'];
        final author = data[0]['a'];
        log('"$quote" — $author');
        return QuotesModel.fromMap(data[0]);
      } else {
        log('Failed to load quote. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log("Error occured when fetching quote $e");
      return null;
    }
  }
}
