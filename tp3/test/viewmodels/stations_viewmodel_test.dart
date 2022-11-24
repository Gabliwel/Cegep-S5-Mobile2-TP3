import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/models/station.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/viewmodels/station_viewmodel.dart';
import 'package:tp3/views/about_view.dart';
import 'package:tp3/views/login_view.dart';
import 'package:tp3/views/welcome_view.dart';
import 'package:tp3/utils/shared_preferences_util.dart';

import 'stations_viewmodel_test.mocks.dart';

@GenerateMocks([
  NavigationService,
  AuthenticationService,
  DialogService,
  ApiService,
  Client,
  SharedPreferencesUtils
])
const revolvair = 'https://test.revolvair.org/api';
void main() {
  final _mockNavigationService = MockNavigationService();
  final _mockAuthenticationService = MockAuthenticationService();
  final _mockDialogService = MockDialogService();
  final _mockApiService = MockApiService();
  final _mockClientService = MockClient();
  final _mockSharedPrefs = MockSharedPreferencesUtils();

  locator.registerSingleton<NavigationService>(_mockNavigationService);
  locator.registerSingleton<AuthenticationService>(_mockAuthenticationService);
  locator.registerSingleton<DialogService>(_mockDialogService);
  locator.registerSingleton<ApiService>(_mockApiService);
  locator.registerSingleton<Client>(_mockClientService);
  locator.registerSingleton<SharedPreferencesUtils>(_mockSharedPrefs);

  tearDown(() {
    reset(_mockNavigationService);
    reset(_mockAuthenticationService);
    reset(_mockDialogService);
    reset(_mockApiService);
    reset(_mockClientService);
    reset(_mockSharedPrefs);
  });
  group('StationsViewModel - fetchAllStation ', () {
    test('fetchAllStation devrait lancer une erreur ainsi que mettre un message d\'erreur', () async {
    when(_mockApiService.fetchActiveStation()).thenThrow(Error());
      when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());
      final stationViewModel = StationsViewModel();

      await stationViewModel.fetchAllStation();

      verify(_mockDialogService.showDialog(
              description: tr(LocaleKeys.app_error)))
          .called(1);
    });

    test('fetchAllStation appelle bien la méthode fetchActiveStation', () async {
    when(_mockApiService.fetchActiveStation()).thenAnswer((realInvocation) => Future.value());
      when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());
      final stationViewModel = StationsViewModel();

      await stationViewModel.fetchAllStation();

      verify(_mockDialogService.showDialog(
              description: tr(LocaleKeys.app_error)))
          .called(1);
        verify(_mockApiService.fetchActiveStation()).called(1);
    });
});
   group("StationsViewModel - sendToDetailPage ", () {
     test(
        "Envoie sur la page de détail de la station en question.",
        () async {
      Station station = Station(commentNumber: 2,description: "", name: "", ownerId: 2,slugID: 3,slugName: "test");
      when(_mockNavigationService.navigateTo(any,
              arguments: anyNamed(
                  'arguments'))) 
          .thenAnswer((_) => Future.value());
          when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());
      final StationViewModel = StationsViewModel();

      await StationViewModel.sendToDetailPage(station);

      final arguments = verify(_mockNavigationService.navigateTo(
              Routes.stationDetailsView,
              arguments: captureAnyNamed('arguments')))
          .captured
          .single as StationDetailsViewArguments;
      expect(arguments.stationInfo, station);
    });
  });
   group("StationsViewModel - goToAbout ", () {
    test(
        "Envoie sur la page du à propos",
        () async {
      when(_mockNavigationService.navigateTo(any,
              arguments: anyNamed(
                  'arguments'))) 
          .thenAnswer((_) => Future.value());
          when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());
      final StationViewModel = StationsViewModel();

       StationViewModel.goToAbout();

      verify(_mockNavigationService.navigateTo(
              Routes.aboutView,
              arguments: captureAnyNamed('arguments')))
          .captured
          .single as AboutView;
    });
  });
   group("StationsViewModel - goToWelcome ", () {
    test(
        "Envoie sur la page d'accueil",
        () async {
      when(_mockNavigationService.replaceWith(any,
              arguments: anyNamed(
                  'arguments'))) 
          .thenAnswer((_) => Future.value());
          when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());
      final StationViewModel = StationsViewModel();

       StationViewModel.goToWelcome();

      verify(_mockNavigationService.replaceWith(
              Routes.welcomeView,
              arguments: captureAnyNamed('arguments')))
          .captured
          .single as WelcomeView;
    });
  });


  
}