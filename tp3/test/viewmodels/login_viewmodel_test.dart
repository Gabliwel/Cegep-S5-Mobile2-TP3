import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/utils/maybe.dart';

import 'login_viewmodel_test.mocks.dart';

@GenerateMocks([NavigationService, AuthenticationService, DialogService])
void main() {
  final _mockNavigationService = MockNavigationService();
  final _mockAuthenticationService = MockAuthenticationService();
  final _mockDialogService = MockDialogService();

  locator.registerSingleton<NavigationService>(_mockNavigationService);
  locator.registerSingleton<AuthenticationService>(_mockAuthenticationService);
  locator.registerSingleton<DialogService>(_mockDialogService);

  tearDown(() {
    reset(_mockNavigationService);
    reset(_mockAuthenticationService);
    reset(_mockDialogService);
  });
  
  group("LoginViewModel - login", () {
    test("Si l'utilisateur est valide, navigue a la page suivante et sauveguarde le token", () async {
      MayBe<User> user = MayBe(User(1, "username", "token"));
      when(_mockAuthenticationService.login("email", "password")).thenAnswer((realInvocation) => Future.value(user));
    });
  });
}