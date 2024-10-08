import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _tokenKey = 'keyToken';

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
