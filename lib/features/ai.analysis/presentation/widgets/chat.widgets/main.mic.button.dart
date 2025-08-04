import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../../core/theme/color.palette.dart';

class MainMicButton extends StatelessWidget {
  const MainMicButton({
    super.key,
    required SpeechToText speechToText,
    required this.statusListener,
    required this.onTap,
  }) : _speechToText = speechToText;

  final SpeechToText _speechToText;
  final String statusListener;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedPadding(
        duration: Duration(milliseconds: 200),
        padding:
            EdgeInsets.only(bottom: context.viewInsects() > 0 ? 10.h : 55.h),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: AvatarGlow(
              duration: Duration(milliseconds: 1000),
              glowRadiusFactor: .4,
              repeat: true,
              animate: _speechToText.isNotListening ||
                      statusListener == "notListening" ||
                      statusListener == "done"
                  ? false
                  : true,
              glowColor: Palette.kPrimaryGreenColor,
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: context.viewInsects() > 0 ? 80 : 90.w,
                  height: context.viewInsects() > 0 ? 80 : 90.w,
                  decoration: BoxDecoration(
                      color: Palette.kPrimaryGreenColor,
                      shape: BoxShape.circle),
                  child: Padding(
                    padding:
                        EdgeInsets.all(context.viewInsects() > 0 ? 20 : 27),
                    child: SvgPicture.asset(
                      // width: 35.w,
                      // height: 35.h,
                      _speechToText.isNotListening ||
                              statusListener == "notListening" ||
                              statusListener == "done"
                          ? "assets/images/svg/mic_icon.svg"
                          : "assets/images/svg/stop_icon.svg",
                      color: Palette.backgroundColor,
                    ),
                  )),
            )),
      ),
    );
  }
}
