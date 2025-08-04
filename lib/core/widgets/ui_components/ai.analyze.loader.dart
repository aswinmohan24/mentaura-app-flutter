import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';

class AiAnalyzeLoader extends StatelessWidget {
  const AiAnalyzeLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.width() - 50,
        height: context.width(),
        decoration: BoxDecoration(
          color: Palette.backgroundColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Column(
          children: [
            Container(
              width: 180.w,
              height: 180.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.emojiBgColor,
                // boxShadow: [
                //   BoxShadow(
                //       color: Palette.kGreyColor,
                //       offset: Offset(-1, 1),
                //       blurRadius: 2)
                // ]
              ),
              child: Center(
                child: Lottie.asset(
                  "assets/lottie/mood_change_loading.json",
                  animate: true,
                  repeat: true,
                  fit: BoxFit.cover,
                  reverse: false,
                ),
              ),
            ),
            const Spacer(),
            AnimatedTextKit(
              repeatForever: true,
              isRepeatingAnimation: true,
              animatedTexts: [
                ColorizeAnimatedText("Sensing Your mood..",
                    textStyle: TextStyle(
                        color: Palette.kPrimaryGreenColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500),
                    colors: [
                      Palette.kPrimaryGreenColor,
                      Palette.kGreyColor,
                    ])
              ],
              // onTap: () {
              //   Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              //     return OnboardOneScreen();
              //   }));
              // },
            ),
            // DefaultTextStyle(
            //     style: TextStyle(
            //         fontFamily: "Monasans",
            //         color: Palette.primaryBlackColor,
            //         fontSize: 17.sp),
            //     child: Text("Sensing Your Mood...")),
          ],
        ));
  }
}
