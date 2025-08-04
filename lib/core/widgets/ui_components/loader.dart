import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/widgets/ui_components/rotating.logo.dart';

class LogoLoader extends StatelessWidget {
  final String dialogText;
  final bool isFullScreen;
  const LogoLoader(
      {super.key, required this.dialogText, this.isFullScreen = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: context.width() - 50,
        height: isFullScreen ? 58.h : 55.h,
        decoration: BoxDecoration(
          color: Palette.backgroundColor,
          borderRadius: BorderRadius.circular(7),
        ),
        child: !isFullScreen
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatingLogo(),
                  const SizedBox(width: 5),
                  DefaultTextStyle(
                      style: TextStyle(
                        fontFamily: "Monasans",
                        color: Palette.primaryTextColor,
                        fontSize: 13.sp,
                      ),
                      child: Text(dialogText))
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatingLogo(),
                  const SizedBox(height: 5),
                  DefaultTextStyle(
                      style: TextStyle(
                        fontFamily: "Monasans",
                        color: Palette.kGreyColor,
                        fontSize: isFullScreen ? 14.sp : 13.sp,
                      ),
                      child: Text(dialogText))
                ],
              ));
  }
}
