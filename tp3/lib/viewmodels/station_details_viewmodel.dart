import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/models/comment.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/utils/shared_preferences_util.dart';
import 'package:tp3/views/about_view.dart';
import 'package:tp3/views/login_view.dart';
import 'package:tp3/views/welcome_view.dart';
import 'package:tp3/utils/constants.dart';

import '../app/app.router.dart';
import '../models/station.dart';


class StationDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _api_service = locator<ApiService>();
  final _dialogService = locator<DialogService>();
  final _authenticationService = locator<AuthenticationService>();
  final _sharedPref = locator<SharedPreferencesUtils>();
  String pm25Average = "";
  List<Comment> commentList = List.empty(growable: true);
  int commentNumber = -1;

 
  Future getPM25MonthAverage(String stationSlug)async {
    try {
      pm25Average  = await _api_service.getPM25Raw(stationSlug);
      if(pm25Average == ""){
        pm25Average = NO_MEASURE_FOR_LAST_MONTH;
      }
    } catch (e) {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
    }
  }

  Future getCommentNumber(String stationSlug)async {
    try {
      commentNumber = -1;
      commentList  = await _api_service.getCommentsForSlug(stationSlug);
      commentNumber = commentList.length;
    } catch (e) {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
    }
  }

  Future sendToCommentPage(String stationSlug) async {
    await _navigationService.navigateTo(Routes.commentsView, arguments: CommentsViewArguments(slugName: stationSlug))?.then((value) => refesh(stationSlug));
  }

  refesh(String slugName) async {
    setBusy(true);
    await getCommentNumber(slugName);
    await getPM25MonthAverage(slugName);
    setBusy(false);
  }
}
