
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {

  void setToken(String token) {
    SharedPreferences.getInstance().then((prefs) { 
      prefs.setString('token', token);
    });
  }

  void setExpiration(int expiration) {
    SharedPreferences.getInstance().then((prefs) { 
      prefs.setInt('expiration', expiration);
    });
  }

  Future<int?> getExpiration() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('expiration');
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('expiration');
  }
}