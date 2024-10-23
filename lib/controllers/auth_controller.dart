import 'package:flutter/material.dart';

import '../models/user.dart';
import '../repositories/user_repository.dart';
import '../services/local_storage_service.dart';

class AuthController extends ChangeNotifier {
  final LocalStorageService localStorage;
  final UserRepository repository;

  User? _user;
  bool _isLoading = false;

  AuthController({required this.localStorage, required this.repository});

  User? get user => _user;
  bool get isLoggedIn =>
      _user != null &&
      _user!.email?.isNotEmpty == true &&
      _user!.token?.isNotEmpty == true;
  bool get isLoading => _isLoading;

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final data = await repository.login(email, password);
    if (data.isNotEmpty) {
      _user = User.fromMap(data);
      await localStorage.saveToken(_user!.token!);
    } else {
      _user = null;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> register() async {
    _isLoading = true;
    notifyListeners();

    final data = await repository.register(user!);
    if (data.isNotEmpty) {
      _user = User.fromMap(data);
    } else {
      _user = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await localStorage.clearAll();
    _user = null;
    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    String? token = await localStorage.getToken();

    if (token != null) {
      //buscar e atualizar o usuário;
      notifyListeners();
    } else {
      _user = null;
      notifyListeners();
    }
  }
}
