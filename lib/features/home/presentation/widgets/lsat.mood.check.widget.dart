import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/features/ai.analysis/models/emotion.history.model.dart';

import '../../../../core/theme/color.palette.dart';
import '../../../../core/theme/text.styles.dart';
import '../../../../core/utils/string.utils.dart';

class LastMoodCheckWidget extends StatelessWidget {
  const LastMoodCheckWidget({
    super.key,
    required this.lastMoodCheck,
  });

  final EmotionHistoryModel lastMoodCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: BoxDecoration(
          color: Palette.kSecondaryGreenColor,
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 5,
            ),
            Column(
              spacing: 2,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat("dd").format(lastMoodCheck.createdDateTime),
                  style: CustomTextStyles.titleLargeBold(
                    color: Palette.backgroundColor,
                  ),
                ),
                Text(
                  DateFormat("MMM").format(lastMoodCheck.createdDateTime),
                  style: CustomTextStyles.subtitleLargeSemiBold(
                    color: Palette.backgroundColor,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),
            Container(
              width: 2.5,
              height: 40.h,
              color: Palette.lightGreyColor,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    lastMoodCheck.chatTitle,
                    style: CustomTextStyles.titleLargeBold(
                      fontSize: 16,
                      color: Palette.backgroundColor,
                    ),
                  ),
                  Text(
                    lastMoodCheck.userMessage,
                    style: CustomTextStyles.subtitleLargeRegular(
                      fontSize: 16,
                      color: Palette.backgroundColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.emojiBgColor,
                  border: Border.all(
                    color: Palette.primaryBlackColor,
                  )),
              child: Center(
                child: SvgPicture.asset(
                  StringUtil.getEmoji(
                    lastMoodCheck.emotion,
                  ),
                  width: 28.w,
                  height: 28.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
