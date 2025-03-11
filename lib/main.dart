import 'package:demo/Common.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:demo/ui/auth/complete_profile_screen.dart';
import 'package:demo/ui/auth/create_account_screen.dart';
import 'package:demo/ui/auth/email_login_screen.dart';
import 'package:demo/ui/auth/mobile_login_screen.dart';
import 'package:demo/ui/auth/select_language_screen.dart';
import 'package:demo/ui/auth/walkthrough_screen.dart';
import 'package:demo/ui/auth/weclome_screen.dart';
import 'package:demo/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

late var isDark;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.colorScreenBg,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
    ));

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          Common.languageSelection: (context) => const SelectLanguageScreen(),
          Common.onboarding: (context) => WalkthroughScreen(),
          Common.welcome: (context) => const WelcomeScreen(),
          Common.createAccount: (context) => const CreateAccountScreen(),
          Common.mobileLogin: (context) => const MobileLoginScreen(),
          Common.emailLogin: (context) => const EmailLoginScreen(),
          Common.completeProfile: (context) => const CompleteProfileScreen(),
        },
      ),
    );
  }
}
