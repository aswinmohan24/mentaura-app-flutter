import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentaura_app/features/auth/providers/user.auth.provider.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';
import 'package:mentaura_app/features/insights/presentation/screens/insights.screen.dart';
import 'package:mentaura_app/features/mood.history/presentation/screens/mood.history.screen.dart';
import 'package:mentaura_app/features/home/presentation/screens/home.screen.dart';
import 'package:mentaura_app/features/profile/presentation/screens/profile.screen.dart';

class BottomBar extends ConsumerWidget {
  static const routeName = "/bottomBar";
  const BottomBar({super.key});

  static final _screens = [
    HomeScreen(),
    MoodHistoryScreen(),
    InsightsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
            backgroundColor: Palette.backgroundColor,
            onTap: (value) {
              ref.read(bottomNavIndexProvider.notifier).state = value;
            },
            selectedLabelStyle: CustomTextStyles.subtitleSmallRegular(),
            unselectedLabelStyle: CustomTextStyles.subtitleSmallRegular(),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: Palette.kGreyColor,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/svg/home_icon .svg",
                  color: currentIndex == 0
                      ? Palette.kPrimaryGreenColor
                      : Palette.kGreyColor,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/svg/history_icon.svg",
                  height: 19.h,
                  color: currentIndex == 1
                      ? Palette.kPrimaryGreenColor
                      : Palette.kGreyColor,
                ),
                label: "History",
              ),
              // BottomNavigationBarItem(
              //   icon: CircleAvatar(
              //     backgroundColor: Palette.kPrimaryGreenColor,
              //     radius: 25.r,
              //     child: SvgPicture.asset(
              //       "assets/images/svg/chat_icon.svg",
              //       color: Palette.kWhiteColor,
              //     ),
              //   ),
              //   label: "Notes",
              // ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/svg/activity_icon.svg",
                  color: currentIndex == 2
                      ? Palette.kPrimaryGreenColor
                      : Palette.kGreyColor,
                ),
                label: "Insights",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/images/svg/profile_icon.svg",
                  color: currentIndex == 3
                      ? Palette.kPrimaryGreenColor
                      : Palette.kGreyColor,
                ),
                label: "Profile",
              ),
            ]),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: currentIndex == 0
      //     ? FloatingActionButton(
      //         backgroundColor: Palette.kPrimaryGreenColor,
      //         shape: CircleBorder(),
      //         onPressed: () {
      //           ref.read(lastWordProvider.notifier).state = "";
      //           ref.read(keyboardProvider.notifier).state = false;

      //           showModalBottomSheet(
      //               context: context,
      //               isScrollControlled: true,
      //               barrierColor: Colors.black38,
      //               builder: (context) {
      //                 return DraggableScrollableSheet(
      //                     expand: false,
      //                     initialChildSize: .78, // 1.0 means full screen
      //                     maxChildSize: .78,
      //                     minChildSize: 0.3,
      //                     builder: (context, scrollController) =>
      //                         const ChatScreen());
      //               });
      //         },
      //         child: SvgPicture.asset(
      //           "assets/images/svg/chat_icon.svg",
      //           color: Palette.backgroundColor,
      //         ))
      //     : const SizedBox.shrink()
    );
  }
}
