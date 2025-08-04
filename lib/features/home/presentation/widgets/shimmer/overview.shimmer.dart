import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/theme/color.palette.dart';

class OverviewShimmer extends StatelessWidget {
  const OverviewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Palette.lightGreyColor.withOpacity(0.3),
      highlightColor: Palette.kWhiteColor,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * .55,
        decoration: BoxDecoration(
          color: Palette.kWhiteColor,
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
        padding: EdgeInsets.all(15.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  Container(
                    height: 30.h,
                    width: 85.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
