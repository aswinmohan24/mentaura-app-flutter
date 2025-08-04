// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:mentaura_app/core/constants/constants.dart';

import '../models/spotify.suggestion.model.dart';

class SpotifyRepository {
  FirebaseAuth auth;
  SpotifyRepository({
    required this.auth,
  });
  Future<SpotifySuggestionsModel> getRecomenedationsFromSpotify(
      String mood) async {
    try {
      final userToken = await auth.currentUser!.getIdToken();
      Map<String, String>? headers = {
        'Authorization': "Bearer ${userToken!}",
        'Content-Type': 'application/json',
      };

      final response = await http.get(
          Uri.parse("$baseUrl/spotify/recommendation/$mood"),
          headers: headers);
      final respJson = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final suggestionsMap = respJson["data"];
        log("Response map $respJson");
        return SpotifySuggestionsModel.fromMap(suggestionsMap);
      } else {
        log("error $respJson ${response.statusCode}");
        throw Exception("Failed to get spotify sugestions");
      }
    } catch (e) {
      log("Failed to get playlist suggestions $e");
      rethrow;
    }
  }
}
