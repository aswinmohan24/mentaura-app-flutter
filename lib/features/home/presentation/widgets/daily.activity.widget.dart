import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentaura_app/core/extensions.dart';

import '../../../../core/theme/color.palette.dart';
import '../../../../core/theme/text.styles.dart';
import '../../../../core/utils/string.utils.dart';

class DailyActivityWidget extends StatelessWidget {
  const DailyActivityWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final activity = StringUtil.getRandomActivity();
    return Container(
        width: context.width(),
        decoration: BoxDecoration(
            color: Palette.quoteBgColor,
            borderRadius: BorderRadius.all(Radius.circular(15.r))),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            child: Row(
              spacing: 10,
              children: [
                CircleAvatar(
                  backgroundColor: Palette.backgroundColor,
                  radius: 25.r,
                  child: SvgPicture.asset(
                    "assets/images/svg/activity_icon.svg",
                    fit: BoxFit.cover,
                    height: 35,
                    color: Palette.kPrimaryGreenColor,
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity["title"],
                        style: CustomTextStyles.subtitleLargeBold(fontSize: 14),
                      ),
                      Text(activity["subtitle"],
                          style: TextStyle(fontSize: 12.sp)),
                    ],
                  ),
                ),
              ],
            )));
  }
}
