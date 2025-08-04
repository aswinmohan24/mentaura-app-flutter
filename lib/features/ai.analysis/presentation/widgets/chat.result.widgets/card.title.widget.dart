import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';

class CardTitleWidget extends StatelessWidget {
  const CardTitleWidget(
      {super.key,
      required this.title,
      required this.bgColor,
      required this.isPrefixiImage,
      this.prefixImageUrl,
      this.fontZise = 14,
      this.titleColor = Palette.primaryBlackColor,
      this.prefixImageColor = Palette.primaryBlackColor,
      this.border,
      this.padding});

  final String title;
  final Color bgColor;
  final bool isPrefixiImage;
  final String? prefixImageUrl;
  final double fontZise;
  final Color titleColor;
  final Color prefixImageColor;
  final Border? border;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      padding: padding,
      decoration: BoxDecoration(
        border: border,
        color: bgColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r), topRight: Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isPrefixiImage && prefixImageUrl != null
                ? SizedBox(
                    width: 30.w,
                    height: 30.h,
                    child: Image.asset(
                      prefixImageUrl!,
                      color: prefixImageColor,
                      height: 10.h,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(width: 5),
            Text(title,
                style: CustomTextStyles.subtitleLargeBold(
                    fontSize: fontZise.sp, color: titleColor)),
          ],
        ),
      ),
    );
  }
}
