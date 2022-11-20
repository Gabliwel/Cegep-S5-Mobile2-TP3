import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/viewmodels/welcome_viewmodel.dart';
import 'package:tp3/views/stations_view.dart';
import 'package:tp3/views/welcome_view.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();

  bool rememberMeLoginAction = false;

  Future login(String email, String password) async {
    setBusy(true);
    try {
      await _authenticationService.login(email, password);
      log(_authenticationService.isUserAuthenticated.toString());
      if (_authenticationService.isUserAuthenticated) {
        log(_authenticationService.authenticatedUser.token);
        SharedPreferences.getInstance().then((prefs) { 
          prefs.setString('token', _authenticationService.authenticatedUser.token);
        });
        log("done");
        await _navigationService.replaceWith(
          Routes.welcomeView,
          arguments: WelcomeView(),
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

  void rememberMeLogin() async {
    setBusyRememberLogin(true);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    if(token != null) {
      log("token: $token");
      //voir avec le prof
      //_authenticationService.tokenLogin(token);
      /*if(_authenticationService.isUserAuthenticated) {
        await _navigationService.replaceWith(
          Routes.welcomeView,
          arguments: WelcomeViewArguments(user: _authenticationService.authenticatedUser),
        );
      }*/

      // pas de moyen de test le token????
      await _navigationService.replaceWith(
        Routes.welcomeView,
        arguments: WelcomeView(),
      );
    }

    setBusyRememberLogin(false);
  }
  
  void setBusyRememberLogin(value) {
    rememberMeLoginAction = value;
    notifyListeners();
  }
}
