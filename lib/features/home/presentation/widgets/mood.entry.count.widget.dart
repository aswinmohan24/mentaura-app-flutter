import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/color.palette.dart';
import '../../../ai.analysis/models/emotion.history.model.dart';

class MoodEntryCountWidget extends StatelessWidget {
  const MoodEntryCountWidget(
      {super.key, required this.moodHistoryList, required this.title});

  final List<EmotionHistoryModel> moodHistoryList;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 10.sp,
              color: Palette.primaryTextColor,
              fontWeight: FontWeight.bold),
        ),
        Row(
          spacing: 3,
          children: [
            Text(
              moodHistoryList.length.toString(),
              style: TextStyle(
                  fontSize: 30.sp,
                  color: Palette.primaryTextColor,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Text(
                moodHistoryList.length <= 1 ? "Entry" : "Entries",
                style:
                    TextStyle(fontSize: 8.sp, color: Palette.primaryTextColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
