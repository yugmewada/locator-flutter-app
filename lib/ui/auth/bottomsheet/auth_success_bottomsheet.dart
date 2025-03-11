import 'package:demo/theming/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gif/gif.dart';

import '../../../generated/assets.dart';
import '../../../theming/AppColor.dart';

class AuthSuccessBottomSheet extends StatefulWidget {
  final VoidCallback onContinueClick; // Callback function
  const AuthSuccessBottomSheet({super.key, required this.onContinueClick});

  @override
  State<AuthSuccessBottomSheet> createState() => _AuthSuccessBottomSheetState();
}

class _AuthSuccessBottomSheetState extends State<AuthSuccessBottomSheet>
    with TickerProviderStateMixin {
  late GifController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GifController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playGifOnce();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _playSuccessGif(),
          Text(
            "You’re all set",
            style: TextStyles.semiBoldColorDarkBlue22(),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Thank you for creating an account\nwith us.",
            style: TextStyles.normalFontGrey14(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 56,
          ),
          _buildContinueButton()
        ],
      ),
    );
  }

  void _playGifOnce() {
    _controller.reset();
    _controller.forward().whenComplete(() => _controller.stop());
  }

  Widget _playSuccessGif() {
    return Center(
      child: SizedBox(
        height: 120,
        width: 172,
        child: Gif(
            controller: _controller,
            autostart: Autostart.once,
            image: const AssetImage(Assets.imagesIcSuccessSignup)),
      ),
    );
  }

  Widget _buildContinueButton() {
    return GestureDetector(
      onTap: () {
        widget.onContinueClick();
        Navigator.pop(context);
      },
      child: Container(
        height: 52.h,
        width: 170.h,
        decoration: const BoxDecoration(
            color: AppColor.colorDarkBlue,
            borderRadius: BorderRadius.all(Radius.circular(26))),
        child: Center(
          child: Text(
            "Continue",
            style: TextStyles.mediumWhite16(),
          ),
        ),
      ),
    );
  }
}
