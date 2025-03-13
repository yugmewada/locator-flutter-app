import 'package:auto_route/annotations.dart';
import 'package:demo/base/base_app_bar.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../generated/assets.dart';
import '../../theming/TextStyles.dart';
import '../../ui/auth/bottomsheet/forgot_password_bottom_sheet.dart';

@RoutePage()
class EmailLoginPage extends StatefulWidget {
  const EmailLoginPage({super.key});

  @override
  State<EmailLoginPage> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLoginPage> {
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
                _buildForgotPassAndLoginButton()
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

  Widget _buildForgotPassAndLoginButton() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => {
                showCupertinoModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (context) {
                    return SizedBox(
                      height: 0.6.sh,
                      child: const ForgotPasswordBottomSheet(),
                    );
                  },
                )
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 20),
                child: Text(
                  "Forgot Password?",
                  style: TextStyles.normalFontGrey16(),
                ),
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: () => {},
          child: _buildButton(),
        )
      ],
    );
  }

//------------------------------------------------------------------------------
  //BUTTON AND HEADER
//------------------------------------------------------------------------------

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Container(
        height: 52.h,
        width: 170.h,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(26.h)),
        child: Center(
          child: Text(
            "Login",
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

//------------------------------------------------------------------------------
//BUTTON AND HEADER
//------------------------------------------------------------------------------
}
