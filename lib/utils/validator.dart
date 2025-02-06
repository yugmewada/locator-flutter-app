import 'package:bidout_app/generated/l10n.dart';
import 'package:form_field_validator/form_field_validator.dart';

final MultiValidator nameValidator = MultiValidator([
  RequiredValidator(errorText: S.current.kEnterYourName),
  MinLengthValidator(2, errorText: S.current.kEnterValidName),
]);
final MultiValidator emailValidator = MultiValidator([
  RequiredValidator(errorText: S.current.kEnterEmailAddress),
  PatternValidator('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\$',
      errorText: S.current.kEnterValidEmailAddress),
  EmailValidator(errorText: S.current.kEnterValidEmailAddress),
]);
final MultiValidator mobileValidator = MultiValidator([
  RequiredValidator(errorText: S.current.kEnterMobileNumber),
  MinLengthValidator(8, errorText: S.current.kEnterValidMobileNumber),
]);
final MultiValidator mobileCodeValidator = MultiValidator([
  RequiredValidator(errorText: S.current.kEnterCountryCode),
]);
final MultiValidator passwordValidator = MultiValidator([
  RequiredValidator(errorText: S.current.kEnterPassword),
  MinLengthValidator(8, errorText: S.current.kEnterValidPassword),
]);
final MultiValidator confPasswordValidator = MultiValidator([
  RequiredValidator(errorText: S.current.kEnterPassword),
  MinLengthValidator(8, errorText: S.current.kEnterValidPassword),
]);
final MultiValidator newPasswordValidator = MultiValidator([
  RequiredValidator(errorText: S.current.kEnterNewPassword),
  MinLengthValidator(8, errorText: S.current.kEnterValidPassword),
]);

final MultiValidator firstNameValidator = MultiValidator([
  RequiredValidator(errorText: S.current.kEnterFirstName),
  MinLengthValidator(2, errorText: S.current.kEnterValidFirstName)
]);
final MultiValidator lastNameValidator = MultiValidator([
  RequiredValidator(errorText: S.current.kEnterLastName),
]);
final MultiValidator otpValidator = MultiValidator([
  RequiredValidator(errorText: S.current.kPleaseEnterOtp),
  MinLengthValidator(4, errorText: S.current.kPleaseEnterValidOtp)
]);