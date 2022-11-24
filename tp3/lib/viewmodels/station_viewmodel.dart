import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/utils/shared_preferences_util.dart';
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
  final _sharedPref = locator<SharedPreferencesUtils>();
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

  Future sendToDetailPage(Station stationSlug) async {
    await _navigationService.navigateTo(Routes.stationDetailsView, arguments: StationDetailsViewArguments(stationInfo: stationSlug))?.then((value) => fetchAllStation());
  }

  void disconnect() async {
    String? token = await _sharedPref.getToken();

    if(token != null) {
      _authenticationService.disconnect();

      _sharedPref.removeAll();
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
    )?.then((value) => fetchAllStation());
  }

  void goToWelcome() async {
    await _navigationService.replaceWith(
      Routes.welcomeView,
      arguments: WelcomeView(),
    );
  }
}
