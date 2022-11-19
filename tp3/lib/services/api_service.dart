import 'dart:convert';
import 'dart:developer';
// import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:tp3/app/app.locator.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/utils/maybe.dart';

class ApiService {
  var client = locator<http.Client>();
  static const revolvair = 'https://test.revolvair.org/api';
  static const Map<String,String> headers = {
    'Content-type' : 'application/json', 
    'Accept': 'application/json'
  };

  Future<MayBe<User>> getUserProfile(String email, String password) async {
    var body = json.encode({"email": email, "password": password});
    const Map<String,String> headers = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
    };
    
    var response = await client.post(Uri.parse('$revolvair/login'), body: body, headers: headers);
    log(response.statusCode.toString());

    if (response.statusCode != 200) {
      return MayBe.empty();
    }

    final user = User.fromJson(response.body);
    return MayBe(user);
  }

  Future<MayBe<User>> getUserProfileWithToken(String token) async {
    final Map<String,String> headerForBearer = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    
    var response = await client.get(Uri.parse('$revolvair/login'), headers: headerForBearer);
    log(response.statusCode.toString());

    if (response.statusCode == 404) {
      return MayBe.empty();
    }

    final user = User.fromJson(response.body);
    return MayBe(user);
  }

  Future<MayBe<User>> createUserProfile(String name, String email, String password) async {
    var body = json.encode({"name": name, "email": email, "password": password});

    var response = await client.post(Uri.parse('$revolvair/register'), body: body, headers: headers);
    log(response.statusCode.toString());

    if (response.statusCode == 404) {
      return MayBe.empty();
    }
    else if (response.statusCode == 422) {
      MayBe<User> mayBe = MayBe.empty();

      var body = json.decode(response.body);
      // la seul erreur connu est avec le email, donc on peut faire cela
      // a changé si ce n'est plus le cas (un manque de doc de l'api aide pas vraiment...)
      mayBe.setWarning(body['errors']['email'][0]);
      return mayBe;
    }

    final user = User.fromJson(response.body);
    log(user.toString());
    return MayBe(user);
  }

  Future<MayBe<User>> logoutUser(User user) async {
    final Map<String,String> headerForBearer = {
      'Content-type' : 'application/json', 
      'Accept': 'application/json',
      'Authorization': 'Bearer ${user.token}',
    };
    
    var response = await client.post(Uri.parse('$revolvair/logout'), headers: headerForBearer);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      return MayBe.empty();
    }

    return MayBe.empty();
  }
}
