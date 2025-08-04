import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/theme/color.palette.dart';

class MoodShimmer extends StatelessWidget {
  const MoodShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: context.width(),
        decoration: BoxDecoration(
          color: Palette.lightYellowAccent,
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20.w,
                    height: 18.h,
                    color: Colors.white,
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    width: 30.w,
                    height: 14.h,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: context.width() * 0.4,
                      height: 18.h,
                      color: Colors.white,
                    ),
                    SizedBox(height: 5.h),
                    Container(
                      width: context.width() * 0.5,
                      height: 16.h,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Palette.primaryBlackColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
