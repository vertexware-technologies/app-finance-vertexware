import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthController with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _currentUser;

  User? get currentUser => _currentUser;
  Future<void> register(User user, String passwordConfirmation) async {
    try {
      _currentUser = await _authService.register(user, passwordConfirmation);
      notifyListeners();
    } catch (error) {
      rethrow; // Deixa o erro ser tratado no nível da interface
    }
  }

  Future<void> login(String email, String password) async {
    await _authService.login(email, password);
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.logout();
    _currentUser = null;
    notifyListeners();
  }
}
