import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/utils/shared_preferences_util.dart';
import 'package:tp3/views/welcome_view.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();
  final _sharedPref = locator<SharedPreferencesUtils>();

  bool rememberMeLoginAction = false;

  Future login(String email, String password) async {
    setBusy(true);
    try {
      await _authenticationService.login(email, password);
      log(_authenticationService.isUserAuthenticated.toString());
      if (_authenticationService.isUserAuthenticated) {
        log(_authenticationService.authenticatedUser.token);
        DateTime now = DateTime.now().add(const Duration(days: 3));
        _sharedPref.setToken(_authenticationService.authenticatedUser.token);
        _sharedPref.setExpiration(now.millisecondsSinceEpoch);
        await _navigationService.replaceWith(
          Routes.welcomeView,
          arguments: WelcomeView(),
        );
      } else {
        _dialogService.showDialog(description: tr(LocaleKeys.login_user_does_not_exist));
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

  void rememberMeLogin() async {
    setBusyRememberLogin(true);

    String? token = await _sharedPref.getToken();
    int? expiration = await _sharedPref.getExpiration();

    if(token != null && expiration != null) {
      log(token);
      log(expiration.toString());
      if(DateTime.now().millisecondsSinceEpoch < expiration) {
        await _navigationService.replaceWith(
          Routes.welcomeView,
          arguments: WelcomeView(),
        );
      } /* else {
        await _dialogService.showDialog(description: tr(LocaleKeys.login_expire_connexion));
      } */
    }

    setBusyRememberLogin(false);
  }
  
  void setBusyRememberLogin(value) {
    rememberMeLoginAction = value;
    notifyListeners();
  }
}
