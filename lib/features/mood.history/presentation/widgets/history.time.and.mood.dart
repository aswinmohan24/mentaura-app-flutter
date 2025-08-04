import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';

import '../../../ai.analysis/models/emotion.history.model.dart';

class HistoryTimeAndMood extends StatelessWidget {
  const HistoryTimeAndMood({
    super.key,
    required this.emotionAsCamelCase,
    required this.historyModel,
  });

  final String emotionAsCamelCase;
  final EmotionHistoryModel historyModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time_filled_outlined,
          color: Palette.kGreyColor,
          size: 17,
        ),
        const SizedBox(width: 5),
        Text(
          DateFormat("hh:mm a").format(historyModel.createdDateTime),
          style: CustomTextStyles.subtitleLargeSemiBold(
              fontSize: 13, color: Palette.kGreyColor),
        ),
        const SizedBox(width: 5),
        Text(
          " ·  Feels $emotionAsCamelCase",
          style: CustomTextStyles.subtitleLargeSemiBold(
              fontSize: 13, color: Palette.kGreyColor),
        )
      ],
    );
  }
}
