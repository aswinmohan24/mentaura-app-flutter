import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentaura_app/core/constants/string.constants.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';
import 'package:mentaura_app/core/utils/string.utils.dart';
import 'package:mentaura_app/core/widgets/ui_components/rotating.logo.dart';
import 'package:mentaura_app/features/ai.analysis/models/emotion.history.model.dart';
import 'package:mentaura_app/features/mood.history/providers/activity.provider.dart';
import 'package:mentaura_app/features/mood.history/presentation/screens/history.details.screen.dart';
import 'package:mentaura_app/features/mood.history/presentation/widgets/history.date.widget.dart';
import '../widgets/history.empty.widget.dart';
import '../widgets/history.time.and.mood.dart';
import '../widgets/mood.choice.chip.dart';

class MoodHistoryScreen extends ConsumerStatefulWidget {
  const MoodHistoryScreen({super.key});

  @override
  ConsumerState<MoodHistoryScreen> createState() => _MoodHistoryScreenState();
}

class _MoodHistoryScreenState extends ConsumerState<MoodHistoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _listAnimation;

  static const moodNameList = [
    "All",
    "Happy",
    "Sad",
    "Neutral",
    "Angry",
    "Surprised",
    "Depressed"
  ];

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _listAnimation = Tween<Offset>(begin: Offset(0, .8), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.forward();

    super.initState();
  }

  String emotionAsCamelCase(String selectedMood,
      List<EmotionHistoryModel> moodHistoryList, int index) {
    String emotionAsCamelCase = "";
    // if (selectedMood == "All") {
    emotionAsCamelCase = moodHistoryList[index].emotion[0].toUpperCase() +
        moodHistoryList[index].emotion.substring(1);
    return emotionAsCamelCase;
    // }
    // else {
    //   emotionAsCamelCase =
    //       sortedMoodHistoryList[index].emotion[0].toUpperCase() +
    //           sortedMoodHistoryList[index].emotion.substring(1);
    //   return emotionAsCamelCase;
    // }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asynValue = ref.watch(emotionHistoryNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, right: 15, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " Mood History",
                style: CustomTextStyles.titleLargeRegular(),
              ),
              SizedBox(
                height: 15.h,
              ),
              MoodChoiceChip(
                moodNameList: moodNameList,
                controller: _controller,
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                  child: asynValue.when(data: (moodHistoryList) {
                moodHistoryList.sort(
                    (a, b) => b.createdDateTime.compareTo(a.createdDateTime));
                final selectedMood = ref.watch(moodChipChangeProvider);

                // final sortedMoodhistoryList = moodHistoryList
                //     .where((history) =>
                //         history.emotion == selectedMood.toLowerCase())
                //     .toList();
                final sortedMoodHistoryList = selectedMood == "All"
                    ? moodHistoryList
                    : moodHistoryList
                        .where((history) =>
                            history.emotion == selectedMood.toLowerCase())
                        .toList();
                return sortedMoodHistoryList.isEmpty
                    ? HistoryEmptyWidget()
                    : ListView.builder(
                        itemCount: sortedMoodHistoryList.length,
                        itemBuilder: (context, index) {
                          final moodDetails = sortedMoodHistoryList[index];
                          return SlideTransition(
                            position: _listAnimation,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: GestureDetector(
                                onTap: () {
                                  log(moodHistoryList[index].id ?? "No id");

                                  Navigator.pushNamed(
                                      context, HistoryDetailsSCreen.routeName,
                                      arguments: moodDetails);
                                },
                                child: Container(
                                  width: context.width(),
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                      color: Palette.kWhiteColor.withAlpha(200),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      children: [
                                        MoodHistoryDateWidget(
                                          history: sortedMoodHistoryList[index],
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              sortedMoodHistoryList[index]
                                                  .chatTitle
                                                  .replaceAll(emojiRegex, ''),
                                              style: CustomTextStyles
                                                  .subtitleLargeBold(
                                                      color: Palette
                                                          .primaryBlackColor),
                                            ),
                                            const SizedBox(height: 5),
                                            HistoryTimeAndMood(
                                                historyModel:
                                                    sortedMoodHistoryList[
                                                        index],
                                                emotionAsCamelCase:
                                                    emotionAsCamelCase(
                                                        selectedMood,
                                                        sortedMoodHistoryList,
                                                        index))
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: 45.w,
                                          height: 45.h,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0XFFFEEF9A),
                                              border: Border.all(
                                                  width: 2,
                                                  color: Palette
                                                      .primaryBlackColor)),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              StringUtil.getEmoji(
                                                  sortedMoodHistoryList[index]
                                                      .emotion),
                                              color: Palette.primaryBlackColor,
                                              clipBehavior: Clip.none,
                                              width: 23.w,
                                              height: 23.h,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              }, error: (err, st) {
                return Center(
                  child: Text("Something Went Wrong"),
                );
              }, loading: () {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5,
                    children: [RotatingLogo(), Text("Loading..")],
                  ),
                );
              }))
            ],
          ),
        ),
      ),
    );
  }
}
