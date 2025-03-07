import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theming/AppColor.dart';
import '../../../theming/TextStyles.dart';

class OtpVerificationBottomSheet extends StatefulWidget {
  const OtpVerificationBottomSheet({super.key});

  @override
  State<OtpVerificationBottomSheet> createState() =>
      _OtpVerificationBottomSheetState();
}

class _OtpVerificationBottomSheetState
    extends State<OtpVerificationBottomSheet> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
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
          ],
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
      width: 50,
      height: 50,
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
            if (index == 0 && value.isEmpty) {
              FocusScope.of(context).unfocus();
            }
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
