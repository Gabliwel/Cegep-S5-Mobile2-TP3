import 'dart:async';

import 'package:tp3/app/app.locator.dart';
import 'package:tp3/models/user.dart';
import 'package:tp3/services/api_service.dart';
import 'package:tp3/utils/maybe.dart';

class AuthenticationService {
  final ApiService _apiService = locator<ApiService>();

  MayBe<User> _authenticatedUser = MayBe.empty();

  User get authenticatedUser => _authenticatedUser.value;
  bool get isUserAuthenticated => _authenticatedUser.hasValue();

  Future login(String email, String password) async {
    _authenticatedUser = await _apiService.getUserProfile(email, password);
  }

  Future tokenLogin(String token) async {
    _authenticatedUser = await _apiService.getUserProfileWithToken(token);
  }

  Future signUp(String name, String email, String password) async {
    _authenticatedUser = await _apiService.createUserProfile(name, email, password);
  }

  Future disconnect() async {
    _authenticatedUser = await _apiService.logoutUser(_authenticatedUser.value);
  }

  bool hasWarning() {
    if(_authenticatedUser.warning == null) {
      return false;
    } else {
      return true;
    }
  }

  String getWarning() {
    return _authenticatedUser.warning ?? "";
  }

  void clearWarning() {
    _authenticatedUser.clearWarning();
  }
}
