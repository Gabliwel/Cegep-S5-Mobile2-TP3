import 'package:easy_localization/easy_localization.dart';
import 'package:tp3/generated/locale_keys.g.dart';

class Validators {
  static String? validateUser(String? value) {
    if (value == null || value.isEmpty) {
      return tr(LocaleKeys.login_user_not_empty);
    }

    /*var regex = RegExp(r'^[0-9]*$');
    if (!regex.hasMatch(value)) {
      return tr(LocaleKeys.login_user_not_a_number);
    }*/

    return null;
  }
}

//mdp 5 charact min
//email doit etre valide
