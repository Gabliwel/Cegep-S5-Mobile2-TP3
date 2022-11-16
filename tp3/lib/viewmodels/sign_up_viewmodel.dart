import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/services/authentication_service.dart';

class SignUpViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();

  Future signUp(String name, String email, String password) async {
    setBusy(true);
    try {
      await _authenticationService.signUp(name, email, password);
      if(_authenticationService.isUserAuthenticated) {
        log("yeeeeeeeeeeeeeeeeeeeah");
      } else {
        await _dialogService.showDialog(description: tr(LocaleKeys.login_cant_create_user));
      }
    } catch (e) {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
    } finally {
      setBusy(false);
    }
  }
}
