import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';

import '../../../../core/theme/text.styles.dart';
import '../../../../core/utils/string.utils.dart';

class IndividualMoodCountWidget extends StatelessWidget {
  const IndividualMoodCountWidget({
    super.key,
    required this.count,
    required this.emotion,
  });

  final int count;
  final String? emotion;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count.toString(),
              style: CustomTextStyles.titleLargeBold(fontSize: 16),
            ),
            Text(
              count <= 1 ? ' Entry' : ' Entries',
              style: CustomTextStyles.subtitleSmallSemiBold(fontSize: 8),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [
            Container(
              width: 15.w,
              height: 15.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Palette.emojiBgColor,
                  border: Border.all(
                    color: Palette.primaryBlackColor,
                  )),
              child: Center(
                child: SvgPicture.asset(
                  StringUtil.getEmoji(
                    emotion!,
                  ),
                  width: 8.w,
                  height: 8.h,
                ),
              ),
            ),
            Text(
              emotion![0].toUpperCase() + emotion!.substring(1),
              style: CustomTextStyles.subtitleLargeBold(),
            )
          ],
        ),
      ],
    );
  }
}
