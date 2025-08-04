import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mentaura_app/features/auth/providers/user.auth.provider.dart';
import 'package:mentaura_app/core/theme/color.palette.dart';
import 'package:mentaura_app/core/extensions.dart';
import 'package:mentaura_app/core/theme/slide.transition.dart';
import 'package:mentaura_app/core/constants/string.constants.dart';
import 'package:mentaura_app/core/theme/text.styles.dart';
import 'package:mentaura_app/core/widgets/dialogs.dart';
import 'package:mentaura_app/core/utils/string.utils.dart';
import 'package:mentaura_app/app/bottom_bar.dart';
import 'package:mentaura_app/features/auth/presentation/screens/onboard.two.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsRetrieverApiListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final res = await smartAuth.getSmsWithRetrieverApi();
    if (res.hasData) {
      return res.data?.code ?? '';
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}

class OtpScreen extends ConsumerStatefulWidget {
  static const routeName = "otpScreen";
  const OtpScreen({super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController _pinPutController = TextEditingController();
  late final SmsRetrieverImpl smsRetrieverImpl;
  Timer? _timer;
  int _start = 60;
  final PinTheme defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20,
        color: Palette.primaryTextColor,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: Palette.lightGreyColor.withAlpha(50),
      borderRadius: BorderRadius.circular(13),
    ),
  );
  late final PinTheme focusedPinTheme;
  late final PinTheme submittedPinTheme;
  late final PinTheme errorPinTheme;
  late final PinTheme followingPintheme;
  late String randomString;
  @override
  void initState() {
    startTimer();

    smsRetrieverImpl = SmsRetrieverImpl(SmartAuth.instance);
    focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: Palette.lightGreyColor.withAlpha(50),
    );
    errorPinTheme = defaultPinTheme.copyDecorationWith(
      color: Palette.lightGreyColor.withAlpha(50),
    );

    submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Palette.lightGreyColor.withAlpha(50),
      ),
    );

    followingPintheme = defaultPinTheme.copyDecorationWith(
      color: Palette.lightGreyColor.withAlpha(50),
    );

    randomString = StringUtil.getRandomString(loadingTextList);
    super.initState();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void verifyPhone(String pin, String verificationId) async {
    final navContext = Navigator.of(context);
    try {
      AppDialogs.showFullScreenLOader(
          context: context, dialogText: randomString);
      final userCredential = await ref
          .read(firebaseAuthRepoProvider)
          .verifyOtp(verficationId: verificationId, userOtp: pin);

      if (userCredential.user?.phoneNumber != null) {
        final user = await ref.read(userAuthRepositoryProvider).getUser();

        navContext.pop();
        if (user == null) {
          ref.read(googleEmailIdProvider.notifier).state = null;
          navContext.pushNamedAndRemoveUntil(
              OnboardTwoScreen.routeName, (route) => false);
        } else {
          ref.read(userDetailsProvider.notifier).updateUserDetails(user);
          ref.read(userNameProvider.notifier).state = user.name;
          ref.read(bottomNavIndexProvider.notifier).state = 0;
          navContext.pushAndRemoveUntil(
              SlidePageRoute(page: BottomBar()), (route) => false);
        }
      } else {
        if (!mounted) return;
        navContext.pushNamedAndRemoveUntil(
            OnboardTwoScreen.routeName, (route) => false);
      }
    } on Exception catch (err) {
      navContext.pop();
      _start = 0;
      setState(() {});
      _timer!.cancel();
      Fluttertoast.showToast(msg: 'Something went wrong !');
      log(".. @$err");
    } catch (e) {
      _start = 0;
      setState(() {});
      _timer!.cancel();
      navContext.pop();

      log("error @$e");
    }
  }

  void resendOtp(String phoneNumber) {
    if (_start > 0) {
      return; // If the timer is still running, prevent resending
    }

    setState(() {
      _start = 60; // Reset the timer to 60 seconds
    });
    startTimer(); // Start the countdown

    _pinPutController.text = "";

    ref.read(firebaseAuthRepoProvider).signInwithPhoneNumber(
        phoneNumber: "+91$phoneNumber", context: context, isResend: true);
  }

  @override
  void dispose() {
    _pinPutController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final values =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final verificationId = values["verificationId"];
    final phoneNumber = values["phoneNumber"];
    return PopScope(
      canPop: _start == 0 ? true : false,
      child: Scaffold(
        backgroundColor: Color(0xFFF3F7F2),
        appBar: AppBar(
          backgroundColor: Palette.backgroundColor,
          automaticallyImplyLeading: false,
          leading: _start == 0
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back))
              : const SizedBox(),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 20),
                SvgPicture.asset(
                  "assets/images/svg/otp_symbo.svg",
                  width: context.width() * .20,
                  height: context.width() * .20,
                  color: Palette.kPrimaryGreenColor.withAlpha(200),
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter Verification Code',
                  style: CustomTextStyles.titleLargeBold(),
                ),
                const SizedBox(height: 15),
                Text(
                  "$otpScreenScript $phoneNumber",
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.subtitleLargeRegular(),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Pinput(
                    autofocus: true,
                    pinAnimationType: PinAnimationType.fade,
                    controller: _pinPutController,
                    smsRetriever: smsRetrieverImpl,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    followingPinTheme: followingPintheme,
                    keyboardType: TextInputType.number,
                    length: 6,
                    onCompleted: (value) {
                      verifyPhone(value, verificationId);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                        TextSpan(text: "Didn't recieve the code ", children: [
                      TextSpan(
                          text: _start == 0 ? "Resend sms " : "Resend sms in ",
                          style: CustomTextStyles.subtitleLargeBold(),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              {
                                resendOtp(phoneNumber);
                              }
                            }),
                      _start != 0
                          ? TextSpan(
                              text: _start > 10 ? "00:$_start" : "00:0$_start",
                              style: TextStyle(
                                  color: Palette.kGreyColor,
                                  fontWeight: FontWeight.bold))
                          : TextSpan()
                    ]))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
