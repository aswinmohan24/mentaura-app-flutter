import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';

import '../../../../core/theme/color.palette.dart';

class MoodAnalyzeButton extends StatelessWidget {
  final VoidCallback onPressed;
  const MoodAnalyzeButton({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: context.width(),
          decoration: BoxDecoration(
              color: Palette.kWhiteColor,
              borderRadius: BorderRadius.all(Radius.circular(30.r))),
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundColor: Palette.quoteBgColor,
                child: Image.asset(
                  "assets/images/mentaura_logo_black.png",
                  fit: BoxFit.contain,
                  height: 35.h,
                  width: 35.w,
                  color: Palette.kPrimaryGreenColor,
                ),
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "AI",
                        style: CustomTextStyles.subtitleLargeBold(
                            color: Palette.primaryBlackColor, fontSize: 14),
                      ),
                      SvgPicture.asset(
                        height: 12,
                        width: 12,
                        "assets/images/svg/ai_stars.svg",
                        color: Palette.primaryBlackColor,
                      ),
                      Text(
                        " Powered mood analysis.",
                        style: CustomTextStyles.subtitleLargeBold(
                            color: Palette.primaryBlackColor, fontSize: 15),
                      ),
                    ],
                  ),
                  Text(
                    "Smart advice, shaped by your mood.",
                    style: CustomTextStyles.subtitleLargeRegular(
                        color: Palette.primaryBlackColor, fontSize: 11),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 25.r,
                backgroundColor: Palette.quoteBgColor,
                child: IconButton(
                  onPressed: onPressed,
                  icon: Icon(CupertinoIcons.arrow_right),
                  color: Palette.kPrimaryGreenColor,
                ),
              ),
            ],
          )
          // ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: Palette.kPrimaryGreenColor),
          //     onPressed: onPressed,
          //     child: Row(
          //       children: [
          //         Text(
          //           "AI",
          //           style: CustomTextStyles.subtitleLargeBold(
          //               color: Palette.backgroundColor),
          //         ),
          //         SvgPicture.asset(
          //             height: 15, width: 15, "assets/images/svg/ai_stars.svg"),
          //         Text(
          //           " Mood Analysis",
          //           style: CustomTextStyles.subtitleLargeBold(
          //               color: Palette.backgroundColor),
          //         ),
          //       ],
          //     ))

          ),
    );
  }
}
