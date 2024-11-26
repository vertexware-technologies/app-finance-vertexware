import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

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
        final data = responseData['data'];
        return User(
          name: data['name'] ?? 'Nome não informado',
          email: data['email'] ?? 'Email não informado',
          password: '', // Senha não é retornada pela API
        );
      }
      return null;
    } else if (response.statusCode == 422) {
      final errors =
          jsonDecode(response.body)['errors'] as Map<String, dynamic>;
      final errorMessage = errors.values.first.join(', ');
      throw Exception('Erro de validação: $errorMessage');
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(
          'Erro ao registrar: ${errorBody['message'] ?? 'Erro desconhecido'}');
    }
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final String token = data['data']['token'];

      // Armazena o token usando SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      print('Login realizado e token armazenado: $token');
    } else {
      throw Exception('Erro ao fazer login: ${response.body}');
    }
  }

  Future<void> logout() async {
    final String? token = await getToken();
    if (token == null) throw Exception('Token não encontrado');

    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      // Remove o token do SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');

      print('Logout realizado com sucesso');
    } else {
      throw Exception('Erro ao fazer logout: ${response.body}');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
