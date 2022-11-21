import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/views/about_view.dart';
import 'package:tp3/views/login_view.dart';
import 'package:tp3/views/welcome_view.dart';

import '../app/app.router.dart';
import '../models/station.dart';


class StationsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _api_service = locator<ApiService>();
  final _dialogService = locator<DialogService>();
  final _authenticationService = locator<AuthenticationService>();
  List<Station> stations = [];

  Future fetchAllStation() async {
    setBusy(true);
    try {
      stations  = await _api_service.fetchActiveStation();
    } catch (e) {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
    } finally {
      setBusy(false);
    }
  }

  Future sendToCommentPage(String stationSlug) async {
    await _navigationService.navigateTo(Routes.commentsView, arguments: CommentsViewArguments(slugName: stationSlug))?.then((value) => fetchAllStation());
  }

  void disconnect() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    if(token != null) {
      _authenticationService.disconnect();

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('expiration');
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

  void goToWelcome() async {
    await _navigationService.replaceWith(
      Routes.welcomeView,
      arguments: WelcomeView(),
    );
  }
}
