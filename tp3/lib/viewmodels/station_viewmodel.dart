import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/services/api_service.dart';

import '../app/app.router.dart';
import '../models/station.dart';


class StationsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _api_service = locator<ApiService>();
  final _dialogService = locator<DialogService>();
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
    await _navigationService.navigateTo(Routes.commentsView, arguments: CommentsViewArguments(slugName: stationSlug));
  }
}
