import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/utils/constants.dart';
import 'package:tp3/viewmodels/station_details_viewmodel.dart';

import 'station_details_viewmodel_test.mocks.dart';



@GenerateMocks([NavigationService, DialogService, ApiService])
void main() {
  final _mockNavigationService = MockNavigationService();
  final _mockDialogService = MockDialogService();
  final _mockApiService = MockApiService();

  locator.registerSingleton<NavigationService>(_mockNavigationService);
  locator.registerSingleton<DialogService>(_mockDialogService);
  locator.registerSingleton<ApiService>(_mockApiService);

  tearDown(() {
    reset(_mockNavigationService);
    reset(_mockDialogService);
    reset(_mockApiService);
  });
  
  group("StationDetailsViewModel - getPM25MonthAverage", () { 
    test("Si le resultat de l'api est non vide et sans erreur, on guarde sa valeur", () async {
      when(_mockApiService.getPM25Raw("stationSlug"))
      .thenAnswer((_) => Future.value("value"));

      final viewModel = StationDetailsViewModel();
      await viewModel.getPM25MonthAverage("stationSlug");
      
      expect(viewModel.pm25Average, "value");
    });

    test("Si le resultat de l'api est vide et sans erreur, on change sa valeur", () async {
      when(_mockApiService.getPM25Raw("stationSlug"))
      .thenAnswer((_) => Future.value(""));

      final viewModel = StationDetailsViewModel();
      await viewModel.getPM25MonthAverage("stationSlug");
      
      expect(viewModel.pm25Average, NO_MEASURE_FOR_LAST_MONTH);
    });

    test("Si le resultat de l'api lance une erreur, on affiche un message", () async {
      when(_mockApiService.getPM25Raw("stationSlug"))
      .thenThrow(Error());

      when(_mockDialogService.showDialog(description: anyNamed('description')))
      .thenAnswer((_) => Future.value());

      final viewModel = StationDetailsViewModel();
      await viewModel.getPM25MonthAverage("stationSlug");
      
      verify(_mockDialogService.showDialog(
              description: tr(LocaleKeys.app_error)))
          .called(1);
    });
  });

  group("StationDetailsViewModel - getCommentNumber", () { 
    test("Si le resultat de l'api est sans erreur, on guarde le compte total", () async {
      when(_mockApiService.getCommentsForSlug("stationSlug"))
      .thenAnswer((_) => Future.value([]));

      final viewModel = StationDetailsViewModel();
      await viewModel.getCommentNumber("stationSlug");
      
      expect(viewModel.commentNumber, 0);
    });

    test("Si le resultat de l'api lance une erreur, on affiche un message", () async {
      when(_mockApiService.getCommentsForSlug("stationSlug"))
      .thenThrow(Error());

      when(_mockDialogService.showDialog(description: anyNamed('description')))
      .thenAnswer((_) => Future.value());

      final viewModel = StationDetailsViewModel();
      await viewModel.getCommentNumber("stationSlug");
      
      verify(_mockDialogService.showDialog(
              description: tr(LocaleKeys.app_error)))
          .called(1);
    });
  });

  group("StationDetailsViewModel - sendToCommentPage", () {
    test("On peut aller à la page de commentaires, et faires les actions nécessaire par la suite ", () async {
      when(_mockNavigationService.navigateTo(any,
              arguments: anyNamed(
                  'arguments'))) 
      .thenAnswer((_) => Future.value());

      //message afficher au retour dans la methode refesh
      when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());

      final viewModel = StationDetailsViewModel();
      await viewModel.sendToCommentPage("stationSlug");
      
      verify(_mockNavigationService.navigateTo(
              Routes.commentsView,
              arguments: captureAnyNamed('arguments')))
          .captured
          .single as CommentsViewArguments;
    });

  });
}