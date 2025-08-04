import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/utils/string.utils.dart';
import 'package:mentaura_app/features/home/presentation/widgets/shimmer/quotes.shimmer.dart';

import '../../../../core/theme/color.palette.dart';
import '../../../../core/theme/text.styles.dart';
import '../../providers/home.provider.dart';

class DailyQuoteWidget extends StatelessWidget {
  const DailyQuoteWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: BoxDecoration(
          color: Palette.kWhiteColor,
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          boxShadow: [
            BoxShadow(color: Palette.lightGreyColor, offset: Offset(-1, 1))
          ]),
      child: Padding(
        padding: EdgeInsets.only(top: 5.h, left: 15.w, bottom: 12.h),
        child: Consumer(
          builder: (context, ref, child) {
            final dailyQuotes = ref.watch(quotesProvider);
            return dailyQuotes.when(
              data: (quote) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Daily inspirations",
                          style: CustomTextStyles.titleLargeBold(
                              fontSize: 16, color: Palette.kGreyColor),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 50.h,
                          width: 50.w,
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/images/svg/quotes_icon.svg",
                              fit: BoxFit.cover,
                              height: 35,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    Text(
                      quote?.quote ?? StringUtil.getRandomQuote()["quote"]!,
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Palette.primaryBlackColor,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "- ${quote?.author ?? StringUtil.getRandomQuote()["author"]!}",
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Palette.primaryBlackColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              },
              loading: () => QuoteShimmer(),
              error: (error, stackTrace) {
                return Center(
                  child: Text("Failed to fetch quotes"),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
