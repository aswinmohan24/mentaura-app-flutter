import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class HistoryEmptyWidget extends StatelessWidget {
  const HistoryEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, top: 50.h),
            child: const Text(
              "No moods recorded under this category yet. Try expressing how you feel to see it here.",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 25.h),
          child: LottieBuilder.asset(
            "assets/lottie/empty_data.json",
          ),
        ),
      ],
    ));
  }
}
