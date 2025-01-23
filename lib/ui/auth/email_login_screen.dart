import 'package:demo/base/base_app_bar.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';
import '../../theming/TextStyles.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<StatefulWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> passwordToggleNotifier = ValueNotifier(false);

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorScreenBg,
      body: Column(
        children: [
          BaseAppBar(
            leadingIcon: true,
            backAction: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                _headerArea(title: "Login to your account"),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 22, right: 22, top: 22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(17.0)),
                    border: Border.all(color: AppColor.colorBorder, width: 1),
                  ),
                  child: Column(
                    children: [
                      _buildEmail(),
                      _buildDivider(),
                      _buildPasswordTextField(hint: "Password")
                    ],
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
  //TEXT FIELDS
//------------------------------------------------------------------------------

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColor.colorBorder,
    );
  }

  Widget _buildEmail() {
    return Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        child: screenTextFields(hint: "Email"));
  }

  Widget screenTextFields({required String hint}) {
    return TextField(
        cursorColor: Colors.black,
        controller: emailController,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: hint,
            hintStyle: TextStyles.normalFontGreyHint_14(),
            labelStyle: TextStyles.normalFontGreyHint_14()));
  }

  Widget _buildPasswordTextField({
    required String hint,
  }) {
    return ValueListenableBuilder<bool>(
      valueListenable: passwordToggleNotifier,
      builder: (context, boolean, child) {
        return Padding(
            padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: passwordTextField(
                      hint: "Password",
                      isShowText: passwordToggleNotifier.value,
                      controller: passwordController),
                ),
                GestureDetector(
                  onTap: () => {
                    passwordToggleNotifier.value = !passwordToggleNotifier.value
                  },
                  child: SizedBox(
                    width: 21,
                    height: 21,
                    child: Image.asset(Assets.imagesImageEye),
                  ),
                )
              ],
            ));
      },
    );
  }

  Widget passwordTextField({
    required String hint,
    required isShowText,
    required TextEditingController controller,
  }) {
    return TextField(
        cursorColor: Colors.black,
        keyboardType: TextInputType.visiblePassword,
        obscureText: !isShowText,
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            counterText: "",
            labelText: hint,
            hintStyle: TextStyles.normalFontGreyHint_14(),
            labelStyle: TextStyles.normalFontGreyHint_14()));
  }

//------------------------------------------------------------------------------
  //BUTTON
//------------------------------------------------------------------------------

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: Container(
        height: 52.h,
        width: 170.h,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(26.h)),
        child: Center(
          child: Text(
            "Get OTP",
            style: TextStyles.mediumWhite16(),
          ),
        ),
      ),
    );
  }

  Widget _headerArea({required String title}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 53.h),
          child: SizedBox(
            height: 55.h,
            width: 159.h,
            child: Image.asset(Assets.imagesImageAppNameOnboarding),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 27),
          child: Text(
            title,
            style: TextStyles.boldDarkBlue18(),
          ),
        )
      ],
    );
  }
}
