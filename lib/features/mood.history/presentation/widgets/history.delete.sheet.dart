import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/constants/string.constants.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';
import 'package:mentaura_app/core/widgets/ui_components/default.button.dart';
import 'package:mentaura_app/features/mood.history/providers/activity.provider.dart';

import '../../../ai.analysis/providers/chat.provider.dart';

class HistoryDeleteSheet extends ConsumerWidget {
  final String id;
  const HistoryDeleteSheet({super.key, required this.id});

  void deleteMoodHistory(String id, BuildContext context, WidgetRef ref) async {
    final navContext = Navigator.of(context);
    // AppDialogs.showCenterLoader(
    //     context: context, dialogText: "Deleting history..");
    ref.read(emotionHistoryNotifierProvider.notifier).deleteMoodHistory(id);
    await ref.read(emotionHistoryRepositoryProvider).deleteEmotionHistory(id);
    Fluttertoast.showToast(msg: "History Deleted");
    navContext.pop();
    navContext.pop();
  }

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
              moodDeleteSheetTitle,
              style: CustomTextStyles.titleLargeSemiBold(fontSize: 18),
            ),
            Text(
              moodDeleteSheetSubtitle,
              style: CustomTextStyles.subtitleLargeRegular(),
              textAlign: TextAlign.center,
            ),
            Lottie.asset("assets/lottie/delete_bin.json",
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
                      text: "Yes, Delete",
                      press: () async {
                        deleteMoodHistory(id, context, ref);
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
