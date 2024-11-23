import 'dart:convert';
import 'package:finance_vertexware/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'https://finance.siriusworks.com.br/api';

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
      // Levantar exceção com o erro retornado pela API
      throw Exception('Erro ao registrar: ${response.body}');
    }
  }

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
      var data = jsonDecode(response.body);
      String token = data['data']['token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      print('Login realizado e token armazenado: $token');
    } else {
      throw Exception('Erro ao fazer login: ${response.body}');
    }
  }

  Future<void> logout() async {
    String? token = await getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      print('Logout realizado com sucesso');
    } else {
      throw Exception('Erro ao fazer logout');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
