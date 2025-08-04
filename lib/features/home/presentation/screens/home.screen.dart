import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/features/ai.analysis/providers/chat.provider.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';
import 'package:mentaura_app/core/utils/string.utils.dart';
import 'package:mentaura_app/features/ai.analysis/presentation/screens/chat.screen.dart';
import 'package:mentaura_app/features/home/presentation/widgets/shimmer/mood.shimmer.dart';
import 'package:mentaura_app/features/home/presentation/widgets/shimmer/overview.shimmer.dart';
import 'package:mentaura_app/features/mood.history/providers/activity.provider.dart';

import '../../../mood.history/presentation/screens/history.details.screen.dart';
import '../widgets/daily.activity.widget.dart';
import '../widgets/daily.quote.widget.dart';
import '../widgets/home.screen.appbar.dart';
import '../widgets/lsat.mood.check.widget.dart';
import '../widgets/mood.analyze.button.dart';
import '../widgets/overview.widget.dart';
import '../widgets/title.with.divider.widget.dart';

class HomeScreen extends ConsumerWidget {
  static const routeName = "/homescreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Palette.backgroundColor,
        statusBarIconBrightness: Brightness.dark));
    final wishString = StringUtil.getWishString(DateTime.now());
    ref.watch(emotionHistoryNotifierProvider.notifier).getAllEmotionsHistory();

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HomeScreenAppBar(),
              SizedBox(
                height: 13.h,
              ),
              Text(
                wishString,
                textAlign: TextAlign.start,
                style: CustomTextStyles.titleLargeBold(
                    color: Palette.primaryBlackColor, fontSize: 21.sp),
              ),
              Text(
                "Hi, How Do You Feel Today?",
                textAlign: TextAlign.start,
                style: CustomTextStyles.titleLargeRegular(
                    color: Palette.primaryBlackColor, fontSize: 15.sp),
              ),
              const SizedBox(height: 13),
              MoodAnalyzeButton(
                onPressed: () {
                  ref.read(lastWordProvider.notifier).state = "";
                  ref.read(keyboardProvider.notifier).state = false;
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      barrierColor: Colors.black38,
                      builder: (context) {
                        return DraggableScrollableSheet(
                            expand: false,
                            initialChildSize: .78, // 1.0 means full screen
                            maxChildSize: .78,
                            minChildSize: 0.3,
                            builder: (context, scrollController) =>
                                const ChatScreen());
                      });
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Consumer(
                builder: (context, ref, child) {
                  final asyncValue = ref.watch(emotionHistoryNotifierProvider);
                  return asyncValue.when(data: (data) {
                    return OverViewWidget(
                      moodHistoryList: data,
                    );
                  }, error: (err, st) {
                    log("error $err");
                    return Center(
                      child: Text("Something Went Wrong"),
                    );
                  }, loading: () {
                    return OverviewShimmer();
                  });
                },
              ),
              SizedBox(
                height: 7,
              ),
              TitleWithDividerWidget(title: 'Recent Mood Entry'),
              SizedBox(
                height: 7,
              ),
              Consumer(
                builder: (context, ref, child) {
                  final asyncValue = ref.watch(emotionHistoryNotifierProvider);

                  return asyncValue.when(data: (data) {
                    final lastMoodCheck = data.reduce((a, b) =>
                        a.createdDateTime.isAfter(b.createdDateTime) ? a : b);
                    return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, HistoryDetailsSCreen.routeName,
                              arguments: lastMoodCheck);
                        },
                        child:
                            LastMoodCheckWidget(lastMoodCheck: lastMoodCheck));
                  }, error: (err, st) {
                    return Center(
                      child: Text("Something Went Wrong"),
                    );
                  }, loading: () {
                    return MoodShimmer();
                  });
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TitleWithDividerWidget(
                title: "Recommended Activity",
              ),
              const SizedBox(
                height: 8,
              ),
              DailyActivityWidget(),
              const SizedBox(
                height: 10,
              ),
              DailyQuoteWidget(),
            ],
          ),
        ),
      ),
    ));
  }
}
