import 'dart:convert';

import '../models/user.dart';
import '../services/http_service.dart';

class UserRepository {
  final HttpService httpService;

  UserRepository({required this.httpService});

  Future<Map<String, dynamic>> login(String email, String password) async {
    final body = {
      'email': email,
      'password': password,
    };

    try {
      final response = await httpService.post('/login', body: body);
      final result = jsonDecode(response.body);
      return result["data"];
    } catch (e) {
      print('Erro ao realizar POST: $e');
      return {};
    }
  }

  Future<Map<String, dynamic>> register(User user) async {
    try {
      final response = await httpService.post('/register', body: user.toBody());
      final result = jsonDecode(response.body);
      return result["data"];
    } catch (e) {
      print('Erro ao realizar POST: $e');
      return {};
    }
  }
}
