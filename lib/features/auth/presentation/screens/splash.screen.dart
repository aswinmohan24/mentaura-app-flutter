import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentaura_app/features/auth/providers/user.auth.provider.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/app/bottom_bar.dart';
import 'package:mentaura_app/features/auth/presentation/screens/onboard.one.dart';
import 'package:mentaura_app/features/auth/presentation/screens/onboard.two.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const routeName = "/splashScreen";
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed((Duration(milliseconds: 1500)))
          .then((value) => checkAndNavigate());
    });
    super.initState();
  }

  void checkAndNavigate() async {
    final navContext = Navigator.of(context);
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (mounted) {
        if (user == null) {
          log("User is not loggedIn");
          Navigator.pushReplacementNamed(context, OnboardOneScreen.routeName);
        } else {
          // final token = await FirebaseAuth.instance.currentUser?.getIdToken();
          // log(token ?? "");
          final userDetails =
              await ref.read(userAuthRepositoryProvider).getUser();
          if (userDetails != null) {
            ref
                .read(userDetailsProvider.notifier)
                .updateUserDetails(userDetails);
            ref.read(userNameProvider.notifier).state = userDetails.name;
            navContext.pushNamedAndRemoveUntil(
                BottomBar.routeName, (route) => false);
          } else {
            navContext.pushNamedAndRemoveUntil(
                OnboardTwoScreen.routeName, (route) => false);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.kPrimaryGreenColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 75.r,
              backgroundColor: Palette.kPrimaryGreenColor,
              child: Image.asset(
                "assets/images/mentaura_logo_black.png",
                color: Palette.kWhiteColor,
              ),
            ),
            AnimatedTextKit(
              repeatForever: true,
              isRepeatingAnimation: true,
              animatedTexts: [
                ColorizeAnimatedText("Mentaura",
                    textStyle: TextStyle(
                        color: Palette.kWhiteColor,
                        fontSize: 27.sp,
                        fontWeight: FontWeight.w500),
                    colors: [Palette.kWhiteColor, Palette.kPrimaryGreenColor])
              ],
              // onTap: () {
              //   Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
              //     return OnboardOneScreen();
              //   }));
              // },
            ),
          ],
        ),
      ),
    );
  }
}
