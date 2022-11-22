import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/services/api_service.dart';

import 'api_service_test.mocks.dart';


@GenerateMocks([http.Client])
void main() {
  final _mockClientService = MockClient();
  locator.registerSingleton<http.Client>(_mockClientService);

  tearDown(() {
    reset(_mockClientService);
  });
  group("ApiService - getUserProfile", () {
    test("lorsque l'utilisateur existe, doit retourner l'utilisateur.",
        () async {
      final user = User(1, "Lulu", "Lolo");
      when(_mockClientService.get(any)).thenAnswer(
          (realInvocation) => Future.value(Response(user.toJson(), 200)));
      final apiService = ApiService();

      var fetchedUser = await apiService.getUserProfile(user.id);

      expect(user, equals(fetchedUser.value));
    });
  });
}