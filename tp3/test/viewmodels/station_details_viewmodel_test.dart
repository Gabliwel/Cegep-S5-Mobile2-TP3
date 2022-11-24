import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/utils/shared_preferences_util.dart';
import 'package:tp3/viewmodels/station_details_viewmodel.dart';
import 'package:tp3/views/station_details_view.dart';

import '../services/api_service_test.mocks.dart';
import '../services/authentication_service_test.mocks.dart';
import 'login_viewmodel_test.mocks.dart';

@GenerateMocks([
  NavigationService,
  AuthenticationService,
  DialogService,
  ApiService,
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
  locator.registerSingleton<SharedPreferencesUtils>(_mockSharedPrefs);

  tearDown(() {
    reset(_mockNavigationService);
    reset(_mockAuthenticationService);
    reset(_mockDialogService);
    reset(_mockApiService);
    reset(_mockClientService);
    reset(_mockSharedPrefs);
  });
   StationDetailsViewModel viewModel =StationDetailsViewModel();
  group("StationsViewModel - getStationColor ", () {
    test("Retourne la la couleur verte si la condition est remplie",() {
      expect(viewModel.getStationColor("2"), const Color.fromARGB(255, 50, 195, 65));
    }); 
    test("Retourne la la couleur jaune si la condition est remplie",() {
      expect(viewModel.getStationColor("12"), const Color.fromARGB(255, 233, 241, 19));
  }); 
    test("Retourne la la couleur jaune/orange si la condition est remplie",() {
      expect(viewModel.getStationColor("35"), const Color.fromARGB(255, 235, 191, 47));
  }); 
    test("Retourne la la couleur orange si la condition est remplie",() {
      expect(viewModel.getStationColor("55"), const Color.fromARGB(255, 247, 156, 37));
  }); 
    test("Retourne la la couleur rouge/bourgogne si la condition est remplie",() {
      expect(viewModel.getStationColor("150"), const Color.fromARGB(255, 128, 30, 85));
  }); 
    test("Retourne la la couleur bourgogne si la condition est remplie",() {
     expect(viewModel.getStationColor("250"), const Color.fromARGB(255, 106, 23, 70));
  }); 
    test("Retourne la la couleur bourgogne foncé si la condition est remplie",() {
      expect(viewModel.getStationColor("350"), const Color.fromARGB(255, 68, 15, 45));
  }); 
   test("Retourne la la couleur bourgogne très foncé si la condition est remplie",() {
      expect(viewModel.getStationColor("500"), const Color.fromARGB(255, 45, 11, 30));
  }); 
  test("Retourne la la couleur verte si la condition est remplie",() {
      expect(viewModel.getStationColor("-10"), const Color.fromARGB(255, 130, 222, 141));
  }); 
  test("Retourne la la couleur verte si aucune condition n'est remplie",() {
      expect(viewModel.getStationColor("-102"), const Color.fromARGB(255, 50, 195, 65));
  }); 
});
}