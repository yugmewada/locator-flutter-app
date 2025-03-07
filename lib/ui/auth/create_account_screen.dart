import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:demo/base/base_app_bar.dart';
import 'package:demo/generated/assets.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:demo/theming/TextStyles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateAccountScreen();
}

class _CreateAccountScreen extends State<CreateAccountScreen> {
  bool showPassword = false;
  bool showConfirmPassword = false;
  bool isTermsCheck = false;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  final ValueNotifier<String> selectedCountryCode =
      ValueNotifier<String>('+91');
  ValueNotifier<Country> selectedCountryFlag =
      ValueNotifier<Country>(CountryPickerUtils.getCountryByIsoCode("IN"));

  @override
  void dispose() {
    super.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void _toggleShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void _toggleTerms() {
    setState(() {
      isTermsCheck = !isTermsCheck;
    });
  }

  void _toggleShowConfirmPassword() {
    setState(() {
      showConfirmPassword = !showConfirmPassword;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(confirmPasswordController.text)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.colorScreenBg,
        body: SingleChildScrollView(
            child: Column(
          children: [
            BaseAppBar(
              leadingIcon: true,
              backAction: () {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              },
            ),
            Column(
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
                    "Create New Account",
                    style: TextStyles.boldDarkBlue18(),
                  ),
                ),
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
                      _buildCountryCode(),
                      _buildDivider(),
                      _buildPassword(),
                      _buildDivider(),
                      _buildConfirmPassword()
                    ],
                  ),
                ),
                termsAndConditions(isChecked: isTermsCheck),
                _buildButton()
              ],
            ),
          ],
        )));
  }

  Widget _buildButton() {
    return Padding(
      padding: EdgeInsets.only(top: 63.h, bottom: 20.h),
      child: Container(
        height: 52.h,
        width: 170.h,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(26.h)),
        child: Center(
          child: Text(
            "Create",
            style: TextStyles.mediumWhite16(),
          ),
        ),
      ),
    );
  }

//------------------------------------------------------------------------------
  //EMAIL
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

//------------------------------------------------------------------------------
  //COUNTRY CODE
//------------------------------------------------------------------------------

  //Country code and phone number section
  Widget _buildCountryCode() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _openCountryPickerDialog();
            },
            child: Row(
              children: [
                Image.asset(
                  CountryPickerUtils.getFlagImageAssetPath(
                      selectedCountryFlag.value.isoCode),
                  height: 20.0,
                  width: 30.0,
                  fit: BoxFit.fill,
                  package: "country_pickers",
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 7, right: 12),
                    child: ValueListenableBuilder<String>(
                      valueListenable: selectedCountryCode,
                      builder: (context, countryCode, child) {
                        return Text(countryCode,
                            style: TextStyles.mediumColorDarkBlue16());
                      },
                    )),
              ],
            ),
          ),
          SizedBox(
            width: 9,
            height: 5,
            child: Image.asset(Assets.imagesImageDropDownCountryCode),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 21, right: 21),
            child: mobileTextField(hint: "Mobile Number"),
          ))
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
  //PASSWORD AND CONFIRM PASSWORD
//------------------------------------------------------------------------------

  Widget _buildPassword() {
    return Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: passwordTextField(
                  hint: "Password",
                  isShowText: showPassword,
                  controller: passwordController),
            ),
            GestureDetector(
              onTap: _toggleShowPassword,
              child: SizedBox(
                width: 21,
                height: 21,
                child: Image.asset(Assets.imagesImageEye),
              ),
            )
          ],
        ));
  }

//------------------------------------------------------------------------------
  //CONFIRM PASSWORD
//------------------------------------------------------------------------------

  Widget _buildConfirmPassword() {
    return Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: passwordTextField(
                  hint: "Confirm Password",
                  isShowText: showConfirmPassword,
                  controller: confirmPasswordController),
            ),
            GestureDetector(
              onTap: _toggleShowConfirmPassword,
              child: SizedBox(
                width: 21,
                height: 21,
                child: Image.asset(Assets.imagesImageEye),
              ),
            )
          ],
        ));
  }

//------------------------------------------------------------------------------
  //TERMS AND CONDITIONS
//------------------------------------------------------------------------------

  Widget termsAndConditions({required isChecked}) {
    return Row(
      children: [
        GestureDetector(
            onTap: () => {_toggleTerms()},
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 0, right: 7),
              child: Image.asset(
                isChecked
                    ? Assets.imagesImageTickCircle
                    : Assets.imagesImageUnSelected,
                height: 24,
                width: 24,
              ),
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 10),
          child: RichText(
              text: TextSpan(
                  text: "By continuing, you agree to the ",
                  style: TextStyles.normalFontGrey2_14(),
                  children: <TextSpan>[
                TextSpan(
                    text: "Terms of Service",
                    style: TextStyles.mediumColorDarkBlue14(),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Terms of Service")));
                      }),
                TextSpan(text: " and ", style: TextStyles.normalFontGrey2_14()),
                TextSpan(
                    text: "Privacy Policy",
                    style: TextStyles.mediumColorDarkBlue14(),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Privacy Policy")));
                      })
              ])),
        ))
      ],
    );
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

  Widget mobileTextField({required String hint}) {
    return TextField(
        cursorColor: Colors.black,
        maxLength: 11,
        controller: mobileNumberController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            border: InputBorder.none,
            counterText: "",
            labelText: hint,
            hintStyle: TextStyles.normalFontGreyHint_14(),
            labelStyle: TextStyles.normalFontGreyHint_14()));
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
  //COUNTRY PICKER DIALOG
//------------------------------------------------------------------------------
  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[
          CountryPickerUtils.getDefaultFlagImage(country),
          const SizedBox(width: 8.0),
          Flexible(
              child: Text(
            "+${country.phoneCode} ${country.name}",
            style: TextStyles.mediumColorDarkBlue16(),
          )),
        ],
      );

  Future _openCountryPickerDialog() => showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
          searchCursorColor: AppColor.primaryColor,
          titlePadding: const EdgeInsets.all(8.0),
          searchInputDecoration: InputDecoration(
            hintText: "Search phone code",
            hintStyle: TextStyles.mediumColorDarkBlue16(),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.primaryColor,
                width: 1.0,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.primaryColor,
                width: 1.0,
              ),
            ),
            labelStyle: TextStyles.mediumColorDarkBlue16(),
          ),
          isSearchable: true,
          title: Text("Select your country",
              style: TextStyles.mediumColorDarkBlue16()),
          onValuePicked: (Country country) => setState(() {
            selectedCountryFlag.value = country;
            selectedCountryCode.value = "+${country.phoneCode}";
          }),
          itemBuilder: _buildDialogItem,
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('IN'),
          ],
        ),
      );
}
