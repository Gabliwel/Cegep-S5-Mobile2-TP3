import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/utils/maybe.dart';

import 'api_service_test.mocks.dart';


// https://staging.revolvair.org/documentation/?url=https://staging.revolvair.org/documentation/api-docs.json#/
const revolvair = 'https://test.revolvair.org/api';

@GenerateMocks([http.Client])
void main() {
  final _mockClientService = MockClient();
  locator.registerSingleton<http.Client>(_mockClientService);

  tearDown(() {
    reset(_mockClientService);
  });

  group("ApiService - getUserProfile", () {
    test("lorsque le login fonctionne, doit retourner l'utilisateur ave son token.", () async {
      const String email = "valid@email.com";
      const String password = "validPassword";
      when(_mockClientService.post(
        Uri.parse('$revolvair/login'), 
        body: json.encode({"email": email, "password": password}), 
        headers: {
          'Content-type' : 'application/json', 
          'Accept': 'application/json',
        }
      )).thenAnswer((_) async =>
        http.Response('{"token": "token123", "id": 2, "role": "user", "username": "username123", "firstname": null, "lastname": null, "score": 0, "avatar": "https://s3.amazonaws.com/debut-ca/avatar/2.jpg", "profile": {}}', 200)
      );
      final apiService = ApiService();

      MayBe<User> user = await apiService.getUserProfile(email, password);

      expect(user.hasValue(), true);
      expect(user.value.id, 2);
      expect(user.value.token, "token123");
      expect(user.value.username, "username123");
    });

    test("lorsque le login ne fonctionne pas, doit retourner un MayBe vide.", () async {
      const String email = "valid@email.com";
      const String password = "invalidPassword";
      when(_mockClientService.post(
        Uri.parse('$revolvair/login'), 
        body: json.encode({"email": email, "password": password}), 
        headers: {
          'Content-type' : 'application/json', 
          'Accept': 'application/json',
        }
      )).thenAnswer((_) async =>
        http.Response('{}', 404)
      );
      final apiService = ApiService();

      MayBe<User> user = await apiService.getUserProfile(email, password);

      expect(user.hasValue(), false);
    });
  });

  group("ApiService - createUserProfile", () {
    test("lorsque la création de compte fonctionne, doit retourner l'utilisateur ave son token comme un login.", () async {
      const String username = "validUsername";
      const String email = "valid@email.com";
      const String password = "validPassword";
      when(_mockClientService.post(
        Uri.parse('$revolvair/register'), 
        body: json.encode({"name": username, "email": email, "password": password}), 
        headers: {
          'Content-type' : 'application/json', 
          'Accept': 'application/json',
        }
      )).thenAnswer((_) async =>
        http.Response('{"token": "token123", "id": 2, "role": "user", "username": "username123", "firstname": null, "lastname": null, "score": 0, "avatar": "https://s3.amazonaws.com/debut-ca/avatar/2.jpg", "profile": {}}', 200)
      );
      final apiService = ApiService();

      MayBe<User> user = await apiService.createUserProfile(username, email, password);

      expect(user.hasValue(), true);
      expect(user.value.id, 2);
      expect(user.value.token, "token123");
      expect(user.value.username, "username123");
    });

    test("lorsque la création de compte ne fonctionne fonctionne pas, doit retourner un MayBe vide.", () async {
      const String username = "validUsername";
      const String email = "valid@email.com";
      const String password = "invalidPassword";
      when(_mockClientService.post(
        Uri.parse('$revolvair/register'), 
        body: json.encode({"name": username, "email": email, "password": password}), 
        headers: {
          'Content-type' : 'application/json', 
          'Accept': 'application/json',
        }
      )).thenAnswer((_) async =>
          http.Response('{}', 404)
      );
      final apiService = ApiService();

      MayBe<User> user = await apiService.createUserProfile(username, email, password);

      expect(user.hasValue(), false);
    });

    test("lorsque la création de compte ne fonctionne fonctionne pas à cause du email, doit retourner un MayBe vide un message.", () async {
      const String username = "validUsername";
      const String email = "invalid@email";
      const String password = "validPassword";
      when(_mockClientService.post(
        Uri.parse('$revolvair/register'), 
        body: json.encode({"name": username, "email": email, "password": password}), 
        headers: {
          'Content-type' : 'application/json', 
          'Accept': 'application/json',
        }
      )).thenAnswer((_) async =>
          http.Response('{"message": "The given data was invalid.", "errors": {"email": ["The email must be a valid email address."]}}', 422)
      );
      final apiService = ApiService();

      MayBe<User> user = await apiService.createUserProfile(username, email, password);

      expect(user.hasValue(), false);
      expect(user.warning, "The email must be a valid email address.");
    });
  });

  group("ApiService - logoutUser", () {
    test("lorsque la déconnection fonctionne, on retourne un MayBe vide", () async {
      User user = User(2, "username", "token");

      when(_mockClientService.post(
        Uri.parse('$revolvair/logout'),
        headers: {
          'Content-type' : 'application/json', 
          'Accept': 'application/json',
          'Authorization': 'Bearer ${user.token}',
        }
      )).thenAnswer((_) async =>
        http.Response('{}', 200)
      );
      final apiService = ApiService();

      MayBe<User> response = await apiService.logoutUser(user);
      expect(response.hasValue(), false);
    });

    test("lorsque la déconnection ne fonctionne pas, on retourne un MayBe vide", () async {
      User user = User(2, "username", "token");

      when(_mockClientService.post(
        Uri.parse('$revolvair/logout'),
        headers: {
          'Content-type' : 'application/json', 
          'Accept': 'application/json',
          'Authorization': 'Bearer ${user.token}',
        }
      )).thenAnswer((_) async =>
        http.Response('{}', 404)
      );
      final apiService = ApiService();

      MayBe<User> response = await apiService.logoutUser(user);
      expect(response.hasValue(), false);
    });
  });
}