
import '../domain/entities/password_checker.dart';
import '../presentation/pages/sign_up_screen.dart';

class AuthInputValidator {
  static bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static bool validatePassword(String password) {
    bool passwordIsValid = true;
    if (password.isEmpty) {
      passwordIsValid = false;
      passwordHasMoreThan6Characters.status =
          PasswordCheckerStatus.notFulfilled;
    }
    if (password.length < 6) {
      passwordIsValid = false;
      passwordHasMoreThan6Characters.status =
          PasswordCheckerStatus.notFulfilled;
    } else {
      passwordHasMoreThan6Characters.status = PasswordCheckerStatus.fulfilled;
    }
    if (password.contains(RegExp(r'[a-z]')) == false) {
      passwordIsValid = false;
      passwordContainsLowerLetter.status = PasswordCheckerStatus.notFulfilled;
    } else {
      passwordContainsLowerLetter.status = PasswordCheckerStatus.fulfilled;
    }
    if (password.contains(RegExp(r'[A-Z]')) == false) {
      passwordIsValid = false;
      passwordContainsUpperLetter.status = PasswordCheckerStatus.notFulfilled;
    } else {
      passwordContainsUpperLetter.status = PasswordCheckerStatus.fulfilled;
    }

    if (password.contains(RegExp(r'[0-9]')) == false) {
      passwordIsValid = false;
      passwordContainsNumericDigit.status = PasswordCheckerStatus.notFulfilled;
    } else {
      passwordContainsNumericDigit.status = PasswordCheckerStatus.fulfilled;
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      passwordIsValid = false;
      passwordContainsSpecialCharacter.status =
          PasswordCheckerStatus.notFulfilled;
    } else {
      passwordContainsSpecialCharacter.status = PasswordCheckerStatus.fulfilled;
    }
    //  if isValidPassword made it to this point without being changed to false, then it's still true
    //hence, the password is valid
    return passwordIsValid;
  }

  static bool validatePasswordsAreMatched(String password1, String password2) {
    return password1 == password2;
  }

  static String? validatePasswordAndReturnErrorMessage(String password) {
    if (validatePassword(password) == false) {
      return 'Wrong email or password';
    } else {
      return null;
    }
  }

  static String? validateEmailAndReturnErrorMessage(String password) {
    if (validateEmail(password) == false) {
      return 'Wrong email or password';
    } else {
      return null;
    }
  }
}
