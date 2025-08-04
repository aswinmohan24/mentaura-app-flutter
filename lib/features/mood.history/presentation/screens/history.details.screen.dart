import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mentaura_app/core/constants/string.constants.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';
import 'package:mentaura_app/core/utils/string.utils.dart';
import 'package:mentaura_app/core/widgets/ui_components/default.button.dart';
import 'package:mentaura_app/features/ai.analysis/models/emotion.history.model.dart';
import 'package:mentaura_app/features/mood.history/presentation/widgets/history.delete.sheet.dart';

import '../../../../core/theme/color.palette.dart';

class HistoryDetailsSCreen extends ConsumerWidget {
  static const routeName = "/historyDetailsScreen";
  const HistoryDetailsSCreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moodDetails =
        ModalRoute.of(context)!.settings.arguments as EmotionHistoryModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Mood Details"),
        backgroundColor: Palette.backgroundColor,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: context.width(),
                  decoration: BoxDecoration(
                    color: Palette.kWhiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 37.h),
                      Container(
                          height: 25.h,
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                              color: Palette.backgroundColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            moodDetails.emotion[0].toUpperCase() +
                                moodDetails.emotion.substring(1),
                            style: CustomTextStyles.subtitleLargeBold(
                                color: StringUtil.getCardColor(
                                    moodDetails.emotion)),
                          )),
                      Text(
                        DateFormat("MMM dd yyy · hh:mm a")
                            .format(moodDetails.createdDateTime),
                        style: CustomTextStyles.subtitleSmallSemiBold(
                            fontSize: 12),
                      ),
                      Text(
                        moodDetails.chatTitle.replaceAll(emojiRegex, ''),
                        style: CustomTextStyles.titleLargeBold(),
                      ),
                      Text(
                        "Message",
                        style: CustomTextStyles.subtitleLargeBold(
                            fontSize: 13, color: Palette.kGreyColor),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width: context.width(),
                          decoration: BoxDecoration(
                              color: Palette.lightYellowAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          child: Text(
                            moodDetails.userMessage,
                            style: CustomTextStyles.subtitleLargeSemiBold(),
                          ),
                        ),
                      ),
                      Text(
                        "Suggested Activity",
                        style: CustomTextStyles.subtitleLargeBold(
                            fontSize: 13, color: Palette.kGreyColor),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15.w, right: 15.w, bottom: 15.h, top: 3.h),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          width: context.width(),
                          decoration: BoxDecoration(
                              color: Palette.kSecondaryGreenColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          child: Text(
                            moodDetails.explanation,
                            style: CustomTextStyles.subtitleLargeSemiBold(
                                color: Palette.backgroundColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -30.h,
                  child: CircleAvatar(
                    radius: 33.r,
                    backgroundColor: Palette.backgroundColor,
                    child: Container(
                      width: 48.h,
                      height: 48.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.emojiBgColor,
                          border: Border.all(
                              width: 2, color: Palette.primaryBlackColor)),
                      child: Center(
                        child: SvgPicture.asset(
                          width: 26.w,
                          height: 26.h,
                          StringUtil.getEmoji(moodDetails.emotion),
                          color: Palette.primaryBlackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            DefaultButton(
                text: "Delete History",
                press: () => {
                      showModalBottomSheet(
                          context: context,
                          builder: (ctx) {
                            return HistoryDeleteSheet(id: moodDetails.id!);
                          })
                    }),
            SizedBox(
              height: 25.h,
            )
          ],
        ),
      )),
    );
  }
}
