import 'package:finance_vertexware/Models/user.dart';
import 'package:finance_vertexware/Services/http_service.dart';
import 'package:finance_vertexware/Services/local_storage_service.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  User? _user;
  bool _isLoggedIn = false;
  bool _isLoading = false;

  final LocalStorageService _localStorageService = LocalStorageService();

  User? get user => _user;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    try {
      HttpService httpService = HttpService();
      final data = await httpService.login(email, password);
      _user = User.fromMap(data);
      _isLoggedIn = true;

      await _localStorageService.saveToken(_user!.token!);
      notifyListeners();
    } catch (error) {
      _isLoggedIn = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> register() async {
    _isLoading = true;
    notifyListeners();

    try {
      HttpService httpService = HttpService();
      final data = await httpService.register(user!);
      _user = User.fromMap(data);
      _isLoggedIn = true;

      await _localStorageService.saveToken(_user!.token!);
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Erro ao registrar usuário');
    }
  }

  Future<void> logout() async {
    await _localStorageService.clearAll();
    _isLoggedIn = false;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    String? token = await _localStorageService.getToken();

    if (token != null && token.isNotEmpty) {
      _isLoggedIn = true;
      notifyListeners();
    } else {
      _isLoggedIn = false;
      notifyListeners();
    }
  }
}
