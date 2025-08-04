import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentaura_app/features/auth/providers/user.auth.provider.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 21.r,
          backgroundColor: Palette.kPrimaryGreenColor,
          child: Consumer(
            builder: (context, ref, child) {
              final userName = ref.watch(userNameProvider);
              return Text(
                userName?[0] ?? "",
                style: CustomTextStyles.titleLargeSemiBold(
                    color: Palette.chipBgColor),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: CustomTextStyles.subtitleLargeRegular(
                    color: Palette.primaryTextColor),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final userName = ref.watch(userNameProvider);
                  return Text(
                    userName ?? "",
                    style: CustomTextStyles.subtitleLargeBold(
                        color: Palette.primaryTextColor),
                  );
                },
              ),
            ],
          ),
        ),
        const Spacer(),
        CircleAvatar(
          backgroundColor: Palette.yellowAccent,
          radius: 21.r,
          child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/images/svg/bell_icon.svg")),
        )
      ],
    );
  }
}
