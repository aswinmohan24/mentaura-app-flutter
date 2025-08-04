import 'package:flutter/material.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/widgets/ui_components/ai.analyze.loader.dart';
import 'package:mentaura_app/core/widgets/ui_components/loader.dart';

class AppDialogs {
  static final AppDialogs _singleTon = AppDialogs._internal();

  AppDialogs._internal();

  factory AppDialogs() {
    return _singleTon;
  }

  static void showCenterLoader(
      {required BuildContext context, String? dialogText}) async {
    showDialog(
      context: context,
      barrierColor: Palette.primaryBlackColor.withAlpha(100),
      barrierDismissible: false,
      builder: ((context) {
        return PopScope(
          canPop: false,
          child: Center(
              child: LogoLoader(
            dialogText: dialogText ?? "Loading...",
          )),
        );
      }),
    );
  }

  static void showFullScreenLOader(
      {required BuildContext context, String? dialogText}) async {
    showDialog(
      context: context,
      barrierColor: Palette.backgroundColor,
      barrierDismissible: false,
      builder: ((context) {
        return PopScope(
          canPop: false,
          child: Center(
              child: LogoLoader(
            dialogText: dialogText ?? "Loading...",
            isFullScreen: true,
          )),
        );
      }),
    );
  }

  static void showAIAnalyzLoader({required BuildContext context}) async {
    showDialog(
      context: context,
      barrierColor: Palette.backgroundColor,
      barrierDismissible: false,
      builder: ((context) {
        return PopScope(
          canPop: true,
          child: Center(child: AiAnalyzeLoader()),
        );
      }),
    );
  }

  static void showCicularLoader(
      {required BuildContext context, String? dialogText}) async {
    showDialog(
      context: context,
      barrierColor: Palette.backgroundColor,
      barrierDismissible: false,
      builder: ((context) {
        return PopScope(
          canPop: false,
          child: Center(
              child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Palette.kPrimaryGreenColor,
          )),
        );
      }),
    );
  }
}
