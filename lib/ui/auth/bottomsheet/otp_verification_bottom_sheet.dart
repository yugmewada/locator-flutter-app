import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theming/AppColor.dart';
import '../../../theming/TextStyles.dart';

class OtpVerificationBottomSheet extends StatefulWidget {
  final VoidCallback onOtpVerified; // Callback function
  const OtpVerificationBottomSheet({super.key, required this.onOtpVerified});

  @override
  State<OtpVerificationBottomSheet> createState() =>
      _OtpVerificationBottomSheetState();
}

class _OtpVerificationBottomSheetState
    extends State<OtpVerificationBottomSheet> {
  Timer? _resendTimer;

  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  ValueNotifier<bool> isTimerRunning = ValueNotifier(false);
  ValueNotifier<int> otpTimerValue = ValueNotifier(30);

  @override
  void dispose() {
    super.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    _resendTimer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHeader(),
            const SizedBox(height: 27),
            _buildOTP(),
            const SizedBox(height: 46),
            _buildVerifyButton(),
            const SizedBox(height: 22),
            _buildTimerAndResendText()
          ],
        ),
      ),
    );
  }

//------------------------------------------------------------------------------
  //MANAGE TIMER
//------------------------------------------------------------------------------

  void _startTimer() {
    isTimerRunning.value = true;
    otpTimerValue.value = 30;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (callback) {
      if (otpTimerValue.value > 0) {
        otpTimerValue.value--;
      } else {
        isTimerRunning.value = false;
        _resendTimer?.cancel();
      }
    });
  }

  Widget _buildTimerAndResendText() {
    return Center(
      child: ValueListenableBuilder<int>(
          valueListenable: otpTimerValue,
          builder: (context, timeoutValue, child) {
            return ValueListenableBuilder<bool>(
                valueListenable: isTimerRunning,
                builder: (context, isRunning, child) {
                  return GestureDetector(
                    onTap: isRunning ? null : _startTimer,
                    child: Text(
                        isRunning
                            ? (timeoutValue < 10)
                                ? "00:0$timeoutValue"
                                : "00:$timeoutValue"
                            : "Re-send Code",
                        style: isRunning
                            ? TextStyles.extraBoldFont14()
                            : TextStyles.normalFontColorDarkBlue14()),
                  );
                });
          }),
    );
  }

//------------------------------------------------------------------------------
  //OTHER WIDGETS
//------------------------------------------------------------------------------

  Widget _buildVerifyButton() {
    return GestureDetector(
      onTap: () {
        var edit1 = _controllers[0];
        var edit2 = _controllers[1];
        var edit3 = _controllers[2];
        var edit4 = _controllers[3];

        if (edit1.text.isEmpty ||
            edit2.text.isEmpty ||
            edit3.text.isEmpty ||
            edit4.text.isEmpty) {
          debugPrint("Please enter OTP");
        }else {
          widget.onOtpVerified();
          Navigator.pop(context);
        }
      },
      child: Container(
        height: 52.h,
        width: 170.h,
        decoration: const BoxDecoration(
            color: AppColor.colorDarkBlue,
            borderRadius: BorderRadius.all(Radius.circular(26))),
        child: Center(
          child: Text(
            "Verify",
            style: TextStyles.mediumWhite16(),
          ),
        ),
      ),
    );
  }

  Widget _buildOTP() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _editTextOTP(controller: _controllers[index], index: index),
        ),
      ),
    );
  }

  Widget _editTextOTP({
    required TextEditingController controller,
    required int index, // Added index as a parameter
  }) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          counter: const Offstage(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColor.colorGreyOp50),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColor.colorGreyOp50),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColor.colorGreyOp50),
          ),
        ),
        onChanged: (value) {
          if (value.length == 1) {
            if (index < 3) {
              FocusScope.of(context).nextFocus(); // Move to next field
            } else {
              FocusScope.of(context).unfocus(); // Hide keyboard on last field
            }
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus();
          } else if (index == 0 && value.isEmpty) {
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Center(
        child: Column(
          children: [
            Text(
              "OTP Verification",
              style: TextStyles.semiBoldColorDarkBlue22(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Please enter the verification code",
                style: TextStyles.normalFontGrey16(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 23),
              child: Text(
                "+966 - 23-894-3766",
                style: TextStyles.mediumColorDarkBlue14(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}