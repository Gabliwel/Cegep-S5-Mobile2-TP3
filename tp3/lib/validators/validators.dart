import 'package:easy_localization/easy_localization.dart';
import 'package:tp3/generated/locale_keys.g.dart';

class Validators {
  static const int passwordMinLen = 5;

  static String? validateBasicField(String? value) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.login_user_not_empty);
    }

    return null;
  }

  // https://stackoverflow.com/questions/16800540/how-should-i-check-if-the-input-is-an-email-address-in-flutter
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.login_user_not_empty);
    } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return tr(LocaleKeys.login_user_email_invalid);
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.login_user_not_empty);
    } else if (value.length < passwordMinLen) {
      return tr(LocaleKeys.login_user_password_short);
    }
    return null;
  }
}

//mdp 5 charact min
//email doit etre valide
