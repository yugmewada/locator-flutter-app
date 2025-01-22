import 'package:demo/Common.dart';
import 'package:demo/generated/assets.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:demo/theming/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreen();
}

class _SelectLanguageScreen extends State<SelectLanguageScreen> {
  var selectedLanguage = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.colorScreenBg,
      body: SingleChildScrollView(
        child: Column(
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(20),
              child: Image.asset(
                Assets.imagesImageSelectLanguage,
              ),
            ),
            Text("Select Language", style: TextStyles.boldDarkBlue18()),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColor.colorBorder, width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(17.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _buildLanguageOption(
                      label: "English",
                      isSelected: selectedLanguage == 1,
                      onTap: () => _selectLanguage(1)),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColor.colorBorder,
                  ),
                  _buildLanguageOption(
                      label: "हिन्दी (Hindi)",
                      isSelected: selectedLanguage == 2,
                      onTap: () => _selectLanguage(2)),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColor.colorBorder,
                  ),
                  _buildLanguageOption(
                      label: "தமிழ் (Tamil)",
                      isSelected: selectedLanguage == 3,
                      onTap: () => _selectLanguage(3)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool(Common.IS_LANGUAGE_SELECTED, true);
                  Navigator.of(context).popAndPushNamed("/onboarding");
              },
              child: Container(
                width: 170.h,
                height: 52.h,
                margin: const EdgeInsets.only(top: 20, bottom: 30),
                decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(26.h)),
                child: Center(
                  child: Text(
                    "Submit",
                    style: TextStyles.mediumWhite16(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 32),
            child: Text(label, style: TextStyles.mediumColorDarkBlue16()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Image.asset(
              isSelected
                  ? Assets.imagesImageSelected
                  : Assets.imagesImageUnSelected,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }

  void _selectLanguage(int language) {
    setState(() {
      selectedLanguage = language;
    });
  }
}
