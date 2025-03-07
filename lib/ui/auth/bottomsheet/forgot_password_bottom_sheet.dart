import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:demo/theming/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/assets.dart';

class ForgotPasswordBottomSheet extends StatefulWidget {
  const ForgotPasswordBottomSheet({super.key});

  @override
  State<ForgotPasswordBottomSheet> createState() =>
      _ForgotPasswordBottomSheetState();
}

class _ForgotPasswordBottomSheetState extends State<ForgotPasswordBottomSheet> {
  final ValueNotifier<bool> isPhoneSelected = ValueNotifier(true);
  final ValueNotifier<String> selectedCountryCode =
      ValueNotifier<String>('+91');
  final ValueNotifier<Country> selectedCountryFlag =
      ValueNotifier<Country>(CountryPickerUtils.getCountryByIsoCode("IN"));

  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(children: [
          _buildHeaderText(),
          const SizedBox(height: 44),
          _buildToggles(),
          const SizedBox(height: 41),
          _buildHideShow(),
          ValueListenableBuilder(
              valueListenable: isPhoneSelected,
              builder: (context, isPhone, child) {
                return _buildButton(title: isPhone ? "Get OTP" : "Submit");
              })
        ]),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Forgot Password",
                style: TextStyles.semiBoldColorDarkBlue22(),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6, left: 20, right: 20),
          child: Center(
            child: Text(
              "Enter your mobile number and we will send an OTP to reset your password.",
              style: TextStyles.normalFontGrey16().copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildButton({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Container(
        height: 52.h,
        width: 170.h,
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(26.h)),
        child: Center(
          child: Text(
            title,
            style: TextStyles.mediumWhite16(),
          ),
        ),
      ),
    );
  }

  Widget _buildToggles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => {
            isPhoneSelected.value = false,
            mobileNumberController.text = ""
          },
          child: ValueListenableBuilder<bool>(
              valueListenable: isPhoneSelected,
              builder: (context, isEmailSelected, child) {
                return Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                      color: !isPhoneSelected.value
                          ? AppColor.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(27)),
                  child: Center(
                    child: Text(
                      "Email",
                      style: TextStyles.normalFontGrey16().copyWith(
                          color: !isPhoneSelected.value
                              ? AppColor.colorWhite
                              : AppColor.colorGrey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }),
        ),
        GestureDetector(
          onTap: () => {
            isPhoneSelected.value = true,
            emailController.text = ""
          },
          child: ValueListenableBuilder<bool>(
            valueListenable: isPhoneSelected,
            builder: (context, isPhSelected, child) {
              return Container(
                width: 90,
                height: 40,
                decoration: BoxDecoration(
                    color: isPhSelected
                        ? AppColor.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(27)),
                child: Center(
                  child: Text(
                    "Phone",
                    style: TextStyles.normalFontGrey16().copyWith(
                        color: isPhSelected
                            ? AppColor.colorWhite
                            : AppColor.colorGrey),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

//------------------------------------------------------------------------------
  //HIDE SHOW AREA
//------------------------------------------------------------------------------

  Widget _buildHideShow() {
    return ValueListenableBuilder<bool>(
        valueListenable: isPhoneSelected,
        builder: (context, isPhone, child) {
          return isPhone ? _buildCountryCode() : _buildEmail();
        });
  }

  Widget _buildEmail() {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 22, right: 22, top: 22),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(17.0)),
          border: Border.all(color: AppColor.colorBorder, width: 1),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
          child: _emailTextField(hint: "Email Address"),
        ));
  }

  Widget _buildCountryCode() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 22, right: 22, top: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(17.0)),
        border: Border.all(color: AppColor.colorBorder, width: 1),
      ),
      child: Column(
        children: [
          Padding(
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
          )
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
  //TEXT FIELDS
//------------------------------------------------------------------------------

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

  Widget _emailTextField({required String hint}) {
    return TextField(
        cursorColor: Colors.black,
        controller: emailController,
        decoration: InputDecoration(
            border: InputBorder.none,
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
