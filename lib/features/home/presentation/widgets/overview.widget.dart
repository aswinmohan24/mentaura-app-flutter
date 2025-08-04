import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/features/ai.analysis/models/emotion.history.model.dart';

import '../../../../core/theme/color.palette.dart';
import '../../../../core/theme/text.styles.dart';
import '../../../insights/presentation/screens/insights.screen.dart';
import 'mood.entry.count.widget.dart';

class OverViewWidget extends ConsumerWidget {
  const OverViewWidget({
    required this.moodHistoryList,
    super.key,
  });
  final List<EmotionHistoryModel> moodHistoryList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get date 7 days ago from now
    final DateTime sevenDaysAgo = DateTime.now().subtract(Duration(days: 7));

// Filter entries from the last 7 days
    final last7DaysEntries = moodHistoryList
        .where((entry) => entry.createdDateTime.isAfter(sevenDaysAgo))
        .toList();
    return Container(
      width: context.width(),
      height: context.width() * .47,
      decoration: BoxDecoration(
          color: Palette.kWhiteColor,
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          boxShadow: [
            BoxShadow(color: Palette.lightGreyColor, offset: Offset(-1, 1))
          ]),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 15.h, left: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Text(
                    "Moods Logged",
                    style: CustomTextStyles.titleLargeBold(
                        fontSize: 16, color: Palette.primaryTextColor),
                  ),

                  Row(
                    spacing: 15,
                    children: [
                      MoodEntryCountWidget(
                        moodHistoryList: moodHistoryList,
                        title: "All time",
                      ),
                      Container(
                        width: 1.5,
                        height: 40.h,
                        color: Palette.backgroundColor,
                      ),
                      MoodEntryCountWidget(
                        moodHistoryList: last7DaysEntries,
                        title: "Last 7 Days",
                      )
                    ],
                  ),
                  // SizedBox(height: 3),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, InsightsScreen.routeName),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Palette.yellowAccent,
                          borderRadius: BorderRadius.circular(15.r),
                          boxShadow: [
                            BoxShadow(
                                color: Palette.kThirdGreenColor,
                                offset: Offset(-1, 1))
                          ]),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
                      child: Text(
                        "View Details",
                        style: CustomTextStyles.subtitleLargeSemiBold(
                            color: Palette.primaryBlackColor),
                      ),
                    ),
                  )
                  // Text(
                  //   "Recent Mood",
                  //   style: CustomTextStyles.titleLargeSemiBold(
                  //       fontSize: 13, color: Palette.primaryTextColor),
                  // ),
                  // Container(
                  //   height: 30.h,
                  //   width: 85.w,
                  //   decoration: BoxDecoration(
                  //       color: Palette.kWhiteColor,
                  //       borderRadius: BorderRadius.all(Radius.circular(18.r))),
                  //   child: Center(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       spacing: 5,
                  //       children: [
                  //         Text(
                  //           moodHistoryList.last.emotion[0].toUpperCase() +
                  //               moodHistoryList.last.emotion.substring(1),
                  //           style: CustomTextStyles.subtitleLargeBold(
                  //               fontSize: 12, color: Palette.primaryBlackColor),
                  //         ),
                  //         Container(
                  //           width: 28.w,
                  //           height: 28.h,
                  //           decoration: BoxDecoration(
                  //               shape: BoxShape.circle,
                  //               color: Palette.emojiBgColor,
                  //               border: Border.all(
                  //                 color: Palette.primaryBlackColor,
                  //               )),
                  //           child: Center(
                  //             child: SvgPicture.asset(
                  //               StringUtil.getEmoji(
                  //                 moodHistoryList.last.emotion,
                  //               ),
                  //               width: 15.w,
                  //               height: 15.h,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          SizedBox(
              width: 167.w,
              height: 167.h,
              child: Center(
                  child: SvgPicture.asset(
                "assets/images/svg/mood.report.svg",
              )))
        ],
      ),
    );
  }
}
