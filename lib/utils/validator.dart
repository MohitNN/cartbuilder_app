import 'app_strings.dart';

class FieldValidator {
  static String validateEmail(String value) {
    if (value.isEmpty) return AppString.emailRequired;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value.trim())) {
      return AppString.enterValidEmail;
    }

    return null;
  }

  /// Password matching expression. Password must be at least 4 characters,
  /// no more than 8 characters, and must include at least one upper case letter,
  /// one lower case letter, and one numeric digit.
  static String validatePassword1(String value) {
    if (value.isEmpty) return AppString.enterPassword;

    Pattern pattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{4,8}$';

    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value.trim())) {
      return AppString.enterValidPassword;
    }

    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is Required";
    } else if (value.length < 8) {
      return "Password Must Minimum 8 Characters";
//    } else if (!regExp.hasMatch(value)) {
//      return "Password at least one uppercase letter, one lowercase letter and one number";
    }
    return null;
  }

  static String validateOriginalPrice(String value, String subVal) {
    if (value.isEmpty) {
      return "Original Price is Required";
    } else if (int.parse(value) < int.parse(subVal)) {
      return "Original Price must be grater then Order Form Price";
//    } else if (!regExp.hasMatch(value)) {
//      return "Password at least one uppercase letter, one lowercase letter and one number";
    }
    return null;
  }

  static String validateConfirmPassword(String value1, String value2) {
    if (value1.isEmpty) {
      return "Password is Required";
    } else if (value1.length < 8) {
      return "Password Must Minimum 8 Characters";
    } else if (value1.toString() != value2.toString()) {
      return AppString.confirmPwdNotMatch;
    }
    return null;
  }

  static String validateValueIsEmpty(String value) {
    if (value.isEmpty) {
      return "Required";
    }
    return null;
  }

  static String validateOtp(String value) {
    if (value.isEmpty) {
      return "OTP must have 6 digits";
    } else if (value.length != 6) {
      return "OTP must have 6 digits";
    }

    return null;
  }

  static String validatePhone(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return "Phone number is Required";
    } else if (value.length != 10) {
      return "Phone must minimum ten characters";
//    } else if (!regExp.hasMatch(value)) {
//      return "Password at least one uppercase letter, one lowercase letter and one number";
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
