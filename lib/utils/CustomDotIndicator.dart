import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/AppColor.dart';

class CustomDotsIndicator extends StatelessWidget {
  final int currentIndex;
  final int index;

  const CustomDotsIndicator({required this.currentIndex, required this.index});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 8.r,
      width: currentIndex == index ? 8.r : 8.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentIndex == index
            ? AppColor.colorIndiSelected
            : AppColor.colorIndiUnSelected,
      ),
    );
  }
}
