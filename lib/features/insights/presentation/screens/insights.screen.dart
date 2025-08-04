import 'dart:math';
import 'dart:developer' as dv;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/features/ai.analysis/models/emotion.history.model.dart';
import 'package:mentaura_app/features/insights/presentation/widgets/mood.chart.dart';
import 'package:mentaura_app/features/insights/providers/insights.provider.dart';
import 'package:mentaura_app/features/mood.history/providers/activity.provider.dart';

import '../../../../core/theme/color.palette.dart';
import '../../../../core/theme/text.styles.dart';
import '../../../../core/utils/string.utils.dart';
import '../widgets/individual.mood.count.widget.dart';
import '../widgets/insight.count.widget.dart';

class InsightsScreen extends StatefulWidget {
  static const routeName = "/insight-screen";
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scaleAnimation = Tween<double>(begin: .5, end: 1).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    slideAnimation = Tween<Offset>(begin: Offset(0, .5), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animationController.forward();
    super.initState();
  }

  Map<String, int> getEmotionCounts(List<EmotionHistoryModel> list) {
    return list.fold<Map<String, int>>({}, (map, item) {
      map[item.emotion] = (map[item.emotion] ?? 0) + 1;
      return map;
    });
  }

  String? getMostFrequentEmotion(List<EmotionHistoryModel> list) {
    if (list.isEmpty) return null;

    // Step 1: Count each emotion
    final Map<String, int> counts = {};
    for (var item in list) {
      counts[item.emotion] = (counts[item.emotion] ?? 0) + 1;
    }

    // Step 2: Find max count
    final int maxCount = counts.values.reduce(max);

    // Step 3: Get all emotions with that count
    final List<String> topEmotions = counts.entries
        .where((entry) => entry.value == maxCount)
        .map((entry) => entry.key)
        .toList();

    if (topEmotions.length == 1) return topEmotions.first;

    // Step 4: Use a stable hash-based random seed
    final seedString = list
        .map((e) => '${e.emotion}:${e.createdDateTime.toIso8601String()}')
        .join(',');
    final seed = seedString.hashCode;
    final random = Random(seed);

    return topEmotions[random.nextInt(topEmotions.length)];
  }

  List<String> getLast7Days() {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final date = now.subtract(Duration(days: index)); // +1 to exclude today
      return _formatDay(date);
    }).reversed.toList(); // Optional: to get Mon to Sun order
  }

  String _formatDay(DateTime date) {
    // You can use intl package for locale-aware formatting
    // But simple fallback:
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[date.weekday - 1];
  }

// for removing time from mongodb timestamp
  DateTime _normalizeDate(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
  // group mood by day
  Map<DateTime, List<String>> groupMoodsByDay(
      List<EmotionHistoryModel> entries) {
    Map<DateTime, List<String>> result = {};
    for (var entry in entries) {
      final day = _normalizeDate(entry.createdDateTime);
      result.putIfAbsent(day, () => []).add(entry.emotion);
    }
    return result;
  }

  String getDominantMood(List<String> moods) {
    final count = <String, int>{};
    for (var mood in moods) {
      count[mood] = (count[mood] ?? 0) + 1;
    }
    // Get mood with highest count
    final maxCount = count.values.reduce((a, b) => a > b ? a : b);
    final topMoods = count.entries
        .where((e) => e.value == maxCount)
        .map((e) => e.key)
        .toList();
    topMoods.shuffle(); // optional: choose randomly if tied
    return topMoods.first;
  }

  Map<String, String> getMoodByDayOrdered(
      Map<DateTime, List<String>> groupedLogs) {
    final now = DateTime.now();
    final result = <String, String>{};

    for (int i = 6; i >= 0; i--) {
      final date = _normalizeDate(now.subtract(Duration(days: i)));
      final dayLabel = _formatDay(date); // 'Mon', 'Tue', ...
      final moods = groupedLogs[date];
      result[dayLabel] = moods != null && moods.isNotEmpty
          ? getDominantMood(moods)
          : 'neutral';
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    dv.log("last 7 dayss ${getLast7Days()}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Insights",
          style: CustomTextStyles.titleLargeRegular(),
        ),
        backgroundColor: Palette.backgroundColor,
        actions: [
          Icon(Icons.more_vert_rounded),
          const SizedBox(
            width: 5,
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
          child: SingleChildScrollView(
            child: Column(
                spacing: 15,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final allHistory =
                          ref.watch(emotionHistoryNotifierProvider);
                      return allHistory.when(
                        data: (data) {
                          return Column(
                            children: [
                              Row(
                                spacing: 9,
                                children: [
                                  InsightScreenCountWidget(
                                    title: "Total Entries",
                                    hisotoryList: data,
                                  ),
                                  InsightScreenCountWidget(
                                    title: "This Week",
                                    hisotoryList: data,
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                        loading: () => SizedBox(),
                        error: (error, stackTrace) => SizedBox(),
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final last7dayMoodHistory =
                          ref.watch(lastSevenDaysMoodProvider);
                      return last7dayMoodHistory.when(
                        data: (data) {
                          final emotion = getMostFrequentEmotion(data);
                          final moodCountMap = getEmotionCounts(data);

                          final groupedMood = groupMoodsByDay(data);

                          final graphMap = getMoodByDayOrdered(groupedMood);
                          dv.log(graphMap.toString());
                          return SingleChildScrollView(
                            child: Column(
                              // spacing: 6,
                              children: [
                                Container(
                                  width: context.width(),
                                  decoration: BoxDecoration(
                                      color: Palette.kSecondaryGreenColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.r),
                                          topRight: Radius.circular(15.r))),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Center(
                                    child: Text(
                                      "Weeky Mood Report",
                                      style: CustomTextStyles.titleLargeBold(
                                          fontSize: 15,
                                          color: Palette.backgroundColor),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: context.width(),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(-1, 1),
                                            color: Palette.lightGreyColor)
                                      ],
                                      color: Palette.kWhiteColor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15.r),
                                          bottomRight: Radius.circular(15.r))),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    spacing: 5,
                                    children: [
                                      // Text(
                                      //   "Weeky Mood Report",
                                      //   style: CustomTextStyles.titleLargeBold(
                                      //       fontSize: 16,
                                      //       color: Palette.primaryBlackColor),
                                      // ),
                                      Text(
                                        "Most Frequent Mood",
                                        style: CustomTextStyles
                                            .subtitleLargeSemiBold(
                                                fontSize: 13,
                                                color:
                                                    Palette.primaryBlackColor),
                                      ),
                                      ScaleTransition(
                                        scale: scaleAnimation,
                                        child: Container(
                                          width: 50.w,
                                          height: 50.h,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Palette.emojiBgColor,
                                              border: Border.all(
                                                color:
                                                    Palette.primaryBlackColor,
                                              )),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              StringUtil.getEmoji(
                                                emotion!,
                                              ),
                                              width: 28.w,
                                              height: 28.h,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 23.h,
                                        width: 100.w,
                                        decoration: BoxDecoration(
                                            color: Palette.kPrimaryGreenColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Center(
                                          child: Text(
                                            emotion[0].toUpperCase() +
                                                emotion.substring(1),
                                            style: CustomTextStyles
                                                .subtitleLargeBold(
                                                    color: Palette
                                                        .backgroundColor),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w, vertical: 5.h),
                                          child: Container(
                                              width: context.width(),
                                              decoration: BoxDecoration(
                                                  color:
                                                      Palette.backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.r))),
                                              padding: EdgeInsets.all(10),
                                              child: GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          childAspectRatio:
                                                              1.5),
                                                  itemCount: moodCountMap
                                                      .entries.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return IndividualMoodCountWidget(
                                                        count: moodCountMap
                                                            .values
                                                            .toList()[index],
                                                        emotion: moodCountMap
                                                            .keys
                                                            .toList()[index]);
                                                  })))
                                    ],
                                  ),
                                ),
                                SizedBox(height: 12.h),
                                SlideTransition(
                                  position: slideAnimation,
                                  child: Container(
                                      width: context.width(),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Palette.lightGreyColor,
                                                offset: Offset(-1, 1))
                                          ],
                                          color: Palette.kWhiteColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.r))),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Mood Chart",
                                            style:
                                                CustomTextStyles.titleLargeBold(
                                                    fontSize: 17),
                                          ),
                                          Text(
                                            'See how your moods shifted this week',
                                            textAlign: TextAlign.center,
                                            style: CustomTextStyles
                                                .subtitleLargeSemiBold(),
                                          ),
                                          Text(
                                            "${DateFormat("MMM dd").format(DateTime.now().subtract(Duration(days: 6)))} - ${DateFormat("MMM dd").format(DateTime.now())}",
                                            textAlign: TextAlign.center,
                                            style: CustomTextStyles
                                                .subtitleLargeBold(),
                                          ),
                                          SizedBox(
                                              height: 200,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10.w,
                                                    bottom: 10.h,
                                                    top: 10.h),
                                                child: WeeklyMoodChart(
                                                    moodMap: graphMap),
                                              )),
                                        ],
                                      )),
                                )
                              ],
                            ),
                          );
                        },
                        loading: () => const SizedBox(),
                        error: (error, stackTrace) => const SizedBox(),
                      );
                    },
                  )
                ]),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
