import 'package:flutter/material.dart';
import 'package:mentaura_app/app/bottom_bar.dart';
import 'package:mentaura_app/features/ai.analysis/presentation/screens/ai.analysis.screen.dart';
import 'package:mentaura_app/features/home/presentation/screens/home.screen.dart';
import 'package:mentaura_app/features/auth/presentation/screens/onboard.one.dart';
import 'package:mentaura_app/features/auth/presentation/screens/onboard.two.dart';
import 'package:mentaura_app/features/auth/presentation/screens/otp.screen.dart';
import 'package:mentaura_app/features/auth/presentation/screens/splash.screen.dart';
import 'package:mentaura_app/features/insights/presentation/screens/insights.screen.dart';
import 'package:mentaura_app/features/mood.history/presentation/screens/history.details.screen.dart';
import 'package:mentaura_app/features/profile/presentation/screens/profile.screen.dart';

// Route<dynamic> generateRoute(RouteSettings settings) {
//   return MaterialPageRoute(
//       settings: settings,
//       builder: (context) {

//         switch (settings.name) {
//           case OnboardOneScreen.routeName:
//             return const OnboardOneScreen();
//           case OtpScreen.routeName:
//             return const OtpScreen();
//           case OnboardTwoScreen.routeName:
//             return const OnboardTwoScreen();
//           case HomeScreen.routeName:
//             return const HomeScreen();
//           case BottomBar.routeName:
//             return const BottomBar();
//           case ProfileScreen.routeName:
//             return const ProfileScreen();
//           case AiAnalysisScreen.routeName:
//             return AiAnalysisScreen();

//           default:
//             return const SplashScreen();
//         }
//       });
// }

Route<dynamic> generateRoute(RouteSettings settings) {
  Widget screen;

  switch (settings.name) {
    case OnboardOneScreen.routeName:
      screen = const OnboardOneScreen();
      break;
    case OtpScreen.routeName:
      screen = const OtpScreen();
      break;
    case OnboardTwoScreen.routeName:
      screen = const OnboardTwoScreen();
      break;
    case HomeScreen.routeName:
      screen = const HomeScreen();
      break;
    case BottomBar.routeName:
      screen = const BottomBar();
      break;
    case ProfileScreen.routeName:
      screen = const ProfileScreen();
      break;
    case AiAnalysisScreen.routeName:
      screen = AiAnalysisScreen();
      break;
    case HistoryDetailsSCreen.routeName:
      screen = HistoryDetailsSCreen();
      break;
    case InsightsScreen.routeName:
      screen = InsightsScreen();
      break;
    default:
      screen = const SplashScreen();
  }

  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (_, __, ___) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Right-to-left slide on push, left-to-right on pop
      const begin = Offset(1.0, 0.0); // Start from right
      const end = Offset.zero; // End at center
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
