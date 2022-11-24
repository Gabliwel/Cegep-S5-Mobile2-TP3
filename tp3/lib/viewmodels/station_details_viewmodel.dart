import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/models/comment.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/views/about_view.dart';
import 'package:tp3/views/login_view.dart';
import 'package:tp3/views/welcome_view.dart';
import 'package:tp3/utils/constants.dart';

import '../app/app.router.dart';

class StationDetailsViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _api_service = locator<ApiService>();
  final _dialogService = locator<DialogService>();
  final _authenticationService = locator<AuthenticationService>();
  String pm25Average = "";
  List<Comment> commentList = List.empty(growable: true);
  int commentNumber = -1;

 
  Future getPM25MonthAverage(String stationSlug)async {
    setBusy(true);
    try {
      pm25Average  = await _api_service.getPM25Raw(stationSlug);
      if(pm25Average == ""){
        pm25Average = NO_MEASURE_FOR_LAST_MONTH;
      }
    } catch (e) {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
    } finally {
      setBusy(false);
    }
  }

  Future getCommentNumber(String stationSlug)async {
    setBusy(true);
    try {
      commentNumber = -1;
      commentList  = await _api_service.getCommentsForSlug(stationSlug);
      commentNumber = commentList.length;
    } catch (e) {
      await _dialogService.showDialog(description: tr(LocaleKeys.app_error));
    } finally {
      setBusy(false);
    }
  }

  Color getStationColor(pm25AverageParam){
    Color color = const Color.fromARGB(255, 50, 195, 65);
    if(int.parse(pm25AverageParam) >= 0 && int.parse(pm25AverageParam) <= 11){
      color = const Color.fromARGB(255, 50, 195, 65);
    }else if(int.parse(pm25AverageParam) >= 12 && int.parse(pm25AverageParam) <= 34){
      color = const Color.fromARGB(255, 233, 241, 19);
    }else if(int.parse(pm25AverageParam) >= 35 && int.parse(pm25AverageParam) <= 54){
      color = const Color.fromARGB(255, 235, 191, 47);
    }else if(int.parse(pm25AverageParam) >= 55 && int.parse(pm25AverageParam) <= 149){
      color = const Color.fromARGB(255, 247, 156, 37);
    }else if(int.parse(pm25AverageParam) >= 150 && int.parse(pm25AverageParam) <= 249){
      color = const Color.fromARGB(255, 128, 30, 85);
    }else if(int.parse(pm25AverageParam) >= 250 && int.parse(pm25AverageParam) <= 349){
      color = const Color.fromARGB(255, 106, 23, 70);
    }else if(int.parse(pm25AverageParam) >= 350 && int.parse(pm25AverageParam) <= 449){
      color = const Color.fromARGB(255, 68, 15, 45);
    }else if(int.parse(pm25AverageParam) >= 500){
      color = const Color.fromARGB(255, 45, 11, 30);
    }
    return color;
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
    await _navigationService.navigateTo(Routes.commentsView, arguments: CommentsViewArguments(slugName: stationSlug))?.then((value) => getCommentNumber(stationSlug));
  }
}
