import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/utils/shared_preferences_util.dart';
import 'package:tp3/views/about_view.dart';
import 'package:tp3/views/login_view.dart';
import 'package:tp3/views/stations_view.dart';

class WelcomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _authenticationService = locator<AuthenticationService>();
  final _sharedPref = locator<SharedPreferencesUtils>();

  void disconnect() async {
    String? token = await _sharedPref.getToken();

    if(token != null) {
      _authenticationService.disconnect(token);

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
    );
  }

  void goToStations() async {
    await _navigationService.replaceWith(
      Routes.allStationView,
      arguments: AllStationView(),
    );
  }

}
