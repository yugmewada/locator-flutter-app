import 'package:demo/Common.dart';
import 'package:demo/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theming/AppColor.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();

}

late var isLanguageSelected;
late var isWalk;

class _SplashScreen extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    final prefs = await SharedPreferences.getInstance();

    final isLanguageSelected = prefs.getBool(Common.IS_LANGUAGE_SELECTED) ?? false;
    final isWalk = prefs.getBool(Common.IS_WALK) ?? false;

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        if (!isLanguageSelected) {
          Navigator.of(context).popAndPushNamed("/language_selection");
        } else if (!isWalk) {
          Navigator.of(context).popAndPushNamed("/onboarding");
        } else {
          Navigator.of(context).popAndPushNamed("/welcome");
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
