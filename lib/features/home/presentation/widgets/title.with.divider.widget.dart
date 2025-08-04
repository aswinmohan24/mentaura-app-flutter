import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';

class TitleWithDividerWidget extends StatelessWidget {
  const TitleWithDividerWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: context.width() * .27,
          height: 0.7,
          color: Palette.lightGreyColor,
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(fontSize: 11.sp),
        ),
        SizedBox(width: 8),
        Container(
          width: context.width() * .27,
          height: 0.7,
          color: Palette.lightGreyColor,
        ),
      ],
    );
  }
}
