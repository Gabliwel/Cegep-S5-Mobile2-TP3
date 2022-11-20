import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/views/login_view.dart';

class AddCommentModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _api = locator<ApiService>();

  Future<bool> addComment(String text, String stationSlug) async {
    setBusy(true);

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    //toujours non null, mais pas le choix
    if(token != null) {
      bool success = await _api.addComment(text, stationSlug, token);
      if(success) {
        await _dialogService.showDialog(description: tr(LocaleKeys.comment_success_add));
      } else {
        await _dialogService.showDialog(description: tr(LocaleKeys.comment_failure_add));
      }
      setBusy(false);
      return success;
    } else {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
      setBusy(false);
      return false;
    }
  }
}
