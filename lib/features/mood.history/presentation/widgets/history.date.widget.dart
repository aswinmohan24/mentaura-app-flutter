import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/color.palette.dart';
import '../../../../core/theme/text.styles.dart';
import '../../../ai.analysis/models/emotion.history.model.dart';

class MoodHistoryDateWidget extends StatelessWidget {
  final EmotionHistoryModel history;
  const MoodHistoryDateWidget({
    super.key,
    required this.history,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 46.h,
      decoration: BoxDecoration(
          color: Palette.lightYellowAccent,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat("MMM").format(history.createdDateTime).toUpperCase(),
            style: CustomTextStyles.subtitleSmallSemiBold(),
          ),
          Text(
            DateFormat("dd").format(history.createdDateTime),
            style: CustomTextStyles.subtitleLargeBold(
                color: Palette.primaryTextColor),
          )
        ],
      ),
    );
  }
}
