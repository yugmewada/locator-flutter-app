import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:demo/theming/AppColor.dart';
import 'package:demo/theming/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Common.dart';
import '../../base/base_app_bar.dart';
import '../../generated/assets.dart';
import '../../utils/media_picker_bottomsheet.dart';
import 'bottomsheet/auth_success_bottomsheet.dart';

@RoutePage()
class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfilePage> {
  final ValueNotifier<File?> _profileImageNotifier = ValueNotifier<File?>(null);
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final TextEditingController mobileNumberController = TextEditingController();

  final ValueNotifier<String> selectedCountryCode =
      ValueNotifier<String>('+91');
  ValueNotifier<Country> selectedCountryFlag =
      ValueNotifier<Country>(CountryPickerUtils.getCountryByIsoCode("IN"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          BaseAppBar(
            statusBarColor: Colors.white,
            backgroundColor: Colors.white,
            showTitle: true,
            leadingIcon: false,
            titleWidget: Text(
              "Complete Profile",
              style: TextStyles.mediumColorDarkBlue16(),
            ),
            titleWidgetColor: AppColor.colorDarkBlue,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 29,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17),
                        border: Border.all(color: AppColor.colorBorder)),
                    child: Column(
                      children: [
                        _buildImageArea(),
                        _screenTextFields(
                            hint: "Name",
                            controller: nameController,
                            textInputAction: TextInputAction.next,
                            inputType: TextInputType.text),
                        _buildDivider(),
                        _screenTextFields(
                            hint: "About",
                            controller: aboutController,
                            inputType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 5),
                        _buildDivider(),
                        _buildAddressTextField(),
                        _buildDivider(),
                        _buildCountryCode(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildSubmitButton(),
                const SizedBox(
                  height: 22,
                ),
                _buildSkipText(),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

//------------------------------------------------------------------------------
  //TEXT FIELDS IMAGE AREA
//------------------------------------------------------------------------------

  Widget _screenTextFields(
      {required String hint,
      required TextEditingController controller,
      required TextInputType inputType,
      required TextInputAction textInputAction,
      int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: TextField(
          cursorColor: Colors.black,
          controller: controller,
          keyboardType: inputType,
          maxLines: maxLines,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: hint,
              alignLabelWithHint: maxLines > 1 ? true : false,
              hintStyle: TextStyles.normalFontGreyHint_14(),
              labelStyle: TextStyles.normalFontGreyHint_14())),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColor.colorBorder,
    );
  }

  Widget _buildAddressTextField() {
    return Row(
      children: [
        Expanded(
          child: _screenTextFields(
              hint: "Home Address (Optional)",
              controller: addressController,
              inputType: TextInputType.text,
              textInputAction: TextInputAction.next),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 20),
          child: SizedBox(
            width: 28,
            height: 28,
            child: Image.asset(Assets.imagesIcAddressPinAuth),
          ),
        ),
      ],
    );
  }

//------------------------------------------------------------------------------
  //IMAGE AREA
//------------------------------------------------------------------------------

  Widget _buildImageArea() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 138.h,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: AppColor.colorGreyOp20,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14), topRight: Radius.circular(14))),
        child: Center(
            child: GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: ValueListenableBuilder(
                    valueListenable: _profileImageNotifier,
                    builder: (context, imageFile, child) {
                      return imageFile == null
                          ? _buildImageIcon()
                          : _buildProfileImage(imageFile);
                    }))),
      ),
    );
  }

  Widget _buildProfileImage(File imageFile) {
    return ClipOval(
      child: SizedBox(
        width: 90,
        height: 90,
        child: Image.file(
          imageFile,
          fit: BoxFit.cover, // Important to cover the entire area
        ),
      ),
    );
  }

  Widget _buildImageIcon() {
    return Container(
        width: 90,
        height: 90,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              height: 28,
              width: 28,
              child: Image.asset(Assets.imagesIcCamera),
            )
          ],
        ));
  }

//------------------------------------------------------------------------------
  //COUNTRY CODE PICKER
//------------------------------------------------------------------------------

  Widget _buildCountryCode() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
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
                    padding: const EdgeInsets.only(left: 7, right: 7),
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
              child: _screenTextFields(
                  hint: "Emergency Contact(Optional)",
                  controller: mobileNumberController,
                  inputType: TextInputType.phone,
                  textInputAction: TextInputAction.done))
        ],
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
            selectedCountryCode.value = "+${country.phoneCode}";
          }),
          itemBuilder: _buildDialogItem,
          priorityList: [
            CountryPickerUtils.getCountryByIsoCode('IN'),
          ],
        ),
      );

  Future<void> _pickImage() async {
    final pickedFile = await showModalBottomSheet<XFile?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => MediaPickerSheet(
        pickFileType: PickedFileType.image,
        onSelectFile: (file, type) {
          if (file != null) {
            _profileImageNotifier.value = File(file.path);
          }
          Navigator.pop(context);
        },
      ),
    );
  }

//------------------------------------------------------------------------------
  //BOTTOM SECTION
//------------------------------------------------------------------------------
  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: () {
        _showSuccessBottomSheet();
      },
      child: Container(
        height: 52.h,
        width: 170.h,
        decoration: const BoxDecoration(
            color: AppColor.colorDarkBlue,
            borderRadius: BorderRadius.all(Radius.circular(26))),
        child: Center(
          child: Text(
            "Submit",
            style: TextStyles.mediumWhite16(),
          ),
        ),
      ),
    );
  }

  Widget _buildSkipText() {
    return GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(Common.IS_LOGIN, true);
        Navigator.pushNamedAndRemoveUntil(
          context,
          Common.homeScreenMain,
          (Route<dynamic> route) => false,
        );
      },
      child: Text(
        "Skip",
        style: TextStyles.mediumColorDarkBlue14(),
      ),
    );
  }

  void _showSuccessBottomSheet() {
    showCupertinoModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        builder: (context) {
          return SizedBox(
            height: 0.4.sh,
            child: AuthSuccessBottomSheet(onContinueClick: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool(Common.IS_LOGIN, true);
              Navigator.pushNamedAndRemoveUntil(
                context,
                Common.homeScreenMain,
                (Route<dynamic> route) => false,
              );
            }),
          );
        },
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))));
  }
}
