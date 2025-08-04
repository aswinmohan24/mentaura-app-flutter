import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/theme/color.palette.dart';

class QuoteShimmer extends StatelessWidget {
  const QuoteShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: context.width(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.r))),
        child: Padding(
            padding: EdgeInsets.only(top: 5.h, left: 15.w, bottom: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: context.width() * 0.4,
                      height: 18.h,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Palette.primaryBlackColor),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Container(
                  width: context.width() * 0.5,
                  height: 16.h,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  width: context.width() * 0.5,
                  height: 16.h,
                  color: Colors.white,
                ),
              ],
            )),
      ),
    );
  }
}
