import 'dart:convert';
import 'package:finance_vertexware/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://finance.siriusworks.com.br/api';
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Registrar um novo usuário
  Future<User?> register(User user, String passwordConfirmation) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      if (responseData.containsKey('data') && responseData['data'] != null) {
        return User.fromJson(responseData['data']);
      } else {
        return null; // Retorne null se a API não retornar 'data'
      }
    } else {
      throw Exception('Erro ao registrar: ${response.body}');
    }
  }

  // Login do usuário e armazenamento do token
  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final String token = data['data']['token'];

      // Armazenar token usando FlutterSecureStorage
      await _secureStorage.write(key: 'token', value: token);
      print('Login realizado e token armazenado: $token');
    } else {
      throw Exception('Erro ao fazer login: ${response.body}');
    }
  }

  // Logout do usuário e remoção do token
  Future<void> logout() async {
    final String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Remover token usando FlutterSecureStorage
      await _secureStorage.delete(key: 'token');
      print('Logout realizado com sucesso');
    } else {
      throw Exception('Erro ao fazer logout: ${response.body}');
    }
  }

  // Obter o token armazenado
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }
}
