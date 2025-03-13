import 'package:auto_route/auto_route.dart';
import 'package:demo/Common.dart';
import 'package:demo/generated/assets.dart';
import 'package:demo/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theming/AppColor.dart';

@RoutePage()
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPage();
}

class _SplashScreenPage extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    final prefs = await SharedPreferences.getInstance();

    final isLanguageSelected =
        prefs.getBool(Common.IS_LANGUAGE_SELECTED) ?? false;
    final isWalk = prefs.getBool(Common.IS_WALK) ?? false;
    final isLogin = prefs.getBool(Common.IS_LOGIN) ?? false;

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        if (!isLogin) {
          if (!isLanguageSelected) {
            context.maybePop();
            context.router.push(const SelectLanguageRoute());
          } else if (!isWalk) {
            context.maybePop();
            context.router.push(const WalkthroughRoute());
          } else {
            context.maybePop();
            context.router.push(const WelcomeRoute());
          }
        } else {
          Navigator.of(context).popAndPushNamed(Common.homeScreenMain);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
      ),
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Image.asset(Assets.imagesImageSplash),
      ),
    );
  }
}
