import 'package:demo/Common.dart';
import 'package:demo/generated/assets.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:demo/theming/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorScreenBg,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 55.h,
                      width: 159.h,
                      child: Image.asset(Assets.imagesImageAppNameOnboarding),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.h, vertical: 28.h),
                        child: Text(
                            "Login with your mobile number or email address",
                            style: TextStyles.boldDarkBlue18(),
                            textAlign: TextAlign.center)),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(17.0)),
                        border:
                            Border.all(color: AppColor.colorBorder, width: 1),
                      ),
                      child: Column(
                        children: <Widget>[
                          welcomeScreenOptions(
                              label: "Login with Mobile",
                              imageAsset: Assets.imagesImageMobile,
                              onClick: () => {
                                    Navigator.of(context)
                                        .pushNamed(Common.mobileLogin)
                                  }),
                          Divider(
                            height: 1.h,
                            thickness: 1.h,
                            color: AppColor.colorBorder,
                          ),
                          welcomeScreenOptions(
                              label: "Login with Email",
                              imageAsset: Assets.imagesImageEmail,
                              onClick: () => {
                                    Navigator.of(context)
                                        .pushNamed(Common.emailLogin)
                                  }),
                          createAccountOptions(
                              onClick: () => {
                                    Navigator.of(context)
                                        .pushNamed(Common.createAccount)
                                  })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: termsAndPrivacyText()),
        ],
      ),
    );
  }

  Widget welcomeScreenOptions(
      {required String label,
      required String imageAsset,
      required VoidCallback onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 46.h,
            height: 46.h,
            margin: EdgeInsets.only(left: 16.h, top: 23.h, bottom: 22),
            child: Image.asset(imageAsset),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(
                label,
                style: TextStyles.mediumColorDarkBlue16(),
              ),
            ),
          ),
          Container(
              height: 13.h,
              width: 8.h,
              margin: const EdgeInsets.only(right: 20),
              child: Image.asset(Assets.imagesImageNextGrey))
        ],
      ),
    );
  }

  Widget termsAndPrivacyText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: "By creating account you agree to our ",
          style: TextStyles.normalFontGrey2_14(),
          children: <TextSpan>[
            TextSpan(
                text: "Terms of Service",
                style: TextStyles.mediumColorDarkBlue14()
                    .copyWith(decoration: TextDecoration.underline)),
            TextSpan(text: " and ", style: TextStyles.normalFontGrey2_14()),
            TextSpan(
                text: "Privacy Policy",
                style: TextStyles.mediumColorDarkBlue14()
                    .copyWith(decoration: TextDecoration.underline))
          ]),
    );
  }

  Widget createAccountOptions({required VoidCallback onClick}) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(17.0),
              bottomLeft: Radius.circular(17.0)),
          border: Border.all(color: AppColor.colorBorder, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 46.h,
              height: 46.h,
              margin: EdgeInsets.only(left: 16.h, top: 23.h, bottom: 22),
              child: Image.asset(Assets.imagesImagePlusWhiteBg),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  "Create New Account",
                  style: TextStyles.mediumColorWhite16(),
                ),
              ),
            ),
            Container(
                height: 13.h,
                width: 8.h,
                margin: const EdgeInsets.only(right: 20),
                child: Image.asset(Assets.imagesImageNextGrey))
          ],
        ),
      ),
    );
  }
}
