import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/services/authentication_service.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();

  Future login(String email, String password) async {
    setBusy(true);
    try {
      await _authenticationService.login(email, password);
      log(_authenticationService.isUserAuthenticated.toString());
      if (_authenticationService.isUserAuthenticated) {
        await _navigationService.navigateTo(
          Routes.allStationView,
        );
      } else {
        // Todo : afficher le message dans un formulaire
        _dialogService.showDialog(
            description: tr(LocaleKeys.login_user_does_not_exist));
      }
    } catch (e) {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
    } finally {
      setBusy(false);
    }
  }

  void signUp() async {
    await _navigationService.navigateTo(Routes.signUpView);
  }
}
