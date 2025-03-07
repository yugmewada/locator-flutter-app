import 'package:form_field_validator/form_field_validator.dart';

final MultiValidator nameValidator = MultiValidator([
  RequiredValidator(errorText: "Please enter your name"),
  MinLengthValidator(2, errorText: "Please enter valid name"),
]);

final MultiValidator emailValidator = MultiValidator([
  RequiredValidator(errorText: "Please enter email address"),
  PatternValidator('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+\$',
      errorText: "Please enter valid email address"),
  EmailValidator(errorText: "Please enter valid email address"),
]);

final MultiValidator mobileValidator = MultiValidator([
  RequiredValidator(errorText: "Please enter mobile number"),
  MinLengthValidator(8, errorText: "Please enter valid mobile number"),
]);

final MultiValidator passwordValidator = MultiValidator([
  RequiredValidator(errorText: "Please enter password"),
  MinLengthValidator(8, errorText: "Please enter valid password"),
]);
final MultiValidator confPasswordEmptyValidator = MultiValidator([
  RequiredValidator(errorText: "Please enter confirm password"),
]);

final MatchValidator confirmPasswordMatchValidator =
    MatchValidator(errorText: "Password mismatch");

final MultiValidator newPasswordValidator = MultiValidator([
  RequiredValidator(errorText: "Please enter new password"),
  MinLengthValidator(8, errorText: "Please enter valid new password"),
]);

final MultiValidator firstNameValidator = MultiValidator([
  RequiredValidator(errorText: "Please enter first name"),
  MinLengthValidator(2, errorText: "Please enter valid first name")
]);
final MultiValidator lastNameValidator = MultiValidator([
  RequiredValidator(errorText: "Please enter last name"),
  MinLengthValidator(2, errorText: "Please enter valid last name")
]);
final MultiValidator otpValidator = MultiValidator([
  RequiredValidator(errorText: "Please enter Otp"),
  MinLengthValidator(4, errorText: "Please enter valid Otp")
]);