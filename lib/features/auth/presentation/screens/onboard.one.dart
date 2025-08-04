import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:mentaura_app/features/auth/providers/user.auth.provider.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/constants/string.constants.dart';
import 'package:mentaura_app/core/widgets/dialogs.dart';
import 'package:mentaura_app/core/widgets/ui_components/default.button.dart';
import 'package:mentaura_app/app/bottom_bar.dart';
import 'package:mentaura_app/features/auth/presentation/screens/onboard.two.dart';
import 'package:smart_auth/smart_auth.dart';

import '../../../../core/widgets/phone.number.field.dart';

class OnboardOneScreen extends ConsumerStatefulWidget {
  static const routeName = "/onboardOne";
  const OnboardOneScreen({super.key});

  @override
  ConsumerState<OnboardOneScreen> createState() => _OnboardOneScreenState();
}

class _OnboardOneScreenState extends ConsumerState<OnboardOneScreen> {
  late SmartAuth smartAuth;
  User? user;
  final TextEditingController phoneNumberController = TextEditingController();
  @override
  void initState() {
    smartAuth = SmartAuth.instance;

    super.initState();
  }

  void requestPhoneNumberHint() async {
    final res = await smartAuth.requestPhoneNumberHint();
    if (res.hasData) {
      phoneNumberController.text = res.data?.substring(3) ?? "";
    } else {
      // Handle error
      Fluttertoast.showToast(msg: "Unable to autofill phonenumber");
    }
  }

  void signInwithPhone(String phoneNumber) {
    if (phoneNumber.isNotEmpty && phoneNumber.length == 10) {
      ref.read(userPhoneNumberProvider.notifier).state = "+91$phoneNumber";
      ref.read(firebaseAuthRepoProvider).signInwithPhoneNumber(
          phoneNumber: "+91$phoneNumber", context: context);
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Enter a valid Phone Number");
    }
  }

  void signInWithGoogle() async {
    final navContext = Navigator.of(context);

    final userCredential =
        await ref.read(googleAuthRepoProvider).signInWithGoogle(context, ref);
    if (userCredential != null) {
      final user = userCredential.user;
      if (user?.email != null) {
        ref.read(googleEmailIdProvider.notifier).state = user?.email;

        AppDialogs.showCenterLoader(
            context: context, dialogText: "Logging in..");
        final userDetails =
            await ref.read(userAuthRepositoryProvider).getUser();
        await Future.delayed(Duration(milliseconds: 1000));
        navContext.pop();
        if (userDetails?.email != null) {
          ref
              .read(userDetailsProvider.notifier)
              .updateUserDetails(userDetails!);
          ref.read(userNameProvider.notifier).state = userDetails.name;
          ref.read(bottomNavIndexProvider.notifier).state = 0;
          navContext.pushNamedAndRemoveUntil(
              BottomBar.routeName, (route) => false);
        } else {
          ref.read(userNameProvider.notifier).state = null;

          navContext.pushNamedAndRemoveUntil(
              OnboardTwoScreen.routeName, (route) => false);
        }
      } else {
        if (!mounted) return;
        navContext.pushNamedAndRemoveUntil(
            OnboardOneScreen.routeName, (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          SizedBox(
            width: context.width(),
            height: context.width(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 18.r,
                      backgroundColor: Palette.backgroundColor,
                      backgroundImage:
                          AssetImage("assets/images/mentaura_logo_green.png"),
                    ),
                    Text(
                      "Mentaura",
                      style: TextStyle(
                          fontSize: 23.sp,
                          fontWeight: FontWeight.bold,
                          color: Palette.kPrimaryGreenColor),
                    )
                  ],
                ),
                LottieBuilder.asset(
                  "assets/lottie/onboard_brain.json",
                  width: 250,
                  height: 230,
                ),
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: context.width(),
                height: context.height() * .65,
                color: Palette.backgroundColor,
                // decoration: BoxDecoration(
                //     color: Palette.backgroundColor,
                //     borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(30),
                //         topRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 25.h),
                      Text(
                        "Let’s Connect With \n Your Mind",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Palette.primaryTextColor,
                          fontSize: 23.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: context.width() * .26,
                            height: 0.5,
                            color: Palette.lightGreyColor,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Login or Sign Up',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: context.width() * .26,
                            height: 0.5,
                            color: Palette.lightGreyColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      PhoneNumberField(
                        phoneNumberController: phoneNumberController,
                        onTap: () {
                          requestPhoneNumberHint();
                        },
                        hintText: "Enter Phone Number",
                      ),
                      const SizedBox(height: 20),
                      DefaultButton(
                          text: 'Continue',
                          press: () async {
                            AppDialogs.showCenterLoader(
                                context: context, dialogText: 'Sending OTP');
                            signInwithPhone(phoneNumberController.text);
                          }),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: context.width() * .26,
                            height: 0.5,
                            color: Palette.lightGreyColor,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'or',
                            style: TextStyle(fontSize: 10.sp),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: context.width() * .26,
                            height: 0.5,
                            color: Palette.lightGreyColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => signInWithGoogle(),
                        child: Container(
                          width: 45.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Palette.lightGreyColor,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Palette.backgroundColor,
                              backgroundImage: AssetImage(
                                  "assets/images/icons/google_icon.png"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 70.h),
                      Text(
                        termsAndPolicy,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Palette.lightTextColor, fontSize: 10.sp),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
