import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/core/extensions.dart';

import '../../../../../core/theme/color.palette.dart';
import '../../../../../core/theme/text.styles.dart';
import '../../../models/emotion.response.model.dart';
import 'card.title.widget.dart';

class SuggestedActivityWidget extends StatelessWidget {
  const SuggestedActivityWidget({
    super.key,
    required this.emotionDetails,
  });

  final EmotionResponse emotionDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardTitleWidget(
          title: emotionDetails.activityTitle,
          bgColor: Palette.quoteBgColor,
          isPrefixiImage: true,
          fontZise: 13,
          prefixImageUrl: "assets/images/mentaura_logo_black.png",
          titleColor: Palette.kPrimaryGreenColor,
          prefixImageColor: Palette.kPrimaryGreenColor,
          border: Border(
              top: BorderSide(color: Palette.kGreyColor, width: .3),
              bottom: BorderSide(color: Palette.kGreyColor, width: .3),
              left: BorderSide(color: Palette.kGreyColor, width: .3),
              right: BorderSide(color: Palette.kGreyColor, width: .3)),
        ),
        Container(
          width: context.width(),
          decoration: BoxDecoration(
              color: Palette.kWhiteColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r)),
              border: Border(
                  bottom: BorderSide(color: Palette.kGreyColor, width: .3),
                  left: BorderSide(color: Palette.kGreyColor, width: .3),
                  right: BorderSide(color: Palette.kGreyColor, width: .3))),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              emotionDetails.explanation,
              style: CustomTextStyles.subtitleLargeSemiBold(
                color: Palette.primaryBlackColor,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
}
