import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:mentaura_app/features/auth/providers/user.auth.provider.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/theme/slide.transition.dart';
import 'package:mentaura_app/core/constants/string.constants.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';
import 'package:mentaura_app/core/widgets/dialogs.dart';
import 'package:mentaura_app/core/widgets/ui_components/default.button.dart';
import 'package:mentaura_app/features/auth/presentation/screens/splash.screen.dart';
import 'package:mentaura_app/features/mood.history/providers/activity.provider.dart';

class LogOutSheet extends ConsumerWidget {
  const LogOutSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Palette.backgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10,
          children: [
            Divider(
              color: Palette.lightTextColor,
              endIndent: 170,
              indent: 170,
              thickness: 3,
            ),
            SizedBox(height: 10.h),
            Text(
              logOutSheetTitle,
              style: CustomTextStyles.titleLargeSemiBold(fontSize: 18),
            ),
            Text(
              logOutSheetSubTitle,
              style: CustomTextStyles.subtitleLargeRegular(),
              textAlign: TextAlign.center,
            ),
            Lottie.asset("assets/lottie/logout.json",
                width: 210.w, height: 210.h, repeat: false),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                SizedBox(
                  width: context.width() * .45,
                  height: 40.h,
                  child: DefaultButton(
                      isInvertColor: true,
                      color: Palette.backgroundColor,
                      text: "No, Cancel",
                      press: () => Navigator.pop(context)),
                ),
                SizedBox(
                  width: context.width() * .45,
                  height: 40.h,
                  child: DefaultButton(
                      text: "Yes, Log Out",
                      press: () async {
                        AppDialogs.showFullScreenLOader(
                            context: context, dialogText: "Logging Out..");
                        ref
                            .read(emotionHistoryNotifierProvider.notifier)
                            .cleaMoodHistory();
                        await ref
                            .read(firebaseAuthRepoProvider)
                            .signOutFromFirebase();
                        await ref
                            .read(googleAuthRepoProvider)
                            .signOutFromGoogle();
                        await Future.delayed(Duration(milliseconds: 1500));
                        Navigator.pushAndRemoveUntil(
                            context,
                            SlidePageRoute(page: SplashScreen()),
                            (route) => false);
                        //
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
