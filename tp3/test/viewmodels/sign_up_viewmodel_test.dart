import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/utils/shared_preferences_util.dart';
import 'package:tp3/viewmodels/sign_up_viewmodel.dart';
import 'package:tp3/views/welcome_view.dart';

import 'sign_up_viewmodel_test.mocks.dart';

@GenerateMocks([NavigationService, AuthenticationService, DialogService, SharedPreferencesUtils])
void main() {
  final _mockNavigationService = MockNavigationService();
  final _mockAuthenticationService = MockAuthenticationService();
  final _mockDialogService = MockDialogService();
  final _mockSharedPrefs = MockSharedPreferencesUtils();

  locator.registerSingleton<NavigationService>(_mockNavigationService);
  locator.registerSingleton<AuthenticationService>(_mockAuthenticationService);
  locator.registerSingleton<DialogService>(_mockDialogService);
  locator.registerSingleton<SharedPreferencesUtils>(_mockSharedPrefs);

  tearDown(() {
    reset(_mockNavigationService);
    reset(_mockAuthenticationService);
    reset(_mockDialogService);
    reset(_mockSharedPrefs);
  });
  group("SignUpModel - signUp", () {
    test("Si la création est valide, navigue a la page suivante et sauveguarde le token", () async {
      User user = User(1, "username", "token");
      when(_mockAuthenticationService.signUp("name", "email", "password")).thenAnswer((_) => Future.value());
      when(_mockAuthenticationService.isUserAuthenticated).thenReturn(true);
      when(_mockAuthenticationService.authenticatedUser).thenReturn(user);
      when(_mockNavigationService.replaceWith(any,
          arguments: anyNamed(
          'arguments')))
      .thenAnswer((_) => Future.value());

      final viewModel = SignUpViewModel();

      await viewModel.signUp("name", "email", "password");

      final arguments = verify(_mockNavigationService.replaceWith(
              Routes.welcomeView,
              arguments: captureAnyNamed('arguments')))
          .captured
          .single as WelcomeView;
      verify(_mockSharedPrefs.setToken("token"));
      verify(_mockSharedPrefs.setExpiration(any));
    });

    test("Si la création est invalide sans warning, navigue pas a la page suivante et affiche une erreur", () async {
      when(_mockAuthenticationService.signUp("name", "email", "password")).thenAnswer((_) => Future.value());
      when(_mockAuthenticationService.isUserAuthenticated).thenReturn(false);
      when(_mockAuthenticationService.hasWarning()).thenReturn(false);
      when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());

      final viewModel = SignUpViewModel();

      await viewModel.signUp("name", "email", "password");

      verify(_mockDialogService.showDialog(
        description: tr(LocaleKeys.login_cant_create_user)))
        .called(1);
      verifyNever(_mockNavigationService.replaceWith(any));
    });

    test("Si la création est invalide avec warning, navigue pas a la page suivante et affiche le warning", () async {
      User user = User(1, "username", "token");
      when(_mockAuthenticationService.signUp("name", "email", "password")).thenAnswer((_) => Future.value());
      when(_mockAuthenticationService.isUserAuthenticated).thenReturn(false);
      when(_mockAuthenticationService.hasWarning()).thenReturn(true);
      when(_mockAuthenticationService.getWarning()).thenReturn("warning");
      when(_mockDialogService.showDialog(description: "warning"))
          .thenAnswer((_) => Future.value());

      final viewModel = SignUpViewModel();

      await viewModel.signUp("name", "email", "password");

      verify(_mockDialogService.showDialog(
        description: "warning"))
        .called(1);
      verifyNever(_mockNavigationService.replaceWith(any));
    });

    test("Si la création cause une erreur, navigue pas a la page suivante et un message d'erreur", () async {
      when(_mockAuthenticationService.signUp("name", "email", "password")).thenThrow(Error());
      when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());

      final viewModel = SignUpViewModel();

      await viewModel.signUp("name", "email", "password");

      verify(_mockDialogService.showDialog(
        description: tr(LocaleKeys.app_error)))
        .called(1);
      verifyNever(_mockNavigationService.replaceWith(any));
    });
  });
}