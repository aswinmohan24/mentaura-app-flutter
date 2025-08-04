import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentaura_app/features/ai.analysis/models/emotion.history.model.dart';
import 'package:mentaura_app/features/mood.history/providers/activity.provider.dart';

final lastSevenDaysMoodProvider =
    Provider<AsyncValue<List<EmotionHistoryModel>>>((ref) {
  final moodState = ref.watch(emotionHistoryNotifierProvider);

  return moodState.whenData((moodList) {
    final now = DateTime.now();
    return moodList.where((mood) {
      final difference = now.difference(mood.createdDateTime);
      return difference.inDays < 7 && difference.inDays >= 0;
    }).toList();
  });
});
