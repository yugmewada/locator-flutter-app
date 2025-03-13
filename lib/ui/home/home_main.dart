import 'package:demo/generated/assets.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:demo/ui/home/chat_screen.dart';
import 'package:demo/ui/home/home_screen.dart';
import 'package:demo/ui/home/notification_screen.dart';
import 'package:demo/ui/home/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeMain extends StatefulWidget {
  const HomeMain({super.key});

  @override
  State<StatefulWidget> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  ValueNotifier<int> selectionNotifier = ValueNotifier(0);

  final pages = [
    const HomeScreen(),
    const ChatScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectionNotifier,
        builder: (context, selectedItem, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: _buildBottomNavigation(),
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Center(
                    child: pages[selectedItem],
                  ),
                ],
              ));
        });
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 88.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavigationItems(
              selectedPage: 0,
              isIndicatorVisible: selectionNotifier.value == 0,
              imageName: selectionNotifier.value == 0
                  ? Assets.imagesIcHomeSelected
                  : Assets.imagesIcHomeUnSelected),
          _buildNavigationItems(
              selectedPage: 1,
              isIndicatorVisible: selectionNotifier.value == 1,
              imageName: selectionNotifier.value == 1
                  ? Assets.imagesIcChatSelected
                  : Assets.imagesIcChatUnselected),
          _buildNavigationItems(
              selectedPage: 2,
              isIndicatorVisible: selectionNotifier.value == 2,
              imageName: selectionNotifier.value == 2
                  ? Assets.imagesIcBellSelected
                  : Assets.imagesIcBellUnSelected),
          _buildNavigationItems(
              selectedPage: 3,
              isIndicatorVisible: selectionNotifier.value == 3,
              imageName: selectionNotifier.value == 3
                  ? Assets.imagesIcProfileSelected
                  : Assets.imagesIcProfileUnSelected),
        ],
      ),
    );
  }

  Widget _buildNavigationItems(
      {required bool isIndicatorVisible,
      required String imageName,
      required int selectedPage}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        selectionNotifier.value = selectedPage;
      },
      child: SizedBox(
        height: 88.h,
        width: 88.h,
        child: Column(
          children: [
            SizedBox(
              height: 4,
              width: 17,
              child: Container(
                decoration: BoxDecoration(
                  color: isIndicatorVisible
                      ? AppColor.colorDarkBlue
                      : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(height: 24, width: 24, child: Image.asset(imageName)),
          ],
        ),
      ),
    );
  }
}
