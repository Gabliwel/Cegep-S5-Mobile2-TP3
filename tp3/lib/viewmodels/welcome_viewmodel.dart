import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/views/about_view.dart';
import 'package:tp3/views/login_view.dart';
import 'package:tp3/views/stations_view.dart';

class WelcomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _authenticationService = locator<AuthenticationService>();

  void disconnect() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    if(token != null) {
      _authenticationService.disconnect();

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
    }
    await _navigationService.replaceWith(
      Routes.loginView,
      arguments: LoginView(),
    );
  }

  void goToAbout() async {
    await _navigationService.navigateTo(
      Routes.aboutView,
      arguments: AboutView(),
    );
  }

  void goToStations() async {
    await _navigationService.replaceWith(
      Routes.allStationView,
      arguments: AllStationView(),
    );
  }

}
