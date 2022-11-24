import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/utils/shared_preferences_util.dart';
import 'package:tp3/views/welcome_view.dart';

class SignUpViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();
  final _sharedPref = locator<SharedPreferencesUtils>();

  Future signUp(String name, String email, String password) async {
    setBusy(true);
    try {
      await _authenticationService.signUp(name, email, password);
      if(_authenticationService.isUserAuthenticated) {
        _sharedPref.setToken(_authenticationService.authenticatedUser.token);
        DateTime now = DateTime.now().add(const Duration(days: 3));
        _sharedPref.setExpiration(now.millisecondsSinceEpoch);
        await _navigationService.replaceWith(
          Routes.welcomeView,
          arguments: WelcomeView(),
        );
      } else {
        if(_authenticationService.hasWarning()) {
          await _dialogService.showDialog(description: _authenticationService.getWarning());
          _authenticationService.clearWarning();
        } else {
          await _dialogService.showDialog(description: tr(LocaleKeys.login_cant_create_user));
        }
      }
    } catch (e) {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
    } finally {
      setBusy(false);
    }
  }
}
