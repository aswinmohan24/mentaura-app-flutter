import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';

class CustomTextStyles {
  static TextStyle titleLargeBold({Color? color, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize?.sp ?? 22.sp,
        fontWeight: FontWeight.bold,
        color: color ?? Palette.primaryTextColor);
  }

  static TextStyle titleLargeSemiBold({Color? color, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize?.sp ?? 22.sp,
        fontWeight: FontWeight.w500,
        color: color ?? Palette.primaryTextColor);
  }

  static TextStyle titleLargeRegular({Color? color, double? fontSize}) {
    return TextStyle(
        fontSize: fontSize?.sp ?? 22.sp,
        color: color ?? Palette.primaryTextColor);
  }

  static TextStyle subtitleSmallRegular({Color? color}) {
    return TextStyle(color: color ?? Palette.lightTextColor, fontSize: 10.sp);
  }

  static TextStyle subtitleSmallBold({Color? color, double? fontSize}) {
    return TextStyle(
        color: color ?? Palette.lightTextColor,
        fontSize: fontSize?.sp ?? 10.sp,
        fontWeight: FontWeight.bold);
  }

  static TextStyle subtitleSmallSemiBold({Color? color, double? fontSize}) {
    return TextStyle(
        color: color ?? Palette.lightTextColor,
        fontSize: fontSize?.sp ?? 10.sp,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis);
  }

  static TextStyle subtitleLargeBold({Color? color, double? fontSize}) {
    return TextStyle(
        color: color ?? Palette.lightTextColor,
        fontSize: fontSize ?? 12.sp,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis);
  }

  static TextStyle subtitleLargeRegular({Color? color, double? fontSize}) {
    return TextStyle(
        color: color ?? Palette.lightTextColor,
        fontSize: fontSize ?? 12.sp,
        overflow: TextOverflow.ellipsis);
  }

  static TextStyle subtitleLargeSemiBold({Color? color, double? fontSize}) {
    return TextStyle(
        color: color ?? Palette.lightTextColor,
        fontSize: fontSize ?? 12.sp,
        fontWeight: FontWeight.w500);
  }

  static TextStyle primaryButtonTextStyle({Color? color}) {
    return TextStyle(
      color: color ?? Palette.backgroundColor,
      fontSize: 13.sp,
    );
  }
}
