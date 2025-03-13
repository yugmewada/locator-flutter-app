import 'package:demo/Common.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:demo/ui/auth/complete_profile_page.dart';
import 'package:demo/ui/auth/create_account_page.dart';
import 'package:demo/ui/auth/email_login_page.dart';
import 'package:demo/ui/auth/mobile_login_page.dart';
import 'package:demo/ui/auth/select_language_page.dart';
import 'package:demo/ui/auth/walkthrough_page.dart';
import 'package:demo/ui/auth/welcome_page.dart';
import 'package:demo/ui/home/home_main.dart';
import 'package:demo/ui/home/home_screen.dart';
import 'package:demo/ui/splash/splash_screen.dart';
import 'package:demo/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<AppRouter>(AppRouter());
}


void main() {
  setupLocator();
  runApp(MyApp(appRouter: locator<AppRouter>()));
}

late var isDark;

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({required this.appRouter, super.key});

  void updateStatusBarColor(Color backgroundColor) {
    Brightness brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    bool isDark = brightness == Brightness.dark;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: backgroundColor,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget? widget) {
          return widget!;
        },
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),

      ),
    );
  }


  // This widget is the root of your application.
  /*@override
  Widget build(BuildContext context) {
    updateStatusBarColor(AppColor.colorScreenBg);

    return ScreenUtilInit(
      designSize: const Size(390, 844),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        *//*initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          Common.languageSelection: (context) => const SelectLanguageScreen(),
          Common.onboarding: (context) => WalkthroughScreen(),
          Common.welcome: (context) => const WelcomeScreen(),
          Common.createAccount: (context) => const CreateAccountScreen(),
          Common.mobileLogin: (context) => const MobileLoginScreen(),
          Common.emailLogin: (context) => const EmailLoginScreen(),
          Common.completeProfile: (context) => const CompleteProfileScreen(),
          Common.homeScreenMain: (context) => const HomeMain(),
        },*//*
      ),
    );
  }*/
}
