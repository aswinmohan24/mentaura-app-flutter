import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/features/ai.analysis/models/emotion.history.model.dart';

import '../../../../core/theme/color.palette.dart';
import '../../../../core/theme/text.styles.dart';

class InsightScreenCountWidget extends StatelessWidget {
  const InsightScreenCountWidget({
    super.key,
    required this.title,
    required this.hisotoryList,
  });
  final String title;
  final List<EmotionHistoryModel> hisotoryList;

  @override
  Widget build(BuildContext context) {
    final last7dayList = hisotoryList.where((history) {
      final difference = DateTime.now().difference(history.createdDateTime);
      return difference.inDays < 7 && difference.inDays >= 0;
    }).toList();
    return Container(
      width: context.width() * .45,
      decoration: BoxDecoration(
          color: Palette.quoteBgColor,
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      padding: EdgeInsets.all(8),
      child: Column(
        spacing: 5,
        children: [
          Text(
            title,
            style: CustomTextStyles.subtitleLargeSemiBold(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          Text(
            title == "Total Entries"
                ? hisotoryList.length.toString()
                : last7dayList.length.toString(),
            style: CustomTextStyles.titleLargeBold(),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
