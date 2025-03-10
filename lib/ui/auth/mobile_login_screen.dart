import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:demo/ui/auth/bottomsheet/otp_verification_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../base/base_app_bar.dart';
import '../../generated/assets.dart';
import '../../theming/TextStyles.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  final ValueNotifier<String> selectedCountryCode =
      ValueNotifier<String>('India (+91)');
  ValueNotifier<Country> selectedCountryFlag =
      ValueNotifier<Country>(CountryPickerUtils.getCountryByIsoCode("IN"));

  final TextEditingController mobileNumberController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    mobileNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.colorScreenBg,
        body: Column(
          children: [
            BaseAppBar(
              leadingIcon: true,
              backAction: () => {Navigator.pop(context)},
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _headerArea(title: "Login to your account"),
                    Container(
                      width: double.infinity,
                      margin:
                          const EdgeInsets.only(left: 22, right: 22, top: 22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(17.0)),
                        border:
                            Border.all(color: AppColor.colorBorder, width: 1),
                      ),
                      child: Column(
                        children: [
                          _buildCountryCode(),
                          _buildDivider(),
                          _mobileTextField(hint: "Mobile Number")
                        ],
                      ),
                    ),
                    _buildButton()
                  ],
                ),
              ),
            )
          ],
        ));
  }

//------------------------------------------------------------------------------
  //COUNTRY CODE
//------------------------------------------------------------------------------

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColor.colorBorder,
    );
  }

  //Country code and phone number section
  Widget _buildCountryCode() {
    return GestureDetector(
      onTap: () {
        _openCountryPickerDialog();
      },
      child: Padding(
        padding:
            const EdgeInsets.only(top: 31, bottom: 31, left: 20, right: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                CountryPickerUtils.getFlagImageAssetPath(
                    selectedCountryFlag.value.isoCode),
                height: 20.0,
                width: 30.0,
                fit: BoxFit.fill,
                package: "country_pickers",
              ),
            ),
            Expanded(
                child: ValueListenableBuilder<String>(
              valueListenable: selectedCountryCode,
              builder: (context, countryCode, child) {
                return Text(
                  countryCode,
                  style: TextStyles.mediumColorDarkBlue16(),
                  overflow: TextOverflow.ellipsis,
                );
              },
            )),
            SizedBox(
              width: 9.h,
              height: 16.h,
              child: Image.asset(Assets.imagesImageDropDownBlack),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mobileTextField({required String hint}) {
    return Padding(
      padding: const EdgeInsets.only(left: 22, right: 22, top: 10, bottom: 10),
      child: TextField(
          cursorColor: Colors.black,
          maxLength: 11,
          controller: mobileNumberController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
              border: InputBorder.none,
              counterText: "",
              labelText: hint,
              hintStyle: TextStyles.normalFontGreyHint_14(),
              labelStyle: TextStyles.normalFontGreyHint_14())),
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

//------------------------------------------------------------------------------
  //BUTTON
//------------------------------------------------------------------------------

  Widget _buildButton() {
    return GestureDetector(
      onTap: () {
        showCupertinoModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: 0.6.sh,
              child: OtpVerificationBottomSheet(onOtpVerified: () {
                debugPrint("OTP Verified");
              }),
            );
          },
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        );
      },
      child: Padding(
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
      ),
    );
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
            selectedCountryCode.value =
                "${country.isoCode} (+${country.phoneCode})";
          }),
          itemBuilder: _buildDialogItem,
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('IN'),
          ],
        ),
      );

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
