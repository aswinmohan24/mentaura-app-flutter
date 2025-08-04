import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentaura_app/features/ai.analysis/providers/chat.provider.dart';
import 'package:mentaura_app/features/ai.analysis/models/emotion.history.model.dart';

final allEmotionHistoryProvider =
    FutureProvider<List<EmotionHistoryModel>>((ref) async {
  final emotionRepository = ref.watch(emotionHistoryRepositoryProvider);
  return emotionRepository.getAllEmotionHistory();
});

final emotionHistoryNotifierProvider = StateNotifierProvider<
    EmotionHistoryNotifier, AsyncValue<List<EmotionHistoryModel>>>((ref) {
  return EmotionHistoryNotifier(ref);
});

class EmotionHistoryNotifier
    extends StateNotifier<AsyncValue<List<EmotionHistoryModel>>> {
  final Ref ref;
  EmotionHistoryNotifier(this.ref) : super(const AsyncValue.loading()) {
    getAllEmotionsHistory();
  }

  void getAllEmotionsHistory() async {
    try {
      final emotionHistory = await ref
          .read(emotionHistoryRepositoryProvider)
          .getAllEmotionHistory();
      state = AsyncValue.data(emotionHistory);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void setMoodHistory(List<EmotionHistoryModel> allHistory) {
    state = AsyncValue.data(allHistory);
  }

  void addNewMoodHistory(EmotionHistoryModel newHisory) {
    final previous = state.value ?? [];
    state = AsyncValue.data([newHisory, ...previous]);
  }

  void deleteMoodHistory(String id) {
    final allMoodList = state.value ?? [];
    allMoodList.removeWhere((mood) => mood.id == id);
    state = AsyncValue.data(allMoodList);
  }

  void cleaMoodHistory() {
    state = AsyncValue.data([]);
    getAllEmotionsHistory();
  }
}

final moodChipChangeProvider = StateProvider<String>((ref) {
  return "All";
});
