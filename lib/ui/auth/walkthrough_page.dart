import 'package:auto_route/annotations.dart';
import 'package:demo/Common.dart';
import 'package:demo/generated/assets.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:demo/theming/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/CustomDotIndicator.dart';

class WalkThroughDataClass {
  String title, image;

  WalkThroughDataClass(this.title, this.image);
}

List<WalkThroughDataClass> pageList = [
  WalkThroughDataClass("View your\nconnections", Assets.imagesImageWalk1),
  WalkThroughDataClass(
      "Tap to get voice notification of the location of your loved ones..",
      Assets.imagesImageWalk2),
  WalkThroughDataClass("Locate, Share and\nChat", Assets.imagesImageWalk3)
];

int currentPage = 0;

@RoutePage()
class WalkthroughPage extends StatefulWidget {
  const WalkthroughPage({super.key});

  @override
  State<StatefulWidget> createState() => _WalkthroughState();
}

class _WalkthroughState extends State<WalkthroughPage> {
  @override
  Widget build(BuildContext context) {
    final PageController pageViewController = PageController();
    final PageView pageController = PageView.builder(
      controller: pageViewController,
      itemCount: 3,
      onPageChanged: (int selectedPage) {
        setState(() {
          currentPage = selectedPage;
        });
      },
      itemBuilder: (BuildContext context, int index) {
        return PageItems(
          title: pageList[index].title,
          image: pageList[index].image,
        );
      },
    );

    return Scaffold(
      backgroundColor: AppColor.colorScreenBg,
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesImageCommonBg),
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: pageController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool(Common.IS_WALK, true);
                      Navigator.of(context).popAndPushNamed("/welcome");
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 23.h, bottom: 42.h),
                      child: Text(
                        "Skip",
                        style: TextStyles.normalFontGrey16(),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 42.h),
                    child: buildIndicator(),
                  ),
                  GestureDetector(
                    onTap: () async {
                      int targetPage = 0;
                      if (currentPage == 0) {
                        targetPage = 1;
                      } else if (currentPage == 1) {
                        targetPage = 2;
                      } else if (currentPage == 2) {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool(Common.IS_WALK, true);
                        Navigator.of(context).popAndPushNamed("/welcome");
                      }

                      pageViewController.animateToPage(
                        targetPage,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: 55.h,
                      height: 55.h,
                      margin: EdgeInsets.only(right: 23.h, bottom: 35.h),
                      child: Image.asset(Assets.imagesImageWalkthroughNext),
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  Widget buildIndicator() {
    return Positioned(
      child: SizedBox(
        child: Row(
          children: List<Widget>.generate(
            pageList.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: CustomDotsIndicator(
                currentIndex: currentPage,
                index: index,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget PageItems({required String title, required String image}) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 89.h),
          height: 55.h,
          width: 159.5,
          child: Image.asset(Assets.imagesImageAppNameOnboarding),
        ),
        Container(
          margin: EdgeInsets.only(top: 29.h, left: 25.h, right: 25.h),
          child: Text(title,
              style: TextStyles.boldDarkBlue24().copyWith(height: 1.5),
              textAlign: TextAlign.center),
        ),
        Container(
          margin: EdgeInsets.only(left: 2.h, right: 2.h),
          child: Image.asset(image),
        ),
      ],
    );
  }
}
