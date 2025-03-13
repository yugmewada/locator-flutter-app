import 'package:demo/base/base_app_bar.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:demo/theming/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BaseAppBar(
        backgroundColor: Colors.white,
        statusBarColor: Colors.white,
        centerTitle: false,
        showTitle: true,
        titleWidget: _buildGreetingText(),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded( // Allows the image to take available space dynamically
            child: Image.asset(
              Assets.imagesMap,
              width: double.infinity,
              fit: BoxFit.cover, // Adjusts the image to fit well
            ),
          ),
          _buildFriendsAndFamilySection(),
        ],
      )
    );
  }

  Widget _buildGreetingText() {
    return RichText(
      text: TextSpan(
          text: "Good Morning, ",
          style: TextStyles.mediumColorDarkBlue14(),
          children: <TextSpan>[
            TextSpan(text: "John Doe!", style: TextStyles.boldDarkBlue14())
          ]),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
      child: SizedBox(
        height: 50, // Set an explicit height
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Fix incorrect `withValues`
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                child: SizedBox(
                  height: 18,
                  width: 18,
                  child: Image.asset(Assets.imagesIcSearchGrey),
                ),
              ),
              Expanded( // Wrap TextField in Expanded to prevent constraint issues
                child: TextField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterText: "",
                    hintText: "Search Location",
                    hintStyle: TextStyles.normalFontGreyHint_14(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFriendsAndFamilySection() {
    return Container(
      width: double.infinity,
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildBottomHeader()
        ],
      ),
    );
  }
  
  Widget _buildBottomHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 21, right: 21, top: 22
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Your friends & family", style: TextStyles.boldDarkBlue18()),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: AppColor.colorGrey3
                )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 18),
              child: Text("View All", style: TextStyles.mediumColorGrey12(),),
            ),
          )
        ],
      ),
    );
  }
}
