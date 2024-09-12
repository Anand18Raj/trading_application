import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider {
  static const _kIsLoggedInKey = 'isLoggedIn';
  static const _kUsernameKey = 'username';

  Future<void> login(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kIsLoggedInKey, true);
    await prefs.setString(_kUsernameKey, username);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kIsLoggedInKey);
    await prefs.remove(_kUsernameKey);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kIsLoggedInKey) ?? false;
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kUsernameKey);
  }
}
