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


class StationDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _api_service = locator<ApiService>();
  final _dialogService = locator<DialogService>();
  final _authenticationService = locator<AuthenticationService>();
  String pm25Average = "";

 
  Future getPM25MonthAverage(String stationSlug)async {
    setBusy(true);
    try {
      pm25Average  = await _api_service.getPM25Raw(stationSlug);
    } catch (e) {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
    } finally {
      setBusy(false);
    }
  }

  void goToAbout() async {
    await _navigationService.navigateTo(
      Routes.aboutView,
      arguments: const AboutView(),
    );
  }

  void goToWelcome() async {
    await _navigationService.replaceWith(
      Routes.welcomeView,
      arguments: const WelcomeView(),
    );
  }

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
      arguments: const LoginView(),
    );
  }

  Future sendToCommentPage(String stationSlug) async {
    await _navigationService.navigateTo(Routes.commentsView, arguments: CommentsViewArguments(slugName: stationSlug));
  }
}
