import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl =
      'http://finance-vertexware.test/api'; // Backend Laravel

  // Função de registro
  Future<void> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      print('Usuário registrado com sucesso');
    } else {
      throw Exception('Erro ao registrar usuário');
    }
  }

  // Função de login
  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // Acesse o token corretamente
      String token = data['data']['token'];

      // Salvar o token no SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      print('Login realizado e token armazenado: $token');
    } else {
      throw Exception('Erro ao fazer login: ${response.body}');
    }
  }

  // Função de logout
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

  // Obter token do SharedPreferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
