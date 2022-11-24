import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/models/comment.dart';
import 'package:tp3/models/station.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/utils/http_detailed_response.dart';
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

      MayBe<User> response = await apiService.logoutUser(user.token);
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

      MayBe<User> response = await apiService.logoutUser(user.token);
      expect(response.hasValue(), false);
    });
  
  });

  group('API Service - getCommentsForSlug', (){
    test("getCommentForSlug retourne la liste de commentaire avec le mauvais nom de station, soit 0", () async {
      String commentJson = jsonEncode({
      "id": 31,
      "text": "bonsoir a tous, petit comment",
      "name": "test"});
      String slugName = 'cegep-de-sainte-foyeeeeeeeeeeeeeeeeee';
      when(_mockClientService.get(
        Uri.parse('$revolvair/stations/$slugName/comments'),
      )).thenAnswer((_) async =>
        http.Response('{"data" : []}',404)
      );
      final apiService = ApiService();

      List<Comment> response = await apiService.getCommentsForSlug(slugName);
      expect(response.length, 0);
    });

  test("getCommentForSlug retourne la liste de commentaire de la station ayant le nom en question", () async {
      String commentJson = jsonEncode({
      "id": 31,
      "text": "bonsoir a tous, petit comment",
      "name": "test",
      "user_id" : 21,
      "created_at" : "01/12/12"});
      String slugName = 'cegep-de-sainte-foyeeeeeeeeeeeeeeeeee';
      when(_mockClientService.get(
        Uri.parse('$revolvair/stations/$slugName/comments'),
      )).thenAnswer((_) async =>
        http.Response('{"data" : [$commentJson]}',200)
      );
      final apiService = ApiService();

      List<Comment> response = await apiService.getCommentsForSlug(slugName);
      expect(response.length, 1);
    });
  });

  group('API Service - getPM25Raw', (){
    test("getPM25Raw retourne la moyenne des mesures du dernier mois de la station en question", () async {
      String pm25_raw= jsonEncode({
      "value" : "32"});
      String slugName = 'cegep-de-sainte-foy';
      when(_mockClientService.get(
        Uri.parse('$revolvair/revolvair/stations/$slugName/measures/pm25_raw/average/month'),
      )).thenAnswer((_) async =>
        http.Response('{"data" : [$pm25_raw]}',200)
      );
      final apiService = ApiService();

      String response = await apiService.getPM25Raw(slugName);
      expect(response, 32.toString());
    });


    test("getPM25Raw retourne une string vide si la station n'existe pas", () async {
      String slugName = 'cegep-de-sainte-foy33333333333333333333333333';
      when(_mockClientService.get(
        Uri.parse('$revolvair/revolvair/stations/$slugName/measures/pm25_raw/average/month'),
      )).thenAnswer((_) async =>
        http.Response('{"data" : []}',200)
      );
      final apiService = ApiService();

      String response = await apiService.getPM25Raw(slugName);
      expect(response, "");
    });
  });

  group('API Service - fetchActiveStation', (){
    test("Retourne la liste de toutes les stations", () async {
      String stationToJson= jsonEncode({"name": "test", "comment_count": 2, "description": "test", "user_id":  2,"slugID": 2,"slug": "test"});
      when(_mockClientService.get(
        Uri.parse('$revolvair/revolvair/stations/'),
      )).thenAnswer((_) async =>
        http.Response('{"data" : [$stationToJson]}',200)
      );
      final apiService = ApiService();

      List<Station> response = await apiService.fetchActiveStation();
      expect(response.length, 0);
    });


  test("Retourne une liste vide s'il n'y a aucune station active", () async {
     
      when(_mockClientService.get(
        Uri.parse('$revolvair/revolvair/stations/'),
      )).thenAnswer((_) async =>
        http.Response('{"data" : []}',200)
      );
      final apiService = ApiService();

      List<Station> response = await apiService.fetchActiveStation();
      expect(response.length, 0);
    });
  });

  group('API Service - addComment', (){
    test("Si le commentaire est ajouté, retourne un réponse authorize avec un succès à true", () async {
      String token = "token";
      String stationSlug = "slug";
      var body = json.encode({"text": "text", "status": "final"});
      final Map<String,String> headerForBearer = {
        'Content-type' : 'application/json', 
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      when(_mockClientService.post(Uri.parse('$revolvair/stations/$stationSlug/comments'), headers: headerForBearer, body: body))
      .thenAnswer((_) async =>
        http.Response('{"data" : []}', 201)
      );

      final apiService = ApiService();
      HttpDetailedReponse response = await apiService.addComment("text", stationSlug, token);

      expect(response.status, 201);
      expect(response.succes, true);
      expect(response.isAuthorize(), true);
    });

    test("Si le commentaire est pas ajouté mais authorize, retourne un réponse authorize avec un succès à false", () async {
      String token = "token";
      String stationSlug = "slug";
      var body = json.encode({"text": "text", "status": "final"});
      final Map<String,String> headerForBearer = {
        'Content-type' : 'application/json', 
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      when(_mockClientService.post(Uri.parse('$revolvair/stations/$stationSlug/comments'), headers: headerForBearer, body: body))
      .thenAnswer((_) async =>
        http.Response('{"data" : []}', 404)
      );

      final apiService = ApiService();
      HttpDetailedReponse response = await apiService.addComment("text", stationSlug, token);

      expect(response.status, 404);
      expect(response.succes, false);
      expect(response.isAuthorize(), true);
    });

    test("Si le commentaire est pas ajouté et pas authorize, retourne un réponse pas authorize avec un succès à false", () async {
      String token = "token";
      String stationSlug = "slug";
      var body = json.encode({"text": "text", "status": "final"});
      final Map<String,String> headerForBearer = {
        'Content-type' : 'application/json', 
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      when(_mockClientService.post(Uri.parse('$revolvair/stations/$stationSlug/comments'), headers: headerForBearer, body: body))
      .thenAnswer((_) async =>
        http.Response('{"data" : []}', 401)
      );

      final apiService = ApiService();
      HttpDetailedReponse response = await apiService.addComment("text", stationSlug, token);

      expect(response.status, 401);
      expect(response.succes, false);
      expect(response.isAuthorize(), false);
    });
  });
}