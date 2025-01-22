import 'package:flutter/material.dart';

import 'AppColor.dart';

class TextStyles {
  static TextStyle mediumFont() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle mediumWhite() {
    return mediumFont().copyWith(color: AppColor.colorWhite);
  }

  static TextStyle mediumWhite16() {
    return mediumWhite().copyWith(fontSize: 16);
  }

  static TextStyle mediumColorDarkBlue() {
    return mediumFont().copyWith(color: AppColor.colorDarkBlue);
  }

  static TextStyle mediumColorDarkBlue16() {
    return mediumColorDarkBlue().copyWith(fontSize: 16);
  }

  static TextStyle mediumColorWhite16() {
    return mediumWhite16().copyWith(fontSize: 16);
  }

  static TextStyle mediumColorDarkBlue14() {
    return mediumColorDarkBlue().copyWith(fontSize: 14);
  }

  //Bold Font Styles

  static TextStyle boldFont() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle boldColorDarkBlue() {
    return boldFont().copyWith(color: AppColor.colorDarkBlue);
  }

  static TextStyle boldDarkBlue18() {
    return boldColorDarkBlue().copyWith(fontSize: 18);
  }

  static TextStyle boldDarkBlue24() {
    return boldColorDarkBlue().copyWith(fontSize: 24);
  }

  //Normal Font Styles

  static TextStyle normalFont() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle normalFontGrey() {
    return normalFont().copyWith(color: AppColor.colorGrey);
  }

  static TextStyle normalFontGrey2() {
    return normalFont().copyWith(color: AppColor.colorGrey2);
  }

  static TextStyle normalFontGreyHint() {
    return normalFont().copyWith(color: AppColor.colorGreyHint);
  }

  static TextStyle normalFontGrey16() {
    return normalFontGrey().copyWith(fontSize: 16);
  }

  static TextStyle normalFontGrey2_14() {
    return normalFontGrey2().copyWith(fontSize: 14);
  }

  static TextStyle normalFontGreyHint_14() {
    return normalFontGreyHint().copyWith(fontSize: 14);
  }
}
