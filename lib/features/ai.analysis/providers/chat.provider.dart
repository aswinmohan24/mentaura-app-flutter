// independent providers -------//

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentaura_app/features/ai.analysis/models/emotion.response.model.dart';
import 'package:mentaura_app/features/ai.analysis/models/spotify.suggestion.model.dart';
import 'package:mentaura_app/features/ai.analysis/repositories/emotion.repository.dart';
import 'package:mentaura_app/features/ai.analysis/repositories/gemini.api.repository.dart';
import 'package:mentaura_app/features/ai.analysis/repositories/spotify.repository.dart';

final lastWordProvider = StateProvider<String>((ref) {
  return "";
});

final keyboardProvider = StateProvider<bool>((ref) {
  return false;
});

final micListeningProvider = StateProvider<String>((ref) {
  return "notListening";
});

// repo providers

final geminiRepositoryProvider = Provider((ref) => GeminiApiRepository());

final emotionHistoryRepositoryProvider =
    Provider((ref) => EmotionRepository(auth: FirebaseAuth.instance));

final spotifyRepsitoryProvider =
    Provider((ref) => SpotifyRepository(auth: FirebaseAuth.instance));

final spotifySuggestionsFutureProvider =
    FutureProvider.family<SpotifySuggestionsModel, String>((ref, mood) async {
  return ref.read(spotifyRepsitoryProvider).getRecomenedationsFromSpotify(mood);
});

// notifier provider-----------------------

final emotionDetailsNotifierProvider =
    StateNotifierProvider<EmotionDetailsNotifier, EmotionResponse>((ref) {
  return EmotionDetailsNotifier();
});

class EmotionDetailsNotifier extends StateNotifier<EmotionResponse> {
  EmotionDetailsNotifier()
      : super(EmotionResponse(
            emotion: "",
            confidence: 0,
            chatTitle: "",
            suggestedReplyTitle: "",
            suggestedReply: "",
            activityTitle: "",
            explanation: ""));

  void updateEmotionDetails(EmotionResponse newEmotion) {
    state = newEmotion;
  }
}
