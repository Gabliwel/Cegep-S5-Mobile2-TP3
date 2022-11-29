import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/utils/http_detailed_response.dart';
import 'package:tp3/utils/shared_preferences_util.dart';
import 'package:tp3/views/login_view.dart';

class AddCommentModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _api = locator<ApiService>();
  final _authenticationService = locator<AuthenticationService>();
  final _sharedPref = locator<SharedPreferencesUtils>();

  Future<bool> addComment(String text, String stationSlug) async {
    setBusy(true);

    String? token = await _sharedPref.getToken();

    //toujours non null, mais pas le choix
    if(token != null) {
      HttpDetailedReponse reponse = await _api.addComment(text, stationSlug, token);

      if(!reponse.isAuthorize()) {
        _authenticationService.disconnect(token);
        _sharedPref.removeAll();
        
        await _dialogService.showDialog(description: tr(LocaleKeys.app_need_reconnection));
        await _navigationService.replaceWith(
          Routes.loginView,
          arguments: LoginView(),
        );
        return false;
      }

      if(reponse.succes) {
        await _dialogService.showDialog(description: tr(LocaleKeys.comment_success_add));
      } else {
        await _dialogService.showDialog(description: tr(LocaleKeys.comment_failure_add));
      }
      setBusy(false);
      return reponse.succes;
    } else {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
      setBusy(false);
      return false;
    }
  }
}
