import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/services/authentication_service.dart';
import 'package:tp3/utils/maybe.dart';

import 'authentication_service_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  final _mockApiService = MockApiService();

  setUp(() {
    locator.registerSingleton<ApiService>(_mockApiService);
  });
  tearDown(() {
    locator.unregister<ApiService>();
    reset(_mockApiService);
  });

  group("AuthenticationService - login", () {
    test("Si le login est valide, doit modifier authenticatedUser et mettre isUserAuthenticated a true", () async {
      final mdp = "mdp";
      User user = User(1, "username", "token");
      when(_mockApiService.getUserProfile("username", "mdp")).thenAnswer((realInvocation) =>Future.value(MayBe(user)));
      final _authenticationService = AuthenticationService();

      await _authenticationService.login(user.username, mdp);

      expect(_authenticationService.isUserAuthenticated, isTrue);
      expect(_authenticationService.authenticatedUser, user);
    });
    test("Si le login est invalide, doit mettre isUserAuthenticated a false", () async {
      MayBe<User> maybe = MayBe.empty();
      when(_mockApiService.getUserProfile("username", "mdp")).thenAnswer((realInvocation) =>Future.value(maybe));
      final _authenticationService = AuthenticationService();

      await _authenticationService.login("username", "mdp");

      expect(_authenticationService.isUserAuthenticated, isFalse);
    });
  });

  group("AuthenticationService - signUp", () {
    test("Si le signUp est valide, doit modifier authenticatedUser et mettre isUserAuthenticated a true", () async {
      final email = "email";
      final mdp = "mdp";
      User user = User(1, "username", "token");
      when(_mockApiService.createUserProfile(user.username, email, mdp)).thenAnswer((realInvocation) =>Future.value(MayBe(user)));
      final _authenticationService = AuthenticationService();

      await _authenticationService.signUp(user.username, email, mdp);

      expect(_authenticationService.isUserAuthenticated, isTrue);
      expect(_authenticationService.authenticatedUser, user);
    });

    test("Si le signUp est invalide, doit mettre isUserAuthenticated a false", () async {
      MayBe<User> maybe = MayBe.empty();
      when(_mockApiService.createUserProfile("username", "email", "mdp")).thenAnswer((realInvocation) =>Future.value(maybe));
      final _authenticationService = AuthenticationService();

      await _authenticationService.signUp("username", "email", "mdp");

      expect(_authenticationService.isUserAuthenticated, isFalse);
    });
  });

  group("AuthenticationService - disconnect", () {
    test("Toute deconnection doit modifier authenticatedUser et mettre isUserAuthenticated a false", () async {
      final mdp = "mdp";
      User user = User(1, "username", "token");
      when(_mockApiService.getUserProfile("username", "mdp")).thenAnswer((realInvocation) =>Future.value(MayBe(user)));
      final _authenticationService = AuthenticationService();

      await _authenticationService.login(user.username, mdp);
      expect(_authenticationService.isUserAuthenticated, isTrue);
      
      when(_mockApiService.logoutUser(user)).thenAnswer((realInvocation) =>Future.value(MayBe.empty()));

      await _authenticationService.disconnect();
      expect(_authenticationService.isUserAuthenticated, isFalse);
    });
  });

  group("AuthenticationService - warning", () {
    test("Si un warning est associé au maybe, on peut savoir si il est non null et obtenir sa valeur", () async {
      final warning = "warning";
      User user = User(1, "username", "token");
      MayBe<User> mayBe = MayBe(user);
      mayBe.setWarning(warning);
      when(_mockApiService.getUserProfile("username", "mdp")).thenAnswer((realInvocation) =>Future.value(mayBe));
      final _authenticationService = AuthenticationService();

      await _authenticationService.login(user.username, "mdp");
      expect(_authenticationService.isUserAuthenticated, isTrue);
      expect(_authenticationService.hasWarning(), isTrue);
      expect(_authenticationService.getWarning(), warning);
    });

    test("Si un warning n'est associé au maybe, on peut savoir si il est null et obtenir sa valeur vide", () async {
      User user = User(1, "username", "token");
      MayBe<User> mayBe = MayBe(user);
      when(_mockApiService.getUserProfile("username", "mdp")).thenAnswer((realInvocation) =>Future.value(mayBe));
      final _authenticationService = AuthenticationService();

      await _authenticationService.login(user.username, "mdp");
      expect(_authenticationService.isUserAuthenticated, isTrue);
      expect(_authenticationService.hasWarning(), isFalse);
      expect(_authenticationService.getWarning().isEmpty, isTrue);
    });

    test("Si un warning est associé au maybe, on peut le retirer", () async {
      final warning = "warning";
      User user = User(1, "username", "token");
      MayBe<User> mayBe = MayBe(user);
      mayBe.setWarning(warning);
      when(_mockApiService.getUserProfile("username", "mdp")).thenAnswer((realInvocation) =>Future.value(mayBe));
      final _authenticationService = AuthenticationService();

      await _authenticationService.login(user.username, "mdp");
      expect(_authenticationService.hasWarning(), isTrue);

      _authenticationService..clearWarning();

      expect(_authenticationService.hasWarning(), isFalse);
    });
  });
}