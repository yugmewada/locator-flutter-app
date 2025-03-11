import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'AppColor.dart';

class TextStyles {
  static TextStyle mediumFont() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle mediumWhite16() {
    return mediumFont()
        .copyWith(color: AppColor.colorWhite)
        .copyWith(fontSize: 16.spMin);
  }

  static TextStyle mediumColorDarkBlue16() {
    return mediumFont()
        .copyWith(color: AppColor.colorDarkBlue)
        .copyWith(fontSize: 16.spMin);
  }

  static TextStyle mediumColorDarkBlue14() {
    return mediumFont()
        .copyWith(color: AppColor.colorDarkBlue)
        .copyWith(fontSize: 14.spMin);
  }

  static TextStyle mediumColorWhite16() {
    return mediumFont()
        .copyWith(color: AppColor.colorWhite)
        .copyWith(fontSize: 16.spMin);
  }

  //Bold Font Styles

  static TextStyle boldFont() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle boldDarkBlue18() {
    return boldFont()
        .copyWith(color: AppColor.colorDarkBlue)
        .copyWith(fontSize: 18.spMin);
  }

  static TextStyle boldDarkBlue24() {
    return boldFont()
        .copyWith(color: AppColor.colorDarkBlue)
        .copyWith(fontSize: 24.spMin);
  }

  static TextStyle boldDarkBlue14() {
    return boldFont()
        .copyWith(color: AppColor.colorDarkBlue)
        .copyWith(fontSize: 14.spMin);
  }

  //Normal Font Styles

  static TextStyle normalFont() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle normalFontGrey16() {
    return normalFont()
        .copyWith(color: AppColor.colorGrey)
        .copyWith(fontSize: 16.spMin);
  }

  static TextStyle normalFontGrey14() {
    return normalFont()
        .copyWith(color: AppColor.colorGrey)
        .copyWith(fontSize: 14.spMin);
  }

  static TextStyle normalFontGrey2_14() {
    return normalFont()
        .copyWith(color: AppColor.colorGrey2)
        .copyWith(fontSize: 14.spMin);
  }

  static TextStyle normalFontGreyHint_14() {
    return normalFont()
        .copyWith(color: AppColor.colorGreyHint)
        .copyWith(fontSize: 14.spMin);
  }

  static TextStyle normalFontColorDarkBlue14() {
    return normalFont()
        .copyWith(color: AppColor.colorDarkBlue)
        .copyWith(fontSize: 14.spMin);
  }

//Semibold Font Styles

  static TextStyle semiBoldFont() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle semiBoldColorDarkBlue22() {
    return semiBoldFont()
        .copyWith(color: AppColor.primaryColor)
        .copyWith(fontSize: 22.spMin);
  }

//Extra Font Styles
  static TextStyle extraBoldFont() {
    return const TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle extraBoldFont14() {
    return extraBoldFont()
        .copyWith(color: AppColor.primaryColor)
        .copyWith(fontSize: 14.spMin);
  }
}
