import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mentaura_app/core/constants/string.constants.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';

class StringUtil {
  static String getRandomString(List<String> strings) {
    final random = Random();
    return strings[random.nextInt(strings.length)];
  }

  static Map<String, String> getRandomQuote() {
    final random = Random();
    return fallbackQuotes[random.nextInt(fallbackQuotes.length)];
  }

  static Map<String, dynamic> getRandomActivity() {
    final random = Random();
    return aiRecommendedActivities[
        random.nextInt(aiRecommendedActivities.length)];
  }

  static String getWishString(DateTime currentTime) {
    final hour = currentTime.hour;

    if (hour >= 0 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 15) {
      return 'Good Afternoon';
    } else if (hour >= 15 && hour < 20) {
      return "Good Evening";
    } else {
      return 'Good Night';
    }
  }

  static const Map<String, String> _emojiMap = {
    "happy": "assets/images/svg/happy_face.svg",
    "surprised": "assets/images/svg/surprised_face.svg",
    "sad": "assets/images/svg/sad_face.svg",
    "depressed": "assets/images/svg/depressed_face.svg",
    "angry": "assets/images/svg/angry_face.svg",
    "neutral": "assets/images/svg/neutral_face.svg",
  };

  static String getEmoji(String emotion) {
    return _emojiMap[emotion] ?? "assets/images/svg/neutral_face.svg";
  }

  static Color getCardColor(String emotion) {
    if (emotion == "surprised" || emotion == "neutral") {
      return Palette.successColor;
    } else if (emotion == "sad" || emotion == "depresees") {
      return Palette.errorColor;
    } else if (emotion == "happy") {
      return Palette.happyFaceColor.withAlpha(165);
    } else {
      return Colors.deepOrangeAccent;
    }
  }
}
