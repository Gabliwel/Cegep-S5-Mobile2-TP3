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
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/utils/constants.dart';
import 'package:tp3/utils/http_detailed_response.dart';
import 'package:tp3/utils/shared_preferences_util.dart';
import 'package:tp3/viewmodels/add_comment_viewmodel.dart';
import 'package:tp3/viewmodels/station_details_viewmodel.dart';
import 'package:tp3/views/login_view.dart';

import 'add_comment_viewmodel_test.mocks.dart';

@GenerateMocks([NavigationService, AuthenticationService, DialogService, ApiService, SharedPreferencesUtils])
void main() {
  final _mockNavigationService = MockNavigationService();
  final _mockAuthenticationService = MockAuthenticationService();
  final _mockDialogService = MockDialogService();
  final _mockApiService = MockApiService();
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
    reset(_mockSharedPrefs);
  });
  
  group("AddCommentModel - addComment", () { 
    test("Si non autorisé, retourne false et retourne au login", () async {
      when(_mockSharedPrefs.getToken()).thenAnswer((_) => Future.value("token"));
      when(_mockApiService.addComment("text", "stationSlug", "token")).thenAnswer((_) => Future.value(HttpDetailedReponse(status: 401, succes: false)));
      when(_mockAuthenticationService.disconnect("token")).thenAnswer((_) => Future.value());
      when(_mockSharedPrefs.removeAll()).thenAnswer((_) => Future.value());

      when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());

      when(_mockNavigationService.replaceWith(any,
              arguments: anyNamed(
                  'arguments'))) 
      .thenAnswer((_) => Future.value());

      final viewModel = AddCommentModel();
      bool result = await viewModel.addComment("text", "stationSlug");

      expect(result, false);

      verify(_mockDialogService.showDialog(
              description: tr(LocaleKeys.app_need_reconnection)))
      .called(1);

      verify(_mockNavigationService.replaceWith(
              Routes.loginView,
              arguments: captureAnyNamed('arguments')))
      .captured
      .single as LoginView;
    });

    test("Si autorisé et succès, retourne true et affiche le succès", () async {
      when(_mockSharedPrefs.getToken()).thenAnswer((_) => Future.value("token"));
      when(_mockApiService.addComment("text", "stationSlug", "token")).thenAnswer((_) => Future.value(HttpDetailedReponse(status: 201, succes: true)));

      when(_mockDialogService.showDialog(description: anyNamed('description')))
      .thenAnswer((_) => Future.value());

      final viewModel = AddCommentModel();
      bool result = await viewModel.addComment("text", "stationSlug");

      expect(result, true);

      verify(_mockDialogService.showDialog(
              description: tr(LocaleKeys.comment_success_add)))
      .called(1);

      verifyNever(_mockNavigationService.replaceWith(any));
    });

    test("Si autorisé et pas de succès, retourne false et affiche un message", () async {
      when(_mockSharedPrefs.getToken()).thenAnswer((_) => Future.value("token"));
      when(_mockApiService.addComment("text", "stationSlug", "token")).thenAnswer((_) => Future.value(HttpDetailedReponse(status: 404, succes: false)));

      when(_mockDialogService.showDialog(description: anyNamed('description')))
      .thenAnswer((_) => Future.value());

      final viewModel = AddCommentModel();
      bool result = await viewModel.addComment("text", "stationSlug");

      expect(result, false);

      verify(_mockDialogService.showDialog(
              description: tr(LocaleKeys.comment_failure_add)))
      .called(1);

      verifyNever(_mockNavigationService.replaceWith(any));
    });
  });
}