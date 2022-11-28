import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/app/app.router.dart';
import 'package:tp3/generated/locale_keys.g.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/utils/maybe.dart';
import 'package:tp3/utils/shared_preferences_util.dart';
import 'package:tp3/viewmodels/login_viewmodel.dart';
import 'package:tp3/views/sign_up_view.dart';
import 'package:tp3/views/welcome_view.dart';

import 'login_viewmodel_test.mocks.dart';

// dart run build_runner build

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
  
  group("LoginViewModel - login", () {
    test("Si l'utilisateur est valide, navigue a la page suivante et sauveguarde le token", () async {
      User user = User(1, "username", "token");
      when(_mockAuthenticationService.login("email", "password")).thenAnswer((_) => Future.value());
      when(_mockAuthenticationService.isUserAuthenticated).thenReturn(true);
      when(_mockAuthenticationService.authenticatedUser).thenReturn(user);
      when(_mockNavigationService.replaceWith(any,
          arguments: anyNamed(
          'arguments')))
      .thenAnswer((_) => Future.value());

      final loginViewModel = LoginViewModel();

      await loginViewModel.login("email", "password");

      final arguments = verify(_mockNavigationService.replaceWith(
              Routes.welcomeView,
              arguments: captureAnyNamed('arguments')))
          .captured
          .single as WelcomeView;
      verify(_mockSharedPrefs.setToken("token"));
      verify(_mockSharedPrefs.setExpiration(any));
    });

    test("Si l'utilisateur est invalide, affiche un message et ne change pas de page", () async {
      when(_mockAuthenticationService.login("email", "password")).thenAnswer((_) => Future.value());
      when(_mockAuthenticationService.isUserAuthenticated).thenReturn(false);
      when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());
      final loginViewModel = LoginViewModel();

      await loginViewModel.login("email", "password");

      verify(_mockDialogService.showDialog(
        description: tr(LocaleKeys.login_user_does_not_exist)))
        .called(1);
      verifyNever(_mockNavigationService.replaceWith(any));
    });

    test("Si l'utilisateur au login cause une erreur, doit afficher un message et ne change pas de page", () async {
      when(_mockAuthenticationService.login("email", "password")).thenThrow(Error());
      when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());
      final loginViewModel = LoginViewModel();

      await loginViewModel.login("email", "password");

      verify(_mockDialogService.showDialog(
        description: tr(LocaleKeys.app_error)))
        .called(1);
      verifyNever(_mockNavigationService.replaceWith(any));
    });
  });
  group("LoginViewModel - signUp", () {
    test("Si on appel la méthode, on navigue sur la page de création de compte", () async {
      when(_mockNavigationService.navigateTo(any,
          arguments: anyNamed(
          'arguments')))
      .thenAnswer((_) => Future.value());

      final loginViewModel = LoginViewModel();
      loginViewModel.signUp();

      verify(_mockNavigationService.navigateTo(
              Routes.signUpView,
              arguments: captureAnyNamed('arguments')))
          .captured
          .single as SignUpView;
    });
  });

  group("LoginViewModel - signUp", () {
    test("Si on appel la méthode, on navigue sur la page de création de compte", () async {
      when(_mockNavigationService.navigateTo(any,
          arguments: anyNamed(
          'arguments')))
      .thenAnswer((_) => Future.value());

      final loginViewModel = LoginViewModel();
      loginViewModel.signUp();

      verify(_mockNavigationService.navigateTo(
              Routes.signUpView,
              arguments: captureAnyNamed('arguments')))
          .captured
          .single as SignUpView;
    });
  });

  group("LoginViewModel - rememberMeLogin", () {
    test("Si un token n'est pas présent, ne fait rien", () async {
      when(_mockSharedPrefs.getToken()).thenAnswer((_) => Future.value(null));
      when(_mockSharedPrefs.getExpiration()).thenAnswer((_) => Future.value(null));

      final loginViewModel = LoginViewModel();
      loginViewModel.rememberMeLogin();

      verifyNever(_mockNavigationService.navigateTo(any));
    });

    test("Si un token est présent, mais non valide, affiche un message", () async {
      when(_mockSharedPrefs.getToken()).thenAnswer((_) => Future.value("token"));
      when(_mockSharedPrefs.getExpiration()).thenAnswer((_) => Future.value(1));
      when(_mockDialogService.showDialog(description: anyNamed('description')))
          .thenAnswer((_) => Future.value());

      final loginViewModel = LoginViewModel();
      await loginViewModel.rememberMeLogin();

      verify(_mockDialogService.showDialog(
        description: tr(LocaleKeys.login_expire_connexion)))
        .called(1);
      verifyNever(_mockNavigationService.navigateTo(any));
    });

    test("Si un token est présent, et valide, change de page pour l'accueil", () async {
      int time = DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch;
      when(_mockSharedPrefs.getToken()).thenAnswer((_) => Future.value("token"));
      when(_mockSharedPrefs.getExpiration()).thenAnswer((_) => Future.value(time));
      when(_mockNavigationService.replaceWith(any,
          arguments: anyNamed(
          'arguments')))
      .thenAnswer((_) => Future.value());

      final loginViewModel = LoginViewModel();
      await loginViewModel.rememberMeLogin();

      verify(_mockNavigationService.replaceWith(
              Routes.welcomeView,
              arguments: captureAnyNamed('arguments')))
          .captured
          .single as WelcomeView;
    });
  });
}